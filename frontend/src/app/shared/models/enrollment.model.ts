export interface EnrollmentResponse {
    enrollmentId: number;
    courseName: string;
    courseAbbreviation: string;
    crn: number;
    sectionNumber: number;
    studentName: string;
    professorName: string;
    status: string;
    enrolledAt: string;
}

export interface EnrollmentRequest {
    crn: number;
    studentId?: number;
}