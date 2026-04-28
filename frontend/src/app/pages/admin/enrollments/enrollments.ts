import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgClass } from '@angular/common';
import { Sidebar } from '../../../shared/components/sidebar/sidebar';
import { Enrollment } from '../../../core/services/enrollment.service';
import { EnrollmentResponse } from '../../../shared/models/enrollment.model';

@Component({
  selector: 'app-enrollments',
  standalone: true,
  imports: [Sidebar, FormsModule, NgClass],
  templateUrl: './enrollments.html',
  styleUrl: './enrollments.css',
})
export class Enrollments {

  private enrollmentService = inject(Enrollment);

  enrollments: EnrollmentResponse[] = [];
  filtered: EnrollmentResponse[] = [];
  search = '';
  modalOpen = false;
  enrollStudentId = 0;
  enrollCrn = 0;

  async ngOnInit(): Promise<void> { await this.load(); }

  async load(): Promise<void> {
    this.enrollments = await this.enrollmentService.getAll();
    this.filtered = [...this.enrollments];
  }

  filter(): void {
    const q = this.search.toLowerCase();
    this.filtered = this.enrollments.filter(e =>
      (e.courseName || '').toLowerCase().includes(q)
    );
  }

  statusClass(status: string): string {
    if (status === 'enrolled') 
      return 'badge-enrolled';
    if (status === 'waitlisted') 
      return 'badge-waitlisted';
    return 'badge-dropped';
  }

  formatDate(dt: string): string {
    if (!dt) return '—';
    return new Date(dt).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
  }

  async manualEnroll(): Promise<void> {
    try {
      await this.enrollmentService.adminEnroll({ studentId: this.enrollStudentId, crn: this.enrollCrn });
      this.modalOpen = false;
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to enroll student');
    }
  }

  async drop(id: number): Promise<void> {
    if (!confirm('Drop this enrollment?')) 
      return;
    try {
      await this.enrollmentService.adminDrop(id);
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to drop enrollment');
    }
  }

  async promote(id: number): Promise<void> {
    try {
      await this.enrollmentService.promote(id);
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to promote student');
    }
  }
}
