# 📊 Aggregation: GROUP BY & HAVING (`group_by_having.sql`)

## What is it?
- **GROUP BY**: Groups rows sharing a property so aggregate functions (like `COUNT`, `SUM`) can be applied.
- **HAVING**: Filters the results after `GROUP BY` based on aggregate conditions.

## Why is it important?
Aggregation allows:
- **Summarization** of data, making it easier to analyze trends.
- Filtering based on **grouped results**.

## Real-life Scenario
A **sales team** might use `GROUP BY` to group sales by region and use `SUM` to calculate the total sales per region. The `HAVING` clause could then be used to display only regions where total sales exceed a target.

## Project: Sales Analysis
In this project, we will utilize aggregation to analyze sales data, helping the sales team identify high-performing regions and make data-driven decisions.

### Example Code
```sql
-- Total sales by region
SELECT region, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(sales_amount) > 5000;
