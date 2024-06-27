-- Create database if not exists
CREATE DATABASE IF NOT EXISTS EcommerceDB;
-- Use the database
USE EcommerceDB;

-- Users Table: Stores information about users
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each user
    username VARCHAR(100) NOT NULL, -- User's username
    email VARCHAR(255) NOT NULL, -- User's email address
    password VARCHAR(255) NOT NULL, -- User's password
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the user account was created
);

-- Products Table: Stores information about products available in the store
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each product
    product_name VARCHAR(255) NOT NULL, -- Name of the product
    description TEXT, -- Description of the product
    price DECIMAL(10, 2) NOT NULL, -- Price of the product
    category_id INT, -- Category ID to which the product belongs
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the product was added
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE -- Link to Categories table
);

-- Categories Table: Stores categories of products
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each category
    category_name VARCHAR(100) NOT NULL -- Name of the category
);

-- Orders Table: Stores information about orders placed by users
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order
    user_id INT, -- User ID who placed the order
    order_date DATE NOT NULL, -- Date when the order was placed
    total_amount DECIMAL(10, 2) NOT NULL, -- Total amount of the order
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the order was placed
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Link to Users table
);

-- OrderDetails Table: Stores details of products in each order
CREATE TABLE IF NOT EXISTS OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order detail
    order_id INT, -- Order ID to which the detail belongs
    product_id INT, -- Product ID purchased in the order
    quantity INT NOT NULL, -- Quantity of the product purchased
    unit_price DECIMAL(10, 2) NOT NULL, -- Unit price of the product at the time of purchase
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE, -- Link to Orders table
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE -- Link to Products table
);

-- Reviews Table: Stores reviews given by users for products
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each review
    product_id INT, -- Product ID for which the review is given
    user_id INT, -- User ID who gave the review
    rating INT NOT NULL, -- Rating given by the user (1-5 stars)
    comment TEXT, -- Optional comment by the user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the review was submitted
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE, -- Link to Products table
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Link to Users table
);

-- Stored Procedures

-- InsertProduct: Inserts a new product into the Products table
DELIMITER //
CREATE PROCEDURE InsertProduct(
    IN p_product_name VARCHAR(255), -- Input parameter: product name
    IN p_description TEXT, -- Input parameter: product description
    IN p_price DECIMAL(10, 2), -- Input parameter: product price
    IN p_category_id INT -- Input parameter: category ID of the product
)
BEGIN
    INSERT INTO Products (product_name, description, price, category_id)
    VALUES (p_product_name, p_description, p_price, p_category_id);
END //
DELIMITER ;

-- UpdateProduct: Updates an existing product in the Products table
DELIMITER //
CREATE PROCEDURE UpdateProduct(
    IN p_product_id INT, -- Input parameter: product ID to update
    IN p_product_name VARCHAR(255), -- Input parameter: new product name
    IN p_description TEXT, -- Input parameter: new product description
    IN p_price DECIMAL(10, 2), -- Input parameter: new product price
    IN p_category_id INT -- Input parameter: new category ID of the product
)
BEGIN
    UPDATE Products
    SET product_name = p_product_name,
        description = p_description,
        price = p_price,
        category_id = p_category_id
    WHERE product_id = p_product_id;
END //
DELIMITER ;

-- DeleteProduct: Deletes a product from the Products table
DELIMITER //
CREATE PROCEDURE DeleteProduct(
    IN p_product_id INT -- Input parameter: product ID to delete
)
BEGIN
    DELETE FROM Products WHERE product_id = p_product_id;
END //
DELIMITER ;

-- GetProductsByCategory: Retrieves products based on a given category
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(
    IN p_category_id INT -- Input parameter: category ID
)
BEGIN
    SELECT * FROM Products WHERE category_id = p_category_id;
END //
DELIMITER ;

-- PlaceOrder: Places a new order in the Orders table and updates OrderDetails table accordingly
DELIMITER //
CREATE PROCEDURE PlaceOrder(
    IN p_user_id INT, -- Input parameter: user ID placing the order
    IN p_order_date DATE, -- Input parameter: date of the order
    IN p_total_amount DECIMAL(10, 2), -- Input parameter: total amount of the order
    IN p_order_details JSON -- Input parameter: JSON array of order details [{product_id, quantity}]
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE product_id INT;
    DECLARE quantity INT;
    DECLARE cur CURSOR FOR SELECT product_id, quantity FROM JSON_TABLE(p_order_details, '$[*]' COLUMNS (product_id INT PATH '$.product_id', quantity INT PATH '$.quantity')) AS jt;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    INSERT INTO Orders (user_id, order_date, total_amount)
    VALUES (p_user_id, p_order_date, p_total_amount);
    
    SET @last_order_id = LAST_INSERT_ID();
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO product_id, quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price)
        VALUES (@last_order_id, product_id, quantity, (SELECT price FROM Products WHERE product_id = product_id));
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- GetOrderDetails: Retrieves details of a specific order
DELIMITER //
CREATE PROCEDURE GetOrderDetails(
    IN p_order_id INT -- Input parameter: order ID
)
BEGIN
    SELECT od.order_detail_id, p.product_name, od.quantity, od.unit_price
    FROM OrderDetails od
    JOIN Products p ON od.product_id = p.product_id
    WHERE od.order_id = p_order_id;
END //
DELIMITER ;

-- AddReview: Allows a user to add a review for a product
DELIMITER //
CREATE PROCEDURE AddReview(
    IN p_product_id INT, -- Input parameter: product ID for the review
    IN p_user_id INT, -- Input parameter: user ID who is adding the review
    IN p_rating INT, -- Input parameter: rating given by the user (1-5 stars)
    IN p_comment TEXT -- Input parameter: optional comment by the user
)
BEGIN
    INSERT INTO Reviews (product_id, user_id, rating, comment)
    VALUES (p_product_id, p_user_id, p_rating, p_comment);
END //
DELIMITER ;

-- Example Usage:

-- Insert a product
CALL InsertProduct('Smartphone', 'High-performance smartphone', 599.99, 1);

-- Update a product
CALL UpdateProduct(1, 'Smartphone Pro', 'Advanced model with enhanced features', 699.99, 1);

-- Delete a product
CALL DeleteProduct(1);

-- Get products by category
CALL GetProductsByCategory(1);

-- Place an order
CALL PlaceOrder(1, '2024-07-01', 799.99, '[{"product_id": 2, "quantity": 1}, {"product_id": 3, "quantity": 2}]');

-- Get order details
CALL GetOrderDetails(1);

-- Add a review
CALL AddReview(2, 1, 5, 'Great product, highly recommended!');

-- Procedures drop (optional after usage)
DROP PROCEDURE IF EXISTS InsertProduct, UpdateProduct, DeleteProduct, GetProductsByCategory,
                      PlaceOrder, GetOrderDetails, AddReview;








Explanation:

1. CREATE DATABASE IF NOT EXISTS EcommerceDB;
   - Database banata hai agar "EcommerceDB" naam ka database nahi bana hua hai.

2. USE EcommerceDB;
   - Use karta hai "EcommerceDB" database ko select karne ke liye.

3. CREATE TABLE IF NOT EXISTS Users (
   user_id INT AUTO_INCREMENT PRIMARY KEY,
   username VARCHAR(100) NOT NULL,
   email VARCHAR(255) NOT NULL,
   password VARCHAR(255) NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
   - "Users" table banata hai jismein har ek user ka information store hota hai:
     - user_id: Har ek user ka unique identifier.
     - username: User ka username.
     - email: User ka email address.
     - password: User ka password.
     - created_at: User account create hone ka timestamp.

4. AUTO_INCREMENT:
   - Har ek "user_id" ko automatically ek unique number assign karta hai jab naya user record insert hota hai.

5. PRIMARY KEY:
   - "user_id" ko define karta hai table ka primary key jo har ek row ko uniquely identify karta hai.

6. VARCHAR(100), VARCHAR(255):
   - "username" aur "email" fields ke liye varchar data type define karta hai jismein maximum 100 aur 255 characters store ho sakte hain.

7. DEFAULT CURRENT_TIMESTAMP:
   - "created_at" column ko current timestamp se populate karta hai jab naya user record create hota hai.

8. FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE:
   - "Products" table mein "category_id" column ko foreign key ke roop mein define karta hai jo "Categories" table ke "category_id" column ko refer karta hai.
   - "CASCADE" delete rule use hota hai jo yeh ensure karta hai ki agar ek category delete hoti hai, to us category se associated sabhi products bhi delete ho jayein.

9. PROCEDURE InsertProduct:
   - Stored procedure create karta hai jo ek naya product insert karta hai "Products" table mein.
   - Input parameters:
     - p_product_name: Product ka naam
     - p_description: Product ki description
     - p_price: Product ki price
     - p_category_id: Product ki category ID

10. JSON_TABLE(p_order_details, '$[*]' COLUMNS (product_id INT PATH '$.product_id', quantity INT PATH '$.quantity')):
    - JSON data ko parse karke "PlaceOrder" stored procedure mein use hota hai jo order details ko insert karta hai "OrderDetails" table mein.
    - "$[*]" JSON path jo sabhi elements ko select karta hai JSON array mein.
    - Columns specify karte hain jo JSON elements ko kaise parse karna hai.

11. DELIMITER //
    - Stored procedures define karne ke liye DELIMITER ka use hota hai jo default ";" ko change karta hai.
    - Stored procedure ke end tak "//" use hota hai.

12. CALL InsertProduct('Smartphone', 'High-performance smartphone', 599.99, 1);
    - InsertProduct stored procedure ko call karta hai jisse ek naya product "Products" table mein insert hota hai.

13. DROP PROCEDURE IF EXISTS InsertProduct;
    - "InsertProduct" stored procedure ko delete karta hai agar wo already exist karta hai, taki dubara define kiya ja sake.

14. TEXT data type:
    - "description" aur "comment" fields ke liye TEXT data type use hota hai jo large amount of text ko store karne ke liye suitable hota hai.

15. TIMESTAMP DEFAULT CURRENT_TIMESTAMP:
    - "created_at" columns ko automatic current timestamp se populate karta hai jab record insert hota hai.

16. VARCHAR(255):
    - "email" aur "password" fields ke liye VARCHAR data type define karta hai jismein maximum 255 characters store ho sakte hain.

17. DECIMAL(10, 2):
    - "price" aur "total_amount" fields ke liye DECIMAL data type use hota hai jo monetary values ko store karne ke liye suitable hota hai.
    - 10 total digits ko store karta hai jismein se 2 decimal places hote hain.

18. JSON data type:
    - "PlaceOrder" stored procedure mein "p_order_details" parameter ke liye JSON data type use hota hai jo order details ko dynamic structure mein represent karta hai.

19. CURSOR:
    - "PlaceOrder" stored procedure mein CURSOR ka use hota hai jo JSON data ko iterate karta hai aur order details ko insert karta hai "OrderDetails" table mein.

20. CURSOR FOR SELECT:
    - CURSOR ka use hota hai result set ko iterate karne ke liye jo SELECT query ke through retrieve hota hai.

21. FETCH cur INTO:
    - CURSOR se data fetch karne ke liye use hota hai jo loop mein iterate karte samay hota hai.

22. OPEN cur; ... CLOSE cur;
    - CURSOR ko open aur close karne ke liye use hota hai jo data retrieval process control karta hai.

23. READ_LOOP:
    - LOOP construct hota hai jo CURSOR ke through iterate karta hai jab tak data available hota hai.

24. CONTINUE HANDLER FOR NOT FOUND:
    - Exception handler hota hai jo loop mein iterate karte samay use hota hai jab CURSOR se data fetch nahi ho pata hai.

25. SET @last_order_id = LAST_INSERT_ID();
    - Variable ko set karta hai jo last insert operation ke during last inserted ID ko store karta hai.

26. LAST_INSERT_ID():
    - Last insert operation ke during auto-generated ID ko retrieve karta hai.

27. DROP PROCEDURE IF EXISTS:
    - Stored procedure ko delete karne ke liye use hota hai jo already exist karta hai.

28. JOIN:
    - Multiple tables ko combine karne ke liye use hota hai jo common columns ke basis par data retrieve karta hai.

29. ON DELETE CASCADE:
    - Foreign key constraint hota hai jo child table ke records ko automatically delete karta hai agar parent table ke records delete hote hain.

30. SELECT ... FROM JSON_TABLE ... AS jt;
    - JSON data ko table format mein convert karta hai jo stored procedure mein dynamic data ko parse karne ke liye use hota hai.

31. DROP PROCEDURE:
    - Stored procedure ko delete karta hai agar wo already exist karta hai.





