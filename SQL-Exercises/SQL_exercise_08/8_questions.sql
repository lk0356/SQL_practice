-- ============================================================
-- SQL Practice Queries
-- ============================================================

-- =====================
-- LEVEL 1 — Basic SELECTs & Filters
-- =====================

-- 1. List all customers who live in the USA.
SELECT * 
FROM Customers
WHERE Country = 'USA'

-- 2. Show all products in the “Electronics” category that cost more than $50.
SELECT * 
FROM Products
WHERE Category = 'Electronics' AND Price > 50
-- 3. Retrieve all orders placed by customer “Alice Johnson.”
SELECT *
FROM Orders o
WHERE o.customer_id IN (
    SELECT c.customer_id
    FROM customers c
    WHERE CONCAT(c.first_name, ' ',c.last_name) LIKE 'Alice Johnson'
)

-- 4. Find all orders that have the status “Delivered.”
SELECT * 
FROM Orders o
WHERE o.status = 'Delivered'

-- 5. Display each product’s name and price, ordered from most expensive to cheapest.
SELECT p.product_name, p.Price
FROM Products p
ORDER BY p.Price DESC

-- =====================
-- LEVEL 2 — Joins & Relationships
-- =====================

-- 6. Show each order along with the customer’s full name and email.
-- 7. List all order items along with the product name and the customer who ordered them.
-- 8. Find all products that have never been ordered.
-- 9. Show all customers who have at least one cancelled order.
-- 10. List each customer and how many total orders they’ve placed.

-- =====================
-- LEVEL 3 — Aggregations & Grouping
-- =====================

-- 11. Calculate the total revenue (sum of quantity × unit_price) per product.
-- 12. Find the total amount spent by each customer across all their orders.
-- 13. Determine the average order value (total per order).
-- 14. Find the top 3 products by total sales revenue.
-- 15. For each country, calculate the total number of delivered orders and total revenue.

-- =====================
-- LEVEL 4 — Subqueries & CTEs
-- =====================

-- 16. Find all customers whose total spend is above the average customer spend.
-- 17. Show the most recent order for each customer (using a subquery or DISTINCT ON).
-- 18. List customers who have ordered more than one distinct product category.
-- 19. Find all customers who have never placed an order.
-- 20. Using a CTE, calculate each customer’s total spend and average order value.

-- =====================
-- LEVEL 5 — Analytical & Window Functions
-- =====================

-- 21. Rank customers by total revenue, from highest to lowest.
-- 22. Within each country, rank customers by their total revenue.
-- 23. Compute a running total of revenue over time (by order_date).
-- 24. For each product, show its revenue and the percent of total company revenue it represents.
-- 25. For each customer, list each order along with their average order value and difference from that average.

-- =====================
-- BONUS / Challenge
-- =====================

-- 26. Find the month-over-month growth in total sales revenue.
-- 27. Identify the most popular product category per country.
-- 28. Determine the first and last purchase date for each customer.
-- 29. Show customers who spent more this year than last year (if you add 2024+ data later).
-- 30. Generate a leaderboard showing each customer, their number of orders, total revenue, and average order value — ordered by total revenue descending.
