-- Customer Table for Presidents

CREATE TABLE customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(200),
	city VARCHAR(150),
	customer_state VARCHAR(150),
	zipcode VARCHAR(50)
);

ALTER TABLE customer
ADD COLUMN email VARCHAR(200);

-- Order table for presidents
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date DATE DEFAULT CURRENT_DATE,
	amount NUMERIC(5,2), -- 90,999.20
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(1,'George','Washington','gwash@usa.gov', '3200 Mt Vernon Hwy', 'Mt Vernon', 'VA', '22121');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(2,'John','Adams','jadams@usa.gov','1200 Hancock', 'Quincy', 'MA','02169');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(3,'Thomas','Jefferson', 'tjeff@usa.gov', '931 Thomas Jefferson Pkway', 'Charlottesville','VA','02169');

INSERt INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(4,'James','Madison', 'jmad@usa.gov', '11350 Conway','Orange','VA','02169');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(5,'James','Monroe','jmonroe@usa.gov','2050 James Monroe Parkway','Charlottesville','VA','02169');

-- INSERT INFO INTO ORDERS TABLE

INSERT INTO order_(order_id,amount,customer_id)
VALUES(1,234.56,1);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(2,78.50,3);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(3,124.00,2);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(4,65.50,3);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(5,55.50,NULL);


SELECT * FROM customer;
SELECT * FROM order_;

-- INNER JOIN
SELECT first_name, last_name, order_date, amount, customer.customer_id --specify when two tables share key
FROM customer
INNER JOIN order_
ON customer.customer_id = order_.customer_id;

-- TABLE A == customer
-- TABLE B == order_
-- TABLE A will be the first table you're selecting from
-- TABLE B will be the table that is being JOINed on

-- LEFT JOIN
SELECT first_name, last_name, order_date, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id;

-- LEFT JOIN only showing values that are NOT NULL in table B
SELECT first_name, last_name, order_date, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id
WHERE order_date IS NOT NULL
ORDER BY amount DESC;

-- RIGHT JOIN
SELECT first_name, last_name, order_date, amount
FROM customer
RIGHT JOIN order_
ON customer.customer_id = order_.customer_id;

-- FULL JOIN
SELECT first_name, last_name, order_date, amount
FROM customer
FULL JOIN order_
ON customer.customer_id = order_.customer_id;

