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
SELECT o.*, c.first_name, c.last_name, c.email
FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id

-- 7. List all order items along with the product name and the customer who ordered them.
SELECT oi.quantity, oi.unit_price, c.first_name, p.product_name
FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id

-- 8. Find all products that have never been ordered.
SELECT * 
FROM Products p
WHERE p.product_id NOT IN (
    SELECT oi.product_id 
    FROM order_items oi
    ) -- doesn't appear that there are any

-- 9. Show all customers who have at least one cancelled order.
SELECT o.order_id, c.first_name, c.last_name, o.status
FROM orders o 
    JOIN customers c
        ON o.customer_id = c.customer_id
WHERE o.status = 'Cancelled'

-- 10. List each customer and how many total orders they’ve placed.
SELECT COUNT(o.order_id) AS order_count, c.first_name, c.last_name
FROM customers c
    JOIN orders o
        ON o.customer_id = c.customer_id
GROUP BY c.customer_id

-- =====================
-- LEVEL 3 — Aggregations & Grouping
-- =====================

-- 11. Calculate the total revenue (sum of quantity × unit_price) per product.
SELECT 
    p.product_name, 
    oi.unit_price*oi.quantity AS total_revenue, 
    oi.quantity
FROM order_items oi
    JOIN products p
        ON p.product_id = oi.product_id
GROUP BY oi.product_id, oi.product_id, p.product_name, oi.quantity, oi.unit_price

SELECT 
    p.product_name,
    SUM(oi.unit_price * oi.quantity) AS total_revenue,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p
    ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 12. Find the total amount spent by each customer across all their orders.
SELECT c.first_name, c.last_name, cus_spend.amount_spent
FROM (
    SELECT 
        o.customer_id,
        SUM(oi.unit_price * oi.quantity) AS amount_spent
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
    ) AS cus_spend
    JOIN customers c
        ON c.customer_id = cus_spend.customer_id

-- 13. Determine the average order value (total per order).
SELECT AVG(ov.order_total) AS average_order_value
FROM (
    SELECT SUM(o.unit_price*o.quantity) AS order_total, order_id
    FROM order_items o
    GROUP BY o.order_id
    ) AS ov

-- 14. Find the top 3 products by total sales revenue.
-- first look for quantity * unit price group by product_id
-- order by asc
-- limit 3
SELECT 
    p.product_name, 
    p.price,
    ag.total_sales_revenue,
    ag.total_products_sold
FROM (
    SELECT 
        SUM(oi.quantity*oi.unit_price) AS total_sales_revenue,
        oi.product_id,
        SUM(oi.quantity) total_products_sold
    FROM order_items oi
    GROUP BY oi.product_id
    ORDER BY total_sales_revenue DESC
    LIMIT 3
    ) AS ag
    JOIN products p
        ON p.product_id = ag.product_id
ORDER BY ag.total_sales_revenue DESC


-- 15. For each country, calculate the total number of delivered orders and total revenue.
-- calc delivered orders = status = "Delivered"
-- total revenue = quantity * unit_price group by order_id
-- group by shipping_country for each country

SELECT 
    o.shipping_country,
    COUNT(DISTINCT(oi.order_id)) AS country_delivered_orders, -- missed the distinct initially
    SUM(oi.quantity*oi.unit_price) AS total_revenue
FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY shipping_country

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
