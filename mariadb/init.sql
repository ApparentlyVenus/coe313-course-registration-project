CREATE DATABASE IF NOT EXISTS course_registration;
USE course_registration;

-- ============================================================
-- SCHEMA
-- ============================================================

CREATE TABLE users (
    user_id  INT AUTO_INCREMENT PRIMARY KEY,
    email    VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     ENUM('ADMIN', 'STUDENT') NOT NULL
);

CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    abbreviation  VARCHAR(20)  NOT NULL UNIQUE
);

CREATE TABLE course (
    course_id     INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    abbreviation  VARCHAR(20)  NOT NULL,
    credits       INT          NOT NULL DEFAULT 3,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE SET NULL
);

CREATE TABLE semester (
    semester_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          ENUM('Fall', 'Spring', 'Summer') NOT NULL,
    academic_year INT  NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NOT NULL,
    UNIQUE (name, academic_year)
);

CREATE TABLE professor (
    professor_id  INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    user_id       INT UNIQUE,
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id)       REFERENCES users(user_id)            ON DELETE SET NULL
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    user_id    INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE section (
    crn            INT AUTO_INCREMENT PRIMARY KEY,
    course_id      INT NOT NULL,
    section_number INT NOT NULL,
    capacity       INT NOT NULL DEFAULT 30,
    professor_id   INT,
    semester_id    INT NOT NULL,
    FOREIGN KEY (course_id)    REFERENCES course(course_id)       ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES professor(professor_id) ON DELETE SET NULL,
    FOREIGN KEY (semester_id)  REFERENCES semester(semester_id)   ON DELETE CASCADE,
    UNIQUE (course_id, section_number, semester_id)
);

CREATE TABLE schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    crn         INT NOT NULL,
    day_of_week ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
    start_time  TIME NOT NULL,
    end_time    TIME NOT NULL,
    room        VARCHAR(50),
    FOREIGN KEY (crn) REFERENCES section(crn) ON DELETE CASCADE
);

CREATE TABLE enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    crn           INT NOT NULL,
    status        ENUM('enrolled', 'waitlisted', 'dropped') NOT NULL DEFAULT 'enrolled',
    enrolled_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (crn)        REFERENCES section(crn)        ON DELETE CASCADE,
    UNIQUE (student_id, crn)
);

CREATE TABLE prerequisite (
    course_id       INT NOT NULL,
    prerequisite_id INT NOT NULL,
    PRIMARY KEY (course_id, prerequisite_id),
    FOREIGN KEY (course_id)       REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_id) REFERENCES course(course_id) ON DELETE CASCADE
);