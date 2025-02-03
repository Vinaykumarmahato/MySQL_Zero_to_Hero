-- Creating an employees table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10, 2),
    dept_id INT
);


-- Inserting data
INSERT INTO employees (emp_name, salary, dept_id)
VALUES ('John Doe', 50000, 1),
       ('Jane Smith', 60000, 2),
       ('Bob Johnson', 55000, 1);

-- Simple subquery in SELECT statement
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Correlated subquery
SELECT emp_name
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id);
