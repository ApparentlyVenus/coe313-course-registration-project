package com.coe313.courseregistration.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class CourseResponse {
    private Integer courseId;
    private String name;
    private String abbreviation;
    private Integer credits;
    private String departmentName;        
    private String departmentAbbreviation;
    private List<String> prerequisites;
}
