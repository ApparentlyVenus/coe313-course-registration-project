package com.coe313.courseregistration.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class DepartmentResponse {
    private Integer departmentId;
    private String name;
    private String abbreviation;
    private String schoolName;
}
