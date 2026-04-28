import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { DepartmentResponse } from '../../shared/models/department.model';

@Injectable({ providedIn: 'root' })
export class DepartmentService {
    private http = inject(HttpClient);

    async getAll(schoolId?: number): Promise<DepartmentResponse[]> {
        const url = schoolId ? `/api/departments?schoolId=${schoolId}` : '/api/departments';
        const res = await firstValueFrom(
            this.http.get<{ data: DepartmentResponse[] }>(url)
        );
        return res.data;
    }
}