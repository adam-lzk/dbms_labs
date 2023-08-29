-- delete tables
DROP TABLE IF EXISTS retail_network;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS store_employee;



-- retail_network
CREATE TABLE retail_network (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name CHAR(50) NOT NULL,
  website_url CHAR(50) NOT NULL
);

INSERT INTO retail_network (name, website_url) VALUES ('evroopt', 'https://evroopt.by');
INSERT INTO retail_network (name, website_url) VALUES ('hit', 'https://hitdiscount.by');
INSERT INTO retail_network (name, website_url) VALUES ('groshyk', 'https://groshyk.by');



-- store
CREATE TABLE store (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  street_name CHAR(50) NOT NULL,
  street_number INT NOT NULL,
  director_first_name CHAR(50) NOT NULL,
  director_last_name CHAR(50) NOT NULL,
  retail_network_id INT REFERENCES retail_network(id)
);

INSERT INTO store (street_name, street_number, director_first_name, director_last_name, retail_network_id) VALUES ('Kalinovskogo', 30, 'Ivan', 'Ivanov', 1);
INSERT INTO store (street_name, street_number, director_first_name, director_last_name, retail_network_id) VALUES ('Lenina', 16, 'Gleb', 'Kozlov', 2);
INSERT INTO store (street_name, street_number, director_first_name, director_last_name, retail_network_id) VALUES ('Lesnaya', 123, 'Andrey', 'Sokolov', 2);
INSERT INTO store (street_name, street_number, director_first_name, director_last_name, retail_network_id) VALUES ('Uzhnaya', 22, 'Petr', 'Abramov', 2);
INSERT INTO store (street_name, street_number, director_first_name, director_last_name, retail_network_id) VALUES ('Derzhinskogo', 72, 'Nikita', 'Krylov', 3);
INSERT INTO store (street_name, street_number, director_first_name, director_last_name, retail_network_id) VALUES ('Zavodskaya', 13, 'Mariya', 'Leshkova', 3);



-- employee
CREATE TABLE employee (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name CHAR(50) NOT NULL,
  last_name CHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL DEFAULT '1970-01-01',  -- default value
  phone_number CHAR(50) NOT NULL CHECK (length(phone_number) = 17),  -- show an error message if the length is != 17
  email CHAR(50) NOT NULL,
  passport_number CHAR(50) NOT NULL CHECK (passport_number LIKE 'MC_______' OR passport_number LIKE 'MP_______')  -- passport_number must look like MC_______ or MP_______
);

CREATE INDEX index_name
ON employee (email);  -- users cannot see the indexes, they are just used to speed up queries

CREATE UNIQUE INDEX full_name_index
ON employee (first_name, last_name);  -- pair of values (first_name, last_name) must be unique

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Elena', 'Morozova', '1988-05-23', '+375(29)555-35-35', 'elena.moroz@gmail.com', 'MC2553636');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Evgeny', 'Abramov', '1999-03-17', '+375(29)581-23-90', 'evgeny.abram@gmail.com', 'MP4439636');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Alexey', 'Nizmin', '1970-12-03', '+375(44)826-19-00', 'alexniz@gmail.com', 'MP9406310');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Svetlana', 'Pryadko', '2001-05-07', '+375(29)189-00-75', 'sveta.rpr@gmail.com', 'MC2011338');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Dzmitry', 'Markov', '1982-04-15', '+375(44)515-80-91', 'dm.markov@gmail.com', 'MC5501456');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Nikolay', 'Rakov', '1987-11-30', '+375(29)112-33-21', 'nickrakov@gmail.com', 'MP9014302');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Petr', 'Landar', '1977-03-20', '+375(29)144-43-10', 'petr.lan@gmail.com', 'MC0193749');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Ivan', 'Repkin', '1990-01-02', '+375(44)672-25-22', 'repkin@gmail.com', 'MP1229585');

INSERT INTO employee (first_name, last_name, date_of_birth, phone_number, email, passport_number)
VALUES ('Svetlana', 'Mikhalova', '1995-11-22', '+375(29)556-35-02', 'svet.mikhalova@gmail.com', 'MP9915750');



-- store_employee
CREATE TABLE store_employee (
  employee_id INT REFERENCES employee(id),
  store_id INT REFERENCES store(id),
  CONSTRAINT store_employee_id PRIMARY KEY (employee_id, store_id)  -- primary key - intersection of two sets of ids
);

INSERT INTO store_employee (employee_id, store_id) VALUES (1, 3), (1, 2);
INSERT INTO store_employee (employee_id, store_id) VALUES (2, 4);
INSERT INTO store_employee (employee_id, store_id) VALUES (3, 3);
INSERT INTO store_employee (employee_id, store_id) VALUES (4, 2);
INSERT INTO store_employee (employee_id, store_id) VALUES (5, 1), (5, 2), (5, 5);
INSERT INTO store_employee (employee_id, store_id) VALUES (6, 3);
INSERT INTO store_employee (employee_id, store_id) VALUES (6, 1);
INSERT INTO store_employee (employee_id, store_id) VALUES (7, 1), (7,5);
INSERT INTO store_employee (employee_id, store_id) VALUES (8, 6);
INSERT INTO store_employee (employee_id, store_id) VALUES (9, 6);
