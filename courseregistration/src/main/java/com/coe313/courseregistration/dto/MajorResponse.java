package com.coe313.courseregistration.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor
public class MajorResponse {
    private Integer majorId;
    private String name;
    private String abbreviation;
    private Integer totalCreditsRequired;
    private String schoolName;
}