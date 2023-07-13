-- create table users if doesnt exists
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email varchar(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);

