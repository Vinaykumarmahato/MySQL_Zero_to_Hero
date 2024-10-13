-- Creating a sales table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting data
INSERT INTO sales (product_name, quantity, price)
VALUES ('Laptop', 5, 1000.00),
       ('Laptop', 3, 1000.00),
       ('Phone', 10, 500.00),
       ('Tablet', 4, 800.00);

-- Using GROUP BY to aggregate data
SELECT product_name, SUM(quantity) AS total_quantity, AVG(price) AS avg_price
FROM sales
GROUP BY product_name;

-- Filtering groups with HAVING
SELECT product_name, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
HAVING total_quantity > 4;
