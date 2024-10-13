

# 🔄 Replication

## What is it?
**Replication** in MySQL is the process of copying data from one database server (the master) to another (the slave) to ensure redundancy and availability.

## Why is it important?
- Replication enhances **data availability** and **load balancing**.
- It provides a backup solution and ensures that data is preserved in case of server failures.

## Real-life Scenario
In a **global application**, where users are spread across different regions, replication allows for local read operations, minimizing latency and improving performance.

### Example Code
```sql
-- Configuring a simple master-slave replication setup

-- On the master server
SHOW MASTER STATUS; -- Get the current log file and position
-- Use the log file and position in slave configuration

-- On the slave server
CHANGE MASTER TO
  MASTER_HOST='master_ip',
  MASTER_USER='replication_user',
  MASTER_PASSWORD='replication_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=154;

START SLAVE; -- Start the replication
