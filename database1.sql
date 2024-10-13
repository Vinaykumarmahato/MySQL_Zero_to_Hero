-- Create a table 'employees'
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Insert some sample data
INSERT INTO employees (name, department, salary) 
VALUES ('John Doe', 'HR', 50000), 
       ('Jane Smith', 'IT', 60000);

-- Update an employee's salary
UPDATE employees
SET salary = 55000
WHERE name = 'John Doe';

-- Select all records from the employees table
SELECT * FROM employees;
