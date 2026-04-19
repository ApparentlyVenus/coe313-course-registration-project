package com.coe313.courseregistration.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.EnrollmentResponse;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.entity.Course;
import com.coe313.courseregistration.entity.Enrollment;
import com.coe313.courseregistration.entity.Schedule;
import com.coe313.courseregistration.entity.Section;
import com.coe313.courseregistration.entity.Student;
import com.coe313.courseregistration.entity.User;
import com.coe313.courseregistration.repository.CourseRepository;
import com.coe313.courseregistration.repository.EnrollmentRepository;
import com.coe313.courseregistration.repository.SectionRepository;
import com.coe313.courseregistration.repository.StudentRepository;
import com.coe313.courseregistration.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EnrollmentService {

    private final EnrollmentRepository enrollmentRepository;
    private final SectionRepository sectionRepository;
    private final StudentRepository studentRepository;
    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final SectionService sectionService;

    /**
     * GRAPH — BFS traversal of the prerequisite graph.
     *
     * The prerequisite relationship forms a directed graph:
     *   course → Set<Course> prerequisites → each has their own prerequisites
     *
     * We use BFS to collect ALL transitive prerequisites, not just direct ones.
     * Example: COE 312 requires COE 211, COE 211 requires nothing.
     *           getAllPrerequisites(COE 312) returns {COE 211}
     *
     * We use a visited set to prevent infinite loops in case of cycles.
     *
     * @param course the course to get all prerequisites for
     * @return set of all prerequisite course IDs (transitive)
     */
    public Set<Integer> getAllPrerequisitesBFS(Course course) {
        Set<Integer> visited = new HashSet<>();
        Queue<Course> queue = new LinkedList<>();

        queue.addAll(course.getPrerequisites());

        while (!queue.isEmpty()) {
            Course current = queue.poll();
            if (visited.add(current.getCourseId())) {
                queue.addAll(current.getPrerequisites());
            }
        }

        return visited;
    }

    /**
     * GRAPH — checks if a student has completed all prerequisites.
     *
     * Uses getAllPrerequisitesBFS() to get the full prereq set,
     * then verifies the student has a past enrolled record for each.
     *
     * @param student the student to check
     * @param course the course being registered for
     * @return list of missing prerequisite abbreviations (empty = all met)
     */
    @SuppressWarnings("null")
    public List<String> getMissingPrerequisites(Student student, Course course) {
        Set<Integer> allPrereqs = getAllPrerequisitesBFS(course);
        List<String> missing = new ArrayList<>();

        for (Integer prereqId : allPrereqs) {
            boolean completed = enrollmentRepository
                .findByStudent(student)
                .stream()
                .anyMatch(e ->
                    e.getSection().getCourse().getCourseId().equals(prereqId) &&
                    e.getStatus() == Enrollment.Status.enrolled
                );
            if (!completed) {
                courseRepository.findById(prereqId).ifPresent(c ->
                    missing.add(c.getAbbreviation())
                );
            }
        }

        return missing;
    }

    /**
     * INTERVAL OVERLAP — schedule conflict detection.
     *
     * Two sections conflict if they share a day AND their times overlap.
     * Overlap condition: A.start < B.end AND A.end > B.start
     *
     * This is the classic interval overlap problem applied to weekly schedules.
     *
     * @param student the student to check conflicts for
     * @param section the new section being registered
     * @return the conflicting section's CRN, or null if no conflict
     */
    public Integer detectScheduleConflict(Student student, Section section) {
        List<Enrollment> activeEnrollments = enrollmentRepository
            .findByStudentAndStatus(student, Enrollment.Status.enrolled);

        for (Enrollment existing : activeEnrollments) {
            for (Schedule existingSlot : existing.getSection().getSchedules()) {
                for (Schedule newSlot : section.getSchedules()) {
                    if (existingSlot.getDayOfWeek().equals(newSlot.getDayOfWeek())) {
                        boolean overlap =
                            existingSlot.getStartTime().isBefore(newSlot.getEndTime()) &&
                            existingSlot.getEndTime().isAfter(newSlot.getStartTime());
                        if (overlap) {
                            return existing.getSection().getCrn();
                        }
                    }
                }
            }
        }
        return null;
    }

    /**
     * QUEUE — promotes the first waitlisted student (FIFO).
     *
     * The waitlist is a FIFO queue ordered by enrolledAt timestamp.
     * When a student drops, the earliest waitlisted student gets promoted.
     *
     * @param section the section whose waitlist to check
     */
    public void promoteFromWaitlist(Section section) {
        enrollmentRepository
            .findBySectionOrderByEnrolledAtAsc(section)
            .stream()
            .filter(e -> e.getStatus() == Enrollment.Status.waitlisted)
            .findFirst()
            .ifPresent(first -> {
                first.setStatus(Enrollment.Status.enrolled);
                enrollmentRepository.save(first);
            });
    }

    // =========================================================
    // BUSINESS LOGIC METHODS
    // =========================================================

    public List<EnrollmentResponse> getAllEnrollments() {
        return enrollmentRepository.findAll()
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    public List<EnrollmentResponse> getEnrollmentsByCrn(Integer crn) {
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));
        return enrollmentRepository.findBySectionOrderByEnrolledAtAsc(section)
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    public List<EnrollmentResponse> getStudentEnrollments(String email) {
        Student student = resolveStudent(email);
        return enrollmentRepository.findByStudent(student)
            .stream()
            .filter(e -> e.getStatus() != Enrollment.Status.dropped)
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    public List<EnrollmentResponse> getEnrollmentsByStudent(Integer studentId) {
        @SuppressWarnings("null")
        Student student = studentRepository.findById(studentId)
            .orElseThrow(() -> new IllegalArgumentException("Student not found"));
        return enrollmentRepository.findByStudent(student)
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    /**
     * Enrolls a student in a section with full validation.
     * Checks in order:
     * 1. Duplicate enrollment
     * 2. Prerequisites (BFS graph traversal)
     * 3. Schedule conflict (interval overlap)
     * 4. Capacity (queue logic)
     */
    public EnrollmentResponse enroll(String email, Integer crn) {
        Student student = resolveStudent(email);
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));

        // 1. duplicate check
        boolean alreadyEnrolled = enrollmentRepository
            .existsByStudentAndSection_Course_CourseIdAndSection_Semester(
                student,
                section.getCourse().getCourseId(),
                section.getSemester()
            );
        if (alreadyEnrolled) {
            throw new IllegalStateException("Already enrolled in this course this semester");
        }

        // 2. prerequisite check — BFS graph traversal
        List<String> missing = getMissingPrerequisites(student, section.getCourse());
        if (!missing.isEmpty()) {
            throw new IllegalStateException("Prerequisites not met: missing " + String.join(", ", missing));
        }

        // 3. schedule conflict — interval overlap detection
        Integer conflictCrn = detectScheduleConflict(student, section);
        if (conflictCrn != null) {
            throw new IllegalStateException("Schedule conflict with section CRN " + conflictCrn);
        }

        // 4. capacity check — queue logic
        long enrolledCount = enrollmentRepository
            .findBySectionOrderByEnrolledAtAsc(section)
            .stream()
            .filter(e -> e.getStatus() == Enrollment.Status.enrolled)
            .count();

        Enrollment.Status status = enrolledCount < section.getCapacity()
            ? Enrollment.Status.enrolled
            : Enrollment.Status.waitlisted;

        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student);
        enrollment.setSection(section);
        enrollment.setStatus(status);
        enrollment.setEnrolledAt(LocalDateTime.now());

        return mapToResponse(enrollmentRepository.save(enrollment));
    }

    /**
     * Drops a student from a section.
     * After dropping, auto-promotes first waitlisted student (FIFO queue).
     */
    public void drop(String email, Integer crn) {
        Student student = resolveStudent(email);
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));

        Enrollment enrollment = enrollmentRepository.findByStudent(student)
            .stream()
            .filter(e -> e.getSection().getCrn().equals(crn))
            .findFirst()
            .orElseThrow(() -> new IllegalArgumentException("Enrollment not found"));

        if (enrollment.getStatus() == Enrollment.Status.dropped) {
            throw new IllegalStateException("Enrollment is already dropped");
        }

        enrollment.setStatus(Enrollment.Status.dropped);
        enrollmentRepository.save(enrollment);

        // QUEUE — promote next waitlisted student
        promoteFromWaitlist(section);
    }

    public EnrollmentResponse adminEnroll(Integer studentId, Integer crn) {
        @SuppressWarnings("null")
        Student student = studentRepository.findById(studentId)
            .orElseThrow(() -> new IllegalArgumentException("Student not found"));
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));

        boolean exists = enrollmentRepository.findByStudent(student)
            .stream()
            .anyMatch(e -> e.getSection().getCrn().equals(crn)
                && e.getStatus() != Enrollment.Status.dropped);
        if (exists) {
            throw new IllegalStateException("Student is already enrolled in this section");
        }

        long enrolledCount = enrollmentRepository
            .findBySectionOrderByEnrolledAtAsc(section)
            .stream()
            .filter(e -> e.getStatus() == Enrollment.Status.enrolled)
            .count();

        Enrollment.Status status = enrolledCount < section.getCapacity()
            ? Enrollment.Status.enrolled
            : Enrollment.Status.waitlisted;

        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student);
        enrollment.setSection(section);
        enrollment.setStatus(status);
        enrollment.setEnrolledAt(LocalDateTime.now());

        return mapToResponse(enrollmentRepository.save(enrollment));
    }

    public void adminDrop(Integer enrollmentId) {
        @SuppressWarnings("null")
        Enrollment enrollment = enrollmentRepository.findById(enrollmentId)
            .orElseThrow(() -> new IllegalArgumentException("Enrollment not found"));
        enrollment.setStatus(Enrollment.Status.dropped);
        enrollmentRepository.save(enrollment);
    }

    public EnrollmentResponse promoteFromWaitlist(Integer enrollmentId) {
        @SuppressWarnings("null")
        Enrollment enrollment = enrollmentRepository.findById(enrollmentId)
            .orElseThrow(() -> new IllegalArgumentException("Enrollment not found"));
        if (enrollment.getStatus() != Enrollment.Status.waitlisted) {
            throw new IllegalStateException("Enrollment is not waitlisted");
        }
        enrollment.setStatus(Enrollment.Status.enrolled);
        return mapToResponse(enrollmentRepository.save(enrollment));
    }

    public List<SectionResponse> getStudentSchedule(String email) {
        Student student = resolveStudent(email);
        return enrollmentRepository
            .findByStudentAndStatus(student, Enrollment.Status.enrolled)
            .stream()
            .map(e -> sectionService.mapToResponse(e.getSection()))
            .collect(Collectors.toList());
    }

    // =========================================================
    // HELPERS
    // =========================================================

    private Student resolveStudent(String email) {
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new IllegalArgumentException("User not found"));
        return studentRepository.findByUser(user)
            .orElseThrow(() -> new IllegalArgumentException("Student not found"));
    }

    private EnrollmentResponse mapToResponse(Enrollment enrollment) {
        return new EnrollmentResponse(
            enrollment.getEnrollmentId(),
            enrollment.getSection().getCourse().getName(),
            enrollment.getSection().getCourse().getAbbreviation(),
            enrollment.getSection().getCrn(),
            enrollment.getSection().getSectionNumber(),
            enrollment.getSection().getProfessor() != null
                ? enrollment.getSection().getProfessor().getFirstName() + " " +
                  enrollment.getSection().getProfessor().getLastName()
                : null,
            enrollment.getStatus().name(),
            enrollment.getEnrolledAt()
        );
    }
}