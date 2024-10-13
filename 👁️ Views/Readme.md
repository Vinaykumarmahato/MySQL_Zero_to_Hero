


### 👁️ Views (`creating_views.sql`)


# 👁️ Views

## What is it?
A **view** is a virtual table that is created from the result of a query. It does not store data itself but displays data from one or more tables.

## Why is it important?
- Views help **simplify complex queries** by encapsulating them in a reusable format.
- They provide **data security** by limiting access to specific rows or columns.

## Real-life Scenario
In a **company payroll system**, you may want to give certain users access to employee names and departments, but not their salary information. A view can provide a filtered version of the data, hiding sensitive columns.

### Example Code
sql
-- Create a view showing employee names and departments only
CREATE VIEW employee_department_view AS
SELECT employee_name, department
FROM employees;

-- Querying the view
SELECT * FROM employee_department_view;
