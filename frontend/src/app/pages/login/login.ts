import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Auth } from '../../core/services/auth';

@Component({
  selector: 'app-login',
  imports: [FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {
  private authService = inject(Auth);
  private router = inject(Router);

  email = '';
  password = '';
  error = '';
  loading = false;

  async onSubmit(): Promise<void> {
    this.error = '';
    this.loading = true;
    try {
      const res = await this.authService.login({
        email: this.email,
        password: this.password
      });
      if (res.role === 'ADMIN') 
        this.router.navigate(['/admin/dashboard']);
      else 
        this.router.navigate(['/student/courses']);
    } catch (err: any) {
      this.error = err?.error?.message || 'Invalid email or password';
    } finally {
      this.loading = false;
    }
  }
}
