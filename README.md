College Management System - MySQL

A complete College Management System database project developed using MySQL.

Project Overview

This project manages:

Departments
Students
Faculty
Courses
Student Enrollments

The database demonstrates relationships between multiple tables using primary keys and foreign keys.

Tables

department
student
faculty
course
enrollment

Concepts Used

CREATE DATABASE
CREATE TABLE
PRIMARY KEY
FOREIGN KEY
AUTO_INCREMENT
NOT NULL
UNIQUE
CHECK
ENUM
DEFAULT
ON DELETE CASCADE
ON DELETE RESTRICT
ON UPDATE CASCADE
INNER JOIN
LEFT JOIN
Aggregate Functions
GROUP BY
HAVING
LIKE Operator
UPDATE
DELETE
Subqueries

Relationships

One Department can have many Students.
One Department can have many Faculty members.
One Faculty member can teach multiple Courses.
Students and Courses have a many-to-many relationship through the Enrollment table.

JOIN Concept

INNER JOIN
Returns only records that have matching values in both tables.

Example:

SELECT s.student_name, d.department_name
FROM student s
INNER JOIN department d
ON s.department_id = d.department_id;

LEFT JOIN

Returns all records from the left table and matching records from the right table.

Example:

SELECT d.department_name, s.student_name
FROM department d
LEFT JOIN student s
ON d.department_id = s.department_id;

How to Run

Open MySQL Workbench.
Open college_management_system.sql.
Run the script.
The database, tables, and sample data will be created.
Run the SELECT queries to view the results.

Files

college_management_system.sql - Complete database project with queries.
README.md - Project documentation.

Tools Used

MySQL,
MySQL Workbench,
GitHub.
