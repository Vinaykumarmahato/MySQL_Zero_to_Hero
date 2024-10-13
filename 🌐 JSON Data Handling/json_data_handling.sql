-- 🌐 JSON Data Handling in MySQL
-- Author: [Your Name]
-- Date: [Date]
-- Description: This script demonstrates how to handle JSON data in MySQL, including storing, querying, and manipulating JSON fields.

-- ====================================
-- 📘 Introduction
-- ====================================
-- JSON (JavaScript Object Notation) is a lightweight data-interchange format that is easy for humans to read and write and easy for machines to parse and generate. 
-- MySQL supports JSON data types, allowing you to store JSON objects and arrays in a column and manipulate them using various JSON functions.

-- Key Points:
-- 1. JSON data is stored in a MySQL column with the `JSON` data type.
-- 2. You can query, extract, and modify JSON data using MySQL’s built-in JSON functions.
-- 3. JSON allows flexibility in handling semi-structured data directly in MySQL.

-- ====================================
-- Step 1: Creating a Table with a JSON Column
-- ====================================
-- Let’s start by creating a table that has a JSON column to store product details in JSON format.

-- Drop the table if it already exists (for testing purposes)
DROP TABLE IF EXISTS products;

-- Create a table with a JSON column
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    product_details JSON
);

-- Explanation:
-- - `product_details`: This column is of the `JSON` data type, which will store product information (like price, category, etc.) in JSON format.

-- ====================================
-- Step 2: Inserting JSON Data into the Table
-- ====================================
-- You can insert JSON data as a string, and MySQL will validate that the data is a valid JSON format.

-- Insert data into the `products` table
INSERT INTO products (product_id, product_name, product_details)
VALUES 
(1, 'Laptop', '{"price": 1000, "brand": "Dell", "specs": {"cpu": "Intel i7", "ram": "16GB", "storage": "512GB SSD"}}'),
(2, 'Smartphone', '{"price": 700, "brand": "Samsung", "specs": {"cpu": "Exynos", "ram": "8GB", "storage": "128GB"}}'),
(3, 'Tablet', '{"price": 400, "brand": "Apple", "specs": {"cpu": "A14", "ram": "4GB", "storage": "64GB"}}');

-- Explanation:
-- - We’ve inserted JSON data into the `product_details` column for each product.
-- - Each row contains JSON data describing product attributes such as `price`, `brand`, and `specs` (which is a nested JSON object).

-- ====================================
-- Step 3: Querying JSON Data
-- ====================================
-- MySQL provides several functions to query JSON data, such as `JSON_EXTRACT()` to extract data from a JSON column.

-- 1. Extracting a Single Value from JSON
-- You can use `->` or `JSON_EXTRACT()` to extract a specific key's value.

-- Example: Extract the `price` from the `product_details`
SELECT 
    product_id, 
    product_name, 
    product_details->>'$.price' AS price
FROM products;

-- Explanation:
-- - The `->>` operator extracts the value of the `price` key from the `product_details` column.
-- - This query will return the product ID, name, and price for each product.

-- 2. Extracting Nested JSON Data
-- To extract data from nested JSON objects, use dot notation.

-- Example: Extract the `cpu` value from the nested `specs` object
SELECT 
    product_id, 
    product_name, 
    product_details->>'$.specs.cpu' AS cpu
FROM products;

-- Explanation:
-- - The dot notation (`$.specs.cpu`) accesses the `cpu` key within the nested `specs` object.

-- ====================================
-- Step 4: Modifying JSON Data
-- ====================================
-- MySQL provides functions like `JSON_SET()`, `JSON_REPLACE()`, and `JSON_REMOVE()` to modify JSON data.

-- 1. Updating a JSON Value
-- You can use `JSON_SET()` to update a specific value in a JSON column.

-- Example: Update the `price` of the laptop
UPDATE products
SET product_details = JSON_SET(product_details, '$.price', 950)
WHERE product_name = 'Laptop';

-- Explanation:
-- - `JSON_SET()` updates the `price` key within the `product_details` column to 950.
-- - The query updates the price of the Laptop from 1000 to 950.

-- 2. Adding a New Key to a JSON Object
-- You can add new fields to a JSON object using `JSON_SET()`.

-- Example: Add a new key `warranty` to the `product_details` JSON object
UPDATE products
SET product_details = JSON_SET(product_details, '$.warranty', '2 years')
WHERE product_name = 'Laptop';

-- Explanation:
-- - This query adds a new key `warranty` with a value of `2 years` to the `product_details` of the Laptop.

-- 3. Removing a Key from JSON Data
-- You can remove a key from a JSON object using `JSON_REMOVE()`.

-- Example: Remove the `warranty` key from the JSON object
UPDATE products
SET product_details = JSON_REMOVE(product_details, '$.warranty')
WHERE product_name = 'Laptop';

-- Explanation:
-- - `JSON_REMOVE()` removes the `warranty` key from the `product_details` column of the Laptop.

-- ====================================
-- Step 5: Filtering Rows Based on JSON Data
-- ====================================
-- You can filter rows based on JSON data using the `JSON_EXTRACT()` function in the `WHERE` clause.

-- Example: Select products with a `price` greater than 500
SELECT 
    product_id, 
    product_name, 
    product_details->>'$.price' AS price
FROM products
WHERE CAST(product_details->>'$.price' AS DECIMAL(10, 2)) > 500;

-- Explanation:
-- - The `CAST()` function converts the JSON value to a numeric type so we can compare it.
-- - The query selects products where the price is greater than 500.

-- ====================================
-- Step 6: Indexing JSON Data for Performance
-- ====================================
-- You can create a **generated column** from JSON data and then index it to improve query performance.

-- Example: Create a generated column and index it
ALTER TABLE products
ADD price DECIMAL(10,2) AS (JSON_UNQUOTE(product_details->'$.price')) STORED,
ADD INDEX (price);

-- Explanation:
-- - We create a generated column `price` by extracting the `price` from `product_details`.
-- - We then index the generated `price` column to speed up queries that filter on price.

-- ====================================
-- Step 7: Validating JSON Data
-- ====================================
-- MySQL automatically validates JSON data, but you can explicitly check if a string is valid JSON using `JSON_VALID()`.

-- Example: Validate if a string is valid JSON
SELECT JSON_VALID('{"name": "John", "age": 30}') AS is_valid;

-- Explanation:
-- - This will return 1 if the string is valid JSON, and 0 if it's not.

-- ====================================
-- 🚀 Conclusion
-- ====================================
-- MySQL’s JSON data type and functions make it easy to store, query, and manipulate semi-structured data.
-- You can use functions like `JSON_EXTRACT()`, `JSON_SET()`, and `JSON_REMOVE()` to handle JSON data efficiently.
-- Indexing JSON data through generated columns can also improve query performance. 
-- Using these techniques, MySQL can seamlessly work with both relational and JSON data.

-- End of script.
