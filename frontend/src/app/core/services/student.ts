import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { StudentResponse } from '../../shared/models/student.model';
import { EnrollmentResponse } from '../../shared/models/enrollment.model';

@Injectable({
  providedIn: 'root',
})
export class Student {
  private http = inject(HttpClient);
  private readonly API = '/api/admin/students';

  async getAll(): Promise<StudentResponse[]> {
    const res = await firstValueFrom(
      this.http.get<{ data: StudentResponse[] }>(this.API)
    );
    return res.data;
  }

  async getById(id: number): Promise<StudentResponse> {
    const res = await firstValueFrom(
      this.http.get<{ data: StudentResponse }>(`${this.API}/${id}`)
    );
    return res.data;
  }

  async getEnrollments(id: number): Promise<EnrollmentResponse[]> {
    const res = await firstValueFrom(
      this.http.get<{ data: EnrollmentResponse[] }>(`${this.API}/${id}/enrollments`)
    );
    return res.data;
  }
}
