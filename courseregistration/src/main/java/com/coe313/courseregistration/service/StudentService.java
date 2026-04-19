package com.coe313.courseregistration.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.StudentResponse;
import com.coe313.courseregistration.entity.Student;
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
        return studentRepository.findAll()
            .stream()
            .map(this::mapToResponse)
            .collect(Collectors.toList());
    }

    /**
     * Returns a single student by ID (admin use).
     * @throws IllegalArgumentException if student not found
     */
    @SuppressWarnings("null")
    public StudentResponse getStudentById(Integer id) {
        Student student = studentRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Student not found"));
        return mapToResponse(student);
    }

    /** 
     * Converts Student entity to student DTO.
    */
    private StudentResponse mapToResponse(Student student) {
        return new StudentResponse(
            student.getStudentId(),
            student.getFirstName(),
            student.getLastName(),
            student.getEmail()
        );
    }
}