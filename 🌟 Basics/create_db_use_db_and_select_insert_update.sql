-- Creating a new database
CREATE DATABASE school_db;

-- Using the newly created database
USE school_db;


-- Creating a table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    grade VARCHAR(10)
);


-- Inserting data into the table
INSERT INTO students (name, age, grade)
VALUES ('John Doe', 16, '10th Grade'),
       ('Jane Smith', 17, '11th Grade');

-- Retrieving data using SELECT
SELECT * FROM students;

-- Updating a record in the table
UPDATE students
SET grade = '12th Grade'
WHERE name = 'Jane Smith';

-- Verifying the update
SELECT * FROM students;
