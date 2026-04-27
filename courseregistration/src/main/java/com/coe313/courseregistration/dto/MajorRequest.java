package com.coe313.courseregistration.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class MajorRequest {
    private String name;
    private String abbreviation;
    private Integer totalCreditsRequired;
    private Integer schoolId;
    
}
