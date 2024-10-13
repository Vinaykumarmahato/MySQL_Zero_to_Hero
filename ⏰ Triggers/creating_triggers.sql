-- Creating an audit table to track changes in employee salary
CREATE TABLE salary_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creating an employees table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- Inserting sample data into employees table
INSERT INTO employees (emp_name, salary)
VALUES ('John Doe', 50000),
       ('Jane Smith', 60000);

-- Creating a BEFORE UPDATE trigger to log salary changes
CREATE TRIGGER before_salary_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit (emp_id, old_salary, new_salary)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary);
END;

-- Updating salary for an employee (This will trigger the BEFORE UPDATE trigger)
UPDATE employees
SET salary = 55000
WHERE emp_id = 1;

-- Verifying the salary change in employees table
SELECT * FROM employees;

-- Checking the salary audit log to see the changes recorded by the trigger
SELECT * FROM salary_audit;

-- Dropping the trigger if no longer needed
DROP TRIGGER before_salary_update;
