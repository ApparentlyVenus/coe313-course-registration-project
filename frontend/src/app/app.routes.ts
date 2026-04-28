import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth-guard';
import { adminGuard } from './core/guards/auth-guard';

export const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'login', loadComponent: () => import('./pages/login/login').then(m => m.Login) },

  // admin routes
  { path: 'admin/dashboard',   canActivate: [adminGuard], loadComponent: () => import('./pages/admin/dashboard/dashboard').then(m => m.Dashboard) },
  { path: 'admin/courses',     canActivate: [adminGuard], loadComponent: () => import('./pages/admin/courses/courses').then(m => m.Courses) },
  { path: 'admin/sections',    canActivate: [adminGuard], loadComponent: () => import('./pages/admin/sections/sections').then(m => m.Sections) },
  { path: 'admin/students',    canActivate: [adminGuard], loadComponent: () => import('./pages/admin/students/students').then(m => m.Students) },
  { path: 'admin/enrollments', canActivate: [adminGuard], loadComponent: () => import('./pages/admin/enrollments/enrollments').then(m => m.Enrollments) },

  // student routes
  { path: 'student/courses',     canActivate: [authGuard], loadComponent: () => import('./pages/student/courses/courses').then(m => m.Courses) },
  { path: 'student/enrollments', canActivate: [authGuard], loadComponent: () => import('./pages/student/enrollments/enrollments').then(m => m.Enrollments) },
  { path: 'student/schedule',    canActivate: [authGuard], loadComponent: () => import('./pages/student/schedule/schedule').then(m => m.Schedule) },
  { path: 'student/dashboard',   canActivate: [authGuard], loadComponent: () => import('./pages/student/dashboard/dashboard').then(m => m.Dashboard) },
  { path: 'student/course-map',  canActivate: [authGuard], loadComponent: () => import('./pages/student/course-map/course-map').then(m => m.CourseMap) },
  
  { path: '**', redirectTo: 'login' }
]