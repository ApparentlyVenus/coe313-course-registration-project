package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.MajorCourseResponse;
import com.coe313.courseregistration.dto.MajorResponse;
import com.coe313.courseregistration.entity.Major;
import com.coe313.courseregistration.entity.MajorCourse;
import com.coe313.courseregistration.repository.MajorCourseRepository;
import com.coe313.courseregistration.repository.MajorRepository;

import lombok.RequiredArgsConstructor;

@Service @RequiredArgsConstructor
public class MajorService {
    private final MajorRepository majorRepository;
    private final MajorCourseRepository majorCourseRepository;

    public List<MajorResponse> getAllMajors() {
        return majorRepository.findAll().stream().map(this::mapToResponse).toList();
    }

    public List<MajorResponse> getMajorsBySchool(Integer schoolId) {
        return majorRepository.findBySchool_SchoolId(schoolId)
            .stream().map(this::mapToResponse).toList();
    }

    @SuppressWarnings("null")
    public MajorResponse getMajorById(Integer id) {
        return mapToResponse(majorRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Major not found")));
    }

    public List<MajorCourseResponse> getCoursesByMajor(Integer majorId) {
    return majorCourseRepository.findByMajor_MajorId(majorId)
        .stream().map(this::mapToResponse).toList();
    }

    private MajorResponse mapToResponse(Major major) {
        return new MajorResponse(
            major.getMajorId(),
            major.getName(),
            major.getAbbreviation(),
            major.getTotalCreditsRequired(),
            major.getSchool() != null ? major.getSchool().getName() : null
        );
    }

    private MajorCourseResponse mapToResponse(MajorCourse mc) {
        return new MajorCourseResponse(
            mc.getCourse().getCourseId(),
            mc.getCourse().getName(),
            mc.getCourse().getAbbreviation(),
            mc.getCourse().getCredits(),
            mc.getRecommendedYear(),
            mc.getRecommendedSemester(),
            mc.getIsRequired()
        );
    }
}
