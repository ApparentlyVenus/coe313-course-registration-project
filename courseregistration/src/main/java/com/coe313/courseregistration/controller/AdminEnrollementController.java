package com.coe313.courseregistration.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.EnrollmentRequest;
import com.coe313.courseregistration.dto.EnrollmentResponse;
import com.coe313.courseregistration.service.EnrollmentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminEnrollementController {
    private final EnrollmentService enrollmentService;

    @GetMapping("/enrollments")
    public ResponseEntity<ApiResponse<List<EnrollmentResponse>>> getAllEnrollments() {

    }

    @GetMapping("/enrollments/{crn}")
    public ResponseEntity<ApiResponse<EnrollmentResponse>> getEnrollmentsByCrn(@PathVariable Integer crn) {

    }

    @PostMapping("/enrollments") 
    public ResponseEntity<ApiResponse<EnrollmentResponse>> manualEnrollment(@RequestBody EnrollmentRequest request) {

    }

    @DeleteMapping("/enrollments/{id}")
    public ResponseEntity<ApiResponse<Void>> manualDrop(@PathVariable Integer id) {

    }

    @PutMapping("/enrollments/{id}/promote")
    public ResponseEntity<ApiResponse<EnrollmentResponse>> promoteFromWaitlist(@PathVariable Integer id) {

    }
}
