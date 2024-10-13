-- 📜 Error Handling in MySQL
-- Author: Vinay Kumar
-- Description: This script demonstrates error handling techniques in MySQL, including using error codes and implementing handlers.

-- ====================================
-- 📘 Introduction
-- ====================================
-- Error handling in MySQL allows you to manage and respond to errors that may occur during database operations.
-- This is essential for maintaining the integrity of your application and ensuring smooth user experiences.

-- Key Points:
-- 1. Understanding error codes and messages.
-- 2. Using DECLARE ... HANDLER to define error handlers.
-- 3. Implementing error handling in stored procedures.

-- ====================================
-- Step 1: Understanding Error Codes
-- ====================================
-- MySQL provides a set of error codes that represent specific types of errors.
-- You can check the error code and message using the following SQL:

-- Example of intentionally causing an error
DROP TABLE IF EXISTS example_table;

-- Attempt to select from a non-existent table to generate an error
SELECT * FROM example_table;

-- The above query will generate an error, which we can handle using a handler.

-- ====================================
-- Step 2: Using DECLARE ... HANDLER
-- ====================================
-- You can declare handlers for various conditions, such as SQLSTATE or error codes.

-- Create a procedure to demonstrate error handling
DROP PROCEDURE IF EXISTS error_handling_example;

DELIMITER $$

CREATE PROCEDURE error_handling_example()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        SELECT 'An error occurred during execution.' AS error_message;
    END;

    -- Attempt to create a table
    CREATE TABLE test_table (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100)
    );

    -- Intentionally cause an error by trying to create the same table again
    CREATE TABLE test_table (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100)
    );

    -- If an error occurs, the handler will execute
    SELECT 'Procedure executed successfully.' AS success_message;
END $$

DELIMITER ;

-- Explanation:
-- - The `DECLARE CONTINUE HANDLER FOR SQLEXCEPTION` statement defines a handler that will execute when an SQL error occurs.
-- - The first `CREATE TABLE` statement will succeed, while the second will fail, triggering the handler.

-- ====================================
-- Step 3: Calling the Procedure
-- ====================================
-- Call the procedure to see how error handling works

CALL error_handling_example();

-- Explanation:
-- - You should see the success message first, followed by the error message due to the second `CREATE TABLE` statement.

-- ====================================
-- Step 4: Using EXIT Handlers
-- ====================================
-- Instead of continuing, you can exit the block when an error occurs.

DROP PROCEDURE IF EXISTS error_handling_exit_example;

DELIMITER $$

CREATE PROCEDURE error_handling_exit_example()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error and exit
        SELECT 'An error occurred, exiting the procedure.' AS error_message;
    END;

    -- Attempt to create a table
    CREATE TABLE another_test_table (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100)
    );

    -- Intentionally cause an error by trying to create the same table again
    CREATE TABLE another_test_table (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100)
    );

    -- This line will not execute due to the EXIT handler
    SELECT 'This message will not be shown.' AS success_message;
END $$

DELIMITER ;

-- Call the procedure to test the EXIT handler
CALL error_handling_exit_example();

-- Explanation:
-- - The EXIT handler will terminate the procedure execution upon an error, preventing any further statements from being executed.

-- ====================================
-- 🚀 Conclusion
-- ====================================
-- Error handling in MySQL is essential for robust application development.
-- Using handlers, you can gracefully manage errors and ensure that your application behaves predictably in the face of unexpected issues.
-- Familiarity with error codes, the DECLARE ... HANDLER statement, and different types of handlers (CONTINUE vs. EXIT) will enhance your error management strategy.

-- End of script.
