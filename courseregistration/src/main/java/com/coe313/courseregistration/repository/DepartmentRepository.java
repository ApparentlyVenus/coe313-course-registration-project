package com.coe313.courseregistration.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Department;

// repository/DepartmentRepository.java
@Repository
public interface DepartmentRepository extends JpaRepository<Department, Integer> {}
