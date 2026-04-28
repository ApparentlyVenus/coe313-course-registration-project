import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Sidebar } from '../../../shared/components/sidebar/sidebar';
import { Course } from '../../../core/services/course.service';
import { CourseResponse, CourseRequest } from '../../../shared/models/course.model';

@Component({
  selector: 'app-courses',
  standalone: true,
  imports: [Sidebar, FormsModule],
  templateUrl: './courses.html',
  styleUrl: './courses.css',
})
export class Courses implements OnInit {
private courseService = inject(Course);

  courses: CourseResponse[] = [];
  filtered: CourseResponse[] = [];
  search = '';
  modalOpen = false;
  editId: number | null = null;
  form: CourseRequest = {
      name: '', abbreviation: '', credits: 3, departmentId: 0, prerequisiteIds: []
  };

  async ngOnInit(): Promise<void> {
    await this.load();
  }

  async load(): Promise<void> {
    this.courses = await this.courseService.getAll();
    this.filtered = [...this.courses];
  }

  filterCourses(): void {
    const q = this.search.toLowerCase();
    this.filtered = this.courses.filter(c =>
      c.name.toLowerCase().includes(q) ||
      c.abbreviation.toLowerCase().includes(q)
    );
  }

  openModal(course?: CourseResponse): void {
    this.editId = course?.courseId ?? null;
    this.form = {
      name: course?.name ?? '',
      abbreviation: course?.abbreviation ?? '',
      credits: course?.credits ?? 3,
      departmentId: 0,
      prerequisiteIds: []
    };
    this.modalOpen = true;
  }

  closeModal(): void { this.modalOpen = false; }

  async save(): Promise<void> {
    try {
      if (this.editId) 
        await this.courseService.update(this.editId, this.form);
      else 
        await this.courseService.create(this.form);
      this.closeModal();
      await this.load();
    } catch (err: any) {
        alert(err?.error?.message || 'Failed to save course');
    }
  }

  async delete(id: number): Promise<void> {
    if (!confirm('Delete this course?')) return;
    try {
      await this.courseService.delete(id);
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to delete course');
    }
  }
}
