-- Creating a table that violates 3NF
CREATE TABLE employees_non_normalized (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(100),
    department_head VARCHAR(100)
);

-- Inserting data
INSERT INTO employees_non_normalized (emp_id, emp_name, department, department_head)
VALUES (1, 'John Doe', 'HR', 'Alice'),
       (2, 'Jane Smith', 'IT', 'Bob');
