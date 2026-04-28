import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { MajorResponse, MajorCourseResponse } from '../../shared/models/major.model';

@Injectable({ providedIn: 'root' })
export class MajorService {
    private http = inject(HttpClient);

    async getAll(schoolId?: number): Promise<MajorResponse[]> {
        const url = schoolId ? `/api/majors?schoolId=${schoolId}` : '/api/majors';
        const res = await firstValueFrom(
            this.http.get<{ data: MajorResponse[] }>(url)
        );
        return res.data;
    }

    async getCourseMap(majorId: number): Promise<MajorCourseResponse[]> {
        const res = await firstValueFrom(
            this.http.get<{ data: MajorCourseResponse[] }>(`/api/majors/${majorId}/courses`)
        );
        return res.data;
    }
}