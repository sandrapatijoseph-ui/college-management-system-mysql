DROP DATABASE IF EXISTS college_management_system;
CREATE DATABASE college_management_system;
USE college_management_system;
CREATE TABLE department (
department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL UNIQUE,
hod VARCHAR(100) NOT NULL
);
CREATE TABLE student (
student_id INT AUTO_INCREMENT PRIMARY KEY,
student_name VARCHAR(100) NOT NULL,
gender ENUM('Male', 'Female', 'Other') NOT NULL,
age INT NOT NULL CHECK (age >= 16 AND age <= 100),
email VARCHAR(100) NOT NULL UNIQUE,
phone VARCHAR(15) NOT NULL UNIQUE,
semester INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
department_id INT NOT NULL,
FOREIGN KEY (department_id)
REFERENCES department(department_id) );
CREATE TABLE faculty (
faculty_id INT AUTO_INCREMENT PRIMARY KEY,
faculty_name VARCHAR(100) NOT NULL,
designation VARCHAR(100) NOT NULL,
salary DECIMAL(10,2) NOT NULL CHECK (salary > 20000),
email VARCHAR(100) NOT NULL UNIQUE,
department_id INT NOT NULL,
FOREIGN KEY (department_id)
REFERENCES department(department_id));
CREATE TABLE course (
course_id INT AUTO_INCREMENT PRIMARY KEY,
course_name VARCHAR(100) NOT NULL UNIQUE,
credits INT NOT NULL CHECK (credits BETWEEN 1 AND 6),
semester INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
faculty_id INT,
FOREIGN KEY (faculty_id)
REFERENCES faculty(faculty_id)
ON DELETE SET NULL
ON UPDATE CASCADE );
CREATE TABLE enrollment (
enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
course_id INT NOT NULL,
enrollment_date DATE DEFAULT (CURRENT_DATE),
grade ENUM('A', 'B', 'C', 'D', 'Fail') DEFAULT 'A',
UNIQUE(student_id, course_id),
FOREIGN KEY (student_id)
REFERENCES student(student_id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (course_id)
REFERENCES course(course_id)
ON DELETE CASCADE
ON UPDATE CASCADE );
INSERT INTO department (department_name, hod)
VALUES
('CSE', 'Dr. Ramesh'),
('ECE', 'Dr. Anitha'),
('EEE', 'Dr. Kumar'),
('ME', 'Dr. Suresh'),
('Civil', 'Dr. Lakshmi');
INSERT INTO student
VALUES
('Arun', 'Male', 20, 'arun@gmail.com', '9000000001', 3, 1),
('Anjali', 'Female', 21, 'anjali@gmail.com', '9000000002', 3, 1),
('Sohan', 'Male', 22, 'sohan@gmail.com', '9000000003', 4, 1),
('Sonia', 'Female', 20, 'sonia@gmail.com', '9000000004', 4, 1),
('Rohan', 'Male', 23, 'rohan@gmail.com', '9000000005', 5, 1),
('Aman', 'Male', 24, 'aman@gmail.com', '9000000006', 5, 1),
('Kiran', 'Male', 21, 'kiran@gmail.com', '9000000007', 3, 2),
('Kavya', 'Female', 22, 'kavya@gmail.com', '9000000008', 4, 2),
('Nandini', 'Female', 20, 'nandini@gmail.com', '9000000009', 3, 2),
('John', 'Male', 26, 'john@gmail.com', '9000000010', 6, 3),
('Suresh', 'Male', 25, 'suresh@gmail.com', '9000000011', 6, 4),
('Anu', 'Female', 19, 'student_anu@gmail.com', '9000000012', 2, 5);
INSERT INTO faculty
VALUES
('Dr. Ravi', 'Professor', 60000, 'ravi@college.com', 1),
('Dr. Priya', 'Associate Professor', 50000, 'priya@college.com', 1),
('Dr. Kiran', 'Professor', 55000, 'kiran@college.com', 2),
('Dr. Rakesh', 'Assistant Professor', 45000, 'rakesh@college.com', 3),
('Dr. Meena', 'Professor', 65000, 'meena@college.com', 4),
('Dr. Sita', 'Assistant Professor', 40000, 'sita@college.com', 5);
INSERT INTO course
VALUES
('Database Management System', 4, 3, 1),
('Data Structures', 4, 3, 1),
('Web Technology', 3, 4, 1),
('Computer Networks', 4, 4, 2),
('Data Analytics', 3, 5, 2),
('Embedded System', 4, 4, 3),
('Power System', 4, 5, 4),
('Mechanical Design', 3, 5, 5),
('Survey System', 3, 4, 6);
INSERT INTO enrollment
VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A'),
(2, 3, 'A'),
(3, 2, 'C'),
(3, 4, 'B'),
(4, 3, 'A'),
(5, 5, 'B'),
(6, 1, 'Fail'),
(7, 6, 'A'),
(8, 6, 'B'),
(9, 2, 'A'),
(10, 7, 'C'),
(11, 8, 'B');
SELECT * FROM department;
SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM course;
SELECT * FROM enrollment;
SELECT s.student_name, d.department_name
FROM student s
INNER JOIN department d
ON s.department_id = d.department_id;
SELECT f.faculty_name, d.department_name
FROM faculty f
INNER JOIN department d
ON f.department_id = d.department_id;
SELECT c.course_name, f.faculty_name
FROM course c
INNER JOIN faculty f
ON c.faculty_id = f.faculty_id;
SELECT s.student_name, c.course_name
FROM student s
INNER JOIN enrollment e
ON s.student_id = e.student_id
INNER JOIN course c
ON e.course_id = c.course_id;
SELECT s.student_name, c.course_name, e.grade
FROM enrollment e
INNER JOIN student s
ON e.student_id = s.student_id
INNER JOIN course c
ON e.course_id = c.course_id;
SELECT f.faculty_name, c.course_name
FROM faculty f
INNER JOIN course c
ON f.faculty_id = c.faculty_id;
SELECT d.department_name,
COUNT(s.student_id) AS total_students
FROM department d
LEFT JOIN student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;
SELECT f.faculty_name,
COUNT(c.course_id) AS total_courses
FROM faculty f
LEFT JOIN course c
ON f.faculty_id = c.faculty_id
GROUP BY f.faculty_id, f.faculty_name;
SELECT student_name, semester
FROM student;
SELECT d.department_name, s.student_name
FROM department d
LEFT JOIN student s
ON d.department_id = s.department_id;
SELECT f.faculty_name, c.course_name
FROM faculty f
LEFT JOIN course c
ON f.faculty_id = c.faculty_id;
SELECT s.student_name,
d.department_name,
c.course_name
FROM student s
INNER JOIN department d
ON s.department_id = d.department_id
INNER JOIN enrollment e
ON s.student_id = e.student_id
INNER JOIN course c
ON e.course_id = c.course_id;
SELECT s.student_name,
d.department_name,
f.faculty_name
FROM student s
INNER JOIN department d
ON s.department_id = d.department_id
INNER JOIN faculty f
ON d.department_id = f.department_id;
SELECT s.student_name,
s.email,
d.department_name
FROM student s
INNER JOIN department d
ON s.department_id = d.department_id;
SELECT c.course_name,
c.credits,
f.faculty_name
FROM course c
INNER JOIN faculty f
ON c.faculty_id = f.faculty_id;
SELECT s.student_name,
c.course_name,
e.grade
FROM student s
INNER JOIN enrollment e
ON s.student_id = e.student_id
INNER JOIN course c
ON e.course_id = c.course_id
WHERE e.grade = 'A';
SELECT d.department_name,
COUNT(f.faculty_id) AS faculty_count
FROM department d
LEFT JOIN faculty f
ON d.department_id = f.department_id
GROUP BY d.department_id, d.department_name;
SELECT s.student_name,
f.faculty_name,
c.course_name
FROM student s
INNER JOIN enrollment e
ON s.student_id = e.student_id
INNER JOIN course c
ON e.course_id = c.course_id
INNER JOIN faculty f
ON c.faculty_id = f.faculty_id;
SELECT s.student_name,
d.department_name,
c.course_name,
f.faculty_name,
e.grade
FROM student s
INNER JOIN department d
ON s.department_id = d.department_id
LEFT JOIN enrollment e
ON s.student_id = e.student_id
LEFT JOIN course c
ON e.course_id = c.course_id
LEFT JOIN faculty f
ON c.faculty_id = f.faculty_id;
SELECT s.student_name
FROM student s
LEFT JOIN enrollment e
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;
SELECT COUNT(*) AS total_students
FROM student;
SELECT department_id,
COUNT(*) AS total_students
FROM student
GROUP BY department_id;
SELECT AVG(age) AS average_age
FROM student;
SELECT MAX(age) AS highest_age
FROM student;
SELECT MIN(credits) AS minimum_credits
FROM course;
SELECT d.department_name,
COUNT(s.student_id) AS student_count
FROM department d
INNER JOIN student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(s.student_id) > 5;
SELECT f.faculty_name,
COUNT(c.course_id) AS course_count
FROM faculty f
INNER JOIN course c
ON f.faculty_id = c.faculty_id
GROUP BY f.faculty_id, f.faculty_name
HAVING COUNT(c.course_id) > 2;
SELECT d.department_name,
AVG(s.age) AS average_age
FROM department d
INNER JOIN student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;
SELECT f.faculty_name,
SUM(c.credits) AS total_credits
FROM faculty f
INNER JOIN course c
ON f.faculty_id = c.faculty_id
GROUP BY f.faculty_id, f.faculty_name;
SELECT c.course_name,
COUNT(e.student_id) AS student_count
FROM course c
LEFT JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
SELECT d.department_name,
COUNT(s.student_id) AS student_count
FROM department d
LEFT JOIN student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;
SELECT d.department_name,
MAX(s.age) AS highest_age
FROM department d
INNER JOIN student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;
SELECT f.faculty_name,
COUNT(c.course_id) AS total_courses
FROM faculty f
INNER JOIN course c
ON f.faculty_id = c.faculty_id
GROUP BY f.faculty_id, f.faculty_name
ORDER BY total_courses DESC
LIMIT 1;
SELECT s.student_name,
COUNT(e.course_id) AS course_count
FROM student s
INNER JOIN enrollment e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(e.course_id) > 1;
SELECT student_name, age
FROM student
ORDER BY age DESC
LIMIT 3;
SELECT * FROM student
WHERE student_name LIKE 'A%';
SELECT * FROM student
WHERE student_name LIKE '%a';
SELECT * FROM student
WHERE student_name LIKE '%an%';
SELECT * FROM student
WHERE student_name LIKE '_o%';
SELECT * FROM student
WHERE student_name LIKE 'S%a';
SELECT * FROM student
WHERE student_name LIKE '_____';
SELECT * FROM student
WHERE student_name LIKE '______';
SELECT * FROM student
WHERE email LIKE '%@gmail.com';
SELECT * FROM student
WHERE email LIKE 'student%';
SELECT * FROM department
WHERE department_name LIKE 'C%';
SELECT * FROM department
WHERE department_name LIKE '%E';
SELECT * FROM faculty
WHERE faculty_name LIKE '%ra%';
SELECT * FROM faculty
WHERE faculty_name LIKE 'Dr%';
SELECT * FROM faculty
WHERE designation LIKE '%Professor';
SELECT * FROM course
WHERE course_name LIKE '%Data%';
SELECT * FROM course
WHERE course_name LIKE 'Web%';
SELECT * FROM course
WHERE course_name LIKE '%System';
SELECT * FROM student
WHERE student_name LIKE '__n%';
SELECT * FROM faculty
WHERE faculty_name LIKE '%k%';
SELECT * FROM student
WHERE student_name LIKE '%n';
UPDATE student
SET email = 'arun_new@gmail.com'
WHERE student_id = 1;
UPDATE student
SET age = age + 1
WHERE student_id = 1;
UPDATE student
SET semester = 4
WHERE department_id = 1;
UPDATE department
SET department_name = 'Computer Science'
WHERE department_id = 1;
UPDATE faculty
SET designation = 'Senior Professor'
WHERE faculty_id = 1;
UPDATE courses
SET credits = 5
WHERE course_id = 1;
UPDATE enrollment
SET grade = 'A'
WHERE student_id = 1 AND course_id = 2;
UPDATE student
SET department_id = (
SELECT department_id
FROM department
WHERE department_name = 'CSE'
)
WHERE department_id = (
SELECT department_id
FROM department
WHERE department_name = 'ECE'
);
UPDATE faculty f
INNER JOIN department d
ON f.department_id = d.department_id
SET f.designation = 'Senior Professor'
WHERE d.department_name = 'CSE';
