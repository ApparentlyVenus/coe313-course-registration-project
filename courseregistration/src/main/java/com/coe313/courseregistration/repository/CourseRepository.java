package com.coe313.courseregistration.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Course;
import com.coe313.courseregistration.entity.Department;
@Repository
public interface CourseRepository extends JpaRepository<Course, Integer> {
    List<Course> findByDepartment(Department department);
    List<Course> findByDepartment_DepartmentId(Integer departmentId);
    List<Course> findByDepartment_School_SchoolId(Integer schoolId);

    @Query("SELECT DISTINCT c FROM Course c LEFT JOIN FETCH c.prerequisites LEFT JOIN FETCH c.department d LEFT JOIN FETCH d.school")
    List<Course> findAllWithPrerequisites();
}