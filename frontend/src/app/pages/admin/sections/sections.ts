import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Sidebar } from '../../../shared/components/sidebar/sidebar';
import { Section } from '../../../core/services/section';
import { SectionResponse, SectionRequest } from '../../../shared/models/section.model';

@Component({
  selector: 'app-sections',
  imports: [Sidebar, FormsModule],
  standalone: true,
  templateUrl: './sections.html',
  styleUrl: './sections.css',
})
export class Sections implements OnInit {
  private sectionService = inject(Section);

  sections: SectionResponse[] = [];
  filtered: SectionResponse[] = [];
  search = '';
  modalOpen = false;
  editCrn: number | null = null;

  form: SectionRequest = {
    courseId: 0, sectionNumber: 1, capacity: 30,
    professorId: 0, semesterId: 1, schedules: []
  };

  async ngOnInit(): Promise<void> { await this.load(); }
  
  async load(): Promise<void> {
    this.sections = await this.sectionService.getAll();
    this.filtered = [...this.sections];
  }

  filter(): void {
    const q = this.search.toLowerCase();
    this.filtered = this.sections.filter(s =>
      (s.courseName || '').toLowerCase().includes(q) ||
      (s.professorName || '').toLowerCase().includes(q) ||
      String(s.crn).includes(q)
    );
  }

  scheduleStr(section: SectionResponse): string {
    return section.schedules.map(s =>
      `${s.dayOfWeek.slice(0,3)} ${s.startTime?.slice(0,5)}–${s.endTime?.slice(0,5)}`
      ).join(', ') || '—';
  }

  capacityPct(s: SectionResponse): number {
    return s.capacity ? Math.min(Math.round((s.enrolled / s.capacity) * 100), 100) : 0;
  }

  openModal(section?: SectionResponse): void {
    this.editCrn = section?.crn ?? null;
    this.form = {
      courseId: 0,
      sectionNumber: section?.sectionNumber ?? 1,
      capacity: section?.capacity ?? 30,
      professorId: 0,
      semesterId: 1,
      schedules: section?.schedules ?? []
    };
    this.modalOpen = true;
  }

  closeModal(): void { this.modalOpen = false; }

  async save(): Promise<void> {
    try {
      if (this.editCrn) await this.sectionService.update(this.editCrn, this.form);
      else await this.sectionService.create(this.form);
      this.closeModal();
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to save section');
    }
  }

  async delete(crn: number): Promise<void> {
    if (!confirm('Delete this section?')) return;
    try {
      await this.sectionService.delete(crn);
      await this.load();
    } catch (err: any) {
      alert(err?.error?.message || 'Failed to delete section');
    }
  }
}
