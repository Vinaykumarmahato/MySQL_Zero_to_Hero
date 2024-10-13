# 📅 Transactions (`transactions_example.sql`)

## What is it?
A **transaction** is a sequence of one or more SQL operations treated as a single unit of work, ensuring that either all operations succeed, or none do (atomicity).

## Why is it important?
- Transactions ensure **data integrity** in multi-step operations.
- They allow rollback in case of failure, ensuring the database remains consistent.

## Real-life Scenario
In a **banking system**, when transferring money from one account to another, the withdrawal and deposit operations must either both succeed or both fail. A transaction guarantees this behavior.

## Project: Banking System
In this project, we will implement transactions to ensure secure and reliable operations in our banking system. This will prevent data inconsistency during operations like fund transfers.

### Example Code
```sql
-- Begin a transaction
START TRANSACTION;

-- Deduct money from account A
UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

-- Add money to account B
UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;

-- Commit the transaction
COMMIT;

-- In case of any error, rollback the transaction
ROLLBACK;
