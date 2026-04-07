package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.StudentResponse;
import com.coe313.courseregistration.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentService {

    private final StudentRepository studentRepository;

    /**
     * Returns all students in the system (admin use).
     */
    public List<StudentResponse> getAllStudents() {
        // TODO: fetch all students
        // map each Student entity to StudentResponse
        return null;
    }

    /**
     * Returns a single student by ID (admin use).
     * @throws IllegalArgumentException if student not found
     */
    public StudentResponse getStudentById(Integer id) {
        // TODO: find student by id
        // throw new IllegalArgumentException("Student not found") if absent
        // map to StudentResponse
        return null;
    }
}