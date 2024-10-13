-- Splitting the table into two to remove redundancy
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    supplier_id INT
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    supplier_phone VARCHAR(20)
);

-- Inserting data into normalized tables
INSERT INTO suppliers (supplier_id, supplier_name, supplier_phone)
VALUES (1, 'TechCorp', '123-456-7890'),
       (2, 'MobileInc', '987-654-3210');

INSERT INTO products (product_id, product_name, supplier_id)
VALUES (1, 'Laptop', 1),
       (2, 'Phone', 2);
