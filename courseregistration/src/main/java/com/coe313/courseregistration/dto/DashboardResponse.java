package com.coe313.courseregistration.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class DashboardResponse {
    private String studentName;
    private String majorName;
    private Integer majorId;
    private Integer completedCredits;
    private Integer requiredCredits;
    private List<EnrollmentResponse> currentEnrollments;
    private List<MajorCourseResponse> courseMap;
}
