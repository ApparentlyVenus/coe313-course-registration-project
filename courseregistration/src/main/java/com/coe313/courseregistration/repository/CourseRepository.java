package com.coe313.courseregistration.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Course;
import com.coe313.courseregistration.entity.Department;

// repository/CourseRepository.java
@Repository
public interface CourseRepository extends JpaRepository<Course, Integer> {
    List<Course> findByDepartment(Department department);
}