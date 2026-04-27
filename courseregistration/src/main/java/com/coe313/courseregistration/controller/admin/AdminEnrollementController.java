package com.coe313.courseregistration.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
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
        return ResponseEntity.ok(ApiResponse.ok(enrollmentService.getAllEnrollments()));
    }

    @GetMapping("/enrollments/{crn}")
    public ResponseEntity<ApiResponse<List<EnrollmentResponse>>> getEnrollmentsByCrn(@PathVariable Integer crn) {
        return ResponseEntity.ok(ApiResponse.ok(enrollmentService.getEnrollmentsByCrn(crn)));
    }

    @PostMapping("/enrollments") 
    public ResponseEntity<ApiResponse<EnrollmentResponse>> adminEnrollment(@RequestBody EnrollmentRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok("Student enrolled successfully", enrollmentService.adminEnroll(request.getStudentId(), request.getCrn())));
    }

    @DeleteMapping("/enrollments/{id}")
    public ResponseEntity<ApiResponse<Void>> adminDrop(@PathVariable Integer id) {
        enrollmentService.adminDrop(id);
        return ResponseEntity.ok(ApiResponse.ok("Enrollment dropped successfully", null));
    }

    @PutMapping("/enrollments/{id}/promote")
    public ResponseEntity<ApiResponse<EnrollmentResponse>> promoteFromWaitlist(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.ok("Student promoted from waitlist", enrollmentService.promoteFromWaitlist(id)));
    }

    @PatchMapping("/enrollments/{id}/complete")
    public ResponseEntity<ApiResponse<EnrollmentResponse>> markCompleted(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.ok("Marked enrollment as completed", enrollmentService.markCompleted(id)));
    }
}
