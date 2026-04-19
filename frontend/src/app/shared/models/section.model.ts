export interface ScheduleDto {
    dayOfWeek: string;
    startTime: string;
    endTime: string;
    room: string;
}

export interface SectionResponse {
    crn: number;
    courseName: string;
    courseAbbreviation: string;
    sectionNumber: number;
    capacity: number;
    enrolled: number;
    professorName: string;
    schedules: ScheduleDto[];
}

export interface SectionRequest {
    courseId: number;
    sectionNumber: number;
    capacity: number;
    professorId: number;
    semesterId: number;
    schedules: ScheduleDto[];
}