


### 🔄 Denormalization 
# 🔄 Denormalization

## What is it?
**Denormalization** introduces redundancy into a database to improve query performance, usually by combining related tables into one.

## Why is it important?
- Denormalization can **speed up read operations** for complex queries by reducing the number of joins.
- It is often used in **reporting** and **data warehousing** scenarios where performance is more important than minimizing redundancy.

## Real-life Scenario
In a **reporting system**, it may be beneficial to have a single table that includes both customer and order data to quickly generate reports, instead of performing multiple joins between `customers` and `orders`.

### Example Code

-- Example of a denormalized table with both customer and order data
CREATE TABLE customer_orders (
  customer_id INT,
  customer_name VARCHAR(100),
  order_id INT,
  order_date DATE,
  order_total DECIMAL(10, 2)
);
