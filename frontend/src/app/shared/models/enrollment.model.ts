export interface EnrollmentResponse {
    enrollmentId: number;
    courseName: string;
    courseAbbreviation: string;
    crn: number;
    sectionNumber: number;
    professorName: string;
    status: string;
    enrolledAt: string;
}

export interface EnrollmentRequest {
    crn: number;
    studentId?: number;
}