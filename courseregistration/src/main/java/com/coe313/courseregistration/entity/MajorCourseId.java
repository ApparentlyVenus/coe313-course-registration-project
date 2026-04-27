package com.coe313.courseregistration.entity;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data @NoArgsConstructor @AllArgsConstructor
public class MajorCourseId implements Serializable {
    private Integer majorId;
    private Integer courseId;
}

