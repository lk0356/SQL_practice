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


-- ============================================================
-- ADDITIONAL DATA
-- ============================================================
INSERT INTO customers (first_name, last_name, email, phone, city, country, signup_date) VALUES
('Fiona', 'Adams', 'fiona.adams@example.com', '555-6789', 'Dublin', 'Ireland', '2023-06-18'),
('George', 'Hernandez', 'george.hernandez@example.com', '555-7890', 'San Francisco', 'USA', '2023-07-09'),
('Hannah', 'Khan', 'hannah.khan@example.com', '555-8901', 'Auckland', 'New Zealand', '2023-07-30'),
('Ivan', 'Petrov', 'ivan.petrov@example.com', '555-9012', 'Berlin', 'Germany', '2023-08-12'),
('Julia', 'Rossi', 'julia.rossi@example.com', '555-0123', 'Rome', 'Italy', '2023-09-05');

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Portable SSD 1TB', 'Electronics', 129.99, 75),
('Gaming Chair', 'Furniture', 199.99, 40),
('Smart LED Strip', 'Home Appliances', 24.99, 180),
('USB-C Charging Cable', 'Electronics', 9.99, 600),
('Notebook Set (5-pack)', 'Office Supplies', 7.99, 300);

INSERT INTO orders (customer_id, order_date, status, shipping_city, shipping_country) VALUES
(6, '2023-10-10 15:30:00', 'Shipped', 'Dublin', 'Ireland'),
(7, '2023-10-12 09:50:00', 'Delivered', 'San Francisco', 'USA'),
(8, '2023-10-14 20:10:00', 'Pending', 'Auckland', 'New Zealand'),
(9, '2023-10-18 12:25:00', 'Delivered', 'Berlin', 'Germany'),
(10, '2023-10-22 08:40:00', 'Shipped', 'Rome', 'Italy'),
(7, '2023-11-01 17:05:00', 'Delivered', 'San Francisco', 'USA'),
(6, '2023-11-04 10:10:00', 'Cancelled', 'Dublin', 'Ireland');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 8 (Fiona)
(8, 8, 1, 129.99),
(8, 10, 2, 24.99),

-- Order 9 (George)
(9, 11, 1, 9.99),
(9, 12, 1, 7.99),

-- Order 10 (Hannah - pending)
(10, 9, 1, 199.99),
(10, 4, 1, 79.99),

-- Order 11 (Ivan)
(11, 2, 1, 89.99),
(11, 6, 1, 149.99),
(11, 10, 3, 24.99),

-- Order 12 (Julia)
(12, 3, 1, 199.99),
(12, 8, 1, 129.99),

-- Order 13 (George again)
(13, 1, 2, 25.99),
(13, 11, 3, 9.99),

-- Order 14 (Fiona - cancelled)
(14, 7, 1, 45.99);
