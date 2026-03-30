package com.coe313.courseregistration.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Semester;

@Repository
public interface SemesterRepository extends JpaRepository<Semester, Integer> {
    Optional<Semester> findByNameAndAcademicYear(Semester.SemesterName name, Integer year);
}
