-- 1. Select all customers with their first name, last name, email, and signup date.
SELECT first_name, last_name, email, signup_date
FROM customers

-- 2. Select all products where stock_quantity <= 50.
SELECT *
FROM products
WHERE stock_quantity <= 50

-- 3. Select all orders placed in June 2023.
SELECT *
FROM orders
WHERE EXTRACT(MONTH FROM order_date) = 6
    AND EXTRACT(YEAR FROM order_date) = 2023

-- 4. Select all customers who live in the USA.
SELECT *
FROM customers
WHERE country = 'USA'

-- 5. Select each customer and the total number of orders they have placed.
SELECT 
    COUNT(order_id) AS total_orders,
    c.customer_id
FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
GROUP BY c.customer_id

-- 6. Calculate the total revenue from all order items (quantity * unit_price).
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items


-- 7. Select each order with the total number of items in the order.
SELECT 
    o.order_id,
    SUM(oi.quantity) AS total_items
FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
GROUP BY o.order_id



-- 8. Select all products that have never been ordered.
SELECT p.*
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL


-- 9. Select the top 5 customers by total order value.
SELECT 
    c.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_order_value DESC
LIMIT 5;

-- 10. Select all pending orders and include customer name and email.
SELECT ...

-- 11. Select average unit price grouped by product category.
SELECT ...

-- 12. Select the most frequently ordered product by total quantity ordered.
SELECT ...

-- 13. Select all customers who have placed more than 3 orders.
SELECT ...

-- 14. Select all orders where shipping country differs from the customer's country.
SELECT ...

-- 15. Select each customer and their most recent order date.
SELECT ...

-- 16. Select total revenue per product ordered from highest to lowest.
SELECT ...

-- 17. Select customers who signed up in 2023 and have placed at least one order.
SELECT ...

-- 18. Select the order with the highest total value.
SELECT ...

-- 19. Select all products and show remaining stock after subtracting ordered quantities.
SELECT ...

-- 20. Select, for each category, how many unique customers bought a product in that category.
SELECT ...
