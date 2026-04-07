package com.coe313.courseregistration.controller.student;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.service.EnrollmentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class StudentScheduleController {
    private final EnrollmentService enrollmentService;

    @GetMapping("/schedule")
    public ResponseEntity<ApiResponse<List<SectionResponse>>> getSchedule() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return ResponseEntity.ok(ApiResponse.ok(enrollmentService.getStudentSchedule(email)));
    } 
}
