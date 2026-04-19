import { Component, inject, OnInit } from '@angular/core';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { Enrollment } from '../../../core/services/enrollment';
import { SectionResponse } from '../../../shared/models/section.model';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-schedule',
  imports: [Navbar, RouterLink],
  templateUrl: './schedule.html',
  styleUrl: './schedule.css',
})
export class Schedule implements OnInit {  
  private enrollmentService = inject(Enrollment);

  days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  byDay: Record<string, { section: SectionResponse, slot: any }[]> = {};
  hasClasses = false;

  async ngOnInit(): Promise<void> {
    const sections = await this.enrollmentService.getMySchedule();
    this.days.forEach(d => this.byDay[d] = []);
    sections.forEach(section => {
      section.schedules.forEach(slot => {
        if (this.byDay[slot.dayOfWeek]) {
            this.byDay[slot.dayOfWeek].push({ section, slot });
        }
      });
    });
    this.hasClasses = Object.values(this.byDay).some(d => d.length > 0);
  }
}
