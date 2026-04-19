import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Sidebar } from '../../../shared/components/sidebar/sidebar';
import { Student } from '../../../core/services/student';
import { Enrollment } from '../../../core/services/enrollment';
import { StudentResponse } from '../../../shared/models/student.model';
import { EnrollmentResponse } from '../../../shared/models/enrollment.model';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-students',
  imports: [Sidebar, FormsModule, NgClass],
  standalone: true,
  templateUrl: './students.html',
  styleUrl: './students.css',
})
export class Students implements OnInit {
  private studentService = inject(Student);
  private enrollmentService = inject(Enrollment);

  students: StudentResponse[] = [];
  filtered: StudentResponse[] = [];
  search = '';
  modalOpen = false;
  selectedStudent: StudentResponse | null = null;
  enrollments: EnrollmentResponse[] = [];

  async ngOnInit(): Promise<void> { await this.load(); }

  async load(): Promise<void> {
    this.students = await this.studentService.getAll();
    this.filtered = [...this.students];
  }

  filter(): void {
    const q = this.search.toLowerCase();
    this.filtered = this.students.filter(s =>
      `${s.firstName} ${s.lastName}`.toLowerCase().includes(q) ||
      s.email.toLowerCase().includes(q)
    );
  }

  initials(s: StudentResponse): string {
    return ((s.firstName?.[0] || '') + (s.lastName?.[0] || '')).toUpperCase();
  }

  async viewEnrollments(student: StudentResponse): Promise<void> {
    this.selectedStudent = student;
    this.enrollments = await this.studentService.getEnrollments(student.studentId);
    this.modalOpen = true;
  }

  closeModal(): void { this.modalOpen = false; }

  statusClass(status: string): string {
    if (status === 'enrolled') return 'badge-enrolled';
    if (status === 'waitlisted') return 'badge-waitlisted';
    return 'badge-dropped';
  }
}
