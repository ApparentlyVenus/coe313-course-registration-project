package com.coe313.courseregistration.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Course;
import com.coe313.courseregistration.entity.Section;
import com.coe313.courseregistration.entity.Semester;

@Repository
public interface SectionRepository extends JpaRepository<Section, Integer> {
    List<Section> findBySemester(Semester semester);
    List<Section> findByCourse(Course course);
}