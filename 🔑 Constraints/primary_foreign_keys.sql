-- Creating a departments table with a Primary Key
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100)
);

-- Creating an employees table with a Foreign Key referencing departments
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Inserting data into the departments table
INSERT INTO departments (dept_name)
VALUES ('HR'), ('Finance');

-- Inserting data into the employees table
INSERT INTO employees (emp_name, dept_id)
VALUES ('Alice', 1), ('Bob', 2);

-- Retrieving data by joining tables using Foreign Key
SELECT emp_name, dept_name
FROM employees
JOIN departments ON employees.dept_id = departments.dept_id;
