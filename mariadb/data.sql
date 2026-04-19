-- ============================================================
-- LAU Computer Engineering - Course Registration Seed Data
-- Semester: Spring 2026
-- ============================================================

-- ============================================================
-- DEPARTMENTS
-- ============================================================
INSERT INTO department (name, abbreviation) VALUES
('Computer Engineering', 'COE'),
('Electrical Engineering', 'ELE'),
('Mathematics', 'MTH'),
('General Engineering', 'GNE'),
('English', 'ENG'),
('Communications', 'COM'),
('Industrial Engineering', 'INE');

-- ============================================================
-- USERS (passwords are bcrypt of "password123")
-- ============================================================
INSERT INTO users (email, password, role) VALUES
-- Admins
('admin@lau.edu.lb',       'password123', 'ADMIN'),
-- Professors
('rchahine@lau.edu.lb',    'password123', 'ADMIN'),
('mhalawi@lau.edu.lb',     'password123', 'ADMIN'),
('nkhoury@lau.edu.lb',     'password123', 'ADMIN'),
('afarhat@lau.edu.lb',     'password123', 'ADMIN'),
('jnasser@lau.edu.lb',     'password123', 'ADMIN'),
('sgebran@lau.edu.lb',     'password123', 'ADMIN'),
('habboud@lau.edu.lb',     'password123', 'ADMIN'),
('ksalem@lau.edu.lb',      'password123', 'ADMIN'),
('mrizk@lau.edu.lb',       'password123', 'ADMIN'),
-- Students (50)
('ahmad.karimi@lau.edu',     'password123', 'STUDENT'),
('lara.haddad@lau.edu',      'password123', 'STUDENT'),
('omar.salameh@lau.edu',     'password123', 'STUDENT'),
('maya.nassar@lau.edu',      'password123', 'STUDENT'),
('karim.abou@lau.edu',       'password123', 'STUDENT'),
('nour.khalil@lau.edu',      'password123', 'STUDENT'),
('hassan.ibrahim@lau.edu',   'password123', 'STUDENT'),
('rima.khoury@lau.edu',      'password123', 'STUDENT'),
('jad.mansour@lau.edu',      'password123', 'STUDENT'),
('sara.azar@lau.edu',        'password123', 'STUDENT'),
('ziad.farah@lau.edu',       'password123', 'STUDENT'),
('dina.saad@lau.edu',        'password123', 'STUDENT'),
('peter.gemayel@lau.edu',    'password123', 'STUDENT'),
('lina.barakat@lau.edu',     'password123', 'STUDENT'),
('mark.rizk@lau.edu',        'password123', 'STUDENT'),
('tala.hajj@lau.edu',        'password123', 'STUDENT'),
('firas.nasser@lau.edu',     'password123', 'STUDENT'),
('nadine.karam@lau.edu',     'password123', 'STUDENT'),
('ali.daher@lau.edu',        'password123', 'STUDENT'),
('carla.hanna@lau.edu',      'password123', 'STUDENT'),
('youssef.sleiman@lau.edu',  'password123', 'STUDENT'),
('jana.moussa@lau.edu',      'password123', 'STUDENT'),
('rami.chaaban@lau.edu',     'password123', 'STUDENT'),
('hiba.torbey@lau.edu',      'password123', 'STUDENT'),
('charbel.eid@lau.edu',      'password123', 'STUDENT'),
('rana.jabbour@lau.edu',     'password123', 'STUDENT'),
('elie.sarkis@lau.edu',      'password123', 'STUDENT'),
('mia.bou@lau.edu',          'password123', 'STUDENT'),
('tony.wehbe@lau.edu',       'password123', 'STUDENT'),
('celine.nassar@lau.edu',    'password123', 'STUDENT'),
('georges.frem@lau.edu',     'password123', 'STUDENT'),
('sarah.akkawi@lau.edu',     'password123', 'STUDENT'),
('tarek.hamdan@lau.edu',     'password123', 'STUDENT'),
('joelle.azzi@lau.edu',      'password123', 'STUDENT'),
('habib.chalhoub@lau.edu',   'password123', 'STUDENT'),
('nadia.el-khoury@lau.edu',  'password123', 'STUDENT'),
('mario.bitar@lau.edu',      'password123', 'STUDENT'),
('luna.francis@lau.edu',     'password123', 'STUDENT'),
('bassem.habib@lau.edu',     'password123', 'STUDENT'),
('christelle.abi@lau.edu',   'password123', 'STUDENT'),
('wael.darwish@lau.edu',     'password123', 'STUDENT'),
('pamela.rahme@lau.edu',     'password123', 'STUDENT'),
('karim.el-amine@lau.edu',   'password123', 'STUDENT'),
('rouba.ghanem@lau.edu',     'password123', 'STUDENT'),
('simon.abou-jaoude@lau.edu','password123', 'STUDENT'),
('mirna.el-hajj@lau.edu',    'password123', 'STUDENT');

-- ============================================================
-- PROFESSORS
-- ============================================================
INSERT INTO professor (first_name, last_name, email, department_id, user_id) VALUES
('Rabih',    'Chahine',  'rchahine@lau.edu.lb',  1, 2),
('Maroun',   'Halawi',   'mhalawi@lau.edu.lb',   1, 3),
('Nada',     'Khoury',   'nkhoury@lau.edu.lb',   1, 4),
('Antoine',  'Farhat',   'afarhat@lau.edu.lb',   2, 5),
('Joanna',   'Nasser',   'jnasser@lau.edu.lb',   2, 6),
('Salim',    'Gebran',   'sgebran@lau.edu.lb',   3, 7),
('Hana',     'Abboud',   'habboud@lau.edu.lb',   4, 8),
('Kamal',    'Salem',    'ksalem@lau.edu.lb',    5, 9),
('Michel',   'Rizk',     'mrizk@lau.edu.lb',     6, 10);

-- ============================================================
-- STUDENTS
-- ============================================================
INSERT INTO student (first_name, last_name, email, user_id) VALUES
('Ahmad',      'Karimi',       'ahmad.karimi@lau.edu.',      11),
('Lara',       'Haddad',       'lara.haddad@lau.edu.',       12),
('Omar',       'Salameh',      'omar.salameh@lau.edu.',      13),
('Maya',       'Nassar',       'maya.nassar@lau.edu.',       14),
('Karim',      'Abou',         'karim.abou@lau.edu.',        15),
('Nour',       'Khalil',       'nour.khalil@lau.edu.',       16),
('Hassan',     'Ibrahim',      'hassan.ibrahim@lau.edu.',    17),
('Rima',       'Khoury',       'rima.khoury@lau.edu.',       18),
('Jad',        'Mansour',      'jad.mansour@lau.edu.',       19),
('Sara',       'Azar',         'sara.azar@lau.edu.',         20),
('Ziad',       'Farah',        'ziad.farah@lau.edu.',        21),
('Dina',       'Saad',         'dina.saad@lau.edu.',         22),
('Peter',      'Gemayel',      'peter.gemayel@lau.edu.',     23),
('Lina',       'Barakat',      'lina.barakat@lau.edu.',      24),
('Mark',       'Rizk',         'mark.rizk@lau.edu.',         25),
('Tala',       'Hajj',         'tala.hajj@lau.edu.',         26),
('Firas',      'Nasser',       'firas.nasser@lau.edu.',      27),
('Nadine',     'Karam',        'nadine.karam@lau.edu.',      28),
('Ali',        'Daher',        'ali.daher@lau.edu.',         29),
('Carla',      'Hanna',        'carla.hanna@lau.edu.',       30),
('Youssef',    'Sleiman',      'youssef.sleiman@lau.edu.',   31),
('Jana',       'Moussa',       'jana.moussa@lau.edu.',       32),
('Rami',       'Chaaban',      'rami.chaaban@lau.edu.',      33),
('Hiba',       'Torbey',       'hiba.torbey@lau.edu.',       34),
('Charbel',    'Eid',          'charbel.eid@lau.edu.',       35),
('Rana',       'Jabbour',      'rana.jabbour@lau.edu.',      36),
('Elie',       'Sarkis',       'elie.sarkis@lau.edu.',       37),
('Mia',        'Bou',          'mia.bou@lau.edu.',           38),
('Tony',       'Wehbe',        'tony.wehbe@lau.edu.',        39),
('Celine',     'Nassar',       'celine.nassar@lau.edu.',     40),
('Georges',    'Frem',         'georges.frem@lau.edu.',      41),
('Sarah',      'Akkawi',       'sarah.akkawi@lau.edu.',      42),
('Tarek',      'Hamdan',       'tarek.hamdan@lau.edu.',      43),
('Joelle',     'Azzi',         'joelle.azzi@lau.edu.',       44),
('Habib',      'Chalhoub',     'habib.chalhoub@lau.edu.',    45),
('Nadia',      'El-Khoury',    'nadia.el-khoury@lau.edu.',   46),
('Mario',      'Bitar',        'mario.bitar@lau.edu.',       47),
('Luna',       'Francis',      'luna.francis@lau.edu.',      48),
('Bassem',     'Habib',        'bassem.habib@lau.edu.',      49),
('Christelle', 'Abi',          'christelle.abi@lau.edu.',    50),
('Wael',       'Darwish',      'wael.darwish@lau.edu.',      51),
('Pamela',     'Rahme',        'pamela.rahme@lau.edu.',      52),
('Karim',      'El-Amine',     'karim.el-amine@lau.edu.',    53),
('Rouba',      'Ghanem',       'rouba.ghanem@lau.edu.',      54),
('Simon',      'Abou-Jaoude',  'simon.abou-jaoude@lau.edu.', 55),
('Mirna',      'El-Hajj',      'mirna.el-hajj@lau.edu.',     56),
('Patrick',    'Sassine',      'patrick.sassine@lau.edu.',   NULL),
('Lea',        'Zgheib',       'lea.zgheib@lau.edu.',        NULL),
('Elias',      'Moawad',       'elias.moawad@lau.edu.',      NULL),
('Rita',       'Feghali',      'rita.feghali@lau.edu.',      NULL),
('Joseph',     'Bechara',      'joseph.bechara@lau.edu.',    NULL);

-- ============================================================
-- SEMESTER
-- ============================================================
INSERT INTO semester (name, academic_year, start_date, end_date) VALUES
('Spring', 2026, '2026-01-19', '2026-05-30');

-- ============================================================
-- COURSES (from LAU COE course map)
-- ============================================================
INSERT INTO course (name, abbreviation, credits, department_id) VALUES
-- COE courses
('Computer Proficiency',        'COE 201', 1, 1),
('Computer Programming',        'COE 211', 4, 1),
('Logic Design',                'COE 321', 3, 1),
('Logic Design Lab',            'COE 322', 1, 1),
('Microprocessors',             'COE 323', 3, 1),
('Microprocessors Lab',         'COE 324', 1, 1),
('Data Structures',             'COE 312', 3, 1),
('Data Structures Lab',         'COE 313', 1, 1),
('Computer Programming II',     'COE 415', 3, 1),
('Computer Programming II Lab', 'COE 415B',1, 1),
('Software Engineering',        'COE 416', 3, 1),
('Database Systems',            'COE 418', 3, 1),
('Computer Architecture',       'COE 423', 3, 1),
('Digital Systems',             'COE 424', 3, 1),
('Digital Systems Lab',         'COE 425', 1, 1),
('Operating Systems',           'COE 414', 3, 1),
('Computer Networks',           'COE 431', 3, 1),
('Embedded Systems',            'COE 521', 3, 1),
('Professionalism 3rd Year',    'COE 493', 3, 1),
('COE Application',             'COE 593', 3, 1),
('Capstone Design Project I',   'COE 595', 3, 1),
('Capstone Design Project II',  'COE 596', 3, 1),
-- ELE courses
('Electric Circuits',           'ELE 300', 3, 2),
('Electric Circuits Lab',       'ELE 303', 1, 2),
('Electronics I',               'ELE 401', 3, 2),
('Electronics I Lab',           'ELE 402', 1, 2),
('Signals & Systems',           'ELE 430', 3, 2),
('Control Systems',             'ELE 442', 3, 2),
('Control Systems Lab',         'ELE 443', 1, 2),
('Communication Systems',       'ELE 537', 3, 2),
('Communication Systems Lab',   'ELE 540', 1, 2),
-- MTH courses
('Calculus III',                'MTH 201', 3, 3),
('Calculus IV',                 'MTH 206', 3, 3),
('Discrete Structures',         'MTH 207', 3, 3),
('Differential Equations',      'MTH 304', 3, 3),
-- GNE courses
('Engineering Mechanics',       'GNE 212', 3, 4),
('Probability & Statistics',    'GNE 331', 3, 4),
('Engineering Ethics',          'GNE 303', 2, 4),
('Professional Communication',  'GNE 301', 2, 4),
-- ENG courses
('English I',                   'ENG 101', 3, 5),
('English II',                  'ENG 102', 3, 5),
('Advanced Academic English',   'ENG 202', 3, 5),
-- COM courses
('Art of Public Communication', 'COM 203', 3, 6),
-- INE courses
('Engineering Economy I',       'INE 320', 3, 7);

-- ============================================================
-- PREREQUISITES (from course map)
-- ============================================================
INSERT INTO prerequisite (course_id, prerequisite_id) VALUES
-- COE 322 requires COE 321
(4,  3),
-- COE 323 requires COE 321
(5,  3),
-- COE 324 requires COE 323
(6,  5),
-- COE 312 requires COE 211
(7,  2),
-- COE 313 requires COE 312
(8,  7),
-- COE 415 requires COE 312
(9,  7),
-- COE 415B requires COE 415
(10, 9),
-- COE 416 requires COE 312
(11, 7),
-- COE 418 requires COE 312
(12, 7),
-- COE 423 requires COE 323
(13, 5),
-- COE 424 requires COE 321
(14, 3),
-- COE 425 requires COE 424
(15, 14),
-- COE 414 requires COE 312
(16, 7),
-- COE 431 requires COE 312
(17, 7),
-- COE 521 requires COE 323
(18, 5),
-- ELE 303 requires ELE 300
(24, 23),
-- ELE 401 requires ELE 300
(25, 23),
-- ELE 402 requires ELE 401
(26, 25),
-- ELE 430 requires MTH 304
(27, 35),
-- ELE 442 requires ELE 430
(28, 27),
-- ELE 443 requires ELE 442
(29, 28),
-- ELE 537 requires ELE 430
(30, 27),
-- ELE 540 requires ELE 537
(31, 30),
-- MTH 206 requires MTH 201
(33, 32),
-- MTH 304 requires MTH 206
(35, 33),
-- ENG 102 requires ENG 101
(40, 39),
-- ENG 202 requires ENG 102
(41, 40);

-- ============================================================
-- SECTIONS (Spring 2026, semester_id = 1)
-- ============================================================
INSERT INTO section (course_id, section_number, capacity, professor_id, semester_id) VALUES
-- COE 312 Data Structures - 3 sections
(7,  1, 30, 1, 1),
(7,  2, 30, 2, 1),
(7,  3, 25, 3, 1),
-- COE 313 Data Structures Lab - 3 sections
(8,  1, 20, 1, 1),
(8,  2, 20, 2, 1),
(8,  3, 20, 3, 1),
-- COE 321 Logic Design - 2 sections
(3,  1, 35, 1, 1),
(3,  2, 35, 2, 1),
-- COE 322 Logic Design Lab - 2 sections
(4,  1, 20, 1, 1),
(4,  2, 20, 2, 1),
-- COE 323 Microprocessors - 2 sections
(5,  1, 30, 2, 1),
(5,  2, 30, 3, 1),
-- COE 324 Microprocessors Lab - 2 sections
(6,  1, 20, 2, 1),
(6,  2, 20, 3, 1),
-- COE 415 Computer Programming II - 1 section
(9,  1, 30, 1, 1),
-- COE 416 Software Engineering - 1 section
(11, 1, 30, 3, 1),
-- COE 418 Database Systems - 1 section
(12, 1, 30, 2, 1),
-- COE 423 Computer Architecture - 1 section
(13, 1, 30, 1, 1),
-- COE 414 Operating Systems - 1 section
(16, 1, 30, 3, 1),
-- ELE 300 Electric Circuits - 2 sections
(23, 1, 35, 4, 1),
(23, 2, 35, 5, 1),
-- ELE 401 Electronics I - 1 section
(25, 1, 30, 4, 1),
-- ELE 402 Electronics I Lab - 2 sections
(26, 1, 20, 4, 1),
(26, 2, 20, 5, 1),
-- ELE 430 Signals & Systems - 1 section
(27, 1, 30, 5, 1),
-- MTH 201 Calculus III - 2 sections
(32, 1, 40, 6, 1),
(32, 2, 40, 6, 1),
-- MTH 207 Discrete Structures - 1 section
(34, 1, 35, 6, 1),
-- GNE 331 Probability & Statistics - 1 section
(37, 1, 35, 7, 1),
-- ENG 101 English I - 2 sections
(39, 1, 25, 8, 1),
(39, 2, 25, 8, 1),
-- ENG 102 English II - 2 sections
(40, 1, 25, 8, 1),
(40, 2, 25, 9, 1);

-- ============================================================
-- SCHEDULES
-- CRN IDs will be auto-incremented starting from 1
-- ============================================================
INSERT INTO schedule (crn, day_of_week, start_time, end_time, room) VALUES
-- COE 312 Section 1 (crn=1) - MWF
(1, 'Monday',    '08:00:00', '09:00:00', 'ENG-201'),
(1, 'Wednesday', '08:00:00', '09:00:00', 'ENG-201'),
(1, 'Friday',    '08:00:00', '09:00:00', 'ENG-201'),
-- COE 312 Section 2 (crn=2) - MWF
(2, 'Monday',    '10:00:00', '11:00:00', 'ENG-202'),
(2, 'Wednesday', '10:00:00', '11:00:00', 'ENG-202'),
(2, 'Friday',    '10:00:00', '11:00:00', 'ENG-202'),
-- COE 312 Section 3 (crn=3) - TTH
(3, 'Tuesday',   '09:30:00', '11:00:00', 'ENG-203'),
(3, 'Thursday',  '09:30:00', '11:00:00', 'ENG-203'),
-- COE 313 Lab Section 1 (crn=4) - Tuesday
(4, 'Tuesday',   '14:00:00', '17:00:00', 'LAB-101'),
-- COE 313 Lab Section 2 (crn=5) - Wednesday
(5, 'Wednesday', '14:00:00', '17:00:00', 'LAB-101'),
-- COE 313 Lab Section 3 (crn=6) - Thursday
(6, 'Thursday',  '14:00:00', '17:00:00', 'LAB-101'),
-- COE 321 Section 1 (crn=7) - MWF
(7, 'Monday',    '11:00:00', '12:00:00', 'ENG-301'),
(7, 'Wednesday', '11:00:00', '12:00:00', 'ENG-301'),
(7, 'Friday',    '11:00:00', '12:00:00', 'ENG-301'),
-- COE 321 Section 2 (crn=8) - TTH
(8, 'Tuesday',   '11:00:00', '12:30:00', 'ENG-302'),
(8, 'Thursday',  '11:00:00', '12:30:00', 'ENG-302'),
-- COE 322 Lab Section 1 (crn=9) - Monday
(9,  'Monday',   '14:00:00', '17:00:00', 'LAB-102'),
-- COE 322 Lab Section 2 (crn=10) - Wednesday
(10, 'Wednesday','14:00:00', '17:00:00', 'LAB-102'),
-- COE 323 Section 1 (crn=11) - MWF
(11, 'Monday',    '09:00:00', '10:00:00', 'ENG-401'),
(11, 'Wednesday', '09:00:00', '10:00:00', 'ENG-401'),
(11, 'Friday',    '09:00:00', '10:00:00', 'ENG-401'),
-- COE 323 Section 2 (crn=12) - TTH
(12, 'Tuesday',   '08:00:00', '09:30:00', 'ENG-402'),
(12, 'Thursday',  '08:00:00', '09:30:00', 'ENG-402'),
-- COE 324 Lab Section 1 (crn=13) - Tuesday
(13, 'Tuesday',   '14:00:00', '17:00:00', 'LAB-103'),
-- COE 324 Lab Section 2 (crn=14) - Thursday
(14, 'Thursday',  '14:00:00', '17:00:00', 'LAB-103'),
-- COE 415 (crn=15) - MWF
(15, 'Monday',    '13:00:00', '14:00:00', 'ENG-201'),
(15, 'Wednesday', '13:00:00', '14:00:00', 'ENG-201'),
(15, 'Friday',    '13:00:00', '14:00:00', 'ENG-201'),
-- COE 416 (crn=16) - TTH
(16, 'Tuesday',   '13:00:00', '14:30:00', 'ENG-301'),
(16, 'Thursday',  '13:00:00', '14:30:00', 'ENG-301'),
-- COE 418 (crn=17) - MWF
(17, 'Monday',    '14:00:00', '15:00:00', 'ENG-202'),
(17, 'Wednesday', '14:00:00', '15:00:00', 'ENG-202'),
(17, 'Friday',    '14:00:00', '15:00:00', 'ENG-202'),
-- COE 423 (crn=18) - TTH
(18, 'Tuesday',   '15:30:00', '17:00:00', 'ENG-401'),
(18, 'Thursday',  '15:30:00', '17:00:00', 'ENG-401'),
-- COE 414 (crn=19) - MWF
(19, 'Monday',    '12:00:00', '13:00:00', 'ENG-302'),
(19, 'Wednesday', '12:00:00', '13:00:00', 'ENG-302'),
(19, 'Friday',    '12:00:00', '13:00:00', 'ENG-302'),
-- ELE 300 Section 1 (crn=20) - MWF
(20, 'Monday',    '08:00:00', '09:00:00', 'ENG-501'),
(20, 'Wednesday', '08:00:00', '09:00:00', 'ENG-501'),
(20, 'Friday',    '08:00:00', '09:00:00', 'ENG-501'),
-- ELE 300 Section 2 (crn=21) - TTH
(21, 'Tuesday',   '09:30:00', '11:00:00', 'ENG-502'),
(21, 'Thursday',  '09:30:00', '11:00:00', 'ENG-502'),
-- ELE 401 (crn=22) - MWF
(22, 'Monday',    '11:00:00', '12:00:00', 'ENG-501'),
(22, 'Wednesday', '11:00:00', '12:00:00', 'ENG-501'),
(22, 'Friday',    '11:00:00', '12:00:00', 'ENG-501'),
-- ELE 402 Lab Section 1 (crn=23) - Monday
(23, 'Monday',    '14:00:00', '17:00:00', 'LAB-201'),
-- ELE 402 Lab Section 2 (crn=24) - Wednesday
(24, 'Wednesday', '14:00:00', '17:00:00', 'LAB-201'),
-- ELE 430 (crn=25) - TTH
(25, 'Tuesday',   '11:00:00', '12:30:00', 'ENG-501'),
(25, 'Thursday',  '11:00:00', '12:30:00', 'ENG-501'),
-- MTH 201 Section 1 (crn=26) - MWF
(26, 'Monday',    '08:00:00', '09:00:00', 'LAS-101'),
(26, 'Wednesday', '08:00:00', '09:00:00', 'LAS-101'),
(26, 'Friday',    '08:00:00', '09:00:00', 'LAS-101'),
-- MTH 201 Section 2 (crn=27) - TTH
(27, 'Tuesday',   '08:00:00', '09:30:00', 'LAS-102'),
(27, 'Thursday',  '08:00:00', '09:30:00', 'LAS-102'),
-- MTH 207 (crn=28) - MWF
(28, 'Monday',    '10:00:00', '11:00:00', 'LAS-101'),
(28, 'Wednesday', '10:00:00', '11:00:00', 'LAS-101'),
(28, 'Friday',    '10:00:00', '11:00:00', 'LAS-101'),
-- GNE 331 (crn=29) - TTH
(29, 'Tuesday',   '13:00:00', '14:30:00', 'ENG-301'),
(29, 'Thursday',  '13:00:00', '14:30:00', 'ENG-301'),
-- ENG 101 Section 1 (crn=30) - MWF
(30, 'Monday',    '09:00:00', '10:00:00', 'LAS-201'),
(30, 'Wednesday', '09:00:00', '10:00:00', 'LAS-201'),
(30, 'Friday',    '09:00:00', '10:00:00', 'LAS-201'),
-- ENG 101 Section 2 (crn=31) - TTH
(31, 'Tuesday',   '11:00:00', '12:30:00', 'LAS-202'),
(31, 'Thursday',  '11:00:00', '12:30:00', 'LAS-202'),
-- ENG 102 Section 1 (crn=32) - MWF
(32, 'Monday',    '10:00:00', '11:00:00', 'LAS-201'),
(32, 'Wednesday', '10:00:00', '11:00:00', 'LAS-201'),
(32, 'Friday',    '10:00:00', '11:00:00', 'LAS-201'),
-- ENG 102 Section 2 (crn=33) - TTH
(33, 'Tuesday',   '13:00:00', '14:30:00', 'LAS-202'),
(33, 'Thursday',  '13:00:00', '14:30:00', 'LAS-202');

-- ============================================================
-- ENROLLMENTS
-- Spread 50 students across sections realistically
-- Some sections will hit capacity to demo waitlist
-- ============================================================
INSERT INTO enrollment (student_id, crn, status, enrolled_at) VALUES
-- COE 312 Section 1 (crn=1, cap=30) - 18 students enrolled
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
-- COE 313 Lab Section 1 (crn=4, cap=20) - FULL + waitlist demo
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
-- waitlisted students for COE 313 Section 1
(21, 4, 'waitlisted', '2025-12-01 11:00:00'),
(22, 4, 'waitlisted', '2025-12-01 11:05:00'),
(23, 4, 'waitlisted', '2025-12-01 11:10:00'),
-- COE 323 Section 1 (crn=11, cap=30)
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
-- ELE 402 Lab Section 1 (crn=23, cap=20) - FULL + waitlist demo
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
-- waitlisted for ELE 402
(24, 23, 'waitlisted','2025-12-02 12:00:00'),
(25, 23, 'waitlisted','2025-12-02 12:05:00'),
-- MTH 201 Section 1 (crn=26)
(30, 26, 'enrolled',  '2025-12-03 09:00:00'),
(31, 26, 'enrolled',  '2025-12-03 09:05:00'),
(32, 26, 'enrolled',  '2025-12-03 09:10:00'),
(33, 26, 'enrolled',  '2025-12-03 09:15:00'),
(34, 26, 'enrolled',  '2025-12-03 09:20:00'),
(35, 26, 'enrolled',  '2025-12-03 09:25:00'),
(36, 26, 'enrolled',  '2025-12-03 09:30:00'),
(37, 26, 'enrolled',  '2025-12-03 09:35:00'),
-- ENG 101 Section 1 (crn=30)
(38, 30, 'enrolled',  '2025-12-03 10:00:00'),
(39, 30, 'enrolled',  '2025-12-03 10:05:00'),
(40, 30, 'enrolled',  '2025-12-03 10:10:00'),
(41, 30, 'enrolled',  '2025-12-03 10:15:00'),
(42, 30, 'enrolled',  '2025-12-03 10:20:00'),
(43, 30, 'enrolled',  '2025-12-03 10:25:00'),
-- ENG 102 Section 2 (crn=33)
(44, 33, 'enrolled',  '2025-12-03 11:00:00'),
(45, 33, 'enrolled',  '2025-12-03 11:05:00'),
(46, 33, 'enrolled',  '2025-12-03 11:10:00'),
(47, 33, 'enrolled',  '2025-12-03 11:15:00'),
-- some dropped enrollments to show history
(24, 1,  'dropped',   '2025-12-01 08:00:00'),
(25, 1,  'dropped',   '2025-12-01 08:30:00'),
(26, 26, 'dropped',   '2025-12-03 08:00:00');