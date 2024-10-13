# 🌟 Basics: SELECT, INSERT, UPDATE

## What is it?
This file covers the **basic SQL operations** which include:
- **SELECT**: Retrieving data from one or more tables.
- **INSERT**: Inserting new records into a table.
- **UPDATE**: Modifying existing records in a table.

## Why is it important?
These are the core commands for interacting with a database:
- **SELECT** allows users to fetch relevant data.
- **INSERT** lets users add new entries to a database.
- **UPDATE** modifies existing data to ensure records stay current.

## Real-life Scenario
Imagine you're managing an **online bookstore**:
- You use `SELECT` to retrieve the list of all books.
- You add new books to the inventory with `INSERT`.
- You modify the price of a book when it goes on sale with `UPDATE`.

### Example Code
```sql
-- SELECT: Get all books
SELECT * FROM books;

-- INSERT: Add a new book
INSERT INTO books (title, author, price)
VALUES ('SQL Mastery', 'John Doe', 25.99);

-- UPDATE: Update the price of a book
UPDATE books
SET price = 19.99
WHERE title = 'SQL Mastery';
