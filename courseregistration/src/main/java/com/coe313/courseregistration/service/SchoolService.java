package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.SchoolResponse;
import com.coe313.courseregistration.entity.School;
import com.coe313.courseregistration.repository.SchoolRepository;

import lombok.RequiredArgsConstructor;

@Service @RequiredArgsConstructor
public class SchoolService {
    private final SchoolRepository schoolRepository;

    public List<SchoolResponse> getAllSchools() {
        return schoolRepository.findAll().stream().map(this::mapToResponse).toList();
    }

    @SuppressWarnings("null")
    public SchoolResponse getSchoolById(Integer id) {
        return mapToResponse(schoolRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("School not found")));
    }

    private SchoolResponse mapToResponse(School school) {
        return new SchoolResponse(
            school.getSchoolId(), 
            school.getName(), 
            school.getAbbreviation());
    }
}
