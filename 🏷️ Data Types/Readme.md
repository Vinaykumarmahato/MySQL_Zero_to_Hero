

### 🏷️ Data Types (`data_types_examples.sql`)

markdown
# 🏷️ Data Types

## What is it?
**Data Types** define the kind of data a column can hold in a MySQL database, such as:
- `INT`: Used for whole numbers.
- `VARCHAR`: Used for variable-length strings.
- `DATE`: Used to store dates.

## Why is it important?
Choosing the correct data type:
- Ensures **data accuracy** and **integrity**.
- Optimizes **storage** and **query performance**.

## Real-life Scenario
In a **customer database**, storing a customer's **age** as an `INT` and their **email address** as a `VARCHAR` makes sure:
- You can perform operations like calculations on age.
- You store variable-length text efficiently for email addresses.

### Example Code
sql
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  email VARCHAR(100),
  registration_date DATE
);
