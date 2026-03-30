package com.coe313.courseregistration.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Professor;
import com.coe313.courseregistration.entity.User;

@Repository
public interface ProfessorRepository extends JpaRepository<Professor, Integer> {
    Optional<Professor> findByUser(User user);
}