package com.coe313.courseregistration.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class SectionRequest {
    private Integer courseId;
    private Integer sectionNumber;
    private Integer capacity;
    private Integer professorId;
    private Integer semesterId;
    private List<ScheduleDto> schedules;
}
