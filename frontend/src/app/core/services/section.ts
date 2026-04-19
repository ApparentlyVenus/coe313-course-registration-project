import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { SectionResponse, SectionRequest } from '../../shared/models/section.model';

@Injectable({
  providedIn: 'root',
})
export class Section {

  private http = inject(HttpClient);
  private readonly API = '/api/admin/sections';

  async getAll(): Promise<SectionResponse[]> {
    const res = await firstValueFrom(
      this.http.get<{ data: SectionResponse[] }>(this.API)
    );
    return res.data;
  }

  async getByCrn(crn: number): Promise<SectionResponse> {
    const res = await firstValueFrom(
      this.http.get<{ data: SectionResponse }>(`${this.API}/${crn}`)
    );
    return res.data;
  }

  async create(request: SectionRequest): Promise<SectionResponse> {
    const res = await firstValueFrom(
      this.http.post<{ data: SectionResponse }>(this.API, request)
    );
    return res.data;
  }

  async update(crn: number, request: SectionRequest): Promise<SectionResponse> {
    const res = await firstValueFrom(
      this.http.put<{ data: SectionResponse }>(`${this.API}/${crn}`, request)
    );
    return res.data;
  }

  async delete(crn: number): Promise<void> {
    await firstValueFrom(this.http.delete(`${this.API}/${crn}`));
  } 
}
