package com.coe313.courseregistration.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class SectionResponse {
    private Integer crn;
    private String courseName;
    private String courseAbbreviation;
    private Integer sectionNumber;
    private Integer capacity;
    private Integer enrolled;
    private String professorName;
    private List<ScheduleDto> schedules;
}
