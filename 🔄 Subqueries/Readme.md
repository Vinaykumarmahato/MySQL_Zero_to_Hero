# 🔄 Subqueries (`subqueries_example.sql`)

## What is it?
A **subquery** is a query nested within another SQL query. It allows for complex queries where one query depends on the result of another.

## Why is it important?
- Subqueries enable **modular query writing**.
- They allow **complex filtering** that can't be done with simple SQL clauses.

## Real-life Scenario
Suppose you're managing a **restaurant chain** and want to find employees whose salary is higher than the **average salary** in their department. A subquery calculates the average salary first, then compares individual salaries to that.

## Project: Employee Salary Analysis
In this project, we will use subqueries to analyze employee salaries within different departments, helping management make informed decisions regarding pay raises or bonuses.

### Example Code
```sql
-- Get employees with salary greater than the department's average
SELECT employee_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department = 'IT');
