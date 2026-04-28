import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { CourseResponse, CourseRequest } from '../../shared/models/course.model';
import { SectionResponse } from '../../shared/models/section.model';

@Injectable({
  providedIn: 'root',
})
export class Course {
  private http = inject(HttpClient);
  
  private readonly ADMIN = '/api/admin/courses';
  private readonly STUDENT = '/api/courses';

  async getAll(): Promise<CourseResponse[]> {
      const res = await firstValueFrom(
          this.http.get<{ data: CourseResponse[] }>(this.ADMIN)
      );
      return res.data;
  }

  async getById(id: number): Promise<CourseResponse> {
      const res = await firstValueFrom(
          this.http.get<{ data: CourseResponse }>(`${this.STUDENT}/${id}`)
      );
      return res.data;
  }

  async create(request: CourseRequest): Promise<CourseResponse> {
      const res = await firstValueFrom(
          this.http.post<{ data: CourseResponse }>(this.ADMIN, request)
      );
      return res.data;
  }

  async update(id: number, request: CourseRequest): Promise<CourseResponse> {
      const res = await firstValueFrom(
          this.http.put<{ data: CourseResponse }>(`${this.ADMIN}/${id}`, request)
      );
      return res.data;
  }

  async delete(id: number): Promise<void> {
      await firstValueFrom(
          this.http.delete(`${this.ADMIN}/${id}`)
      );
  }

  async getAllForStudent(): Promise<CourseResponse[]> {
      const res = await firstValueFrom(
          this.http.get<{ data: CourseResponse[] }>(this.STUDENT)
      );
      return res.data;
  }
  
  async getSections(courseId: number): Promise<SectionResponse[]> {
      const res = await firstValueFrom(
          this.http.get<{ data: SectionResponse[] }>(`${this.STUDENT}/${courseId}/sections`)
      );
      return res.data;
  }
}
