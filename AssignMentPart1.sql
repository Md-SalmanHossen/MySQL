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
    course_id INT PRIMARY KEY,
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
INSERT INTO classroom (building, room_number, capacity)
VALUES 
('Watson', '101', 50),
('Watson', '102', 30),
('Taylor', '201', 40),
('Taylor', '202', 35);

-- Insert data into department
INSERT INTO department (dept_name, building, budget)
VALUES 
('Computer Science', 'Watson', 120000),
('Mathematics', 'Taylor', 90000),
('Physics', 'Taylor', 80000),
('History', 'Watson', 70000);

-- Insert data into course
INSERT INTO course (course_id, title, dept_name, credits)
VALUES
(101, 'Database Systems', 'Computer Science', 4),
(102, 'Algorithms', 'Computer Science', 3),
(202, 'Quantum Mechanics', 'Physics', 3),
(201, 'Linear Algebra', 'Mathematics', 3);

-- Insert data into instructor
INSERT INTO instructor (ID, name, dept_name, salary)
VALUES 
(1, 'Alice', 'Computer Science', 90000),
(2, 'Bob', 'Mathematics', 85000),
(3, 'Charlie', 'Physics', 75000),
(4, 'Diana', 'History', 60000);

-- Insert data into section
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id)
VALUES 
(101, 'A', 'Fall', 2024, 'Watson', '101', 'TS1'),
(102, 'B', 'Spring', 2025, 'Watson', '102', 'TS2'),
(201, 'A', 'Fall', 2024, 'Taylor', '201', 'TS3'),
(202, 'B', 'Spring', 2025, 'Taylor', '202', 'TS4');

-- Insert data into teaches
INSERT INTO teaches (ID, course_id, sec_id, semester, year)
VALUES 
(1, 101, 'A', 'Fall', 2024),
(2, 102, 'B', 'Spring', 2025),
(3, 201, 'A', 'Fall', 2024),
(4, 202, 'B', 'Spring', 2025);

-- Insert data into student
INSERT INTO student (ID, name, dept_name, tot_cred)
VALUES 
(1001, 'Eve', 'Computer Science', 120),
(1002, 'Frank', 'Mathematics', 90),
(1003, 'Grace', 'Physics', 75),
(1004, 'Henry', 'History', 60);

-- Insert data into takes
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade)
VALUES 
(1001, 101, 'A', 'Fall', 2024, 'A'),
(1002, 102, 'B', 'Spring', 2025, 'B'),
(1003, 201, 'A', 'Fall', 2024, 'A'),
(1004, 202, 'B', 'Spring', 2025, 'C');

-- Insert data into advisor
INSERT INTO advisor (s_ID, i_ID)
VALUES 
(1001, 1),
(1002, 2),
(1003, 3),
(1004, 4);

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
(201, NULL);  -- This assumes NULL is allowed
