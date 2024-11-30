
create Database IF NOT EXISTS University_Enterprise;
USE University_Enterprise;

-- Drop and create classroom table
DROP TABLE IF EXISTS classroom;
CREATE TABLE IF NOT EXISTS classroom (
    building VARCHAR(50),
    room_number VARCHAR(50),
    capacity INT,
    PRIMARY KEY (building, room_number)
);

-- Drop and create department table
DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget INT
);

-- Drop and create course table
DROP TABLE IF EXISTS course;
CREATE TABLE IF NOT EXISTS course (
    course_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(30),
    dept_name VARCHAR(40),
    credits INT,
    FOREIGN KEY fk_course (dept_name) REFERENCES department(dept_name)
);

-- Table: instructor
DROP TABLE IF EXISTS instructor;
CREATE TABLE IF NOT EXISTS instructor (
    ID INT PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    salary FLOAT,
    FOREIGN KEY fk_ins(dept_name) REFERENCES department(dept_name)
);

-- Create section table
DROP TABLE IF EXISTS section;
CREATE TABLE IF NOT EXISTS section (
    course_id INT,
    sec_id VARCHAR(50),
    semester VARCHAR(50),
    year INT,
    building VARCHAR(50),
    room_number VARCHAR(50),
    time_slot_id VARCHAR(50),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number)
);

-- Create teaches table
DROP TABLE IF EXISTS teaches;
CREATE TABLE IF NOT EXISTS teaches (
    ID INT,
    course_id INT,
    sec_id VARCHAR(50),
    semester VARCHAR(30),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY fk_id(ID) REFERENCES instructor(ID),
    FOREIGN KEY fk_section(course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);

-- Student table
DROP TABLE IF EXISTS student;
CREATE TABLE IF NOT EXISTS student (
    ID INT PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    tot_cred INT,
    FOREIGN KEY fk_student(dept_name) REFERENCES department(dept_name)
);

-- Takes table
DROP TABLE IF EXISTS takes;
CREATE TABLE IF NOT EXISTS takes (
    ID INT,
    course_id INT,
    sec_id VARCHAR(50),
    semester VARCHAR(20),
    year INT,
    grade CHAR(1),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY fk_section(course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year),
    FOREIGN KEY fk_id(ID) REFERENCES student(ID)
);

-- Advisor table
DROP TABLE IF EXISTS advisor;
CREATE TABLE IF NOT EXISTS advisor (
    s_ID INT,
    i_ID INT,
    PRIMARY KEY (s_ID, i_ID),
    FOREIGN KEY fk_sid(s_ID) REFERENCES student(ID),
    FOREIGN KEY fk_iid(i_ID) REFERENCES instructor(ID)
);

-- Timeslot table
DROP TABLE IF EXISTS timeslot;
CREATE TABLE IF NOT EXISTS timeslot (
    time_slot_id VARCHAR(50) PRIMARY KEY,
    day VARCHAR(50),
    start_time TIME,
    end_time TIME
);

-- Modify prereq table to allow NULL for prereq_id and create the table
DROP TABLE IF EXISTS prereq;

CREATE TABLE IF NOT EXISTS prereq (
    course_id INT,
    prereq_id INT NULL,  -- Allow NULL for prereq_id
    UNIQUE (course_id, prereq_id),  -- Use UNIQUE instead of PRIMARY KEY
    FOREIGN KEY fk_course_id(course_id) REFERENCES course(course_id),
    FOREIGN KEY fk_prereq_id(prereq_id) REFERENCES course(course_id)
);


-- Insert data into classroom
INSERT INTO classroom (building, room_number, capacity) VALUES
('Packard', '101', 500),
('Painter', '514', 10),
('Taylor', '3128', 70),
('Watson', '100', 30),
('Watson', '120', 50);


-- Insert data into department
INSERT INTO department (dept_name, building, budget) VALUES
('Biology', 'Watson', 90000),
('Com. Sci.', 'Taylor', 100000),
('Ele. Eng.', 'Taylor', 85000),
('Finance', 'Painter', 120000),
('History', 'Painter', 50000),
('Music', 'Packard', 80000),
('Physics', 'Watson', 70000);


-- Insert data into course
INSERT INTO course (course_id, title, dept_name, credits) VALUES
('BIO-101', 'Intro. to Biology', 'Biology', 4),
('BIO-301', 'Genetics', 'Biology', 4),
('BIO-399', 'Computational Biology', 'Biology', 3),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4),
('CS-190', 'Game Design', 'Comp. Sci.', 4),
('CS-315', 'Robotics', 'Comp. Sci.', 3),
('CS-319', 'Image Processing', 'Comp. Sci.', 3),
('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3),
('FIN-201', 'Investment Banking', 'Finance', 3),
('HIS-351', 'World History', 'History', 3),
('MU-199', 'Music Video Production', 'Music', 3),
('PHY-101', 'Physical Principles', 'Physics', 4);


-- Insert data into instructor
INSERT INTO instructor (ID, name, dept_name, salary) VALUES
(10101, 'Srinivasan', 'Comp. Sci.', 65000),
(12121, 'Wu', 'Finance', 90000),
(15151, 'Mozart', 'Music', 40000),
(22222, 'Einstein', 'Physics', 95000),
(32343, 'El Said', 'History', 60000),
(33456, 'Gold', 'Physics', 87000),
(45565, 'Katz', 'Comp. Sci.', 75000),
(58583, 'Califieri', 'History', 62000),
(76543, 'Singh', 'Finance', 80000),
(76766, 'Crick', 'Biology', 72000),
(83821, 'Brandt', 'Comp. Sci.', 92000),
(98345, 'Kim', 'Elec. Eng.', 80000);


-- Insert data into section
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES
('BIO-101', '1', 'Summer', 2009, 'Painter', '514', 'B'),
('BIO-301', '1', 'Summer', 2010, 'Painter', '514', 'A'),
('CS-101', '1', 'Fall', 2009, 'Packard', '101', 'H'),
('CS-101', '1', 'Spring', 2010, 'Packard', '101', 'F'),
('CS-190', '1', 'Spring', 2009, 'Taylor', '3128', 'E'),
('CS-190', '2', 'Spring', 2009, 'Taylor', '3128', 'A'),
('CS-315', '1', 'Spring', 2010, 'Watson', '120', 'D'),
('CS-319', '1', 'Spring', 2010, 'Watson', '100', 'B'),
('CS-319', '2', 'Spring', 2010, 'Taylor', '3128', 'C'),
('CS-347', '1', 'Fall', 2009, 'Taylor', '3128', 'A'),
('EE-181', '1', 'Spring', 2009', 'Taylor', '3128', 'A'),
('FIN-201', '1', 'Spring', 2010, 'Packard', '101', 'H'),
('HIS-351', '1', 'Spring', 2010', 'Painter', '514', 'A'),
('MU-199', '1', 'Spring', 2010', 'Packard', '101', 'ACBCDA'),
('PHY-101', '1', 'Fall', 2009, 'Watson', '100', 'A');


-- Insert data into teaches
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES
(10101, 'CS-101', '1', 'Fall', 2009),
(10101, 'CS-315', '1', 'Spring', 2010),
(10101, 'CS-347', '1', 'Fall', 2009),
(12121, 'FIN-201', '1', 'Spring', 2010),
(15151, 'MU-199', '1', 'Spring', 2010),
(22222, 'PHY-101', '1', 'Fall', 2009),
(32343, 'HIS-351', '1', 'Spring', 2010),
(45565, 'CS-101', '1', 'Spring', 2010),
(45565, 'CS-319', '1', 'Spring', 2010),
(76766, 'BIO-101', '1', 'Summer', 2009),
(76766, 'BIO-301', '1', 'Summer', 2010),
(83821, 'CS-190', '1', 'Spring', 2009),
(83821, 'CS-190', '2', 'Spring', 2009),
(83821, 'CS-319', '2', 'Spring', 2010),
(98345, 'EE-181', '1', 'Spring', 2009);


-- Insert data into student
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES
(00128, 'Zhang', 'Comp. Sci.', 102),
(12345, 'Shankar', 'Comp. Sci.', 32),
(19991, 'Brandt', 'History', 80),
(23121, 'Chavez', 'Finance', 110),
(44553, 'Peltier', 'Physics', 56),
(45678, 'Levy', 'Physics', 46),
(54321, 'Williams', 'Comp. Sci.', 54),
(55739, 'Sanchez', 'Music', 38),
(70557, 'Snow', 'Physics', 0),
(76543, 'Brown', 'Comp. Sci.', 58),
(76653, 'Aoi', 'Elec. Eng.', 60),
(98765, 'Bourikas', 'Elec. Eng.', 98),
(98988, 'Tanaka', 'Biology', 120);


-- Insert data into takes
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES
(00128, 'CS-101', '1', 'Fall', 2009, 'A'),
(00128, 'CS-347', '1', 'Fall', 2009, 'A'),
(12345, 'CS-101', '1', 'Fall', 2009, 'C'),
(12345, 'CS-190', '2', 'Spring', 2009, 'A'),
(12345, 'CS-315', '10', 'Spring', 2010, 'A'),
(12345, 'CS-347', '1', 'Fall', 2009, 'A'),
(19991, 'HIS-351', '1', 'Spring', 2010, 'B'),
(23121, 'FIN-201', '1', 'Spring', 2010, 'C+'),
(44553, 'PHY-101', '1', 'Fall', 2009, 'B-'),
(45678, 'CS-101', '1', 'Fall', 2009, 'F'),
(45678, 'CS-101', '1', 'Spring', 2010, 'B+'),
(45678, 'CS-319', '1', 'Spring', 2010, 'B'),
(54321, 'CS-101', '1', 'Fall', 2009, 'A-'),
(54321, 'CS-190', '2', 'Spring', 2009, 'B+'),
(55739, 'MU-199', '1', 'Spring', 2010, 'A-'),
(76543, 'CS-101', '1', 'Fall', 2009, 'A'),
(76543, 'CS-319', '2', 'Spring', 2010, 'A'),
(76653, 'EE-181', '1', 'Spring', 2009, 'C'),
(98765, 'CS-101', '1', 'Fall', 2009, 'C-'),
(98765, 'CS-315', '1', 'Spring', 2010, 'B'),
(98988, 'BIO-101', '1', 'Summer', 2009, 'A'),
(98988, 'BIO-301', '1', 'Summer', 2010, NULL);


-- Insert data into advisor
INSERT INTO advisor (s_ID, i_ID)
VALUES 
(00128, 10101),
(12345, 12121),
(19991, 32343),
(23121, 12121);


-- Insert data into timeslot
INSERT INTO timeslot (time_slot_id, day, start_time, end_time)
VALUES 
('TS1', 'Monday', '10:00:00', '11:00:00'),
('TS2', 'Tuesday', '11:00:00', '12:00:00'),
('TS3', 'Wednesday', '14:00:00', '15:00:00'),
('TS4', 'Thursday', '15:00:00', '16:00:00');

-- Insert prerequisite data into the 'prereq' table
INSERT INTO prereq (course_id, prereq_id)
VALUES
(101, 201),
(102, 101),
(202, 201),
(201, NULL);  


