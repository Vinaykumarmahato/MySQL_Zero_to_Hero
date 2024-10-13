-- Creating two tables: accounts and transactions
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10, 2)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_amount DECIMAL(10, 2),
    transaction_type VARCHAR(10),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Inserting data into accounts table
INSERT INTO accounts (account_holder, balance)
VALUES ('Alice', 5000.00),
       ('Bob', 3000.00);

-- Starting a transaction to transfer money between accounts
START TRANSACTION;

-- Deducting 1000 from Alice's account
UPDATE accounts
SET balance = balance - 1000
WHERE account_holder = 'Alice';

-- Adding 1000 to Bob's account
UPDATE accounts
SET balance = balance + 1000
WHERE account_holder = 'Bob';

-- Committing the transaction (making changes permanent)
COMMIT;

-- Verifying the balances after the transaction
SELECT * FROM accounts;

-- Starting another transaction, but rolling it back
START TRANSACTION;

-- Deducting 2000 from Alice's account
UPDATE accounts
SET balance = balance - 2000
WHERE account_holder = 'Alice';

-- Adding 2000 to Bob's account
UPDATE accounts
SET balance = balance + 2000
WHERE account_holder = 'Bob';

-- Rolling back the transaction (undoing changes)
ROLLBACK;

-- Verifying that the rollback was successful
SELECT * FROM accounts;
