-- Creating two tables
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Inserting data into customers table
INSERT INTO customers (customer_name)
VALUES ('John Doe'), ('Jane Smith');

-- Inserting data into orders table
INSERT INTO orders (customer_id, order_date)
VALUES (1, '2023-10-01'), (2, '2023-10-03');

-- INNER JOIN example
SELECT customer_name, order_date
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;

-- LEFT JOIN example
SELECT customer_name, order_date
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

-- RIGHT JOIN example
SELECT customer_name, order_date
FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id;
