package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.SemesterRequest;
import com.coe313.courseregistration.dto.SemesterResponse;
import com.coe313.courseregistration.entity.Semester;
import com.coe313.courseregistration.repository.SemesterRepository;

import lombok.RequiredArgsConstructor;

@Service @RequiredArgsConstructor
public class SemesterService {
    private final SemesterRepository semesterRepository;

    public List<SemesterResponse> getAllSemesters() {
        return semesterRepository.findAll().stream().map(this::mapToResponse).toList();
    }

    @SuppressWarnings("null")
    public SemesterResponse getSemesterById(Integer id) {
        return mapToResponse(semesterRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Semester not found")));
    }

    public SemesterResponse createSemester(SemesterRequest request) {
        Semester semester = new Semester();
        semester.setName(Semester.SemesterName.valueOf(request.getName()));
        semester.setAcademicYear(request.getAcademicYear());
        semester.setStartDate(request.getStartDate());
        semester.setEndDate(request.getEndDate());
        return mapToResponse(semesterRepository.save(semester));
    }

    @SuppressWarnings("null")
    public SemesterResponse updateSemester(Integer id, SemesterRequest request) {
        Semester semester = semesterRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Semester not found"));
        semester.setName(Semester.SemesterName.valueOf(request.getName()));
        semester.setAcademicYear(request.getAcademicYear());
        semester.setStartDate(request.getStartDate());
        semester.setEndDate(request.getEndDate());
        return mapToResponse(semesterRepository.save(semester));
    }

    @SuppressWarnings("null")
    public void deleteSemester(Integer id) {
        semesterRepository.deleteById(id);
    }

    private SemesterResponse mapToResponse(Semester semester) {
        return new SemesterResponse(
            semester.getSemesterId(),
            semester.getName().toString(),
            semester.getAcademicYear(),
            semester.getStartDate(),
            semester.getEndDate()
        );
    }
}
