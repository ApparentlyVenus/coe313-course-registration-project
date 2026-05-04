import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { Course } from '../../../core/services/course.service';
import { DepartmentService } from '../../../core/services/department.service';
import { CourseResponse } from '../../../shared/models/course.model';
import { DepartmentResponse } from '../../../shared/models/department.model';
import { SectionResponse } from '../../../shared/models/section.model';
import { Enrollment } from '../../../core/services/enrollment.service';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'app-student-courses',
    standalone: true,
    imports: [Navbar, FormsModule],
    templateUrl: './courses.html',
    styleUrl: './courses.css'
})
export class Courses implements OnInit {
    private courseService = inject(Course);
    private departmentService = inject(DepartmentService);
    private enrollmentService = inject(Enrollment);
    private route = inject(ActivatedRoute);

    courses: CourseResponse[] = [];
    departments: DepartmentResponse[] = [];
    search = '';
    displaySearch = '';
    selectedDepartmentId: number | null = null;
    modalOpen = false;
    selectedCourse: CourseResponse | null = null;
    sections: SectionResponse[] = [];

    get filtered(): CourseResponse[] {
        return this.courses.filter(c => {
            const matchesSearch = !this.displaySearch ||
                c.name.toLowerCase().includes(this.displaySearch.toLowerCase()) ||
                c.abbreviation.toLowerCase().includes(this.displaySearch.toLowerCase()) ||
                (c.departmentName || '').toLowerCase().includes(this.displaySearch.toLowerCase());

            const matchesDepartment = !this.selectedDepartmentId ||
                c.departmentAbbreviation === this.departments.find(
                    d => d.departmentId === this.selectedDepartmentId
                )?.abbreviation;

            return matchesSearch && matchesDepartment;
        });
    }

    async ngOnInit(): Promise<void> {
        [this.courses, this.departments] = await Promise.all([
            this.courseService.getAllForStudent(),
            this.departmentService.getAll()
        ]);

        const courseId = this.route.snapshot.queryParamMap.get('courseId');
        if (courseId) {
            const course = this.courses.find(c => c.courseId === +courseId);
            if (course) 
                this.openCourse(course);
        }
    }

    applySearch(): void {
        this.displaySearch = this.search;
    }

    clearSearch(): void {
        this.search = '';
        this.displaySearch = '';
        this.selectedDepartmentId = null;
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