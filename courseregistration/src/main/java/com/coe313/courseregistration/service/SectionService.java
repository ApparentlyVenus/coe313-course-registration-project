package com.coe313.courseregistration.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.ScheduleDto;
import com.coe313.courseregistration.dto.SectionRequest;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.entity.Course;
import com.coe313.courseregistration.entity.Enrollment;
import com.coe313.courseregistration.entity.Professor;
import com.coe313.courseregistration.entity.Schedule;
import com.coe313.courseregistration.entity.Section;
import com.coe313.courseregistration.entity.Semester;
import com.coe313.courseregistration.repository.CourseRepository;
import com.coe313.courseregistration.repository.EnrollmentRepository;
import com.coe313.courseregistration.repository.ProfessorRepository;
import com.coe313.courseregistration.repository.SectionRepository;
import com.coe313.courseregistration.repository.SemesterRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SectionService {

    private final SectionRepository sectionRepository;
    private final CourseRepository courseRepository;
    private final ProfessorRepository professorRepository;
    private final SemesterRepository semesterRepository;
    private final EnrollmentRepository enrollmentRepository;

    /**
     * Returns all sections for the current semester.
     * enrolled count = number of enrollments with status 'enrolled'
     */
    public List<SectionResponse> getAllSections() {
        return sectionRepository.findAll()
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    /**
     * Returns a single section by CRN.
     * @throws IllegalArgumentException if section not found
     */
    public SectionResponse getSectionByCrn(Integer crn) {
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));
        return mapToResponse(section);
    }

    /**
     * Returns all sections for a specific course.
     * @throws IllegalArgumentException if course not found
     */
    public List<SectionResponse> getSectionsByCourse(Integer courseId) {
        @SuppressWarnings("null")
        Course course = courseRepository.findById(courseId)
            .orElseThrow(() -> new IllegalArgumentException("Course not found"));
        return sectionRepository.findByCourse(course)
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    /**
     * Creates a new section with its schedules.
     * @throws IllegalArgumentException if course not found
     * @throws IllegalArgumentException if professor not found
     * @throws IllegalArgumentException if semester not found
     * @throws IllegalStateException if section number already exists for this course and semester
     */
    public SectionResponse createSection(SectionRequest request) {
        @SuppressWarnings("null")
        Course course = courseRepository.findById(request.getCourseId())
            .orElseThrow(() -> new IllegalArgumentException("Course not found"));

        @SuppressWarnings("null")
        Professor professor = professorRepository.findById(request.getProfessorId())
            .orElseThrow(() -> new IllegalArgumentException("Professor not found"));

        @SuppressWarnings("null")
        Semester semester = semesterRepository.findById(request.getSemesterId())
            .orElseThrow(() -> new IllegalArgumentException("Semester not found"));

        boolean duplicate = sectionRepository.findByCourse(course)
            .stream()
            .anyMatch(s -> s.getSectionNumber().equals(request.getSectionNumber())
                && s.getSemester().getSemesterId().equals(semester.getSemesterId()));
        if (duplicate) {
            throw new IllegalStateException("Section number already exists for this course and semester");
        }

        Section section = new Section();
        section.setCourse(course);
        section.setProfessor(professor);
        section.setSemester(semester);
        section.setSectionNumber(request.getSectionNumber());
        section.setCapacity(request.getCapacity());

        if (request.getSchedules() != null) {
            List<Schedule> schedules = request.getSchedules().stream().map(dto -> {
                Schedule s = new Schedule();
                s.setDayOfWeek(dto.getDayOfWeek());
                s.setStartTime(dto.getStartTime());
                s.setEndTime(dto.getEndTime());
                s.setRoom(dto.getRoom());
                s.setSection(section);
                return s;
            }).collect(Collectors.toList());
            section.setSchedules(schedules);
        }

        return mapToResponse(sectionRepository.save(section));
    }

    /**
     * Updates an existing section.
     * @throws IllegalArgumentException if section not found
     * @throws IllegalArgumentException if professor not found
     */
    public SectionResponse updateSection(Integer crn, SectionRequest request) {
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));

        @SuppressWarnings("null")
        Professor professor = professorRepository.findById(request.getProfessorId())
            .orElseThrow(() -> new IllegalArgumentException("Professor not found"));

        section.setCapacity(request.getCapacity());
        section.setProfessor(professor);

        return mapToResponse(sectionRepository.save(section));
    }

    /**
     * Deletes a section by CRN.
     * cascades to schedules and enrollments via DB foreign keys.
     * @throws IllegalArgumentException if section not found
     */
    @SuppressWarnings("null")
    public void deleteSection(Integer crn) {
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));
        sectionRepository.delete(section);
    }

    public SectionResponse mapToResponse(Section section) {
        long enrolledCount = enrollmentRepository.findBySectionOrderByEnrolledAtAsc(section)
            .stream()
            .filter(e -> e.getStatus() == Enrollment.Status.enrolled)
            .count();

        List<ScheduleDto> schedules = section.getSchedules()
            .stream()
            .map(s -> new ScheduleDto(
                s.getDayOfWeek(),
                s.getStartTime(),
                s.getEndTime(),
                s.getRoom()
            ))
            .collect(Collectors.toList());

        String professorName = section.getProfessor() != null
            ? section.getProfessor().getFirstName() + " " + section.getProfessor().getLastName()
            : null;

        return new SectionResponse(
            section.getCrn(),
            section.getCourse().getName(),
            section.getCourse().getAbbreviation(),
            section.getSectionNumber(),
            section.getCapacity(),
            (int) enrolledCount,
            professorName,
            schedules
        );
    }
}