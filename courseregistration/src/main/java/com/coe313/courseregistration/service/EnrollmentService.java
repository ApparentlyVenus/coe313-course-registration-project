package com.coe313.courseregistration.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.EnrollmentResponse;
import com.coe313.courseregistration.repository.EnrollmentRepository;
import com.coe313.courseregistration.repository.SectionRepository;
import com.coe313.courseregistration.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EnrollmentService {

    private final EnrollmentRepository enrollmentRepository;
    private final SectionRepository sectionRepository;
    private final StudentRepository studentRepository;

    /**
     * Returns all enrollments in the system (admin use).
     */
    public List<EnrollmentResponse> getAllEnrollments() {
        // TODO: fetch all enrollments
        // map each to EnrollmentResponse
        return null;
    }

    /**
     * Returns all enrollments for a specific section (admin use).
     * includes enrolled, waitlisted, and dropped.
     * @throws IllegalArgumentException if section not found
     */
    public List<EnrollmentResponse> getEnrollmentsByCrn(Integer crn) {
        // TODO: find section by crn, throw if not found
        // find all enrollments for that section ordered by enrolledAt ascending
        // map to EnrollmentResponse
        return null;
    }

    /**
     * Returns all active enrollments for the authenticated student.
     * active = status is enrolled or waitlisted, not dropped.
     * @throws IllegalArgumentException if student not found
     */
    public List<EnrollmentResponse> getStudentEnrollments(Integer studentId) {
        // TODO: find student by id, throw if not found
        // find all enrollments by student where status != dropped
        // map to EnrollmentResponse
        return null;
    }

    /**
     * Returns all enrollments for a specific student (admin use).
     * @throws IllegalArgumentException if student not found
     */
    public List<EnrollmentResponse> getEnrollmentsByStudent(Integer studentId) {
        // TODO: find student by id, throw if not found
        // find all enrollments by student including dropped history
        // map to EnrollmentResponse
        return null;
    }

    /**
     * Enrolls a student in a section (student self-service).
     * this method must check ALL of the following in order:
     *
     * 1. student is not already enrolled in this course this semester
     *    → throw IllegalStateException("Already enrolled in this course this semester")
     *
     * 2. student has completed all prerequisites for the course
     *    → traverse the prerequisite GRAPH (this is the DS component)
     *    → throw IllegalStateException("Prerequisites not met: missing X, Y")
     *
     * 3. check for schedule conflict with student's existing enrollments
     *    → compare day + time intervals (interval overlap detection)
     *    → throw IllegalStateException("Schedule conflict with section CRN X")
     *
     * 4. check section capacity
     *    → count enrollments with status = enrolled
     *    → if count < capacity: enroll with status = enrolled
     *    → if count >= capacity: enroll with status = waitlisted (queue logic)
     *
     * @throws IllegalArgumentException if student or section not found
     * @throws IllegalStateException for any business rule violation above
     */
    public EnrollmentResponse enroll(Integer studentId, Integer crn) {
        // TODO: implement all checks above in order
        // set enrolledAt = LocalDateTime.now()
        // save and return mapped EnrollmentResponse
        return null;
    }

    /**
     * Drops a student from a section (student self-service).
     * after dropping, if there are waitlisted students for this section,
     * automatically promote the first one (earliest enrolledAt) to enrolled.
     * this is the QUEUE component — FIFO waitlist.
     *
     * @throws IllegalArgumentException if enrollment not found
     * @throws IllegalStateException if enrollment is already dropped
     */
    public void drop(Integer studentId, Integer crn) {
        // TODO: find enrollment by student and crn, throw if not found
        // throw IllegalStateException if status is already dropped
        // set status = dropped
        // check waitlist: find first waitlisted enrollment for this section ordered by enrolledAt
        // if exists: promote to enrolled
        // save
    }

    /**
     * Manually enrolls any student into any section (admin override).
     * skips prerequisite and conflict checks.
     * still respects capacity — waitlists if full.
     *
     * @throws IllegalArgumentException if student or section not found
     * @throws IllegalStateException if student already enrolled in this section
     */
    public EnrollmentResponse adminEnroll(Integer studentId, Integer crn) {
        // TODO: find student and section, throw if not found
        // check if enrollment already exists for this student + crn
        // check capacity, set status accordingly
        // save and return mapped EnrollmentResponse
        return null;
    }

    /**
     * Manually drops any enrollment by enrollment ID (admin override).
     * does NOT auto-promote waitlist — admin controls this manually.
     *
     * @throws IllegalArgumentException if enrollment not found
     */
    public void adminDrop(Integer enrollmentId) {
        // TODO: find enrollment by id, throw if not found
        // set status = dropped
        // save
    }

    /**
     * Promotes the first waitlisted student to enrolled (admin manual control).
     * @throws IllegalArgumentException if enrollment not found
     * @throws IllegalStateException if enrollment is not waitlisted
     */
    public EnrollmentResponse promoteFromWaitlist(Integer enrollmentId) {
        // TODO: find enrollment by id, throw if not found
        // throw IllegalStateException("Enrollment is not waitlisted") if status != waitlisted
        // set status = enrolled
        // save and return mapped EnrollmentResponse
        return null;
    }
}