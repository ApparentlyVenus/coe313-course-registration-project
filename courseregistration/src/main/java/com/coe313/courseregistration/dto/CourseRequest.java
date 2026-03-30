package com.coe313.courseregistration.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class CourseRequest {
    private String name;
    private String abbreviation;
    private Integer credits;
    private Integer departmentId;
    private List<Integer> prerequisiteIds;
}
