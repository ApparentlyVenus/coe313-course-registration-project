package com.coe313.courseregistration.controller.student;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.CourseResponse;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.service.CourseService;
import com.coe313.courseregistration.service.SectionService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/courses")
@RequiredArgsConstructor
public class StudentCourseController {
    private final CourseService courseService;
    private final SectionService sectionService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<CourseResponse>>> getAllCourses(
            @RequestParam(required = false) Integer schoolId,
            @RequestParam(required = false) Integer departmentId) {
        return ResponseEntity.ok(ApiResponse.ok(courseService.getAllCourses(schoolId, departmentId)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<CourseResponse>> getCourseById(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.ok(courseService.getCourseById(id)));
    }

    @GetMapping("/{id}/sections")
    public ResponseEntity<ApiResponse<List<SectionResponse>>> getSectionsByCourse(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.ok(sectionService.getSectionsByCourse(id)));
    }

    @GetMapping("/sections/{crn}")
    public ResponseEntity<ApiResponse<SectionResponse>> getSectionByCrn(@PathVariable Integer crn) {
        return ResponseEntity.ok(ApiResponse.ok(sectionService.getSectionByCrn(crn)));
    }
}
