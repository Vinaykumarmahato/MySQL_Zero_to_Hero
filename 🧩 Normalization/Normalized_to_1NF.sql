-- Creating a normalized table with atomic values
CREATE TABLE orders (
    order_id INT,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    PRIMARY KEY (order_id, product_name)
);

-- Inserting atomic values
INSERT INTO orders (order_id, customer_name, product_name)
VALUES (1, 'John Doe', 'Laptop'),
       (1, 'John Doe', 'Phone'),
       (2, 'Jane Smith', 'Tablet'),
       (2, 'Jane Smith', 'Phone');
