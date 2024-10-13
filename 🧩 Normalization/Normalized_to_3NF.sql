-- Splitting the table into two to eliminate transitive dependency
CREATE TABLE departments (
    department VARCHAR(100) PRIMARY KEY,
    department_head VARCHAR(100)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(100),
    FOREIGN KEY (department) REFERENCES departments(department)
);

-- Inserting data into normalized tables
INSERT INTO departments (department, department_head)
VALUES ('HR', 'Alice'),
       ('IT', 'Bob');

INSERT INTO employees (emp_id, emp_name, department)
VALUES (1, 'John Doe', 'HR'),
       (2, 'Jane Smith', 'IT');
