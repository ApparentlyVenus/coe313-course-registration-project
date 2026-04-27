package com.coe313.courseregistration.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.coe313.courseregistration.entity.School;
public interface SchoolRepository extends JpaRepository<School, Integer> {}