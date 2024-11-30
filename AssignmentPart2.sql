
-- Find the names of all departments with instructors and remove duplicates. 
SELECT DISTINCT department.dept_name, instructor.name
FROM department
JOIN instructor ON department.dept_name = instructor.dept_name;


-- Find the names of all instructors in the History department.
SELECT name
FROM instructor
WHERE dept_name = 'History';

-- Find the instructor_ID and department_name of all instructors associated with a department with a budget greater than $95,000.
SELECT instructor.ID, instructor.dept_name
FROM instructor
JOIN department ON instructor.dept_name = department.dept_name
WHERE department.budget > 95000;

-- Find all instructors in the Computer Science department with salaries more than $80,000.
SELECT name
FROM instructor
WHERE dept_name = 'Comp. Sci.' AND salary > 80000;

-- List the names of instructors along with the titles of courses that they teach.
SELECT instructor.name, course.title
FROM instructor
JOIN teaches ON instructor.ID = teaches.ID
JOIN course ON teaches.course_id = course.course_id;

-- Find the names of all instructors who have a higher salary than some instructors in the Computer Science department.
SELECT DISTINCT i1.name
FROM instructor i1
WHERE i1.salary > ANY (
    SELECT i2.salary
    FROM instructor i2
    WHERE i2.dept_name = 'Comp. Sci.'
);


-- Find the names of all instructors whose salary is greater than at least one instructor in the Biology department.
SELECT DISTINCT i1.name
FROM instructor i1
WHERE i1.salary > ANY (
    SELECT i2.salary
    FROM instructor i2
    WHERE i2.dept_name = 'Biology'
);


--  Find the names of all departments whose building name includes the substring 'Watson'.
SELECT dept_name
FROM department
WHERE building LIKE '%Watson%';

-- List in alphabetical order the names of all instructors.
SELECT name
FROM instructor
ORDER BY name;


-- Find the names of instructors with salary amounts between $90,000 and $100,000.
SELECT name
FROM instructor
WHERE salary BETWEEN 90000 AND 100000;

-- Find the instructor names and the courses they taught for all instructors in the Biology department who have taught some course.
SELECT instructor.name, course.title
FROM instructor
JOIN teaches ON instructor.ID = teaches.ID
JOIN course ON teaches.course_id = course.course_id
WHERE instructor.dept_name = 'Biology';

--  Find the set of all courses taught either in Fall 2009 or in Spring 2010 Semester, or both.
SELECT DISTINCT course_id
FROM section
WHERE (semester = 'Fall' AND year = 2009)
   OR (semester = 'Spring' AND year = 2010);

-- Find the set of all courses taught in the Fall 2009 as well as in Spring 2010 Semester.
SELECT DISTINCT course_id
FROM section
WHERE (semester = 'Fall' AND year = 2009)
  AND course_id IN (
    SELECT course_id
    FROM section
    WHERE semester = 'Spring' AND year = 2010
);


-- Find all courses taught in the Fall 2009 semester but not in the Spring 2010 Semester.
SELECT DISTINCT course_id
FROM section
WHERE (semester = 'Fall' AND year = 2009)
  AND course_id NOT IN (
    SELECT course_id
    FROM section
    WHERE semester = 'Spring' AND year = 2010
);


-- Find courses offered in Fall 2009 and in Spring 2010 Semester.
SELECT DISTINCT course_id
FROM section
WHERE (semester = 'Fall' AND year = 2009)
   OR (semester = 'Spring' AND year = 2010);


-- Find courses offered in Fall 2009 but not in Spring 2010 Semester.
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
  AND course_id NOT IN (
    SELECT course_id
    FROM section
    WHERE semester = 'Spring' AND year = 2010
);


--  Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 10101.
SELECT COUNT(DISTINCT takes.ID) AS total_students
FROM takes
JOIN teaches ON takes.course_id = teaches.course_id
    AND takes.sec_id = teaches.sec_id
    AND takes.semester = teaches.semester
    AND takes.year = teaches.year
WHERE teaches.ID = 10101;


--  Find the names of instructors with salaries greater than that of some (at least one) instructor in the Biology department.
SELECT DISTINCT i1.name
FROM instructor i1
WHERE i1.salary > ANY (
    SELECT i2.salary
    FROM instructor i2
    WHERE i2.dept_name = 'Biology'
);


-- Find the names of all instructors whose salary is greater than the salary of all instructors in the Biology department.
SELECT DISTINCT i1.name
FROM instructor i1
WHERE i1.salary > ALL (
    SELECT i2.salary
    FROM instructor i2
    WHERE i2.dept_name = 'Biology'
);


-- Find all courses taught in both the Fall 2009 semester and in the Spring 2010 semester.
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
  AND course_id IN (
    SELECT course_id
    FROM section
    WHERE semester = 'Spring' AND year = 2010
);


--  Find all students who have taken all courses offered in the Biology department.
SELECT DISTINCT takes.ID
FROM takes
JOIN course ON takes.course_id = course.course_id
WHERE course.dept_name = 'Biology'
GROUP BY takes.ID
HAVING COUNT(DISTINCT course.course_id) = (
    SELECT COUNT(course_id)
    FROM course
    WHERE dept_name = 'Biology'
);

--  Find all courses that were offered at most once in 2009.
SELECT course_id
FROM section
WHERE year = 2009
GROUP BY course_id
HAVING COUNT(*) <= 1;
