


# 🚀 Stored Functions

## What is it?
A **stored function** is a set of SQL statements that perform a specific task, returning a single value. It can be used in SQL expressions.

## Why is it important?
- Stored functions encapsulate complex logic in a reusable format.
- They improve performance by minimizing the number of SQL statements sent to the server.

## Real-life Scenario
In an **e-commerce application**, a stored function can calculate discounts based on various criteria, making it easier to apply discounts consistently across the application.

### Example Code
-- Create a stored function to calculate discount
DELIMITER //
CREATE FUNCTION CalculateDiscount(price DECIMAL(10, 2), discount_rate DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
BEGIN
  RETURN price - (price * discount_rate / 100);
END //
DELIMITER ;

-- Call the stored function
SELECT CalculateDiscount(100, 10) AS final_price; -- Returns 90.00
