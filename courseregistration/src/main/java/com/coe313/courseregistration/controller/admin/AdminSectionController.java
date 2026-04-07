package com.coe313.courseregistration.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
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
import com.coe313.courseregistration.dto.ScheduleDto;
import com.coe313.courseregistration.dto.SectionRequest;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.service.ScheduleService;
import com.coe313.courseregistration.service.SectionService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminSectionController {
    private final SectionService sectionService;
    private final ScheduleService scheduleService;
    
    @GetMapping("/sections")
    public ResponseEntity<ApiResponse<List<SectionResponse>>> getAllSections() {
        return ResponseEntity.ok(ApiResponse.ok(sectionService.getAllSections()));
    }

    @GetMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<SectionResponse>> getSectionByCRN(@PathVariable Integer crn) {
        return ResponseEntity.ok(ApiResponse.ok(sectionService.getSectionByCrn(crn)));
    }

    @PostMapping("/sections")
    public ResponseEntity<ApiResponse<SectionResponse>> createSection(@RequestBody SectionRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok("Section created successfully", sectionService.createSection(request)));
    }

    @PutMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<SectionResponse>> updateSection(@PathVariable Integer crn, @RequestBody SectionRequest request) {
        return ResponseEntity.ok(ApiResponse.ok("Section updated successfully", sectionService.updateSection(crn, request)));
    }
    
    @DeleteMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<Void>> deleteSection(@PathVariable Integer crn) {
        sectionService.deleteSection(crn);
        return ResponseEntity.ok(ApiResponse.ok("Section deleted successfully", null));
    }

    @PostMapping("/sections/{crn}/schedules")
    public ResponseEntity<ApiResponse<ScheduleDto>> addSchedule(@PathVariable Integer crn, @RequestBody ScheduleDto request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.ok("Schedule added successfully", scheduleService.addSchedule(crn, request)));
    }

    @PutMapping("/sections/{crn}/schedules/{id}")
    public ResponseEntity<ApiResponse<ScheduleDto>> updateSchedule(@PathVariable Integer crn, @PathVariable Integer id, @RequestBody ScheduleDto request) {
        return ResponseEntity.ok(ApiResponse.ok("Schedule updated successfully", scheduleService.updateSchedule(id, request)));
    }

    @DeleteMapping("/sections/{crn}/schedules/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteSchedule(@PathVariable Integer crn, @PathVariable Integer id) {
        scheduleService.deleteSchedule(id);
        return ResponseEntity.ok(ApiResponse.ok("Schedule deleted successfully", null));
    }
}
