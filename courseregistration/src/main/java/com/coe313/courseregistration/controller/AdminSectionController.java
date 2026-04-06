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
import com.coe313.courseregistration.dto.SectionRequest;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.service.SectionService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminSectionController {
    private final SectionService sectionService;
    
    @GetMapping("/sections")
    public ResponseEntity<ApiResponse<List<SectionResponse>>> getAllSections() {
        
    }

    @GetMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<SectionResponse>> getSectionByCRN(@PathVariable Integer crn) {

    }

    @PostMapping("/sections")
    public ResponseEntity<ApiResponse<SectionResponse>> createSection(@RequestBody SectionRequest request) {

    }

    @PutMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<SectionResponse>> updateSection(@PathVariable Integer crn, @RequestBody SectionRequest request) {

    }
    
    @DeleteMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<Void>> deleteSection(@PathVariable Integer id) {

    }
}
