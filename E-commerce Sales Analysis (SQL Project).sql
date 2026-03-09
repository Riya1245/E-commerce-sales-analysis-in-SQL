-- Create Database
CREATE DATABASE ecommerce_sales;
USE ecommerce_sales;

-- Customers Table
CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50),
country VARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order Details Table
CREATE TABLE Order_Details (
order_detail_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Customers
INSERT INTO Customers VALUES
(1,'Riya','Delhi','India'),
(2,'Amit','Mumbai','India'),
(3,'Neha','Pune','India'),
(4,'Rahul','Bangalore','India');

-- Insert Products
INSERT INTO Products VALUES
(101,'Laptop','Electronics',60000),
(102,'Mobile','Electronics',20000),
(103,'Headphones','Accessories',2000),
(104,'Shoes','Fashion',3000);

-- Insert Orders
INSERT INTO Orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-02-15'),
(1003,3,'2024-03-12'),
(1004,1,'2024-04-20');

-- Insert Order Details
INSERT INTO Order_Details VALUES
(1,1001,101,1),
(2,1002,102,2),
(3,1003,103,3),
(4,1004,104,2);
SELECT * FROM Orders;
-- Check Data
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Details;

UPDATE Order_Details
SET quantity = 2
WHERE order_detail_id = 1;

UPDATE Order_Details
SET product_id = 105
WHERE order_detail_id = 2;

SELECT * FROM Order_Details;
DELETE FROM Order_Details;
DELETE FROM Order_Details
WHERE order_detail_id > 0;
INSERT INTO Order_Details VALUES
(1,1001,101,1),
(2,1002,102,2),
(3,1003,103,3),
(4,1004,104,2);

DESCRIBE Order_Details;

INSERT INTO Order_Details (order_detail_id, order_id, product_id, quantity)
VALUES
(1,1001,101,1),
(2,1002,102,2),
(3,1003,103,3),
(4,1004,104,2);

SELECT * FROM Orders;
DELETE FROM Orders WHERE order_id IS NULL;

INSERT INTO Order_Details (order_detail_id, order_id, product_id, quantity)
VALUES
(1,1001,101,1),
(2,1002,102,2),
(3,1003,103,3),
(4,1004,104,2);

INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-11'),
(1003,3,'2024-01-12'),
(1004,4,'2024-01-13');




-- Top Selling Products
SELECT p.product_name,
SUM(od.quantity) AS total_sold
FROM Order_Details od
JOIN Products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Monthly Sales Trend
SELECT MONTH(o.order_date) AS month,
SUM(p.price * od.quantity) AS total_sales
FROM Orders o
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Products p
ON od.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

-- Customer Purchase Behavior
SELECT c.customer_name,
COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- Highest Revenue Category
SELECT p.category,
SUM(p.price * od.quantity) AS total_revenue
FROM Order_Details od
JOIN Products p
ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT COUNT(order_id) AS total_orders
FROM Orders;

SELECT product_id, SUM(quantity) AS total_quantity
FROM Order_Details
GROUP BY product_id
ORDER BY total_quantity DESC;

SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id;