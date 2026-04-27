package com.coe313.courseregistration.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor
public class MajorCourseResponse {
    private Integer courseId;
    private String courseName;
    private String courseAbbreviation;
    private Integer credits;
    private Integer recommendedYear;
    private Integer recommendedSemester;
    private Boolean isRequired;
}