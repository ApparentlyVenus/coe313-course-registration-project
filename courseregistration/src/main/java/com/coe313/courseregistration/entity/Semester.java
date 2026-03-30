package com.coe313.courseregistration.entity;

import java.time.LocalDate;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Enumerated;
import jakarta.persistence.EnumType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity @Data @NoArgsConstructor @AllArgsConstructor
public class Semester {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer semesterId;

    @Enumerated(EnumType.STRING)
    private SemesterName name;
    private Integer academicYear;
    private LocalDate startDate;
    private LocalDate endDate;

    public enum SemesterName { Fall, Spring, Summer }
}