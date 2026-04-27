package com.coe313.courseregistration.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class SemesterRequest {
    private String name;
    private Integer academicYear;
    private LocalDate startDate;
    private LocalDate endDate;
    
}
