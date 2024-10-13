


### 🛠️ Stored Procedures 

# 🛠️ Stored Procedures

## What is it?
A **stored procedure** is a precompiled SQL script that you can execute to perform complex database operations. It’s stored in the database and can be reused.

## Why is it important?
- Stored procedures **improve performance** by reducing the need for repeated compilation.
- They **encapsulate business logic** in the database, making it easier to maintain and reuse.

## Real-life Scenario
In an **inventory management system**, a stored procedure might be used to calculate the restocking quantity for products based on their sales data and current stock levels.

### Example Code
sql

-- Create a stored procedure to calculate product restock
DELIMITER //
CREATE PROCEDURE CalculateRestock()
BEGIN
  UPDATE products
  SET restock_quantity = (sales_last_month - stock_on_hand);
END //
DELIMITER ;

-- Call the stored procedure
CALL CalculateRestock();
