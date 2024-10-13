-- 🔄 MySQL Replication
-- Author: [Your Name]
-- Date: [Date]
-- Description: This script demonstrates how to set up and manage MySQL replication, including master-slave configuration.

-- ====================================
-- 📘 Introduction
-- ====================================
-- MySQL Replication is a process in which data from one MySQL server (the master) is copied to one or more MySQL servers (the slaves).
-- This allows for data redundancy, load balancing, and improved availability.

-- Key Points:
-- 1. There are different replication types: Statement-based, Row-based, and Mixed.
-- 2. Replication can be synchronous or asynchronous.
-- 3. You can configure replication for high availability, load balancing, or backup purposes.

-- ====================================
-- Step 1: Setting Up the Master Server
-- ====================================
-- On the master server, perform the following steps to configure it for replication.

-- 1. Edit the MySQL configuration file (my.cnf or my.ini) and add the following lines:
-- Note: This configuration should be done on the master server.

-- Enable binary logging (for replication)
-- [mysqld]
-- log-bin=mysql-bin
-- server-id=1
-- binlog-do-db=mydatabase  -- Optional: Specify the database to replicate
-- expire_logs_days=7        -- Optional: Automatically remove binary logs older than 7 days

-- 2. Restart the MySQL server to apply the changes.
-- You can restart the MySQL server using the following command (Linux):
-- sudo systemctl restart mysql

-- 3. Create a replication user on the master server.
-- The user must have the REPLICATION SLAVE privilege.

CREATE USER 'replicator'@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';

-- Explanation:
-- - We create a user `replicator` with a password, granting it the necessary permissions for replication.

-- 4. Obtain the binary log file name and position to be used for replication.
-- Use the following command to get the binary log file name and position:
SHOW MASTER STATUS;

-- This command will output the current binary log file and position.

-- ====================================
-- Step 2: Setting Up the Slave Server
-- ====================================
-- On the slave server, perform the following steps to configure it for replication.

-- 1. Edit the MySQL configuration file (my.cnf or my.ini) and add the following lines:
-- Note: This configuration should be done on the slave server.

-- Enable server ID
-- [mysqld]
-- server-id=2

-- 2. Restart the MySQL server on the slave to apply the changes.
-- sudo systemctl restart mysql

-- 3. Configure the slave to connect to the master server.
-- Replace 'master_host' with the IP or hostname of the master server, and 'log_file' and 'log_pos' with the values obtained from SHOW MASTER STATUS.

CHANGE MASTER TO
    MASTER_HOST='master_host',
    MASTER_USER='replicator',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',  -- Example binary log file
    MASTER_LOG_POS=154;                  -- Example position

-- Explanation:
-- - The `CHANGE MASTER TO` command specifies the connection details to the master server, including the replication user and the binary log file/position.

-- 4. Start the replication process on the slave server.
START SLAVE;

-- 5. Check the replication status on the slave to verify that it is working.
SHOW SLAVE STATUS\G;

-- Explanation:
-- - This command displays detailed information about the replication status, including whether it is running, the master’s log file, and any errors.

-- ====================================
-- Step 3: Testing Replication
-- ====================================
-- 1. Create a test database on the master server.
CREATE DATABASE mydatabase;

-- 2. Create a test table in the master database.
USE mydatabase;

CREATE TABLE test_table (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- 3. Insert some data into the test table on the master server.
INSERT INTO test_table (name) VALUES ('Test Entry 1'), ('Test Entry 2');

-- 4. Check the data on the slave server.
-- You should see the same entries replicated from the master.

USE mydatabase;
SELECT * FROM test_table;

-- Explanation:
-- - If replication is configured correctly, the slave server will have the same data as the master server.

-- ====================================
-- Step 4: Managing Replication
-- ====================================
-- You can manage replication using the following commands.

-- 1. Stop the slave if needed.
STOP SLAVE;

-- 2. Start the slave again.
START SLAVE;

-- 3. To change the master, you can use the CHANGE MASTER TO command again with new details.

-- 4. If there are issues, you can troubleshoot replication by checking the error logs on both master and slave servers.

-- ====================================
-- 🚀 Conclusion
-- ====================================
-- MySQL replication is a powerful feature that allows you to enhance the availability and scalability of your database systems.
-- With a master-slave configuration, you can achieve data redundancy, load balancing, and improved performance.
-- Understanding how to configure and manage replication is essential for maintaining a robust MySQL environment.

-- End of script.
