package com.coe313.courseregistration.dto;

import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class ScheduleDto {
    private String dayOfWeek;
    private LocalTime startTime;
    private LocalTime endTime;
    private String room;
}

