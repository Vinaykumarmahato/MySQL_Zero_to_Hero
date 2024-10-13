

### 🔑 Constraints (`primary_foreign_keys.sql`)

markdown
# 🔑 Constraints: PRIMARY & FOREIGN KEYS

## What is it?
- **PRIMARY KEY**: A unique identifier for each record in a table.
- **FOREIGN KEY**: A field in one table that links to the PRIMARY KEY in another table, creating a relationship between the two.

## Why is it important?
- Ensures **data integrity** by preventing duplicate records (PRIMARY KEY).
- Enforces **referential integrity** by linking related tables (FOREIGN KEY).

## Real-life Scenario
In an **e-commerce system**:
- The `customer_id` field in the `customers` table is a **PRIMARY KEY** (each customer has a unique ID).
- The `order_id` field in the `orders` table is linked to `customer_id` as a **FOREIGN KEY**, ensuring orders always belong to valid customers.

### Example Code
sql
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  order_date DATE,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
