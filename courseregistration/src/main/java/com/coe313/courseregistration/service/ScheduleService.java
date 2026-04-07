package com.coe313.courseregistration.service;

import org.springframework.stereotype.Service;

import com.coe313.courseregistration.dto.ScheduleDto;
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
        // TODO: find section by crn, throw if not found
        // build Schedule entity from ScheduleDto
        // link to section, save and return mapped ScheduleDto
        return null;
    }

    /**
     * Updates an existing schedule slot.
     * @throws IllegalArgumentException if schedule not found
     */
    public ScheduleDto updateSchedule(Integer scheduleId, ScheduleDto request) {
        // TODO: find schedule by scheduleId, throw if not found
        // update day, startTime, endTime, room
        // save and return mapped ScheduleDto
        return null;
    }

    /**
     * Deletes a schedule slot.
     * @throws IllegalArgumentException if schedule not found
     */
    public void deleteSchedule(Integer scheduleId) {
        // TODO: find schedule by scheduleId, throw if not found
        // delete it
    }
}