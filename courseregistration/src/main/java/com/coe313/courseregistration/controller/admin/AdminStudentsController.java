package com.coe313.courseregistration.controller.admin;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.EnrollmentResponse;
import com.coe313.courseregistration.dto.StudentResponse;
import com.coe313.courseregistration.service.StudentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin/")
@RequiredArgsConstructor
public class AdminStudentsController {
    private final StudentService studentService;

    @GetMapping("/students")
    public ResponseEntity<ApiResponse<List<StudentResponse>>> getAllStudents() {}

    @GetMapping("/students/{id}")
    public ResponseEntity<ApiResponse<StudentResponse>> getStudentById(@PathVariable Integer id) {}

    @GetMapping("/students/{id}/enrollments")
    public ResponseEntity<ApiResponse<List<EnrollmentResponse>>> getStudentEnrollments(@PathVariable Integer id) {}
    
}
