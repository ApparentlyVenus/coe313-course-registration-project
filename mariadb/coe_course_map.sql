USE course_registration;

-- COE major_id = 1
-- recommended_semester: 1=Fall, 2=Spring
-- Year 1
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 1, TRUE FROM course WHERE abbreviation = 'COE 201';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 1, TRUE FROM course WHERE abbreviation = 'COE 211';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 1, TRUE FROM course WHERE abbreviation = 'MTH 201';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 1, TRUE FROM course WHERE abbreviation = 'ENG 101';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 2, TRUE FROM course WHERE abbreviation = 'COE 212';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 2, TRUE FROM course WHERE abbreviation = 'MTH 206';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 2, TRUE FROM course WHERE abbreviation = 'PHY 201';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 1, 2, TRUE FROM course WHERE abbreviation = 'ENG 102';

-- Year 2
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 1, TRUE FROM course WHERE abbreviation = 'COE 312';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 1, TRUE FROM course WHERE abbreviation = 'COE 313';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 1, TRUE FROM course WHERE abbreviation = 'MTH 207';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 1, TRUE FROM course WHERE abbreviation = 'COE 321';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 1, TRUE FROM course WHERE abbreviation = 'MTH 304';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 2, TRUE FROM course WHERE abbreviation = 'COE 322';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 2, TRUE FROM course WHERE abbreviation = 'COE 323';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 2, TRUE FROM course WHERE abbreviation = 'COE 324';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 2, TRUE FROM course WHERE abbreviation = 'ELE 300';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 2, TRUE FROM course WHERE abbreviation = 'GNE 212';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 2, 2, TRUE FROM course WHERE abbreviation = 'ENG 202';

-- Year 3
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'COE 415';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'COE 415B';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'COE 418';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'COE 423';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'ELE 401';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'ELE 402';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 1, TRUE FROM course WHERE abbreviation = 'GNE 301';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'COE 416';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'COE 424';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'COE 425';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'ELE 430';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'GNE 303';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'COE 493';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 3, 2, TRUE FROM course WHERE abbreviation = 'INE 320';

-- Year 4
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 1, TRUE FROM course WHERE abbreviation = 'COE 414';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 1, TRUE FROM course WHERE abbreviation = 'COE 431';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 1, TRUE FROM course WHERE abbreviation = 'ELE 442';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 1, TRUE FROM course WHERE abbreviation = 'ELE 443';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 1, TRUE FROM course WHERE abbreviation = 'COM 203';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 2, TRUE FROM course WHERE abbreviation = 'COE 521';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 2, TRUE FROM course WHERE abbreviation = 'ELE 537';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 2, TRUE FROM course WHERE abbreviation = 'ELE 540';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 2, TRUE FROM course WHERE abbreviation = 'GNE 331';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 4, 2, TRUE FROM course WHERE abbreviation = 'COE 593';

-- Year 5
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 5, 1, TRUE FROM course WHERE abbreviation = 'COE 595';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 5, 1, TRUE FROM course WHERE abbreviation = 'COE 498';
INSERT INTO major_course (major_id, course_id, recommended_year, recommended_semester, is_required)
SELECT 1, course_id, 5, 2, TRUE FROM course WHERE abbreviation = 'COE 596';