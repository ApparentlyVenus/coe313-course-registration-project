import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { EnrollmentResponse, EnrollmentRequest } from '../../shared/models/enrollment.model';
import { SectionResponse } from '../../shared/models/section.model';

@Injectable({
  providedIn: 'root',
})
export class Enrollment {

  private http = inject(HttpClient);
  private readonly ADMIN = '/api/admin/enrollments';
  private readonly STUDENT = '/api/enrollment';

  async getAll(): Promise<EnrollmentResponse[]> {
      const res = await firstValueFrom(
        this.http.get<{ data: EnrollmentResponse[] }>(this.ADMIN)
      );
      return res.data;
  }
  async getByCrn(crn: number): Promise<EnrollmentResponse[]> {
      const res = await firstValueFrom(
        this.http.get<{ data: EnrollmentResponse[] }>(`${this.ADMIN}/${crn}`)
      );
      return res.data;
  }
  async adminEnroll(request: EnrollmentRequest): Promise<EnrollmentResponse> {
      const res = await firstValueFrom(
        this.http.post<{ data: EnrollmentResponse }>(this.ADMIN, request)
      );
      return res.data;
  }
  async adminDrop(enrollmentId: number): Promise<void> {
      await firstValueFrom(this.http.delete(`${this.ADMIN}/${enrollmentId}`));
  }
  async promote(enrollmentId: number): Promise<EnrollmentResponse> {
      const res = await firstValueFrom(
        this.http.put<{ data: EnrollmentResponse }>(`${this.ADMIN}/${enrollmentId}/promote`, {})
      );
      return res.data;
  }
  async getMyEnrollments(): Promise<EnrollmentResponse[]> {
      const res = await firstValueFrom(
        this.http.get<{ data: EnrollmentResponse[] }>(this.STUDENT)
      );
      return res.data;
  }
  async enroll(crn: number): Promise<EnrollmentResponse> {
      const res = await firstValueFrom(
        this.http.post<{ data: EnrollmentResponse }>(this.STUDENT, { crn })
      );
      return res.data;
  }
  async drop(crn: number): Promise<void> {
      await firstValueFrom(this.http.delete(`${this.STUDENT}/${crn}`));
  }
  async getMySchedule(): Promise<SectionResponse[]> {
      const res = await firstValueFrom(
        this.http.get<{ data: SectionResponse[] }>('/api/schedule')
      );
      return res.data;
  }

  async markComplete(enrollmentId: number): Promise<EnrollmentResponse> {
    const res = await firstValueFrom(
      this.http.patch<{data: EnrollmentResponse}>(`/api/admin/enrollments/${enrollmentId}/complete`, {})
    )
    return res.data;
  }
}
