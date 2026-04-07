package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.SectionRequest;
import com.coe313.courseregistration.dto.SectionResponse;
import com.coe313.courseregistration.repository.CourseRepository;
import com.coe313.courseregistration.repository.EnrollmentRepository;
import com.coe313.courseregistration.repository.ProfessorRepository;
import com.coe313.courseregistration.repository.SectionRepository;
import com.coe313.courseregistration.repository.SemesterRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SectionService {

    private final SectionRepository sectionRepository;
    private final CourseRepository courseRepository;
    private final ProfessorRepository professorRepository;
    private final SemesterRepository semesterRepository;
    private final EnrollmentRepository enrollmentRepository;

    /**
     * Returns all sections for the current semester.
     * enrolled count = number of enrollments with status 'enrolled'
     */
    public List<SectionResponse> getAllSections() {
        // TODO: fetch all sections
        // for each section, count enrolled students (status = enrolled)
        // map to SectionResponse including schedules, professor name, enrolled count
        return null;
    }

    /**
     * Returns a single section by CRN.
     * @throws IllegalArgumentException if section not found
     */
    public SectionResponse getSectionByCrn(Integer crn) {
        // TODO: find section by crn
        // throw new IllegalArgumentException("Section not found") if absent
        // map to SectionResponse
        return null;
    }

    /**
     * Returns all sections for a specific course.
     * @throws IllegalArgumentException if course not found
     */
    public List<SectionResponse> getSectionsByCourse(Integer courseId) {
        // TODO: find course by id, throw if not found
        // find all sections by course
        // map to SectionResponse
        return null;
    }

    /**
     * Creates a new section with its schedules.
     * @throws IllegalArgumentException if course not found
     * @throws IllegalArgumentException if professor not found
     * @throws IllegalArgumentException if semester not found
     * @throws IllegalStateException if section number already exists for this course and semester
     */
    public SectionResponse createSection(SectionRequest request) {
        // TODO: find course, professor, semester by their ids, throw if any not found
        // check UNIQUE(course_id, section_number, semester_id) — throw IllegalStateException if duplicate
        // build Section entity
        // for each ScheduleDto in request.getSchedules(), build Schedule entity and link to section
        // save section (cascades to schedules) and return mapped SectionResponse
        return null;
    }

    /**
     * Updates an existing section.
     * @throws IllegalArgumentException if section not found
     * @throws IllegalArgumentException if professor not found
     */
    public SectionResponse updateSection(Integer crn, SectionRequest request) {
        // TODO: find section by crn, throw if not found
        // update capacity, professor (find by id)
        // do NOT change course or semester on an existing section
        // save and return mapped SectionResponse
        return null;
    }

    /**
     * Deletes a section by CRN.
     * cascades to schedules and enrollments via DB foreign keys.
     * @throws IllegalArgumentException if section not found
     */
    public void deleteSection(Integer crn) {
        // TODO: find section by crn, throw if not found
        // delete it — DB cascade handles schedules and enrollments
    }
}