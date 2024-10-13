-- Create database if not exists
CREATE DATABASE IF NOT EXISTS ExpenseTrackerDB;

-- Use the database
USE ExpenseTrackerDB;

-- Categories Table
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each category
    category_name VARCHAR(100) NOT NULL, -- Category name
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the category was created
);

-- Expenses Table
CREATE TABLE IF NOT EXISTS Expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each expense
    amount DECIMAL(10, 2) NOT NULL, -- Amount spent
    description TEXT, -- Description of the expense
    category_id INT, -- Category to which the expense belongs
    expense_date DATE NOT NULL, -- Date of the expense
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the expense was recorded
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE -- Linking expenses to categories
);

-- Procedures for CRUD operations

-- Procedure to insert category
DELIMITER //

CREATE PROCEDURE InsertCategory(
    IN p_name VARCHAR(100) -- Input parameter: category name
)
BEGIN
    INSERT INTO Categories (category_name)
    VALUES (p_name);
END //

DELIMITER ;

-- Procedure to select category by id
DELIMITER //

CREATE PROCEDURE SelectCategoryById(
    IN p_category_id INT -- Input parameter: category id
)
BEGIN
    SELECT * FROM Categories WHERE category_id = p_category_id;
END //

DELIMITER ;

-- Procedure to update category
DELIMITER //

CREATE PROCEDURE UpdateCategory(
    IN p_category_id INT, -- Input parameter: category id to update
    IN p_name VARCHAR(100) -- Input parameter: new category name
)
BEGIN
    UPDATE Categories
    SET category_name = p_name
    WHERE category_id = p_category_id;
END //

DELIMITER ;

-- Procedure to delete category
DELIMITER //

CREATE PROCEDURE DeleteCategory(
    IN p_category_id INT -- Input parameter: category id to delete
)
BEGIN
    DELETE FROM Categories WHERE category_id = p_category_id;
END //

DELIMITER ;

-- Procedure to insert expense
DELIMITER //

CREATE PROCEDURE InsertExpense(
    IN p_amount DECIMAL(10, 2), -- Input parameter: amount spent
    IN p_description TEXT, -- Input parameter: description of the expense
    IN p_category_id INT, -- Input parameter: category id for the expense
    IN p_expense_date DATE -- Input parameter: date of the expense
)
BEGIN
    INSERT INTO Expenses (amount, description, category_id, expense_date)
    VALUES (p_amount, p_description, p_category_id, p_expense_date);
END //

DELIMITER ;

-- Procedure to select expense by id
DELIMITER //

CREATE PROCEDURE SelectExpenseById(
    IN p_expense_id INT -- Input parameter: expense id
)
BEGIN
    SELECT * FROM Expenses WHERE expense_id = p_expense_id;
END //

DELIMITER ;

-- Procedure to update expense
DELIMITER //

CREATE PROCEDURE UpdateExpense(
    IN p_expense_id INT, -- Input parameter: expense id to update
    IN p_amount DECIMAL(10, 2), -- Input parameter: new amount spent
    IN p_description TEXT, -- Input parameter: new description of the expense
    IN p_category_id INT, -- Input parameter: new category id for the expense
    IN p_expense_date DATE -- Input parameter: new date of the expense
)
BEGIN
    UPDATE Expenses
    SET amount = p_amount,
        description = p_description,
        category_id = p_category_id,
        expense_date = p_expense_date
    WHERE expense_id = p_expense_id;
END //

DELIMITER ;

-- Procedure to delete expense
DELIMITER //

CREATE PROCEDURE DeleteExpense(
    IN p_expense_id INT -- Input parameter: expense id to delete
)
BEGIN
    DELETE FROM Expenses WHERE expense_id = p_expense_id;
END //

DELIMITER ;

-- Example of usage:
-- Insert a category
CALL InsertCategory('Food');

-- Select a category by id
CALL SelectCategoryById(1);

-- Update a category
CALL UpdateCategory(1, 'Groceries');

-- Delete a category
CALL DeleteCategory(1);

-- Insert an expense
CALL InsertExpense(50.00, 'Groceries for the week', 1, '2024-06-28');

-- Select an expense by id
CALL SelectExpenseById(1);

-- Update an expense
CALL UpdateExpense(1, 55.00, 'Groceries for the month', 1, '2024-06-30');

-- Delete an expense
CALL DeleteExpense(1);

-- Procedures drop (optional after usage)
DROP PROCEDURE IF EXISTS InsertCategory, SelectCategoryById, UpdateCategory, DeleteCategory,
                      InsertExpense, SelectExpenseById, UpdateExpense, DeleteExpense;

