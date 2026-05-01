package com.coe313.courseregistration.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.CourseRequest;
import com.coe313.courseregistration.dto.CourseResponse;
import com.coe313.courseregistration.entity.Course;
import com.coe313.courseregistration.entity.Department;
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
     * Can take schoolId or departmentId as optional parameters
     */
    public List<CourseResponse> getAllCourses(Integer schoolId, Integer departmentId) {
        if (departmentId != null) {
            return courseRepository.findByDepartment_DepartmentId(departmentId)
                .stream().map(this::mapToResponse).toList();
        }
        if (schoolId != null) {
            return courseRepository.findByDepartment_School_SchoolId(schoolId)
                .stream().map(this::mapToResponse).toList();
        }
        return courseRepository.findAll()
            .stream().map(this::mapToResponse).toList();
    }

    /**
     * Returns a single course by ID.
     * @throws IllegalArgumentException if course not found
     */
    @SuppressWarnings("null")
    public CourseResponse getCourseById(Integer id) {
        Course course = courseRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Course not found"));
        return mapToResponse(course);
    }

    /**
     * Creates a new course.
     * @throws IllegalArgumentException if department not found
     * @throws IllegalArgumentException if any prerequisite course id not found
     */
    public CourseResponse createCourse(CourseRequest request) {
        @SuppressWarnings("null")
        Department department = departmentRepository.findById(request.getDepartmentId())
            .orElseThrow(() -> new IllegalArgumentException("Department not found"));
        
        Set<Course> prerequisites = new HashSet<>();
        if (request.getPrerequisiteIds() != null) {
            for (Integer prereqID : request.getPrerequisiteIds()) {
                @SuppressWarnings("null")
                Course prereq = courseRepository.findById(prereqID)
                    .orElseThrow(() -> new IllegalArgumentException("Prerequisite course not found: " + prereqID));
                prerequisites.add(prereq);
            }
        }

        Course course = new Course();
        course.setName(request.getName());
        course.setAbbreviation(request.getAbbreviation());
        course.setCredits(request.getCredits());
        course.setDepartment(department);
        course.setPrerequisites(prerequisites);

        return mapToResponse(courseRepository.save(course));
    }

    /**
     * Updates an existing course.
     * @throws IllegalArgumentException if course not found
     * @throws IllegalArgumentException if department not found
     * @throws IllegalArgumentException if any prerequisite course id not found
     */
    public CourseResponse updateCourse(Integer id, CourseRequest request) {
        @SuppressWarnings("null")
        Course course = courseRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Course not found"));

        @SuppressWarnings("null")
        Department department = departmentRepository.findById(request.getDepartmentId())
            .orElseThrow(() -> new IllegalArgumentException("Department not found"));
        
        Set<Course> prerequisites = new HashSet<>();
        if (request.getPrerequisiteIds() != null) {
            for (Integer prereqID : request.getPrerequisiteIds()) {
                @SuppressWarnings("null")
                Course prereq = courseRepository.findById(prereqID)
                    .orElseThrow(() -> new IllegalArgumentException("Prerequisite course not found: " + prereqID));
                prerequisites.add(prereq);
            }
        }
        
        course.setName(request.getName());
        course.setAbbreviation(request.getAbbreviation());
        course.setCredits(request.getCredits());
        course.setDepartment(department);
        course.setPrerequisites(prerequisites);

        return mapToResponse(courseRepository.save(course));
    }

    /**
     * Deletes a course by ID.
     * @throws IllegalArgumentException if course not found
     */
    @SuppressWarnings("null")
    public void deleteCourse(Integer id) {
        Course course = courseRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Course not found"));
        courseRepository.delete(course);
    }

    private CourseResponse mapToResponse(Course course) {
        List<String> prerequisites = course.getPrerequisites()
            .stream()
            .map(Course::getAbbreviation)
            .collect(Collectors.toList());

        return new CourseResponse(
            course.getCourseId(),
            course.getName(),
            course.getAbbreviation(),
            course.getCredits(),
            course.getDepartment() != null ? course.getDepartment().getName() : null,
            course.getDepartment() != null ? course.getDepartment().getAbbreviation() : null,
            course.getDescription(),
            prerequisites
        );
    }
}