CREATE DATABASE tree_plantation;

USE tree_plantation;

CREATE TABLE tree_drive (
    id INT AUTO_INCREMENT PRIMARY KEY,
    volunteer VARCHAR(40),
    tree VARCHAR(15),
    location VARCHAR(40),
    trees INT
);
