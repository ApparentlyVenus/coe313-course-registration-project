// MajorRepository.java
package com.coe313.courseregistration.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.coe313.courseregistration.entity.Major;

public interface MajorRepository extends JpaRepository<Major, Integer> {
    List<Major> findBySchool_SchoolId(Integer schoolId);
}