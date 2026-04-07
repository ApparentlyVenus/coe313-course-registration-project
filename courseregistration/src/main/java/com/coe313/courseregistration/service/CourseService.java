package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.CourseRequest;
import com.coe313.courseregistration.dto.CourseResponse;
import com.coe313.courseregistration.repository.CourseRepository;
import com.coe313.courseregistration.repository.DepartmentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CourseService {

    private final CourseRepository courseRepository;
    private final DepartmentRepository departmentRepository;

    /**
     * Returns all courses in the system.
     */
    public List<CourseResponse> getAllCourses() {
        // TODO: fetch all courses
        // map each Course entity to CourseResponse
        // include department name, department abbreviation, and prerequisite abbreviations
        return null;
    }

    /**
     * Returns a single course by ID.
     * @throws IllegalArgumentException if course not found
     */
    public CourseResponse getCourseById(Integer id) {
        // TODO: find course by id
        // throw new IllegalArgumentException("Course not found") if absent
        // map to CourseResponse
        return null;
    }

    /**
     * Creates a new course.
     * @throws IllegalArgumentException if department not found
     * @throws IllegalArgumentException if any prerequisite course id not found
     */
    public CourseResponse createCourse(CourseRequest request) {
        // TODO: find department by request.getDepartmentId()
        // throw new IllegalArgumentException("Department not found") if absent
        // for each id in request.getPrerequisiteIds(), find the Course
        // throw new IllegalArgumentException("Prerequisite course not found") if any absent
        // build Course entity, set fields, set prerequisites
        // save and return mapped CourseResponse
        return null;
    }

    /**
     * Updates an existing course.
     * @throws IllegalArgumentException if course not found
     * @throws IllegalArgumentException if department not found
     * @throws IllegalArgumentException if any prerequisite course id not found
     */
    public CourseResponse updateCourse(Integer id, CourseRequest request) {
        // TODO: find course by id, throw if not found
        // update fields from request
        // update department and prerequisites same as createCourse
        // save and return mapped CourseResponse
        return null;
    }

    /**
     * Deletes a course by ID.
     * @throws IllegalArgumentException if course not found
     */
    public void deleteCourse(Integer id) {
        // TODO: find course by id, throw if not found
        // delete it
    }
}