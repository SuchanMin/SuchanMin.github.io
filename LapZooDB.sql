
CREATE DATABASE ZooDB

--ตาราง AnimalType--
CREATE TABLE AnimalType 
(animal_type_id INT Not Null PRIMARY KEY ,
 type_name NVARCHAR(100) Not Null,
 description NVARCHAR(MAX) Null)

 select * from AnimalType;

 --ตาราง Seeciesinfo
 CREATE TABLE Speciesinfo 
 ( specires_info_id INt Not Null PRIMARY KEY,
  common_name NVARCHAR(100) Not Null,
  scientific_name NVARCHAR(100) Null,
  habital NVARCHAR(MAX) Null,
  diet NVARCHAR(100) NULL,
  conservation_status NVARCHAR(100) Null,
  description NVARCHAR Null )

  SELECT * from Speciesinfo;

  --ตาราง Enclosure 
  CREATE TABLE Enclosure 
  (enclosure_id int not null PRIMARY KEY,
   name NVARCHAR(100) not null,
    location NVARCHAR Null )
    SELECT * from Enclosure;

-- ตาราง Keeper 
CREATE TABLE Keeper 
( keeper_id  int Not Null PRIMARY KEY,
 name NVARCHAR(100) Not Null,
 phone NVARCHAR(50) Null,
 email NVARCHAR(100) Null)

 SELECT * from Keeper;

 --ตาราง Enclosur