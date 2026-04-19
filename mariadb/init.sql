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

-- ============================================================
-- SEED DATA
-- ============================================================

-- ============================================================
-- DEPARTMENTS
-- ============================================================
INSERT INTO department (name, abbreviation) VALUES
('Computer Engineering',  'COE'),
('Electrical Engineering','ELE'),
('Mathematics',           'MTH'),
('General Engineering',   'GNE'),
('English',               'ENG'),
('Communications',        'COM'),
('Industrial Engineering','INE');

-- ============================================================
-- USERS
-- password for all users is: password123
-- bcrypt hash: $2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG
-- ============================================================
INSERT INTO users (email, password, role) VALUES
-- Admin
('admin@lau.edu.lb',          '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
-- Professors
('rchahine@lau.edu.lb',       '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('mhalawi@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('nkhoury@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('afarhat@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('jnasser@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('sgebran@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('habboud@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('ksalem@lau.edu.lb',         '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
('mrizk@lau.edu.lb',          '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'ADMIN'),
-- Students
('ahmad.karimi@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('lara.haddad@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('omar.salameh@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('maya.nassar@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('karim.abou@lau.edu.lb',     '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('nour.khalil@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('hassan.ibrahim@lau.edu.lb', '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('rima.khoury@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('jad.mansour@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('sara.azar@lau.edu.lb',      '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('ziad.farah@lau.edu.lb',     '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('dina.saad@lau.edu.lb',      '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('peter.gemayel@lau.edu.lb',  '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('lina.barakat@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('mark.rizk@lau.edu.lb',      '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('tala.hajj@lau.edu.lb',      '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('firas.nasser@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('nadine.karam@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('ali.daher@lau.edu.lb',      '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('carla.hanna@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('youssef.sleiman@lau.edu.lb','$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('jana.moussa@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('rami.chaaban@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('hiba.torbey@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('charbel.eid@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('rana.jabbour@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('elie.sarkis@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('mia.bou@lau.edu.lb',        '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('tony.wehbe@lau.edu.lb',     '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('celine.nassar@lau.edu.lb',  '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('georges.frem@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('sarah.akkawi@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('tarek.hamdan@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('joelle.azzi@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('habib.chalhoub@lau.edu.lb', '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('nadia.elkhoury@lau.edu.lb', '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('mario.bitar@lau.edu.lb',    '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('luna.francis@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('bassem.habib@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('christelle.abi@lau.edu.lb', '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('wael.darwish@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('pamela.rahme@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('karim.elamine@lau.edu.lb',  '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('rouba.ghanem@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT'),
('simon.aboujaoude@lau.edu.lb','$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG','STUDENT'),
('mirna.elhajj@lau.edu.lb',   '$2a$10$Tu4yJQAKChWuLxbAlcK0lerrzPlFUzJM3qo9t4XJR04GrYAFaW3JG', 'STUDENT');

-- ============================================================
-- PROFESSORS
-- ============================================================
INSERT INTO professor (first_name, last_name, email, department_id, user_id) VALUES
('Rabih',   'Chahine', 'rchahine@lau.edu.lb', 1, 2),
('Maroun',  'Halawi',  'mhalawi@lau.edu.lb',  1, 3),
('Nada',    'Khoury',  'nkhoury@lau.edu.lb',  1, 4),
('Antoine', 'Farhat',  'afarhat@lau.edu.lb',  2, 5),
('Joanna',  'Nasser',  'jnasser@lau.edu.lb',  2, 6),
('Salim',   'Gebran',  'sgebran@lau.edu.lb',  3, 7),
('Hana',    'Abboud',  'habboud@lau.edu.lb',  4, 8),
('Kamal',   'Salem',   'ksalem@lau.edu.lb',   5, 9),
('Michel',  'Rizk',    'mrizk@lau.edu.lb',    6, 10);

-- ============================================================
-- STUDENTS
-- ============================================================
INSERT INTO student (first_name, last_name, email, user_id) VALUES
('Ahmad',      'Karimi',      'ahmad.karimi@lau.edu.lb',    11),
('Lara',       'Haddad',      'lara.haddad@lau.edu.lb',     12),
('Omar',       'Salameh',     'omar.salameh@lau.edu.lb',    13),
('Maya',       'Nassar',      'maya.nassar@lau.edu.lb',     14),
('Karim',      'Abou',        'karim.abou@lau.edu.lb',      15),
('Nour',       'Khalil',      'nour.khalil@lau.edu.lb',     16),
('Hassan',     'Ibrahim',     'hassan.ibrahim@lau.edu.lb',  17),
('Rima',       'Khoury',      'rima.khoury@lau.edu.lb',     18),
('Jad',        'Mansour',     'jad.mansour@lau.edu.lb',     19),
('Sara',       'Azar',        'sara.azar@lau.edu.lb',       20),
('Ziad',       'Farah',       'ziad.farah@lau.edu.lb',      21),
('Dina',       'Saad',        'dina.saad@lau.edu.lb',       22),
('Peter',      'Gemayel',     'peter.gemayel@lau.edu.lb',   23),
('Lina',       'Barakat',     'lina.barakat@lau.edu.lb',    24),
('Mark',       'Rizk',        'mark.rizk@lau.edu.lb',       25),
('Tala',       'Hajj',        'tala.hajj@lau.edu.lb',       26),
('Firas',      'Nasser',      'firas.nasser@lau.edu.lb',    27),
('Nadine',     'Karam',       'nadine.karam@lau.edu.lb',    28),
('Ali',        'Daher',       'ali.daher@lau.edu.lb',       29),
('Carla',      'Hanna',       'carla.hanna@lau.edu.lb',     30),
('Youssef',    'Sleiman',     'youssef.sleiman@lau.edu.lb', 31),
('Jana',       'Moussa',      'jana.moussa@lau.edu.lb',     32),
('Rami',       'Chaaban',     'rami.chaaban@lau.edu.lb',    33),
('Hiba',       'Torbey',      'hiba.torbey@lau.edu.lb',     34),
('Charbel',    'Eid',         'charbel.eid@lau.edu.lb',     35),
('Rana',       'Jabbour',     'rana.jabbour@lau.edu.lb',    36),
('Elie',       'Sarkis',      'elie.sarkis@lau.edu.lb',     37),
('Mia',        'Bou',         'mia.bou@lau.edu.lb',         38),
('Tony',       'Wehbe',       'tony.wehbe@lau.edu.lb',      39),
('Celine',     'Nassar',      'celine.nassar@lau.edu.lb',   40),
('Georges',    'Frem',        'georges.frem@lau.edu.lb',    41),
('Sarah',      'Akkawi',      'sarah.akkawi@lau.edu.lb',    42),
('Tarek',      'Hamdan',      'tarek.hamdan@lau.edu.lb',    43),
('Joelle',     'Azzi',        'joelle.azzi@lau.edu.lb',     44),
('Habib',      'Chalhoub',    'habib.chalhoub@lau.edu.lb',  45),
('Nadia',      'El-Khoury',   'nadia.elkhoury@lau.edu.lb',  46),
('Mario',      'Bitar',       'mario.bitar@lau.edu.lb',     47),
('Luna',       'Francis',     'luna.francis@lau.edu.lb',    48),
('Bassem',     'Habib',       'bassem.habib@lau.edu.lb',    49),
('Christelle', 'Abi',         'christelle.abi@lau.edu.lb',  50),
('Wael',       'Darwish',     'wael.darwish@lau.edu.lb',    51),
('Pamela',     'Rahme',       'pamela.rahme@lau.edu.lb',    52),
('Karim',      'El-Amine',    'karim.elamine@lau.edu.lb',   53),
('Rouba',      'Ghanem',      'rouba.ghanem@lau.edu.lb',    54),
('Simon',      'Abou-Jaoude', 'simon.aboujaoude@lau.edu.lb',55),
('Mirna',      'El-Hajj',     'mirna.elhajj@lau.edu.lb',    56),
('Patrick',    'Sassine',     'patrick.sassine@lau.edu.lb', NULL),
('Lea',        'Zgheib',      'lea.zgheib@lau.edu.lb',      NULL),
('Elias',      'Moawad',      'elias.moawad@lau.edu.lb',    NULL),
('Rita',       'Feghali',     'rita.feghali@lau.edu.lb',    NULL),
('Joseph',     'Bechara',     'joseph.bechara@lau.edu.lb',  NULL);

-- ============================================================
-- SEMESTER
-- ============================================================
INSERT INTO semester (name, academic_year, start_date, end_date) VALUES
('Spring', 2026, '2026-01-19', '2026-05-30');

-- ============================================================
-- COURSES
-- ============================================================
INSERT INTO course (name, abbreviation, credits, department_id) VALUES
('Computer Proficiency',        'COE 201',  1, 1),
('Computer Programming',        'COE 211',  4, 1),
('Logic Design',                'COE 321',  3, 1),
('Logic Design Lab',            'COE 322',  1, 1),
('Microprocessors',             'COE 323',  3, 1),
('Microprocessors Lab',         'COE 324',  1, 1),
('Data Structures',             'COE 312',  3, 1),
('Data Structures Lab',         'COE 313',  1, 1),
('Computer Programming II',     'COE 415',  3, 1),
('Computer Programming II Lab', 'COE 415B', 1, 1),
('Software Engineering',        'COE 416',  3, 1),
('Database Systems',            'COE 418',  3, 1),
('Computer Architecture',       'COE 423',  3, 1),
('Digital Systems',             'COE 424',  3, 1),
('Digital Systems Lab',         'COE 425',  1, 1),
('Operating Systems',           'COE 414',  3, 1),
('Computer Networks',           'COE 431',  3, 1),
('Embedded Systems',            'COE 521',  3, 1),
('Professionalism 3rd Year',    'COE 493',  3, 1),
('COE Application',             'COE 593',  3, 1),
('Capstone Design Project I',   'COE 595',  3, 1),
('Capstone Design Project II',  'COE 596',  3, 1),
('Electric Circuits',           'ELE 300',  3, 2),
('Electric Circuits Lab',       'ELE 303',  1, 2),
('Electronics I',               'ELE 401',  3, 2),
('Electronics I Lab',           'ELE 402',  1, 2),
('Signals & Systems',           'ELE 430',  3, 2),
('Control Systems',             'ELE 442',  3, 2),
('Control Systems Lab',         'ELE 443',  1, 2),
('Communication Systems',       'ELE 537',  3, 2),
('Communication Systems Lab',   'ELE 540',  1, 2),
('Calculus III',                'MTH 201',  3, 3),
('Calculus IV',                 'MTH 206',  3, 3),
('Discrete Structures',         'MTH 207',  3, 3),
('Differential Equations',      'MTH 304',  3, 3),
('Engineering Mechanics',       'GNE 212',  3, 4),
('Probability & Statistics',    'GNE 331',  3, 4),
('Engineering Ethics',          'GNE 303',  2, 4),
('Professional Communication',  'GNE 301',  2, 4),
('English I',                   'ENG 101',  3, 5),
('English II',                  'ENG 102',  3, 5),
('Advanced Academic English',   'ENG 202',  3, 5),
('Art of Public Communication', 'COM 203',  3, 6),
('Engineering Economy I',       'INE 320',  3, 7);

-- ============================================================
-- PREREQUISITES
-- ============================================================
INSERT INTO prerequisite (course_id, prerequisite_id) VALUES
(4,  3),   -- COE 322 requires COE 321
(5,  3),   -- COE 323 requires COE 321
(6,  5),   -- COE 324 requires COE 323
(7,  2),   -- COE 312 requires COE 211
(8,  7),   -- COE 313 requires COE 312
(9,  7),   -- COE 415 requires COE 312
(10, 9),   -- COE 415B requires COE 415
(11, 7),   -- COE 416 requires COE 312
(12, 7),   -- COE 418 requires COE 312
(13, 5),   -- COE 423 requires COE 323
(14, 3),   -- COE 424 requires COE 321
(15, 14),  -- COE 425 requires COE 424
(16, 7),   -- COE 414 requires COE 312
(17, 7),   -- COE 431 requires COE 312
(18, 5),   -- COE 521 requires COE 323
(24, 23),  -- ELE 303 requires ELE 300
(25, 23),  -- ELE 401 requires ELE 300
(26, 25),  -- ELE 402 requires ELE 401
(27, 35),  -- ELE 430 requires MTH 304
(28, 27),  -- ELE 442 requires ELE 430
(29, 28),  -- ELE 443 requires ELE 442
(30, 27),  -- ELE 537 requires ELE 430
(31, 30),  -- ELE 540 requires ELE 537
(33, 32),  -- MTH 206 requires MTH 201
(35, 33),  -- MTH 304 requires MTH 206
(40, 39),  -- ENG 102 requires ENG 101
(41, 40);  -- ENG 202 requires ENG 102

-- ============================================================
-- SECTIONS (Spring 2026, semester_id = 1)
-- ============================================================
INSERT INTO section (course_id, section_number, capacity, professor_id, semester_id) VALUES
(7,  1, 30, 1, 1),  -- COE 312 §1
(7,  2, 30, 2, 1),  -- COE 312 §2
(7,  3, 25, 3, 1),  -- COE 312 §3
(8,  1, 20, 1, 1),  -- COE 313 §1
(8,  2, 20, 2, 1),  -- COE 313 §2
(8,  3, 20, 3, 1),  -- COE 313 §3
(3,  1, 35, 1, 1),  -- COE 321 §1
(3,  2, 35, 2, 1),  -- COE 321 §2
(4,  1, 20, 1, 1),  -- COE 322 §1
(4,  2, 20, 2, 1),  -- COE 322 §2
(5,  1, 30, 2, 1),  -- COE 323 §1
(5,  2, 30, 3, 1),  -- COE 323 §2
(6,  1, 20, 2, 1),  -- COE 324 §1
(6,  2, 20, 3, 1),  -- COE 324 §2
(9,  1, 30, 1, 1),  -- COE 415 §1
(11, 1, 30, 3, 1),  -- COE 416 §1
(12, 1, 30, 2, 1),  -- COE 418 §1
(13, 1, 30, 1, 1),  -- COE 423 §1
(16, 1, 30, 3, 1),  -- COE 414 §1
(23, 1, 35, 4, 1),  -- ELE 300 §1
(23, 2, 35, 5, 1),  -- ELE 300 §2
(25, 1, 30, 4, 1),  -- ELE 401 §1
(26, 1, 20, 4, 1),  -- ELE 402 §1
(26, 2, 20, 5, 1),  -- ELE 402 §2
(27, 1, 30, 5, 1),  -- ELE 430 §1
(32, 1, 40, 6, 1),  -- MTH 201 §1
(32, 2, 40, 6, 1),  -- MTH 201 §2
(34, 1, 35, 6, 1),  -- MTH 207 §1
(37, 1, 35, 7, 1),  -- GNE 331 §1
(39, 1, 25, 8, 1),  -- ENG 101 §1
(39, 2, 25, 8, 1),  -- ENG 101 §2
(40, 1, 25, 8, 1),  -- ENG 102 §1
(40, 2, 25, 9, 1);  -- ENG 102 §2

-- ============================================================
-- SCHEDULES
-- ============================================================
INSERT INTO schedule (crn, day_of_week, start_time, end_time, room) VALUES
(1,  'Monday',    '08:00:00', '09:00:00', 'ENG-201'),
(1,  'Wednesday', '08:00:00', '09:00:00', 'ENG-201'),
(1,  'Friday',    '08:00:00', '09:00:00', 'ENG-201'),
(2,  'Monday',    '10:00:00', '11:00:00', 'ENG-202'),
(2,  'Wednesday', '10:00:00', '11:00:00', 'ENG-202'),
(2,  'Friday',    '10:00:00', '11:00:00', 'ENG-202'),
(3,  'Tuesday',   '09:30:00', '11:00:00', 'ENG-203'),
(3,  'Thursday',  '09:30:00', '11:00:00', 'ENG-203'),
(4,  'Tuesday',   '14:00:00', '17:00:00', 'LAB-101'),
(5,  'Wednesday', '14:00:00', '17:00:00', 'LAB-101'),
(6,  'Thursday',  '14:00:00', '17:00:00', 'LAB-101'),
(7,  'Monday',    '11:00:00', '12:00:00', 'ENG-301'),
(7,  'Wednesday', '11:00:00', '12:00:00', 'ENG-301'),
(7,  'Friday',    '11:00:00', '12:00:00', 'ENG-301'),
(8,  'Tuesday',   '11:00:00', '12:30:00', 'ENG-302'),
(8,  'Thursday',  '11:00:00', '12:30:00', 'ENG-302'),
(9,  'Monday',    '14:00:00', '17:00:00', 'LAB-102'),
(10, 'Wednesday', '14:00:00', '17:00:00', 'LAB-102'),
(11, 'Monday',    '09:00:00', '10:00:00', 'ENG-401'),
(11, 'Wednesday', '09:00:00', '10:00:00', 'ENG-401'),
(11, 'Friday',    '09:00:00', '10:00:00', 'ENG-401'),
(12, 'Tuesday',   '08:00:00', '09:30:00', 'ENG-402'),
(12, 'Thursday',  '08:00:00', '09:30:00', 'ENG-402'),
(13, 'Tuesday',   '14:00:00', '17:00:00', 'LAB-103'),
(14, 'Thursday',  '14:00:00', '17:00:00', 'LAB-103'),
(15, 'Monday',    '13:00:00', '14:00:00', 'ENG-201'),
(15, 'Wednesday', '13:00:00', '14:00:00', 'ENG-201'),
(15, 'Friday',    '13:00:00', '14:00:00', 'ENG-201'),
(16, 'Tuesday',   '13:00:00', '14:30:00', 'ENG-301'),
(16, 'Thursday',  '13:00:00', '14:30:00', 'ENG-301'),
(17, 'Monday',    '14:00:00', '15:00:00', 'ENG-202'),
(17, 'Wednesday', '14:00:00', '15:00:00', 'ENG-202'),
(17, 'Friday',    '14:00:00', '15:00:00', 'ENG-202'),
(18, 'Tuesday',   '15:30:00', '17:00:00', 'ENG-401'),
(18, 'Thursday',  '15:30:00', '17:00:00', 'ENG-401'),
(19, 'Monday',    '12:00:00', '13:00:00', 'ENG-302'),
(19, 'Wednesday', '12:00:00', '13:00:00', 'ENG-302'),
(19, 'Friday',    '12:00:00', '13:00:00', 'ENG-302'),
(20, 'Monday',    '08:00:00', '09:00:00', 'ENG-501'),
(20, 'Wednesday', '08:00:00', '09:00:00', 'ENG-501'),
(20, 'Friday',    '08:00:00', '09:00:00', 'ENG-501'),
(21, 'Tuesday',   '09:30:00', '11:00:00', 'ENG-502'),
(21, 'Thursday',  '09:30:00', '11:00:00', 'ENG-502'),
(22, 'Monday',    '11:00:00', '12:00:00', 'ENG-501'),
(22, 'Wednesday', '11:00:00', '12:00:00', 'ENG-501'),
(22, 'Friday',    '11:00:00', '12:00:00', 'ENG-501'),
(23, 'Monday',    '14:00:00', '17:00:00', 'LAB-201'),
(24, 'Wednesday', '14:00:00', '17:00:00', 'LAB-201'),
(25, 'Tuesday',   '11:00:00', '12:30:00', 'ENG-501'),
(25, 'Thursday',  '11:00:00', '12:30:00', 'ENG-501'),
(26, 'Monday',    '08:00:00', '09:00:00', 'LAS-101'),
(26, 'Wednesday', '08:00:00', '09:00:00', 'LAS-101'),
(26, 'Friday',    '08:00:00', '09:00:00', 'LAS-101'),
(27, 'Tuesday',   '08:00:00', '09:30:00', 'LAS-102'),
(27, 'Thursday',  '08:00:00', '09:30:00', 'LAS-102'),
(28, 'Monday',    '10:00:00', '11:00:00', 'LAS-101'),
(28, 'Wednesday', '10:00:00', '11:00:00', 'LAS-101'),
(28, 'Friday',    '10:00:00', '11:00:00', 'LAS-101'),
(29, 'Tuesday',   '13:00:00', '14:30:00', 'ENG-301'),
(29, 'Thursday',  '13:00:00', '14:30:00', 'ENG-301'),
(30, 'Monday',    '09:00:00', '10:00:00', 'LAS-201'),
(30, 'Wednesday', '09:00:00', '10:00:00', 'LAS-201'),
(30, 'Friday',    '09:00:00', '10:00:00', 'LAS-201'),
(31, 'Tuesday',   '11:00:00', '12:30:00', 'LAS-202'),
(31, 'Thursday',  '11:00:00', '12:30:00', 'LAS-202'),
(32, 'Monday',    '10:00:00', '11:00:00', 'LAS-201'),
(32, 'Wednesday', '10:00:00', '11:00:00', 'LAS-201'),
(32, 'Friday',    '10:00:00', '11:00:00', 'LAS-201'),
(33, 'Tuesday',   '13:00:00', '14:30:00', 'LAS-202'),
(33, 'Thursday',  '13:00:00', '14:30:00', 'LAS-202');

-- ============================================================
-- ENROLLMENTS
-- ============================================================
INSERT INTO enrollment (student_id, crn, status, enrolled_at) VALUES
-- COE 312 §1 (crn=1, cap=30)
(1,  1, 'enrolled',   '2025-12-01 09:00:00'),
(2,  1, 'enrolled',   '2025-12-01 09:05:00'),
(3,  1, 'enrolled',   '2025-12-01 09:10:00'),
(4,  1, 'enrolled',   '2025-12-01 09:15:00'),
(5,  1, 'enrolled',   '2025-12-01 09:20:00'),
(6,  1, 'enrolled',   '2025-12-01 09:25:00'),
(7,  1, 'enrolled',   '2025-12-01 09:30:00'),
(8,  1, 'enrolled',   '2025-12-01 09:35:00'),
(9,  1, 'enrolled',   '2025-12-01 09:40:00'),
(10, 1, 'enrolled',   '2025-12-01 09:45:00'),
(11, 1, 'enrolled',   '2025-12-01 09:50:00'),
(12, 1, 'enrolled',   '2025-12-01 09:55:00'),
(13, 1, 'enrolled',   '2025-12-01 10:00:00'),
(14, 1, 'enrolled',   '2025-12-01 10:05:00'),
(15, 1, 'enrolled',   '2025-12-01 10:10:00'),
(16, 1, 'enrolled',   '2025-12-01 10:15:00'),
(17, 1, 'enrolled',   '2025-12-01 10:20:00'),
(18, 1, 'enrolled',   '2025-12-01 10:25:00'),
-- COE 313 §1 (crn=4, cap=20) FULL + waitlist
(1,  4, 'enrolled',   '2025-12-01 09:00:00'),
(2,  4, 'enrolled',   '2025-12-01 09:05:00'),
(3,  4, 'enrolled',   '2025-12-01 09:10:00'),
(4,  4, 'enrolled',   '2025-12-01 09:15:00'),
(5,  4, 'enrolled',   '2025-12-01 09:20:00'),
(6,  4, 'enrolled',   '2025-12-01 09:25:00'),
(7,  4, 'enrolled',   '2025-12-01 09:30:00'),
(8,  4, 'enrolled',   '2025-12-01 09:35:00'),
(9,  4, 'enrolled',   '2025-12-01 09:40:00'),
(10, 4, 'enrolled',   '2025-12-01 09:45:00'),
(11, 4, 'enrolled',   '2025-12-01 09:50:00'),
(12, 4, 'enrolled',   '2025-12-01 09:55:00'),
(13, 4, 'enrolled',   '2025-12-01 10:00:00'),
(14, 4, 'enrolled',   '2025-12-01 10:05:00'),
(15, 4, 'enrolled',   '2025-12-01 10:10:00'),
(16, 4, 'enrolled',   '2025-12-01 10:15:00'),
(17, 4, 'enrolled',   '2025-12-01 10:20:00'),
(18, 4, 'enrolled',   '2025-12-01 10:25:00'),
(19, 4, 'enrolled',   '2025-12-01 10:30:00'),
(20, 4, 'enrolled',   '2025-12-01 10:35:00'),
(21, 4, 'waitlisted', '2025-12-01 11:00:00'),
(22, 4, 'waitlisted', '2025-12-01 11:05:00'),
(23, 4, 'waitlisted', '2025-12-01 11:10:00'),
-- COE 323 §1 (crn=11)
(1,  11, 'enrolled',  '2025-12-02 09:00:00'),
(2,  11, 'enrolled',  '2025-12-02 09:05:00'),
(3,  11, 'enrolled',  '2025-12-02 09:10:00'),
(4,  11, 'enrolled',  '2025-12-02 09:15:00'),
(5,  11, 'enrolled',  '2025-12-02 09:20:00'),
(6,  11, 'enrolled',  '2025-12-02 09:25:00'),
(7,  11, 'enrolled',  '2025-12-02 09:30:00'),
(8,  11, 'enrolled',  '2025-12-02 09:35:00'),
(9,  11, 'enrolled',  '2025-12-02 09:40:00'),
(10, 11, 'enrolled',  '2025-12-02 09:45:00'),
-- ELE 402 §1 (crn=23, cap=20) FULL + waitlist
(1,  23, 'enrolled',  '2025-12-02 10:00:00'),
(2,  23, 'enrolled',  '2025-12-02 10:05:00'),
(3,  23, 'enrolled',  '2025-12-02 10:10:00'),
(4,  23, 'enrolled',  '2025-12-02 10:15:00'),
(5,  23, 'enrolled',  '2025-12-02 10:20:00'),
(6,  23, 'enrolled',  '2025-12-02 10:25:00'),
(7,  23, 'enrolled',  '2025-12-02 10:30:00'),
(8,  23, 'enrolled',  '2025-12-02 10:35:00'),
(9,  23, 'enrolled',  '2025-12-02 10:40:00'),
(10, 23, 'enrolled',  '2025-12-02 10:45:00'),
(11, 23, 'enrolled',  '2025-12-02 10:50:00'),
(12, 23, 'enrolled',  '2025-12-02 10:55:00'),
(13, 23, 'enrolled',  '2025-12-02 11:00:00'),
(14, 23, 'enrolled',  '2025-12-02 11:05:00'),
(15, 23, 'enrolled',  '2025-12-02 11:10:00'),
(16, 23, 'enrolled',  '2025-12-02 11:15:00'),
(17, 23, 'enrolled',  '2025-12-02 11:20:00'),
(18, 23, 'enrolled',  '2025-12-02 11:25:00'),
(19, 23, 'enrolled',  '2025-12-02 11:30:00'),
(20, 23, 'enrolled',  '2025-12-02 11:35:00'),
(24, 23, 'waitlisted','2025-12-02 12:00:00'),
(25, 23, 'waitlisted','2025-12-02 12:05:00'),
-- MTH 201 §1 (crn=26)
(30, 26, 'enrolled',  '2025-12-03 09:00:00'),
(31, 26, 'enrolled',  '2025-12-03 09:05:00'),
(32, 26, 'enrolled',  '2025-12-03 09:10:00'),
(33, 26, 'enrolled',  '2025-12-03 09:15:00'),
(34, 26, 'enrolled',  '2025-12-03 09:20:00'),
(35, 26, 'enrolled',  '2025-12-03 09:25:00'),
(36, 26, 'enrolled',  '2025-12-03 09:30:00'),
(37, 26, 'enrolled',  '2025-12-03 09:35:00'),
-- ENG 101 §1 (crn=30)
(38, 30, 'enrolled',  '2025-12-03 10:00:00'),
(39, 30, 'enrolled',  '2025-12-03 10:05:00'),
(40, 30, 'enrolled',  '2025-12-03 10:10:00'),
(41, 30, 'enrolled',  '2025-12-03 10:15:00'),
(42, 30, 'enrolled',  '2025-12-03 10:20:00'),
(43, 30, 'enrolled',  '2025-12-03 10:25:00'),
-- ENG 102 §2 (crn=33)
(44, 33, 'enrolled',  '2025-12-03 11:00:00'),
(45, 33, 'enrolled',  '2025-12-03 11:05:00'),
(46, 33, 'enrolled',  '2025-12-03 11:10:00'),
(47, 33, 'enrolled',  '2025-12-03 11:15:00'),
-- dropped enrollments for history demo
(24, 1,  'dropped',   '2025-12-01 08:00:00'),
(25, 1,  'dropped',   '2025-12-01 08:30:00'),
(26, 26, 'dropped',   '2025-12-03 08:00:00');