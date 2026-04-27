package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.DepartmentResponse;
import com.coe313.courseregistration.entity.Department;
import com.coe313.courseregistration.repository.DepartmentRepository;

import lombok.RequiredArgsConstructor;

@Service @RequiredArgsConstructor
public class DepartmentService {
    private final DepartmentRepository departmentRepository;

    public List<DepartmentResponse> getAllDepartments() {
        return departmentRepository.findAll().stream().map(this::mapToResponse).toList();
    }

    public List<DepartmentResponse> getDepartmentsBySchool(Integer schoolId) {
        return departmentRepository.findBySchool_SchoolId(schoolId)
            .stream().map(this::mapToResponse).toList();
    }
    
    private DepartmentResponse mapToResponse(Department dept) {
        return new DepartmentResponse(
            dept.getDepartmentId(),
            dept.getName(),
            dept.getAbbreviation(),
            dept.getSchool() != null ? dept.getSchool().getName() : null
        );
    }

}
