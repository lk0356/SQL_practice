-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
-- 1.1 Select the names of all the products in the store.
SELECT name FROM public.products;
-- 1.2 Select the names and the prices of all the products in the store.
SELECT name, price
FROM public.products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name, price
FROM public.products
WHERE price <= 200;
-- 1.4 Select all the products with a price between $60 and $120.
SELECT *
FROM public.products
WHERE price >=60 AND price <= 120;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name, (price*100) as cents_price
FROM public.products;
-- 1.6 Compute the average price of all the products.
SELECT AVG(price)
FROM public.products;
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price)
FROM public.products, public.manufacturers
WHERE products.manufacturer = manufacturers.code 
AND manufacturers.code = 2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*)
FROM public.products
WHERE price >= 180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name, price
FROM public.products
WHERE price >= 180
ORDER BY price DESC, name ASC
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT *
FROM public.products as prod
LEFT JOIN public.manufacturers AS man
  ON prod.manufacturer = man.code;
-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT prod.name, prod.price, man.name AS manufacturer_name
FROM public.products AS prod
LEFT JOIN public.manufacturers AS man
  ON prod.manufacturer = man.code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(prod.price) as avg_price, prod.manufacturer
FROM public.products as prod
GROUP BY prod.manufacturer;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(p.price) as avg_price, m.name
FROM Products p join Manufacturers m 
ON p.manufacturer = m.code
GROUP BY m.name;
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT AVG(p.price) as avg_price, m.name
FROM Products p RIGHT JOIN Manufacturers m 
ON p.manufacturer = m.code
GROUP BY m.name
HAVING AVG(p.price) >= 150;

-- 1.15 Select the name and price of the cheapest product.
SELECT name, price
FROM Products
WHERE Price = (SELECT MIN(price) FROM Products);

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
SELECT * FROM Products

INSERT INTO Products VALUES (11, 'Loudspeakers', 70, 2) 
-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET Name = 'Laser Printer'
WHERE Code = 8;
-- 1.19 Apply a 10% discount to all products.
UPDATE Products
SET Price = Price*0.9;
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE Products
SET Price = Price*0.9
WHERE Price >= 120;
