package com.coe313.courseregistration.controller.student;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.coe313.courseregistration.dto.ApiResponse;
import com.coe313.courseregistration.dto.DepartmentResponse;
import com.coe313.courseregistration.dto.MajorCourseResponse;
import com.coe313.courseregistration.dto.MajorResponse;
import com.coe313.courseregistration.dto.SchoolResponse;
import com.coe313.courseregistration.service.DepartmentService;
import com.coe313.courseregistration.service.MajorService;
import com.coe313.courseregistration.service.SchoolService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class StudentCatalogueController {
    private final SchoolService schoolService;
    private final DepartmentService departmentService;
    private final MajorService majorService;

    @GetMapping("/schools")
    public ResponseEntity<ApiResponse<List<SchoolResponse>>> getSchools() {
        return ResponseEntity.ok(ApiResponse.ok(schoolService.getAllSchools()));
    }

    @GetMapping("/departments")
    public ResponseEntity<ApiResponse<List<DepartmentResponse>>> getDepartments(
            @RequestParam(required = false) Integer schoolId) {
        List<DepartmentResponse> result = schoolId != null
            ? departmentService.getDepartmentsBySchool(schoolId)
            : departmentService.getAllDepartments();
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/majors")
    public ResponseEntity<ApiResponse<List<MajorResponse>>> getMajors(
            @RequestParam(required = false) Integer schoolId) {
        List<MajorResponse> result = schoolId != null
            ? majorService.getMajorsBySchool(schoolId)
            : majorService.getAllMajors();
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/majors/{id}")
    public ResponseEntity<ApiResponse<MajorResponse>> getMajorById(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.ok(majorService.getMajorById(id)));
    }

    @GetMapping("/majors/{id}/courses")
    public ResponseEntity<ApiResponse<List<MajorCourseResponse>>> getMajorCourses(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.ok(majorService.getCoursesByMajor(id)));
    }
}
