CREATE DATABASE IF NOT EXISTS  BALLERINA;
CREATE DATABASE IF NOT EXISTS EI;

USE BALLERINA;

DROP TABLE IF EXISTS inserttest;
DROP TABLE IF EXISTS batchinserttest;
DROP TABLE IF EXISTS selecttest;

CREATE TABLE `inserttest` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
);

CREATE TABLE `batchinserttest` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
);

CREATE TABLE `selecttest` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DELIMITER $$
CREATE PROCEDURE populateSelectTable() 
BEGIN
DECLARE id INT;
DECLARE name VARCHAR(20);
SET id = 1;
SET name = 'John';
WHILE id <= 100 DO
   SET name = CONCAT(name, id);
   INSERT INTO selecttest VALUES(id, name);
   SET id = id + 1;
   SET name = 'John';
END WHILE;
END$$
DELIMITER ;

CALL populateSelectTable();

USE EI;

DROP TABLE IF EXISTS inserttest;
DROP TABLE IF EXISTS batchinserttest;
DROP TABLE IF EXISTS selecttest;

CREATE TABLE `inserttest` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
);

CREATE TABLE `batchinserttest` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
);

CREATE TABLE `selecttest` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


DELIMITER $$
CREATE PROCEDURE populateSelectTable() 
BEGIN
DECLARE id INT;
DECLARE name VARCHAR(20);
SET id = 1;
SET name = 'John';
WHILE id <= 100 DO
   SET name = CONCAT(name, id);
   INSERT INTO selecttest VALUES(id, name);
   SET id = id + 1;
   SET name = 'John';
END WHILE;
END$$
DELIMITER ;

CALL populateSelectTable();
