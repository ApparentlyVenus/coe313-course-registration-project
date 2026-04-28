import { Component, inject, OnInit} from '@angular/core';
import { RouterLink } from '@angular/router';
import { DashboardService } from '../../../core/services/dashboard.service';
import { DashboardResponse } from '../../../shared/models/dashboard.model';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-dashboard',
  imports: [Navbar, NgClass, RouterLink],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css',
})
export class Dashboard implements OnInit {
  private dashboardService = inject(DashboardService);

  dashboard: DashboardResponse | null = null;

  async ngOnInit(): Promise<void> {
    this.dashboard = await this.dashboardService.getDashboard();
  }

  get progressPercent(): number {
    if (!this.dashboard)
      return 0;
    return Math.min(
      Math.round((this.dashboard.completedCredits / this.dashboard.requiredCredits) * 100),
      100
    );
  }

  get progressCircle(): string {
    const circumference = 2 * Math.PI * 54;
    const offset = circumference - (this.progressPercent / 100) * circumference;
    return `${circumference - offset} ${offset}`;
  }
}
