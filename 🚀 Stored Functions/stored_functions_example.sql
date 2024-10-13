-- 🚀 Stored Functions in MySQL
-- Author: [Your Name]
-- Date: [Date]
-- Description: This script demonstrates how to create and use stored functions in MySQL, with explanations of each part.

-- ====================================
-- 📘 Introduction
-- ====================================
-- A **Stored Function** is a reusable piece of SQL code that performs a specific task and returns a single value.
-- Stored functions can take input parameters and use them to return a calculated value. 
-- Functions are similar to stored procedures but are used to return a result, while stored procedures perform an action.

-- Key Points:
-- 1. Stored functions are called from SQL statements and return a single value.
-- 2. They can accept parameters and use them for calculations or logic.
-- 3. Functions can be used within SQL queries, making them powerful tools for repetitive calculations or logic.
-- 4. They are stored in the database and can be reused across multiple queries or applications.

-- ====================================
-- 🛠️ Syntax for Creating a Stored Function
-- ====================================
-- CREATE FUNCTION function_name (parameter_list)
-- RETURNS data_type
-- BEGIN
--     -- Function logic goes here
--     RETURN value;
-- END;

-- Explanation:
-- - `function_name`: The name of the function.
-- - `parameter_list`: A list of parameters (if any) the function will accept.
-- - `RETURNS data_type`: Specifies the data type of the value that the function will return.
-- - `RETURN value`: The value that the function returns.

-- ====================================
-- Step 1: Create a Sample Function
-- ====================================
-- In this example, we will create a function called `calculate_discount` that takes two parameters: 
-- the original price and the discount percentage, and it returns the final price after applying the discount.

-- Drop the function if it already exists (for testing purposes)
DROP FUNCTION IF EXISTS calculate_discount;

-- Create the function
DELIMITER $$

CREATE FUNCTION calculate_discount(original_price DECIMAL(10,2), discount_percent INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE final_price DECIMAL(10,2);
    SET final_price = original_price - (original_price * discount_percent / 100);
    RETURN final_price;
END$$

DELIMITER ;

-- Explanation:
-- - `original_price`: The original price of the product (DECIMAL data type).
-- - `discount_percent`: The discount percentage (INT data type).
-- - Inside the function, we calculate the final price after applying the discount and return that value.

-- ====================================
-- Step 2: Use the Function in a Query
-- ====================================
-- Now that we have created the `calculate_discount` function, let's use it in a SQL query.

-- Create a sample table to demonstrate the function usage
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO products (product_id, product_name, price)
VALUES (1, 'Laptop', 1000.00),
       (2, 'Smartphone', 500.00),
       (3, 'Tablet', 300.00);

-- Query to apply the `calculate_discount` function to the products
SELECT product_id, product_name, price AS original_price,
       calculate_discount(price, 10) AS discounted_price
FROM products;

-- Explanation:
-- - We created a `products` table with some sample products and prices.
-- - The `SELECT` statement applies the `calculate_discount` function to calculate the discounted price with a 10% discount.
-- - The function is used like any other SQL function, inside the `SELECT` statement.

-- ====================================
-- Step 3: Another Example: Calculate Sales Tax
-- ====================================
-- Now, let’s create another stored function to calculate the total price including sales tax.

-- Drop the function if it already exists
DROP FUNCTION IF EXISTS calculate_total_with_tax;

-- Create the function
DELIMITER $$

CREATE FUNCTION calculate_total_with_tax(price DECIMAL(10,2), tax_percent INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_price DECIMAL(10,2);
    SET total_price = price + (price * tax_percent / 100);
    RETURN total_price;
END$$

DELIMITER ;

-- Explanation:
-- - The `calculate_total_with_tax` function takes a `price` and a `tax_percent` as input.
-- - It returns the total price after adding the sales tax.
-- - We use the same `DELIMITER $$` statement to ensure the function is correctly parsed.

-- Use the new function in a query:
SELECT product_id, product_name, price AS original_price,
       calculate_total_with_tax(price, 5) AS total_with_tax
FROM products;

-- Explanation:
-- - This `SELECT` query applies the `calculate_total_with_tax` function to calculate the total price after adding a 5% tax.

-- ====================================
-- Best Practices for Using Stored Functions
-- ====================================
-- 1. **Keep Functions Simple**: Functions should perform a single task and return a value.
-- 2. **Use Deterministic Functions**: If your function always returns the same result for the same inputs, declare it as `DETERMINISTIC`. This can improve performance.
-- 3. **Avoid Complex Logic in Functions**: Functions should not have complex business logic or perform actions like inserts, updates, or deletes. Use stored procedures for those operations.
-- 4. **Testing**: Always test your functions thoroughly with various input values to ensure they work correctly.

-- ====================================
-- Conclusion
-- ====================================
-- Stored functions in MySQL allow you to encapsulate reusable logic that returns a single value. They can be 
-- used directly within SQL queries to simplify and centralize calculations, making your database code cleaner and 
-- more maintainable. By following best practices, you can ensure that your stored functions are efficient and effective.
