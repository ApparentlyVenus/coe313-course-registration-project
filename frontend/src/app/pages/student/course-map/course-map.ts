import { Component, inject, OnInit } from '@angular/core';
import { DashboardService } from '../../../core/services/dashboard.service';
import { MajorCourseResponse } from '../../../shared/models/major.model';
import { Navbar } from '../../../shared/components/navbar/navbar';

@Component({
  selector: 'app-course-map',
  standalone: true,
  imports: [Navbar],
  templateUrl: './course-map.html',
  styleUrl: './course-map.css',
})
export class CourseMap implements OnInit {
  private dashboardService = inject(DashboardService);

  courseMap : MajorCourseResponse[] | null = null;

  async ngOnInit(): Promise<void> {
    this.courseMap = (await this.dashboardService.getDashboard()).courseMap;
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

}
