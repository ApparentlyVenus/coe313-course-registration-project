package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.DashboardResponse;
import com.coe313.courseregistration.dto.EnrollmentResponse;
import com.coe313.courseregistration.dto.MajorCourseResponse;
import com.coe313.courseregistration.entity.Enrollment;
import com.coe313.courseregistration.entity.MajorCourse;
import com.coe313.courseregistration.entity.Student;
import com.coe313.courseregistration.repository.EnrollmentRepository;
import com.coe313.courseregistration.repository.MajorCourseRepository;
import com.coe313.courseregistration.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final StudentRepository studentRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final MajorCourseRepository majorCourseRepository;

    public DashboardResponse getDashboard(String email) {
        Student student = studentRepository.findByEmail(email)
            .orElseThrow(() -> new IllegalArgumentException("Student not found"));

        List<Enrollment> enrollments = enrollmentRepository.findByStudent(student);

        int completedCredits = enrollments.stream()
            .filter(e -> e.getStatus() == Enrollment.Status.completed)
            .mapToInt(e -> e.getSection().getCourse().getCredits())
            .sum();

        List<EnrollmentResponse> current = enrollments.stream()
            .filter(e -> e.getStatus() == Enrollment.Status.enrolled
                      || e.getStatus() == Enrollment.Status.waitlisted)
            .map(this::mapToResponse)
            .toList();

        List<MajorCourseResponse> courseMap = student.getMajor() != null
            ? majorCourseRepository.findByMajor_MajorId(student.getMajor().getMajorId())
                .stream().map(this::mapToResponse).toList()
            : List.of();

        return mapToResponse(student, current, completedCredits, courseMap);
    }

    private DashboardResponse mapToResponse(
        Student student, 
        List<EnrollmentResponse> current,
        Integer completedCredits, 
        List<MajorCourseResponse> courseMap) {

        return new DashboardResponse(
            student.getFirstName() + " " + student.getLastName(),
            student.getMajor() != null ? student.getMajor().getName() : null,
            student.getMajor() != null ? student.getMajor().getMajorId() : null,
            completedCredits,
            student.getMajor() != null ? student.getMajor().getTotalCreditsRequired() : null,
            current,
            courseMap
        );
    }

    private MajorCourseResponse mapToResponse(MajorCourse mc) {
        return new MajorCourseResponse(
            mc.getCourse().getCourseId(),
            mc.getCourse().getName(),
            mc.getCourse().getAbbreviation(),
            mc.getCourse().getCredits(),
            mc.getRecommendedYear(),
            mc.getRecommendedSemester(),
            mc.getIsRequired()
        );
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
