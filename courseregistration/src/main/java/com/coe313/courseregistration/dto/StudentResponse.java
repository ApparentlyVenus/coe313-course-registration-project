package com.coe313.courseregistration.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class StudentResponse {
    private Integer studentId;
    private String firstName;
    private String lastName;
    private String email;
    private String majorName;
    private String majorAbbreviation;
}