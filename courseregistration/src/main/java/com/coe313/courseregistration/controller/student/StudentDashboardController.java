package com.coe313.courseregistration.controller.student;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.DashboardResponse;
import com.coe313.courseregistration.service.DashboardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
public class StudentDashboardController {
    private final DashboardService dashboardService;

    @GetMapping("")
    public ResponseEntity<ApiResponse<DashboardResponse>> getDashboard() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return ResponseEntity.ok(ApiResponse.ok("Loaded Dashboard", dashboardService.getDashboard(email)));
    }
}
