-- Creating a table that violates 2NF
CREATE TABLE products_non_normalized (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    supplier_name VARCHAR(100),
    supplier_phone VARCHAR(20)
);

-- Inserting data
INSERT INTO products_non_normalized (product_id, product_name, supplier_name, supplier_phone)
VALUES (1, 'Laptop', 'TechCorp', '123-456-7890'),
       (2, 'Phone', 'MobileInc', '987-654-3210');
