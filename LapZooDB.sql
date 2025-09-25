
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
  description NVARCHAR Null );

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

 --ตาราง EnclosureKeeper 
 CREATE TABLE Enclosure
 (enclosure_id int Not null PRIMARY KEY FOREIGN KEY(Enclosure),
  keeper_id int Not Null PRIMARY KEY FOREIGN KEY(Keeper));

  SELECT * from Enclosure;

  --ตารางFood
  CREATE TABLE Food
  ( food_id int NOT NULL PRIMARY KEY,
   name NVARCHAR not null ,
   type NVARCHAR Null,
   unit NVARCHAR Null)

   SELECT * from  Food;

--ตาราง Animal
CREATE TABLE Animal (
    animal_id int PRIMARY KEY, 
    name NVARCHAR(100) NOt NULL,
    gender NVARCHAR(10) NULL,
    birth_date DATE NULL,
    enclosure_id int NULL,
    animal_type_id int NULL,
    species_info_id int NULL,
    FOREIGN KEY(enclosure_id) REFERENCES Enclosure(enclosure_id),
    FOREIGN KEY(animal_type_id) REFERENCES AnimalType(animal_type_id),
    FOREIGN KEY(species_info_id) REFERENCES Speciesinfo(specires_info_id));

    Select * from Animal

--ตาราง FeedingSchedule
CREATE TABLE FeedingSchedule(
    feeding_id int PRIMARY KEY,
    animal_id int Not NULL,
    food_id int Not NULL,
    amount DECIMAL(10,2) NULL,
    feeding_date DATE NULL,
    feeding_time TIME NULL,
    keeper_id int NULL,
    FOREIGN KEY(animal_id) REFERENCES Animal(animal_id),
    FOREIGN KEY(food_id) REFERENCES Food(food_id),
    FOREIGN KEY(keeper_id) REFERENCES Keeper(keeper_id));

    Select * from FeedingSchedule