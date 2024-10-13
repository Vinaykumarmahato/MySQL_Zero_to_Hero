-- Creating a view to show high salary employees
CREATE VIEW high_salary_employees AS
SELECT emp_name, salary
FROM employees
WHERE salary > 55000;

-- Selecting data from the view
SELECT * FROM high_salary_employees;

-- Dropping the view
DROP VIEW high_salary_employees;
