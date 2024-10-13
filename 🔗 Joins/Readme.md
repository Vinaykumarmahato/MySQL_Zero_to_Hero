


### 🔗 Joins (`inner_outer_joins.sql`)

markdown
# 🔗 Joins: INNER & OUTER

## What is it?
- **INNER JOIN**: Returns records that have matching values in both tables.
- **OUTER JOIN**: Returns all records from one table, and the matched records from another. If no match is found, NULL values are returned.

## Why is it important?
Joins are crucial for:
- **Combining data** from multiple tables.
- Performing complex queries to retrieve relevant, associated data efficiently.

## Real-life Scenario
In a **social media app**:
- An `INNER JOIN` could combine users and posts to display only the posts from users with matching profiles.
- An `OUTER JOIN` might show users and their posts, even if some users have not made any posts (by returning NULL for missing posts).

### Example Code
sql
-- INNER JOIN: Get users with posts
SELECT users.username, posts.content
FROM users
INNER JOIN posts ON users.user_id = posts.user_id;

-- LEFT OUTER JOIN: Get all users and their posts, even if some users have no posts
SELECT users.username, posts.content
FROM users
LEFT JOIN posts ON users.user_id = posts.user_id;
