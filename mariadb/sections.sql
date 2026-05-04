USE course_registration;

-- Semester
INSERT INTO semester (name, academic_year, start_date, end_date)
VALUES ('Spring', 2026, '2026-01-15', '2026-05-30');

-- Professor
INSERT INTO users (email, password, role)
VALUES ('prof@lau.edu.lb', '$2b$12$hY/6RaRnlNqrQM2pVSNe1O0jIOpEuAZm9OLQraarZg1oUox9BQVSa', 'STUDENT');

INSERT INTO professor (first_name, last_name, email, department_id)
VALUES ('John', 'Doe', 'prof@lau.edu.lb', 1);

-- One section per course
INSERT INTO section (course_id, section_number, capacity, professor_id, semester_id)
SELECT course_id, 1, 30, 1, 1 FROM course;

-- COE 201 capacity 1 for waitlist demo
UPDATE section SET capacity = 1
WHERE course_id = (SELECT course_id FROM course WHERE abbreviation = 'COE 201')
AND section_number = 1;

-- Monday schedules for COE courses
INSERT INTO schedule (crn, day_of_week, start_time, end_time, room)
SELECT s.crn, 'Monday', '09:00:00', '10:00:00', 'SOE 301'
FROM section s
JOIN course c ON c.course_id = s.course_id
WHERE c.abbreviation IN ('COE 201','COE 211','COE 212','COE 312','COE 313','COE 321','COE 322','COE 323','COE 415','COE 416');

-- Wednesday schedules
INSERT INTO schedule (crn, day_of_week, start_time, end_time, room)
SELECT s.crn, 'Wednesday', '09:00:00', '10:00:00', 'SOE 301'
FROM section s
JOIN course c ON c.course_id = s.course_id
WHERE c.abbreviation IN ('COE 201','COE 211','COE 212','COE 312','COE 313','COE 321','COE 322','COE 323','COE 415','COE 416');

-- Friday schedules
INSERT INTO schedule (crn, day_of_week, start_time, end_time, room)
SELECT s.crn, 'Friday', '09:00:00', '10:00:00', 'SOE 301'
FROM section s
JOIN course c ON c.course_id = s.course_id
WHERE c.abbreviation IN ('COE 201','COE 211','COE 212','COE 312','COE 313','COE 321','COE 322','COE 323','COE 415','COE 416');