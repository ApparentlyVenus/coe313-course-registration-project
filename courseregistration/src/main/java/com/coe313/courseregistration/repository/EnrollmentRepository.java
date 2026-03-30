package com.coe313.courseregistration.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Enrollment;
import com.coe313.courseregistration.entity.Section;
import com.coe313.courseregistration.entity.Semester;
import com.coe313.courseregistration.entity.Student;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Integer> {
    List<Enrollment> findByStudent(Student student);
    List<Enrollment> findByStudentAndStatus(Student student, Enrollment.Status status);
    List<Enrollment> findBySectionOrderByEnrolledAtAsc(Section section);
    boolean existsByStudentAndSection_Course_CourseIdAndSection_Semester(
        Student student, Integer courseId, Semester semester);
}
