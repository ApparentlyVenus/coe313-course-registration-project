import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { Auth } from '../../../core/services/auth';

interface NavLink {
  path: string;
  label: string;
}

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive],
  templateUrl: './sidebar.html',
  styleUrl: './sidebar.css',
})
export class Sidebar {
  private authService = inject(Auth);
  private router = inject(Router);

  links: NavLink[] = [
    { path: '/admin/dashboard',   label: 'Dashboard' },
    { path: '/admin/courses',     label: 'Courses' },
    { path: '/admin/sections',    label: 'Sections' },
    { path: '/admin/students',    label: 'Students' },
    { path: '/admin/enrollments', label: 'Enrollments' },
  ];

  logout(): void {
    this.authService.logout();
  }
}
