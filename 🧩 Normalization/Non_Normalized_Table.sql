-- Creating a non-normalized table with multiple values in one column
CREATE TABLE orders_non_normalized (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    products VARCHAR(255)
);

-- Inserting data with repeating groups
INSERT INTO orders_non_normalized (order_id, customer_name, products)
VALUES (1, 'John Doe', 'Laptop, Phone'),
       (2, 'Jane Smith', 'Tablet, Phone');
