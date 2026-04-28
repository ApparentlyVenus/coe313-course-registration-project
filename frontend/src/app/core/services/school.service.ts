import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { SchoolResponse } from '../../shared/models/school.model';

@Injectable({ providedIn: 'root' })
export class SchoolService {
    private http = inject(HttpClient);

    async getAll(): Promise<SchoolResponse[]> {
        const res = await firstValueFrom(
            this.http.get<{ data: SchoolResponse[] }>('/api/schools')
        );
        return res.data;
    }
}