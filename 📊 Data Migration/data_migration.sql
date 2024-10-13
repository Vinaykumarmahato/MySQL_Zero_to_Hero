-- 📊 Data Migration in MySQL
-- Author: [Your Name]
-- Date: [Date]
-- Description: This script explains how to perform data migration in MySQL. It covers the process of moving data 
-- from a source database to a target database, including the necessary commands and steps.

-- ====================================
-- 🚀 Introduction
-- ====================================
-- Data migration is the process of moving data between databases, often required for database upgrades, system
-- consolidation, cloud migration, or data reorganization. 
-- The main steps in data migration are: 
-- 1. Backup the source data.
-- 2. Prepare the target database.
-- 3. Export data from the source database.
-- 4. Import data into the target database.
-- 5. Verify data integrity.
-- 6. Optimize the target database.

-- ====================================
-- Step 1: Backup the Source Database
-- ====================================
-- Before starting the migration, it's critical to take a full backup of the source database. This ensures that no 
-- data is lost in case of an error during the migration process.

-- MySQL command to create a backup of the source database (this is not SQL code but a shell command):
-- mysqldump -u username -p source_db > source_db_backup.sql

-- ====================================
-- Step 2: Prepare the Target Database
-- ====================================
-- First, create the target database and necessary tables where the data will be migrated.

-- Creating the target database
CREATE DATABASE IF NOT EXISTS target_db;

-- Switch to the target database
USE target_db;

-- Creating the customers table in the target database
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    registration_date DATE
);

-- Creating the orders table in the target database
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Explanation:
-- The `customers` and `orders` tables have been created in the target database, with a foreign key relationship between them.
-- This structure mirrors the source database, allowing for the smooth migration of data.

-- ====================================
-- Step 3: Export Data from the Source Database
-- ====================================
-- The next step is to export data from the source database. You can use MySQL Workbench or the `mysqldump` command to export the data.

-- Example command to export data (not SQL, but a command line instruction):
-- mysqldump -u username -p source_db customers orders > data_export.sql

-- This exports the `customers` and `orders` tables from the source database to a file named `data_export.sql`.

-- ====================================
-- Step 4: Import Data into the Target Database
-- ====================================
-- Once the data has been exported, you can import it into the target database using the following MySQL command:

-- Example command to import the exported data into the target database (not SQL):
-- mysql -u username -p target_db < data_export.sql

-- Alternatively, you can use MySQL Workbench or another GUI tool to import the `data_export.sql` file directly into the target database.

-- ====================================
-- Step 5: Verify Data Integrity
-- ====================================
-- After importing the data, verify that the migration was successful by querying the target database.

-- Querying the customers table to check data integrity
SELECT * FROM customers;

-- Querying the orders table to check data integrity
SELECT * FROM orders;

-- Explanation:
-- After the migration, it is important to verify that all the data has been correctly transferred from the source
-- to the target database. Check for the consistency of the data by comparing the row counts and key values between
-- the source and target tables.

-- ====================================
-- Step 6: Optimize the Target Database
-- ====================================
-- After migrating the data, it's good practice to optimize the target database by analyzing tables and rebuilding indexes.

-- Analyze and rebuild indexes for the customers table
ANALYZE TABLE customers;

-- Analyze and rebuild indexes for the orders table
ANALYZE TABLE orders;

-- Optional: Optimize the tables to defragment and improve performance
OPTIMIZE TABLE customers;
OPTIMIZE TABLE orders;

-- Explanation:
-- Optimizing the target database helps ensure that indexes are rebuilt, and performance is improved, especially
-- after importing large volumes of data.

-- ====================================
-- Handling Large-Scale Data Migrations (Optional)
-- ====================================
-- For very large tables, migrating data in smaller chunks can help prevent performance issues. This technique is known
-- as "chunking."

-- Example of migrating data in chunks using LIMIT and OFFSET
-- Insert the first 1000 rows into the target database
INSERT INTO target_db.customers
SELECT * FROM source_db.customers LIMIT 1000 OFFSET 0;

-- Explanation:
-- By migrating data in smaller chunks using `LIMIT` and `OFFSET`, you can reduce the load on the database and avoid 
-- potential downtime during the migration process. Increase the offset incrementally (e.g., 1000, 2000, etc.) until all 
-- data has been migrated.

-- ====================================
-- Best Practices for Data Migration
-- ====================================
-- 1. **Backup**: Always back up the source data before starting the migration.
-- 2. **Test**: Test the migration process with a small dataset first.
-- 3. **Downtime Planning**: If dealing with a large dataset, plan for downtime or perform the migration during off-peak hours.
-- 4. **Data Validation**: Validate the data after migration by comparing the row counts and data values between the source and target databases.
-- 5. **Rollback Strategy**: Have a rollback plan in place in case something goes wrong during the migration.

-- ====================================
-- 🚀 Conclusion
-- ====================================
-- Data migration is a crucial process for upgrading databases, moving to the cloud, or consolidating systems. 
-- By following a well-defined process, including backing up, preparing the target database, exporting, importing, 
-- verifying, and optimizing, you can ensure a successful data migration. Additionally, chunking large datasets 
-- and validating the results will help prevent issues during the migration.

-- End of script.
