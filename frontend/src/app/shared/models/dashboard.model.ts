import { EnrollmentResponse } from './enrollment.model';
import { MajorCourseResponse } from './major.model';

export interface DashboardResponse {
    studentName: string;
    majorName: string;
    completedCredits: number;
    requiredCredits: number;
    currentEnrollments: EnrollmentResponse[];
    courseMap: MajorCourseResponse[];
}