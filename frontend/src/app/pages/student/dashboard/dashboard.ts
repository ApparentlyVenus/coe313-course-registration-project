import { Component, inject, OnInit } from '@angular/core';
import { DashboardService } from '../../../core/services/dashboard.service';
import { DashboardResponse } from '../../../shared/models/dashboard.model';
import { Navbar } from '../../../shared/components/navbar/navbar';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-dashboard',
  imports: [Navbar, NgClass],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css',
})
export class Dashboard {
    private dashboardService = inject(DashboardService);

    dashboard: DashboardResponse | null = null;

    async ngOnInit(): Promise<void> {
      this.dashboard = await this.dashboardService.getDashboard();
    }
}
