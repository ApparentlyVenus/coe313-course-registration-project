import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { firstValueFrom } from 'rxjs';

export interface AuthRequest {
  email: string;
  password: string;
}

export interface AuthResponse {
  token: string;
  role: string;
}

@Injectable({
  providedIn: 'root',
})
export class Auth {
  private http = inject(HttpClient);
  private router = inject(Router);

  private readonly API = '/api/auth';

  async login(credentials: AuthRequest): Promise<AuthResponse> {
    const res = await firstValueFrom(
      this.http.post<{ data: AuthResponse }>(`${this.API}/login`, credentials)
    );
    const { token, role } = res.data;
    localStorage.setItem('token', token);
    localStorage.setItem('role', role);
    return res.data;
  }

  logout(): void {
    localStorage.removeItem('token');
    localStorage.removeItem('role');
    this.router.navigate(['/login']);
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }
  
  getRole(): string | null {
    return localStorage.getItem('role');
  }

  isLoggedIn(): boolean {
        return !!this.getToken();
    }

  isAdmin(): boolean {
        return this.getRole() === 'ADMIN';
    }
}
