# ⏰ Triggers (`creating_triggers.sql`)

## What is it?
A **trigger** is an SQL command that automatically executes when a specified event occurs on a table, such as `INSERT`, `UPDATE`, or `DELETE`.

## Why is it important?
- Triggers automate tasks like logging, auditing, or validation.
- They help maintain **data integrity** by ensuring actions are automatically taken when data changes.

## Real-life Scenario
In an **e-commerce system**, you can create a trigger that automatically updates a product’s `last_updated` timestamp whenever its price or stock changes.

## Project: E-commerce Inventory Management
In this project, we will implement triggers to enhance the functionality of our e-commerce inventory management system. The trigger will ensure that any changes to product details are recorded automatically.

### Example Code
```sql
-- Create a trigger to update the last_updated timestamp
DELIMITER //
CREATE TRIGGER update_last_modified
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  SET NEW.last_updated = NOW();
END //
DELIMITER ;
