import { Component, inject, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { DashboardService } from '../../../core/services/dashboard.service';
import { MajorCourseResponse } from '../../../shared/models/major.model';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { CourseResponse } from '../../../shared/models/course.model';
import { Course } from '../../../core/services/course.service';
import { DashboardResponse } from '../../../shared/models/dashboard.model';

@Component({
  selector: 'app-course-map',
  standalone: true,
  imports: [Navbar, RouterLink],
  templateUrl: './course-map.html',
  styleUrl: './course-map.css',
})
export class CourseMap implements OnInit {
  private dashboardService = inject(DashboardService);
  private courseService = inject(Course);
  
  dashboard : DashboardResponse | null = null;
  courseMap : MajorCourseResponse[] | null = null;
  selectedCourse: CourseResponse | null = null;
  modalOpen = false;

  async ngOnInit(): Promise<void> {
    this.dashboard = (await this.dashboardService.getDashboard())
    this.courseMap = this.dashboard.courseMap;
  }
  
  years = [1, 2, 3, 4, 5];

  get groupedByYear(): Record<number, MajorCourseResponse[]> {
    if (!this.courseMap) 
      return {};

    const grouped: Record<number, MajorCourseResponse[]> = {};

    for (const course of this.courseMap) {
      const year = course.recommendedYear ?? 0;

      if (!grouped[year]) 
        grouped[year] = [];
      grouped[year].push(course);
    }
    return grouped;
  }

  async openCourse(course: MajorCourseResponse): Promise<void> {
    this.modalOpen = true;
    this.selectedCourse = await this.courseService.getById(course.courseId);
  }

  closeModal(): void {
    this.modalOpen = false;
    this.selectedCourse = null;
  }

  getCourseStatus(course: MajorCourseResponse): 'completed' | 'ongoing' | 'not-started' {
    const abbr = course.courseAbbreviation;
    if (this.dashboard!.completedEnrollments.some(e => e.courseAbbreviation === abbr))
        return 'completed';
    if (this.dashboard!.currentEnrollments.some(e => e.courseAbbreviation === abbr))
        return 'ongoing';
    return 'not-started';
  }

}
