

# 🌐 JSON Data Handling

## What is it?
**JSON data handling** in MySQL allows you to store and manipulate JSON data natively, using JSON data types and functions.

## Why is it important?
- JSON handling simplifies the storage of semi-structured data, making it easy to work with in modern applications.
- It provides flexibility in database design, allowing for dynamic data structures.

## Real-life Scenario
In a **social media application**, user preferences may vary widely. Storing user preferences as JSON data allows for flexible storage and easy retrieval without needing to alter the database schema frequently.


### Example Code
```sql
-- Create a table with a JSON column
CREATE TABLE user_preferences (
  user_id INT PRIMARY KEY,
  preferences JSON
);

-- Insert JSON data
INSERT INTO user_preferences (user_id, preferences)
VALUES (1, '{"theme": "dark", "notifications": true}');

-- Query JSON data
SELECT preferences->>'$.theme' AS theme FROM user_preferences WHERE user_id = 1;
