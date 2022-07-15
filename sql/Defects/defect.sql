CREATE TABLE Defects.Defects(
 yearID SMALLINT(2) not null,
 JobID MEDIUMINT(6) zerofill NOT NULL AUTO_INCREMENT ,
 department varchar(20),
 problem varchar(40),
 location varchar(40),
 complete bit(1) default 0,
  CONSTRAINT pk_defects PRIMARY KEY (yearID,JobID),
  CONSTRAINT fk_dep FOREIGN KEY (department) REFERENCES Defects.Department(Name)
)ENGINE = MyISAM;

INSERT INTO Defects.Defects
(yearID,department,problem,location)
VALUES
(22,"Electrical","Light bulb flashing","cabin 2002"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Socket not working","cabin 11102"),
(22,"Electrical","Light bulb flashing","cabin 4102"),
(22,"Electrical","Light bulb flashing","bathroom 10185"),
(22,"Plumbing","Toilet wont flush","cabin 6211"),
(22,"Ventilation","AC not working","cabin 8247"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Light bulb flashing","cabin 2002"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Socket not working","cabin 11102"),
(22,"Electrical","Light bulb flashing","cabin 4102"),
(22,"Electrical","Light bulb flashing","bathroom 10185"),
(22,"Plumbing","Toilet wont flush","cabin 6211"),
(22,"Ventilation","AC not working","cabin 8247"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Light bulb flashing","cabin 2002"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Socket not working","cabin 11102"),
(22,"Electrical","Light bulb flashing","cabin 4102"),
(22,"Electrical","Light bulb flashing","bathroom 10185"),
(22,"Plumbing","Toilet wont flush","cabin 6211"),
(22,"Ventilation","AC not working","cabin 8247"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Light bulb flashing","cabin 2002"),
(22,"Plumbing","Toilet wont flush","cabin 3152"),
(22,"Electrical","Socket not working","cabin 11102"),
(22,"Electrical","Light bulb flashing","cabin 4102"),
(22,"Electrical","Light bulb flashing","bathroom 10185"),
(22,"Plumbing","Toilet wont flush","cabin 6211"),
(22,"Ventilation","AC not working","cabin 8247"),
(22,"Plumbing","Toilet wont flush","cabin 3152");