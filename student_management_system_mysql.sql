-- Create database if not exists
CREATE DATABASE IF NOT EXISTS StudentManagementDB;

-- Use the database
USE StudentManagementDB;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each student
    student_name VARCHAR(100) NOT NULL, -- Student's name
    student_email VARCHAR(255) NOT NULL UNIQUE, -- Student's email (must be unique)
    student_dob DATE NOT NULL, -- Student's date of birth
    student_address TEXT, -- Student's address
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the student record was created
);

-- Courses Table
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each course
    course_name VARCHAR(255) NOT NULL, -- Course name
    course_description TEXT, -- Course description
    course_credit INT NOT NULL, -- Course credit hours
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the course record was created
);

-- Enrollments Table
CREATE TABLE IF NOT EXISTS Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each enrollment
    student_id INT, -- Student enrolled in the course
    course_id INT, -- Course enrolled by the student
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the enrollment was made
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE, -- Linking enrollments to students
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE -- Linking enrollments to courses
);

-- Procedures for CRUD operations

-- Procedure to insert student
DELIMITER //

CREATE PROCEDURE InsertStudent(
    IN p_name VARCHAR(100), -- Input parameter: student name
    IN p_email VARCHAR(255), -- Input parameter: student email
    IN p_dob DATE, -- Input parameter: student date of birth
    IN p_address TEXT -- Input parameter: student address
)
BEGIN
    INSERT INTO Students (student_name, student_email, student_dob, student_address)
    VALUES (p_name, p_email, p_dob, p_address);
END //

DELIMITER ;

-- Procedure to select student by id
DELIMITER //

CREATE PROCEDURE SelectStudentById(
    IN p_student_id INT -- Input parameter: student id
)
BEGIN
    SELECT * FROM Students WHERE student_id = p_student_id;
END //

DELIMITER ;

-- Procedure to update student
DELIMITER //

CREATE PROCEDURE UpdateStudent(
    IN p_student_id INT, -- Input parameter: student id to update
    IN p_name VARCHAR(100), -- Input parameter: new student name
    IN p_email VARCHAR(255), -- Input parameter: new student email
    IN p_dob DATE, -- Input parameter: new student date of birth
    IN p_address TEXT -- Input parameter: new student address
)
BEGIN
    UPDATE Students
    SET student_name = p_name,
        student_email = p_email,
        student_dob = p_dob,
        student_address = p_address
    WHERE student_id = p_student_id;
END //

DELIMITER ;

-- Procedure to delete student
DELIMITER //

CREATE PROCEDURE DeleteStudent(
    IN p_student_id INT -- Input parameter: student id to delete
)
BEGIN
    DELETE FROM Students WHERE student_id = p_student_id;
END //

DELIMITER ;

-- Procedure to insert course
DELIMITER //

CREATE PROCEDURE InsertCourse(
    IN p_name VARCHAR(255), -- Input parameter: course name
    IN p_description TEXT, -- Input parameter: course description
    IN p_credit INT -- Input parameter: course credit hours
)
BEGIN
    INSERT INTO Courses (course_name, course_description, course_credit)
    VALUES (p_name, p_description, p_credit);
END //

DELIMITER ;

-- Procedure to select course by id
DELIMITER //

CREATE PROCEDURE SelectCourseById(
    IN p_course_id INT -- Input parameter: course id
)
BEGIN
    SELECT * FROM Courses WHERE course_id = p_course_id;
END //

DELIMITER ;

-- Procedure to update course
DELIMITER //

CREATE PROCEDURE UpdateCourse(
    IN p_course_id INT, -- Input parameter: course id to update
    IN p_name VARCHAR(255), -- Input parameter: new course name
    IN p_description TEXT, -- Input parameter: new course description
    IN p_credit INT -- Input parameter: new course credit hours
)
BEGIN
    UPDATE Courses
    SET course_name = p_name,
        course_description = p_description,
        course_credit = p_credit
    WHERE course_id = p_course_id;
END //

DELIMITER ;

-- Procedure to delete course
DELIMITER //

CREATE PROCEDURE DeleteCourse(
    IN p_course_id INT -- Input parameter: course id to delete
)
BEGIN
    DELETE FROM Courses WHERE course_id = p_course_id;
END //

DELIMITER ;

-- Example of usage:
-- Insert a student
CALL InsertStudent('John Doe', 'john.doe@example.com', '2000-01-01', '123 Main St, Anytown');

-- Select a student by id
CALL SelectStudentById(1);

-- Update a student
CALL UpdateStudent(1, 'Jane Smith', 'jane.smith@example.com', '1999-12-31', '456 Elm St, Othertown');

-- Delete a student
CALL DeleteStudent(1);

-- Insert a course
CALL InsertCourse('Computer Science', 'Introduction to Computer Science', 3);

-- Select a course by id
CALL SelectCourseById(1);

-- Update a course
CALL UpdateCourse(1, 'Advanced Computer Science', 'Advanced topics in Computer Science', 4);

-- Delete a course
CALL DeleteCourse(1);

-- Procedures drop (optional after usage)
DROP PROCEDURE IF EXISTS InsertStudent, SelectStudentById, UpdateStudent, DeleteStudent,
                      InsertCourse, SelectCourseById, UpdateCourse, DeleteCourse;

