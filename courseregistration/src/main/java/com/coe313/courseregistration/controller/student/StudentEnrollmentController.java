package com.coe313.courseregistration.controller.student;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.EnrollmentRequest;
import com.coe313.courseregistration.dto.EnrollmentResponse;
import com.coe313.courseregistration.service.EnrollmentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/enrollment")
@RequiredArgsConstructor
public class StudentEnrollmentController {
    private final EnrollmentService enrollmentService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<EnrollmentResponse>>> getEnrollments() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return ResponseEntity.ok(ApiResponse.ok(enrollmentService.getStudentEnrollments(email)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<EnrollmentResponse>> enroll(@RequestBody EnrollmentRequest request) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok("Enrolled successfully", enrollmentService.enroll(email, request.getCrn())));

    }

    @DeleteMapping("/{crn}")
    public ResponseEntity<ApiResponse<Void>> drop(@PathVariable Integer crn) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        enrollmentService.drop(email, crn);
        return ResponseEntity.ok(ApiResponse.ok("Dropped successfully", null));
    }
}
