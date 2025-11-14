-- student_management.sql
-- Student Management System: schema and sample queries

-- Creating tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    year INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE enrollment (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Sample data inserts (optional)
INSERT INTO students (student_id, name, department, year) VALUES
(1, 'Alice Johnson', 'Computer Science', 2),
(2, 'Bob Singh', 'Electrical', 3),
(3, 'Carla Mehta', 'Computer Science', 2);

INSERT INTO courses (course_id, course_name, credits) VALUES
(101, 'Database Systems', 4),
(102, 'Data Structures', 3),
(103, 'Operating Systems', 4);

INSERT INTO enrollment (enroll_id, student_id, course_id) VALUES
(1, 1, 101),
(2, 1, 102),
(3, 2, 101),
(4, 3, 103);

INSERT INTO marks (mark_id, student_id, course_id, marks) VALUES
(1, 1, 101, 88),
(2, 1, 102, 92),
(3, 2, 101, 75),
(4, 3, 103, 81);

-- Sample Queries

-- 1. Fetch student performance with average marks
SELECT s.student_id, s.name, AVG(m.marks) AS avg_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name;

-- 2. Identify top performing students (average > 85)
SELECT s.student_id, s.name, AVG(m.marks) AS avg_score
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name
HAVING AVG(m.marks) > 85;

-- 3. Course-wise average marks
SELECT c.course_id, c.course_name, AVG(m.marks) AS course_avg
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name;

-- 4. Students enrolled in each course
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- 5. Detailed report: student, course, marks
SELECT s.student_id, s.name, c.course_name, m.marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN courses c ON m.course_id = c.course_id
ORDER BY s.student_id;

-- 6. List students with no marks recorded
SELECT s.student_id, s.name
FROM students s
LEFT JOIN marks m ON s.student_id = m.student_id
WHERE m.mark_id IS NULL;
