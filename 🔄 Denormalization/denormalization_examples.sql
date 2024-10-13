-- Step 1: Creating normalized tables (customers and orders)

-- Creating the customers table (normalized)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255)
);

-- Creating the orders table (normalized)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Inserting data into customers table (normalized)
INSERT INTO customers (customer_id, customer_name, customer_address)
VALUES (1, 'John Doe', '123 Elm St'),
       (2, 'Jane Smith', '456 Oak St');

-- Inserting data into orders table (normalized)
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (1, 1, '2023-09-15'),
       (2, 2, '2023-09-16');

-- Step 2: Querying the normalized tables with JOIN

-- Selecting customer details along with their orders (normalized structure)
SELECT o.order_id, o.order_date, c.customer_name, c.customer_address
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Step 3: Creating a denormalized table (combining customers and orders)

-- Dropping the denormalized table if it already exists (safety measure)
DROP TABLE IF EXISTS orders_denormalized;

-- Creating the denormalized orders table
CREATE TABLE orders_denormalized (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    order_date DATE
);

-- Inserting data directly into the denormalized table
INSERT INTO orders_denormalized (order_id, customer_name, customer_address, order_date)
VALUES (1, 'John Doe', '123 Elm St', '2023-09-15'),
       (2, 'Jane Smith', '456 Oak St', '2023-09-16');

-- Step 4: Querying the denormalized table

-- Selecting customer orders directly from the denormalized table
SELECT order_id, customer_name, customer_address, order_date
FROM orders_denormalized;

-- Step 5: (Optional) Comparing performance between normalized and denormalized queries

-- Normalized query (with JOIN)
SELECT o.order_id, o.order_date, c.customer_name, c.customer_address
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Denormalized query (no JOIN)
SELECT order_id, customer_name, customer_address, order_date
FROM orders_denormalized;
