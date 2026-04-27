CREATE DATABASE IF NOT EXISTS course_registration;
USE course_registration;

-- ============================================================
-- SCHOOL
-- ============================================================
CREATE TABLE school (
    school_id    INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(150) NOT NULL UNIQUE,
    abbreviation VARCHAR(20)  NOT NULL UNIQUE
);

-- ============================================================
-- DEPARTMENT
-- ============================================================
CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    abbreviation  VARCHAR(20)  NOT NULL UNIQUE,
    school_id     INT,
    FOREIGN KEY (school_id) REFERENCES school(school_id) ON DELETE SET NULL
);

-- ============================================================
-- MAJOR
-- ============================================================
CREATE TABLE major (
    major_id               INT AUTO_INCREMENT PRIMARY KEY,
    name                   VARCHAR(150) NOT NULL,
    abbreviation           VARCHAR(20)  NOT NULL UNIQUE,
    total_credits_required INT          NOT NULL DEFAULT 120,
    school_id              INT,
    FOREIGN KEY (school_id) REFERENCES school(school_id) ON DELETE SET NULL
);

-- ============================================================
-- COURSE
-- ============================================================
CREATE TABLE course (
    course_id     INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(150) NOT NULL,
    abbreviation  VARCHAR(20)  NOT NULL UNIQUE,
    credits       INT          NOT NULL DEFAULT 3,
    description   TEXT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE SET NULL
);

-- ============================================================
-- MAJOR_COURSE  (the course map — which courses belong to a major)
-- recommended_semester: 1=Fall, 2=Spring, 3=Summer
-- ============================================================
CREATE TABLE major_course (
    major_id             INT     NOT NULL,
    course_id            INT     NOT NULL,
    recommended_year     INT,
    recommended_semester INT,
    is_required          BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (major_id, course_id),
    FOREIGN KEY (major_id)  REFERENCES major(major_id)   ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE
);

-- ============================================================
-- PREREQUISITE
-- ============================================================
CREATE TABLE prerequisite (
    course_id       INT NOT NULL,
    prerequisite_id INT NOT NULL,
    PRIMARY KEY (course_id, prerequisite_id),
    FOREIGN KEY (course_id)       REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_id) REFERENCES course(course_id) ON DELETE CASCADE
);

-- ============================================================
-- SEMESTER
-- ============================================================
CREATE TABLE semester (
    semester_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          ENUM('Fall', 'Spring', 'Summer') NOT NULL,
    academic_year INT  NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NOT NULL,
    UNIQUE (name, academic_year)
);

-- ============================================================
-- USERS
-- ============================================================
CREATE TABLE users (
    user_id  INT AUTO_INCREMENT PRIMARY KEY,
    email    VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     ENUM('STUDENT', 'ADMIN') NOT NULL DEFAULT 'STUDENT'
);

-- ============================================================
-- PROFESSOR
-- ============================================================
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

-- ============================================================
-- STUDENT
-- ============================================================
CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    major_id   INT,
    user_id    INT UNIQUE,
    FOREIGN KEY (major_id) REFERENCES major(major_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id)  REFERENCES users(user_id)  ON DELETE SET NULL
);

-- ============================================================
-- SECTION
-- ============================================================
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

-- ============================================================
-- SCHEDULE
-- ============================================================
CREATE TABLE schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    crn         INT NOT NULL,
    day_of_week ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
    start_time  TIME NOT NULL,
    end_time    TIME NOT NULL,
    room        VARCHAR(50),
    FOREIGN KEY (crn) REFERENCES section(crn) ON DELETE CASCADE
);

-- ============================================================
-- ENROLLMENT  (added 'completed' to status)
-- ============================================================
CREATE TABLE enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    crn           INT NOT NULL,
    status        ENUM('enrolled', 'waitlisted', 'dropped', 'completed') NOT NULL DEFAULT 'enrolled',
    enrolled_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (crn)        REFERENCES section(crn)        ON DELETE CASCADE,
    UNIQUE (student_id, crn)
);

-- ============================================================
-- SCHOOLS
-- ============================================================
INSERT INTO school (name, abbreviation) VALUES
('School of Engineering',                 'ENG'),
('School of Arts and Sciences',           'LAS'),
('Suliman S. Olayan School of Business',  'BUS'),
('School of Architecture and Design',     'ARCH'),
('School of Pharmacy',                    'PHAR'),
('School of Nursing',                     'NUR'),
('School of Communication Arts',          'COMM');

-- ============================================================
-- MAJORS
-- school_id: 1=ENG, 2=LAS, 3=BUS, 4=ARCH, 5=PHAR, 6=NUR, 7=COMM
-- ============================================================
INSERT INTO major (name, abbreviation, total_credits_required, school_id) VALUES
('Computer Engineering',    'COE',  135, 1),
('Electrical Engineering',  'ELE',  135, 1),
('Mechanical Engineering',  'MEE',  135, 1),
('Civil Engineering',       'CIE',  135, 1),
('Chemical Engineering',    'CHE',  135, 1),
('Computer Science',        'CSC',  120, 2),
('Mathematics',             'MTH',  120, 2),
('Business Administration', 'BUS',  120, 3),
('Accounting',              'ACC',  120, 3),
('Architecture',            'ARCH', 180, 4),
('Pharmacy',                'PHAR', 180, 5),
('Nursing',                 'NUR',  120, 6),
('Communication Arts',      'COMM', 120, 7);

-- ============================================================
-- USERS  (password is bcrypt of "password123")
-- ============================================================
INSERT INTO users (email, password, role) VALUES
('admin@lau.edu.lb',   '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'ADMIN'),
('coe@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('ele@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('mee@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('cie@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('che@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('csc@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('mth@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('bus@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('acc@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('arch@lau.edu.lb',    '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('phar@lau.edu.lb',    '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('nur@lau.edu.lb',     '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT'),
('comm@lau.edu.lb',    '$2a$10$7EqJtq98hPqEX7fNZaFWoOe3XLp/PQsF4QEFBEMhg7O9.LlD4VBWW', 'STUDENT');

-- ============================================================
-- STUDENTS  (one per major, major_id matches order above)
-- user_id 1=admin, 2=coe student, 3=ele, ...
-- ============================================================
INSERT INTO student (first_name, last_name, email, major_id, user_id) VALUES
('Student', 'COE',  'coe@lau.edu.lb',  1,  2),
('Student', 'ELE',  'ele@lau.edu.lb',  2,  3),
('Student', 'MEE',  'mee@lau.edu.lb',  3,  4),
('Student', 'CIE',  'cie@lau.edu.lb',  4,  5),
('Student', 'CHE',  'che@lau.edu.lb',  5,  6),
('Student', 'CSC',  'csc@lau.edu.lb',  6,  7),
('Student', 'MTH',  'mth@lau.edu.lb',  7,  8),
('Student', 'BUS',  'bus@lau.edu.lb',  8,  9),
('Student', 'ACC',  'acc@lau.edu.lb',  9,  10),
('Student', 'ARCH', 'arch@lau.edu.lb', 10, 11),
('Student', 'PHAR', 'phar@lau.edu.lb', 11, 12),
('Student', 'NUR',  'nur@lau.edu.lb',  12, 13),
('Student', 'COMM', 'comm@lau.edu.lb', 13, 14);