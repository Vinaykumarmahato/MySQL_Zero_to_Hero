


### 🧩 Normalization (`database_normalization.sql`)

# 🧩 Normalization

## What is it?
**Normalization** is the process of organizing data into related tables to reduce data redundancy and ensure data integrity.

## Why is it important?
- It minimizes **duplicate data** and ensures the database is efficient.
- Normalization also makes it easier to **update** and **maintain** the database.

## Real-life Scenario
In a **university database**, instead of storing student and course information together (which can cause redundancy), normalization separates them into different tables like `students`, `courses`, and `enrollments`. This ensures data consistency and avoids duplication of information.

### Example Code
sql
-- Normalized tables for a university database

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100)
);

CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
