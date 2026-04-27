package com.coe313.courseregistration.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor
public class SchoolResponse {
    private Integer schoolId;
    private String name;
    private String abbreviation;
}