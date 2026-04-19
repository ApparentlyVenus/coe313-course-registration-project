import { Component, inject, OnInit } from '@angular/core';
import { NgClass } from '@angular/common';
import { RouterLink } from '@angular/router';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { Enrollment } from '../../../core/services/enrollment';
import { EnrollmentResponse } from '../../../shared/models/enrollment.model';

@Component({
  selector: 'app-enrollments',
  standalone: true,
  imports: [Navbar, NgClass, RouterLink],
  templateUrl: './enrollments.html',
  styleUrl: './enrollments.css',
})
export class Enrollments implements OnInit {
  private enrollmentService = inject(Enrollment);

  enrollments: EnrollmentResponse[] = [];
  active: EnrollmentResponse[] = [];
  dropped: EnrollmentResponse[] = [];

  async ngOnInit(): Promise<void> { await this.load(); }
  
  async load(): Promise<void> {
    this.enrollments = await this.enrollmentService.getMyEnrollments();
    this.active = this.enrollments.filter(e => e.status !== 'dropped');
    this.dropped = this.enrollments.filter(e => e.status === 'dropped');
  }
  statusClass(status: string): string {
    if (status === 'enrolled') 
      return 'badge-enrolled';
    if (status === 'waitlisted') 
      return 'badge-waitlisted';
    return 'badge-dropped';
  }
  async drop(crn: number): Promise<void> {
    if (!confirm('Are you sure you want to drop this course?')) return;
    try {
      await this.enrollmentService.drop(crn);
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to drop course');
    }
  }
}
