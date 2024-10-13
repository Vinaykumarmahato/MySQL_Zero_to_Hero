-- Creating a table with no index
CREATE TABLE customers_no_index (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    registration_date DATE
);

-- Inserting sample data
INSERT INTO customers_no_index (customer_id, customer_name, customer_email, registration_date)
VALUES (1, 'John Doe', 'john@example.com', '2023-01-10'),
       (2, 'Jane Smith', 'jane@example.com', '2023-01-12'),
       (3, 'Mike Johnson', 'mike@example.com', '2023-02-15');

-- Slow query without an index (full table scan)
SELECT customer_name
FROM customers_no_index
WHERE registration_date = '2023-01-10';

-- Optimized query by adding an index on registration_date
CREATE INDEX idx_registration_date ON customers_no_index (registration_date);

-- Faster query using the index
SELECT customer_name
FROM customers_no_index
WHERE registration_date = '2023-01-10';
