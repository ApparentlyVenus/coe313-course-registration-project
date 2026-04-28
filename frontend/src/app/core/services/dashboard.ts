import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { DashboardResponse } from '../../shared/models/dashboard.model';

@Injectable({ providedIn: 'root' })
export class DashboardService {
    private http = inject(HttpClient);

    async getDashboard(): Promise<DashboardResponse> {
        const res = await firstValueFrom(
            this.http.get<{ data: DashboardResponse }>('/api/dashboard')
        );
        return res.data;
    }
}