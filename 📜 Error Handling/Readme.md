
# 🛡️ Error Handling

## What is it?
**Error handling** in SQL refers to the techniques used to manage and respond to errors that occur during database operations.

## Why is it important?
- Proper error handling prevents application crashes and ensures smooth operation.
- It allows developers to provide meaningful feedback to users and maintain data integrity.

## Real-life Scenario
In an **online shopping application**, if a payment fails, effective error handling ensures that the user receives a clear message and can attempt the transaction again without losing their cart items.

### Example Code
```sql
-- Example of error handling in a stored procedure
DELIMITER //
CREATE PROCEDURE SafeInsert()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    -- Handle the error (e.g., log it, notify the user)
    INSERT INTO error_log(message) VALUES ('Insert failed');
  END;

  -- Attempt to insert data
  INSERT INTO orders (order_id, customer_id) VALUES (1, 1);
END //
DELIMITER ;

-- Call the stored procedure
CALL SafeInsert();
