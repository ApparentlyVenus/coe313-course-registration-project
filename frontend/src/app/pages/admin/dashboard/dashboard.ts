import { Component, inject, OnInit } from '@angular/core';
import { Sidebar } from '../../../shared/components/sidebar/sidebar';
import { Course } from '../../../core/services/course.service';
import { Section } from '../../../core/services/section.service';
import { Student } from '../../../core/services/student.service';
import { Enrollment } from '../../../core/services/enrollment.service';
import { EnrollmentResponse } from '../../../shared/models/enrollment.model';
import { NgClass } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [Sidebar, NgClass, RouterLink],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css',
})
export class Dashboard implements OnInit{
  private courseService = inject(Course);
  private sectionService = inject(Section);
  private studentService = inject(Student);
  private enrollmentService = inject(Enrollment);

  statCourses = 0;
  statSections = 0;
  statStudents = 0;
  statEnrollments = 0;
  recentEnrollments: EnrollmentResponse[] = [];

  async ngOnInit(): Promise<void> {
    const [courses, sections, students, enrollments] = await Promise.all([
      this.courseService.getAll(),
      this.sectionService.getAll(),
      this.studentService.getAll(),
      this.enrollmentService.getAll()
    ]);
    this.statCourses = courses.length;
    this.statSections = sections.length;
    this.statStudents = students.length;
    this.statEnrollments = enrollments.length;
    this.recentEnrollments = enrollments.slice(0, 5);
  }

  statusClass(status: string): string {
      if (status === 'enrolled') return 'badge-enrolled';
      if (status === 'waitlisted') return 'badge-waitlisted';
      return 'badge-dropped';
  }

}
