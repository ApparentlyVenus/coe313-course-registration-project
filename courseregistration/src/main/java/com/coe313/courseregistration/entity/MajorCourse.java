package com.coe313.courseregistration.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "major_course")
@Data @NoArgsConstructor @AllArgsConstructor
public class MajorCourse {
    @EmbeddedId
    private MajorCourseId id;

    @ManyToOne
    @MapsId("majorId")
    @JoinColumn(name = "major_id")
    private Major major;

    @ManyToOne
    @MapsId("courseId")
    @JoinColumn(name = "course_id")
    private Course course;

    private Integer recommendedYear;
    private Integer recommendedSemester;
    private Boolean isRequired = true;
}