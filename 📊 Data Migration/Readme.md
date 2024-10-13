



# 📊 Data Migration

## What is it?
**Data migration** is the process of transferring data between storage types, formats, or systems, often used during upgrades or system changes.

## Why is it important?
- Proper data migration ensures that your data is preserved, consistent, and accurately transferred to a new environment.
- It allows organizations to upgrade systems or consolidate data into a centralized location.

## Real-life Scenario
In a **company merging**, when two organizations combine databases, data migration ensures that all customer information is seamlessly integrated into a single system without data loss.

### Example Code
-- Data migration example from old_table to new_table

-- Step 1: Create the new table
CREATE TABLE new_table (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

-- Step 2: Migrate data
INSERT INTO new_table (id, name, email)
SELECT id, name, email FROM old_table;

-- Step 3: Verify the data migration
SELECT COUNT(*) FROM new_table;
