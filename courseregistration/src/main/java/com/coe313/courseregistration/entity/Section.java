package com.coe313.courseregistration.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Entity @Data @NoArgsConstructor @AllArgsConstructor
public class Section {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer crn;
    private Integer sectionNumber;
    private Integer capacity;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne
    @JoinColumn(name = "professor_id")
    private Professor professor;

    @ManyToOne
    @JoinColumn(name = "semester_id")
    private Semester semester;

    @OneToMany(mappedBy = "section", cascade = CascadeType.ALL)
    private List<Schedule> schedules = new ArrayList<>();
}
