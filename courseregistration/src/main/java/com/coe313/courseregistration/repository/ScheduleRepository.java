package com.coe313.courseregistration.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.coe313.courseregistration.entity.Schedule;
import com.coe313.courseregistration.entity.Section;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    List<Schedule> findBySection(Section section);
}
