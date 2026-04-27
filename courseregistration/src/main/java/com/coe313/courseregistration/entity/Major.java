package com.coe313.courseregistration.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity @Data @NoArgsConstructor @AllArgsConstructor
public class Major {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer majorId;
    private String name;
    private String abbreviation;
    private Integer totalCreditsRequired;

    @ManyToOne
    @JoinColumn(name = "school_id")
    private School school;
}
