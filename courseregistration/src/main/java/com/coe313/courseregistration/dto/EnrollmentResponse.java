package com.coe313.courseregistration.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class EnrollmentResponse {
    private Integer enrollmentId;
    private String courseName;
    private String courseAbbreviation;
    private Integer crn;
    private Integer sectionNumber;
    private String professorName;
    private String status;
    private LocalDateTime enrolledAt;
}