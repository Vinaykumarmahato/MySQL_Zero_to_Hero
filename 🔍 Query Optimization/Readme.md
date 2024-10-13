# Query Optimization (`query_optimization_example.sql`)

## What is it?
**Query optimization** refers to the techniques used to improve the performance of SQL queries by reducing execution time and resource consumption.

## Why is it important?
- Optimized queries reduce **server load** and **response time**.
- It ensures your database performs well, especially as it scales with more data and users.

## Real-life Scenario
In a **banking system**, poorly optimized queries might lead to slow processing times during peak usage hours, affecting customer experience. Query optimization helps ensure fast and efficient data retrieval.

## Project: Banking System Performance Enhancement
In this project, we will implement query optimization techniques to enhance the performance of our banking system, ensuring efficient data retrieval during high-traffic periods.

### Example Code
```sql
-- Example of optimizing a query with an index
CREATE INDEX idx_customer_name ON customers(name);

-- Optimized query using the index
SELECT * FROM customers WHERE name = 'John Doe';
