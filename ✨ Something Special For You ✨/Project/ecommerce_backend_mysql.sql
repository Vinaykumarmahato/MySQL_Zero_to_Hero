-- Create database if not exists
CREATE DATABASE IF NOT EXISTS ECommerceDB;

-- Use the database
USE ECommerceDB;


-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each user
    username VARCHAR(100) NOT NULL, -- User's username
    email VARCHAR(255) NOT NULL UNIQUE, -- User's email (must be unique)
    password VARCHAR(255) NOT NULL, -- User's password
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the user record was created
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each product
    name VARCHAR(255) NOT NULL, -- Product name
    description TEXT, -- Product description
    price DECIMAL(10, 2) NOT NULL, -- Product price
    stock_quantity INT NOT NULL DEFAULT 0, -- Current stock quantity of the product
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the product record was created
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order
    user_id INT, -- User who placed the order
    total_amount DECIMAL(10, 2) NOT NULL, -- Total amount of the order
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the order was placed
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Foreign key constraint to link orders with users
);

-- Order Details Table
CREATE TABLE IF NOT EXISTS OrderDetails (
    detail_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order detail
    order_id INT, -- Order to which this detail belongs
    product_id INT, -- Product in this order detail
    quantity INT NOT NULL, -- Quantity of the product in this order detail
    price_per_unit DECIMAL(10, 2) NOT NULL, -- Price per unit of the product at the time of order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE, -- Foreign key constraint to link order details with orders
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE -- Foreign key constraint to link order details with products
);

-- Reviews Table
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each review
    product_id INT, -- Product being reviewed
    user_id INT, -- User who posted the review
    rating DECIMAL(2, 1) NOT NULL, -- Rating given by the user for the product
    comment TEXT, -- Comment or review text
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the review was posted
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE, -- Foreign key constraint to link reviews with products
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Foreign key constraint to link reviews with users
);

-- Procedure to insert product
DELIMITER //

CREATE PROCEDURE InsertProduct(
    IN p_name VARCHAR(255), -- Input parameter: product name
    IN p_description TEXT, -- Input parameter: product description
    IN p_price DECIMAL(10, 2), -- Input parameter: product price
    IN p_stock_quantity INT -- Input parameter: initial stock quantity
)
BEGIN
    INSERT INTO Products (name, description, price, stock_quantity) -- Inserting values into Products table
    VALUES (p_name, p_description, p_price, p_stock_quantity); -- Using input parameters to set values
END //

DELIMITER ;

-- Procedure to select product by id
DELIMITER //

CREATE PROCEDURE SelectProductById(
    IN p_product_id INT -- Input parameter: product id
)
BEGIN
    SELECT * FROM Products WHERE product_id = p_product_id; -- Selecting product with given product_id
END //

DELIMITER ;

-- Procedure to update product
DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN p_product_id INT, -- Input parameter: product id to update
    IN p_name VARCHAR(255), -- Input parameter: new product name
    IN p_description TEXT, -- Input parameter: new product description
    IN p_price DECIMAL(10, 2), -- Input parameter: new product price
    IN p_stock_quantity INT -- Input parameter: new stock quantity
)
BEGIN
    UPDATE Products -- Updating Products table
    SET name = p_name, -- Setting new values for name, description, price, and stock_quantity
        description = p_description,
        price = p_price,
        stock_quantity = p_stock_quantity
    WHERE product_id = p_product_id; -- Updating product with given product_id
END //

DELIMITER ;

-- Procedure to delete product
DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN p_product_id INT -- Input parameter: product id to delete
)
BEGIN
    DELETE FROM Products WHERE product_id = p_product_id; -- Deleting product with given product_id from Products table
END //

DELIMITER ;
