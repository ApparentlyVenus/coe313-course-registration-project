// MajorCourseRepository.java
package com.coe313.courseregistration.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.coe313.courseregistration.entity.MajorCourse;
import com.coe313.courseregistration.entity.MajorCourseId;
public interface MajorCourseRepository extends JpaRepository<MajorCourse, MajorCourseId> {
    List<MajorCourse> findByMajor_MajorId(Integer majorId);
}