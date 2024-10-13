-- Creating a table with various data types
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- Inserting data into the table
INSERT INTO employees (name, salary, hire_date)
VALUES ('Alice', 50000.00, '2022-05-10'),
       ('Bob', 60000.00, '2023-03-20');

-- Selecting data to see how the data types work
SELECT * FROM employees;
