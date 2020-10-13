use lw3

CREATE TABLE official_city
(
	id int NOT NULL,
	title varchar(30) NOT NULL,
	area varchar(30) NOT NULL,
	postal_code int NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE orders
( 
	id int NOT NULL,
	order_recipient_name varchar(50) NOT NULL,
	order_recipient_surname varchar(50) NOT NULL,
	date_of_order datetime NOT NULL,
	order_number int NOT NULL,
	PRIMARY KEY (id),
); 

CREATE TABLE official
(
	id int NOT NULL,
	official_name varchar(50) NOT NULL,
	official_company varchar(80) NOT NULL,
	official_address varchar(100) NOT NULL,
	official_salary int NOT NULL,
	official_city_id int NOT NULL,
	official_postal_code int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (official_city_id) REFERENCES official_city(id)
);

CREATE TABLE order_sender
(
	id int NOT NULL,
	sender_organisation_title varchar(50) NOT NULL,
	sender_address varchar(80) NOT NULL,
	sender_city_id int NOT NULL,
	sender_postal_code int NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE mailing_to_officials
(
	id int NOT NULL,
	date_of_shipment datetime NOT NULL,
	name_of_official varchar(100) NOT NULL,
	order_id int NOT NULL,
	official_id int NOT NULL,
	official_city_id int NOT NULL,
	sender_id int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (official_id) REFERENCES official(id),
	FOREIGN KEY (official_city_id) REFERENCES official_city(id),
	FOREIGN KEY (sender_id) REFERENCES order_sender(id)
);