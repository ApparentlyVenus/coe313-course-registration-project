// MajorRepository.java
package com.coe313.courseregistration.repository;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.coe313.courseregistration.entity.Major;

public interface MajorRepository extends JpaRepository<Major, Integer> {
    Optional<Major> findBySchool_SchoolId(Integer schoolId);
}