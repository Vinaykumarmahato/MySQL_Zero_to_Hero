use student;
-- Disable safe update mode for this session
SET SQL_SAFE_UPDATES = 0;
-- Step 1: Create a table named 'employees'
DROP TABLE IF EXISTS employees;  -- Remove the table if it already exists

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-incrementing ID for each employee
    name VARCHAR(50) NOT NULL,          -- Name of the employee (not null constraint)
    department VARCHAR(50),              -- Department of the employee
    salary DECIMAL(10, 2)                -- Salary of the employee with two decimal places
);
-- Step 2: Insert sample data into the employees table
INSERT INTO employees (name, department, salary) 
VALUES 
    ('John Doe', 'HR', 50000.00),       -- Insert John Doe into HR
    ('Jane Smith', 'IT', 60000.50),     -- Insert Jane Smith into IT
    ('Emily Johnson', 'Finance', 55000.75); -- Insert Emily Johnson into Finance

-- Update the salary of John Doe using the primary key (id)
UPDATE employees
SET salary = 55000.00
WHERE id = 1;  -- Assuming John Doe's ID is 1

-- You can check the ID for John Doe by running:
SELECT id, name FROM employees;


-- Step 4: Select all records from the employees table
SELECT * FROM employees;                -- Retrieve all records to check the updates   