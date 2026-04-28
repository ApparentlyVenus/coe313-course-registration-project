export interface CourseResponse {
    courseId: number;
    name: string;
    abbreviation: string;
    credits: number;
    departmentName: string;
    departmentAbbreviation: string;
    description: string;
    prerequisites: string[];
}

export interface CourseRequest {
    name: string;
    abbreviation: string;
    credits: number;
    departmentId: number;
    prerequisiteIds: number[];
}