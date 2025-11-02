-- Drop tables if they already exist (so you can rerun the script cleanly)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE DEFAULT CURRENT_DATE
);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    shipping_city VARCHAR(50),
    shipping_country VARCHAR(50)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL
);

-- ============================================================
-- CUSTOMERS
-- ============================================================
INSERT INTO customers (first_name, last_name, email, phone, city, country, signup_date) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '555-1234', 'New York', 'USA', '2023-01-15'),
('Bob', 'Smith', 'bob.smith@example.com', '555-2345', 'Los Angeles', 'USA', '2023-02-10'),
('Charlie', 'Nguyen', 'charlie.nguyen@example.com', '555-3456', 'Toronto', 'Canada', '2023-03-05'),
('Diana', 'Lee', 'diana.lee@example.com', '555-4567', 'London', 'UK', '2023-04-20'),
('Ethan', 'Martinez', 'ethan.martinez@example.com', '555-5678', 'Sydney', 'Australia', '2023-05-11');

-- ============================================================
-- PRODUCTS
-- ============================================================
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Wireless Mouse', 'Electronics', 25.99, 200),
('Mechanical Keyboard', 'Electronics', 89.99, 150),
('Noise Cancelling Headphones', 'Electronics', 199.99, 80),
('Coffee Maker', 'Home Appliances', 79.99, 120),
('Electric Kettle', 'Home Appliances', 39.99, 90),
('Office Chair', 'Furniture', 149.99, 50),
('Desk Lamp', 'Furniture', 45.99, 100);

-- ============================================================
-- ORDERS
-- ============================================================
INSERT INTO orders (customer_id, order_date, status, shipping_city, shipping_country) VALUES
(1, '2023-06-01 10:23:00', 'Delivered', 'New York', 'USA'),
(1, '2023-07-15 14:45:00', 'Shipped', 'New York', 'USA'),
(2, '2023-08-05 09:12:00', 'Cancelled', 'Los Angeles', 'USA'),
(3, '2023-08-10 16:30:00', 'Delivered', 'Toronto', 'Canada'),
(3, '2023-09-01 11:00:00', 'Pending', 'Toronto', 'Canada'),
(4, '2023-09-15 18:20:00', 'Delivered', 'London', 'UK'),
(5, '2023-10-03 13:45:00', 'Delivered', 'Sydney', 'Australia');

-- ============================================================
-- ORDER_ITEMS
-- ============================================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1 (Alice)
(1, 1, 2, 25.99),
(1, 2, 1, 89.99),
-- Order 2 (Alice)
(2, 3, 1, 199.99),
(2, 4, 1, 79.99),
-- Order 3 (Bob - cancelled)
(3, 1, 1, 25.99),
(3, 5, 1, 39.99),
-- Order 4 (Charlie)
(4, 2, 1, 89.99),
(4, 6, 1, 149.99),
-- Order 5 (Charlie - pending)
(5, 1, 3, 25.99),
(5, 7, 2, 45.99),
-- Order 6 (Diana)
(6, 3, 1, 199.99),
(6, 4, 1, 79.99),
(6, 7, 1, 45.99),
-- Order 7 (Ethan)
(7, 6, 1, 149.99),
(7, 5, 2, 39.99);
