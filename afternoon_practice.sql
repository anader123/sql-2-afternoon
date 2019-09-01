-- PRACTICE JOINS 

-- 1. 

SELECT * 
FROM invoice i 
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

-- 2. 

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i 
JOIN customer c ON c.customer_id = i.customer_id;

-- 3. 

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c 
JOIN employee e ON c.support_rep_id = e.employee_id;

-- 4. 

SELECT al.title, ar.name 
FROM album al 
JOIN artist ar ON al.artist_id = ar.artist_id;

-- 5. 

SELECT pl.track_id 
FROM playlist_track pl
JOIN playlist p ON p.playlist_id = pl.playlist_id
WHERE p.name = 'Music';

-- 6. 

SELECT t.name
FROM track t 
JOIN playlist_track p ON t.track_id = p.track_id 
WHERE p.playlist_id = 5; 

-- 7. 

SELECT t.name, pl.name
FROM track t 
JOIN playlist_track plt ON t.track_id = plt.track_id
JOIN playlist pl ON plt.playlist_id = pl.playlist_id; 

-- 8. 

SELECT t.name, a.title 
FROM track t 
JOIN album a ON t.album_id = a.album_id 
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk'; 

-- PRACTICE NESTED QUERIES 

-- 1. 

SELECT *
FROM invoice 
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

-- 2. 

SELECT * 
FROM playlist_track 
WHERE playlist_id IN ( SELECT playlist_id FROM playlist pl WHERE pl.name = 'Music' );

-- 3. 

SELECT name 
FROM track 
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id =5 );

-- 4. 

SELECT name 
FROM track 
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy'); 

-- 5. 

SELECT * 
FROM track 
WHERE album_id IN (SELECT album_id FROM album WHERE name = 'Fireball'); 

-- 6. 

SELECT * 
FROM track 
WHERE album_id IN (SELECT album_id FROM album WHERE name = 'Fireball'); 

-- PRACTICE UPDATING ROWS 

-- 1. 

UPDATE customer 
SET fax = null
WHERE fax IS NOT null;

-- 2. 

UPDATE customer
SET company = 'SELF'
WHERE company IS null;

-- 3. 

UPDATE customer 
SET first_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- 4. 

UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'; 

-- 5. 
 
UPDATE track 
SET composer = 'The darkness around us' 
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal') 
AND composer IS null; 

-- GROUP BY 

-- 1. 

SELECT count(*), g.name 
FROM track t 
JOIN genre g ON g.genre_id = t.genre_id
GROUP BY g.name;

-- 2. 

SELECT count(t.track_id)
FROM track t 
JOIN genre g ON g.genre_id = t.genre_id 
WHERE g.name = 'Pop' OR g.name = 'Rock' 
GROUP BY g.name; 

-- 3. 

SELECT ar.name, count(*)  
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id 
GROUP BY ar.name;

-- USE DISTINCT 

-- 1. 

SELECT DISTINCT composer
FROM track

-- 2. 

SELECT DISTINCT billing_postal_code 
FROM invoice;

-- 3. 

SELECT DISTINCT company
FROM customer; 

-- DELETE ROWS

-- 2. 

DELETE FROM practice_delete 
WHERE type = 'bronze';  

-- 3. 

DELETE 
FROM practice_delete
WHERE type = 'silver'; 

-- 4. 

DELETE 
FROM practice_delete
WHERE value = 150; 

-- eCommerce Simulation 

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY, 
    name TEXT, 
    email TEXT 
),

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY, 
    product_name TEXT, 
    product_price INTEGER 
),

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    user_id INTEGER REFERENCES users(user_id), 
    product_id INTEGER REFERENCES products(product_id)
);

-- DUMMY DATA 

INSERT INTO users 
(name, email)
VALUES
('Bob', 'bob@bob.com'),
('Sam', 'sam@sam.com'),
('Al', 'al@al.com');

INSERT INTO products 
(product_name, product_price)
VALUES
('nail', 1),
('wrench', 1),
('hammer', 1);

INSERT INTO orders 
(user_id, product_id)
VALUES 
(1, 2);

INSERT INTO orders 
(user_id, product_id)
VALUES 
(2, 1);

INSERT INTO orders 
(user_id, product_id)
VALUES 
(3, 3);

-- Queries Run Against Data 

-- 1. 

SELECT p
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_id = 1; 

-- 2. 

SELECT *
FROM orders;

-- 3. 

SELECT sum(p.product_price)
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_id = 1; 

-- 4. 

ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(order_id);

-- 5. 

UPDATE orders
SET user_id = 1
WHERE order_id = 1; 

-- 6. 

SELECT count(*), us.name
FROM orders o 
JOIN users us on us.user_id = o.user_id
GROUP BY us.name; 

SELECT SUM(price), us.name 
FROM orders o 
JOIN users us on us.user_id = o.user_id
JOIN products p on o.product_id = p.product_id
GROUP BY us.name; 