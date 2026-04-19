package com.coe313.courseregistration.service;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.ScheduleDto;
import com.coe313.courseregistration.entity.Schedule;
import com.coe313.courseregistration.entity.Section;
import com.coe313.courseregistration.repository.ScheduleRepository;
import com.coe313.courseregistration.repository.SectionRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;
    private final SectionRepository sectionRepository;

    /**
     * Adds a new schedule slot to an existing section.
     * @throws IllegalArgumentException if section not found
     */
    public ScheduleDto addSchedule(Integer crn, ScheduleDto request) {
        @SuppressWarnings("null")
        Section section = sectionRepository.findById(crn)
            .orElseThrow(() -> new IllegalArgumentException("Section not found"));

        Schedule schedule = new Schedule();
        schedule.setDayOfWeek(request.getDayOfWeek());
        schedule.setStartTime(request.getStartTime());
        schedule.setEndTime(request.getEndTime());
        schedule.setRoom(request.getRoom());
        schedule.setSection(section);

        return mapToDto(scheduleRepository.save(schedule));
    }

    /**
     * Updates an existing schedule slot.
     * @throws IllegalArgumentException if schedule not found
     */
    public ScheduleDto updateSchedule(Integer scheduleId, ScheduleDto request) {
        @SuppressWarnings("null")
        Schedule schedule = scheduleRepository.findById(scheduleId)
            .orElseThrow(() -> new IllegalArgumentException("Schedule not found"));

        schedule.setDayOfWeek(request.getDayOfWeek());
        schedule.setStartTime(request.getStartTime());
        schedule.setEndTime(request.getEndTime());
        schedule.setRoom(request.getRoom());

        return mapToDto(scheduleRepository.save(schedule));
    }

    /**
     * Deletes a schedule slot.
     * @throws IllegalArgumentException if schedule not found
     */
    @SuppressWarnings("null")
    public void deleteSchedule(Integer scheduleId) {
        @SuppressWarnings("null")
        Schedule schedule = scheduleRepository.findById(scheduleId)
            .orElseThrow(() -> new IllegalArgumentException("Schedule not found"));
        scheduleRepository.delete(schedule);
    }


    private ScheduleDto mapToDto(Schedule schedule) {
        return new ScheduleDto(
            schedule.getDayOfWeek(),
            schedule.getStartTime(),
            schedule.getEndTime(),
            schedule.getRoom()
        );
    }
}