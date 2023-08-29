CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  price INT NOT NULL,
  quantity_in_store INT NOT NULL,
  cathegory CHAR(50),
  store_id INT REFERENCES store(id)
);

CREATE INDEX cathegory_index
ON products (cathegory);



CREATE TABLE service AS
  SELECT price, cathegory
  FROM products;

DROP TABLE IF EXISTS service;



INSERT INTO products (price, quantity_in_store, cathegory)
VALUES
(12, 3, 'milk'),
(25, 13, 'vegetables'),
(4, 32, 'fish'),
(122, 5, 'fish'),
(995, 10, 'fruits'),
(2, 55, 'vegetables'),
(1002, 1, 'milk'),
(75, 13, 'milk');



SELECT *
FROM products
LIMIT 5;



SELECT cathegory, price, quantity_in_store, price * quantity_in_store AS price_for_all
FROM products
WHERE price_for_all > 100 AND cathegory != 'milk';



SELECT cathegory, COUNT(*) AS units_of_cathegory, SUM(quantity_in_store) AS units_quantity_in_store
FROM products
GROUP BY cathegory;

SELECT cathegory, COUNT(*) AS units_of_cathegory
FROM products
WHERE cathegory != 'fish'
GROUP BY cathegory;

SELECT cathegory, COUNT(*) AS units_in_cathegory
FROM products
WHERE cathegory != 'fish'
GROUP BY cathegory
HAVING units_in_cathegory >= 2
ORDER BY units_in_cathegory ASC;



SELECT price
FROM products;

DELETE FROM products
WHERE price > 80;

SELECT price
FROM products;



SELECT *
FROM products;

UPDATE products
SET price = 17, quantity_in_store = 4
WHERE id = 1;

SELECT *
FROM products;



DROP TABLE IF EXISTS products;



SELECT COUNT(*)
FROM employee;



SELECT first_name, last_name, CURRENT_DATE - date_of_birth AS age
FROM employee;

SELECT MIN(CURRENT_DATE - date_of_birth) AS min_age
FROM employee;

SELECT MAX(CURRENT_DATE - date_of_birth) AS max_age
FROM employee;

SELECT AVG(CURRENT_DATE - date_of_birth) AS avg_age
FROM employee;



SELECT *
FROM store
INNER JOIN retail_network ON store.retail_network_id = retail_network.id;

SELECT street_name, street_number, retail_network_id, retail_network.name
FROM store
INNER JOIN retail_network ON store.retail_network_id = retail_network.id;

SELECT street_name, street_number, retail_network_id, retail_network.name
FROM store
INNER JOIN retail_network ON store.retail_network_id = retail_network.id
WHERE street_number > 20
GROUP BY retail_network.name;



SELECT *
FROM retail_network
LEFT JOIN store ON store.retail_network_id = retail_network.id;

SELECT retail_network.name, street_name, street_number, retail_network_id
FROM retail_network
LEFT JOIN store ON store.retail_network_id = retail_network.id;



SELECT *
FROM employee
WHERE id =
  (SELECT COUNT(*)
   FROM employee);



CREATE VIEW employee_view AS
  SELECT first_name, last_name, passport_number
  FROM employee;

DROP VIEW IF EXISTS employee_view;



SELECT first_name
from employee
UNION
SELECT director_first_name
FROM store;

SELECT first_name
from employee
UNION ALL
SELECT director_first_name
FROM store;

SELECT first_name
from employee
INTERSECT
SELECT director_first_name
FROM store;
