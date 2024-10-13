-- Creating a customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

-- Creating an index on customer_name
CREATE INDEX idx_customer_name ON customers(customer_name);

-- Creating a unique index on email
CREATE UNIQUE INDEX idx_email ON customers(email);

-- Using index in a query
SELECT * FROM customers WHERE customer_name = 'John Doe';
