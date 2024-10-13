# 📈 Indexes (`indexes_example.sql`)

## What is it?
An **index** is a data structure that improves the speed of data retrieval operations on a database table by providing quick lookups for specific columns.

## Why is it important?
Indexes are crucial because:
- They **speed up query performance**, especially for large datasets.
- Without an index, the database must scan the entire table to find the requested data, which can be slow.

## Real-life Scenario
In a **library system**, when searching for a book by its title, having an index on the `title` column allows the database to retrieve the book’s information quickly instead of scanning the entire books table.

## Project: Library Management System
In this project, we will implement indexes to enhance the performance of our library management system. By indexing important columns, we can ensure fast data retrieval, improving the overall user experience.

### Example Code
```sql
-- Creating an index on the title column
CREATE INDEX idx_book_title ON books(title);

-- Query that uses the index
SELECT * FROM books WHERE title = 'SQL Mastery';
