export interface MajorResponse {
    majorId: number;
    name: string;
    abbreviation: string;
    totalCreditsRequired: number;
    schoolName: string;
}

export interface MajorCourseResponse {
    courseId: number;
    courseName: string;
    courseAbbreviation: string;
    credits: number;
    recommendedYear: number;
    recommendedSemester: number;
    isRequired: boolean;
}