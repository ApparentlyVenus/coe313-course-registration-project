import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { Course } from '../../../core/services/course.service';
import { Enrollment } from '../../../core/services/enrollment.service';
import { CourseResponse } from '../../../shared/models/course.model';
import { SectionResponse } from '../../../shared/models/section.model';

@Component({
    selector: 'app-student-courses',
    standalone: true,
    imports: [Navbar, FormsModule],
    templateUrl: './courses.html',
    styleUrl: './courses.css'
})
export class Courses implements OnInit {
    private courseService = inject(Course);
    private enrollmentService = inject(Enrollment);

    courses: CourseResponse[] = [];
    search = '';
    displaySearch = '';
    modalOpen = false;
    selectedCourse: CourseResponse | null = null;
    sections: SectionResponse[] = [];

    get filtered(): CourseResponse[] {
        const q = this.displaySearch.toLowerCase();
        if (!q) return this.courses;
        return this.courses.filter(c =>
            c.name.toLowerCase().includes(q) ||
            c.abbreviation.toLowerCase().includes(q) ||
            (c.departmentName || '').toLowerCase().includes(q)
        );
    }

    async ngOnInit(): Promise<void> {
        this.courses = await this.courseService.getAllForStudent();
    }

    applySearch(): void {
        this.displaySearch = this.search;
    }

    clearSearch(): void {
        this.search = '';
        this.displaySearch = '';
    }

    async openCourse(course: CourseResponse): Promise<void> {
        this.selectedCourse = course;
        this.sections = [];
        this.modalOpen = true;
        try {
            this.sections = await this.courseService.getSections(course.courseId);
        } catch (err: any) {
            console.error('Failed to load sections', err);
        }
    }

    closeModal(): void {
        this.modalOpen = false;
        this.selectedCourse = null;
        this.sections = [];
    }

    scheduleStr(s: SectionResponse): string {
        return s.schedules.map(x =>
            `${x.dayOfWeek.slice(0, 3)} ${x.startTime?.slice(0, 5)}–${x.endTime?.slice(0, 5)}`
        ).join(', ') || '—';
    }

    capacityPct(s: SectionResponse): number {
        return s.capacity ? Math.min(Math.round((s.enrolled / s.capacity) * 100), 100) : 0;
    }

    async enroll(crn: number): Promise<void> {
        try {
            const res = await this.enrollmentService.enroll(crn);
            alert(res.status === 'waitlisted' ? 'Added to waitlist' : 'Enrolled successfully');
            this.closeModal();
        } catch (err: any) {
            alert(err?.error?.message || 'Enrollment failed');
        }
    }
}