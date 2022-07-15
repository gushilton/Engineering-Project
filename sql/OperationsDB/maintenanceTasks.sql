CREATE TABLE Operations.MaintenanceTasks(
 yearID SMALLINT(2) not null,
 JobID MEDIUMINT(6) zerofill NOT NULL AUTO_INCREMENT ,
 Job_Name varchar(255),
 AssignedTo int,

 routineDuty BIT(1) DEFAULT 0,
 Department_short char(3),
 Routine_number int(5)  zerofill  not null ,

 descriptionProblem varchar(255) DEFAULT '',
 descriptionAction varchar(255) DEFAULT '',

 hierachy char(3),
 functionID int(6) zerofill ,

 ComponentShort char(10),
 ComponentNumber int(6) zerofill not null,

 Date_Created DATE,
 Date_Due DATE,
 Date_Complete DATE,
 Complete BIT(1) DEFAULT 0,

 CONSTRAINT pk_maintenanceTasks PRIMARY KEY (yearID,JobID),
 CONSTRAINT fk_assigned FOREIGN KEY (AssignedTo) REFERENCES personnel.crewRoles(RoleID),
 CONSTRAINT fk_routine FOREIGN KEY (Department_short,Routine_number) REFERENCES Operations.routineJobs(Department_short, number),
 CONSTRAINT fk_hierachy FOREIGN KEY (hierachy,functionID) REFERENCES Operations.functions(heirachy,function),
 CONSTRAINT fk_component FOREIGN KEY (ComponentShort,ComponentNumber) REFERENCES Operations.Components(ComponentShort,ComponentNumber)
)ENGINE = MyISAM;


e

INSERT INTO Operations.MaintenanceTasks
(yearID,   Job_Name,                AssignedTo,   routineDuty,Department_short,Routine_number,hierachy,  functionID,  ComponentShort  ,ComponentNumber,   Date_Created,  Date_Due,    Date_Complete )
VALUES
(22,       'ELE/4- Fire Zone Detector Testing',  16,               1,          "ELE",            4,            "GBA",     3,          "FireDet"    ,       3,            "2022-02-26",   "2022-03-26"    , null          )



INSERT INTO Operations.MaintenanceTasks
(yearID,JobID ,Job_Name,                AssignedTo,   routineDuty,Department_short,Routine_number,hierachy,  functionID,  ComponentShort  ,ComponentNumber,   Date_Created,  Date_Due,    Date_Complete )
VALUES
(21,7880   ,    'ELE/4- Fire Zone Detector Testing',  16,               1,          "ELE",            4,            "GBA",     1,          "FireDet"    ,       1,            "2021-10-06",   "2021-11-06"    , "2021-11-06"         )




INSERT INTO Operations.MaintenanceTasks
(yearID,JobID,   Job_Name,                AssignedTo,   routineDuty,Department_short,Routine_number,hierachy,  functionID,  ComponentShort  ,ComponentNumber,   Date_Created,  Date_Due,    Date_Complete ,Complete)
VALUES
(21, 15000,     'ELE/1- Alternator 1 Yearly Inspection',  14,               1,          "ELE",            1,            "AB",     1,  "Alternator"    ,    1   ,            "2021-12-28",   "2022-12-27"    ,   null ,0   )





INSERT INTO Operations.MaintenanceTasks
(yearID,JobID,   Job_Name,                AssignedTo,   routineDuty,Department_short,Routine_number,hierachy,  functionID,  ComponentShort  ,ComponentNumber,   Date_Created,  Date_Due,    Date_Complete ,Complete)
VALUES
(21, 21000,     'ENG/1- Engine 4 Overhaul',  14,               1,          "ENG",            1,            "AA",     4,  "ENGINE"    ,    4   ,            "2021-11-18",   "2022-11-17"    ,   null ,0   ),
(20, 18000,     'ENG/1- Engine 4 Overhaul',  14,               1,          "ENG",            1,            "AA",     4,  "ENGINE"    ,    4   ,            "2020-11-18",   "2021-11-10"    ,   "2021-11-10" ,1   ),
(19, 18000,     'ENG/1- Engine 4 Overhaul',  14,               1,          "ENG",            1,            "AA",     4,  "ENGINE"    ,    4   ,            "2019-11-18",   "2020-11-10"    ,   "2020-11-10" ,1   )




INSERT INTO Operations.MaintenanceTasks
(yearID,JobID,   Job_Name,                AssignedTo,   routineDuty,Department_short,Routine_number,hierachy,  functionID,  ComponentShort  ,ComponentNumber,   Date_Created,  Date_Due,    Date_Complete ,Complete)
VALUES
(21, 1000,     'ELE/00001- Engine 4 Overhaul',  14,               1,          "ENG",            1,            "AA",     4,  "ENGINE"    ,    4   ,            "2021-11-18",   "2022-11-17"    ,   null ,0   ),




INSERT INTO Operations.MaintenanceTasks
(Job_Name,AssignedTo,routineDuty,Department_short,Routine_number,hierachy,functionID,ComponentShort,ComponentNumber,Date_Created,Date_Due,Date_Complete,Complete,yearID,JobID)
SELECT Job_Name,AssignedTo,routineDuty,Department_short,Routine_number,hierachy,functionID,ComponentShort,ComponentNumber,Date_Complete AS Date_Created,'2022-06-01'AS Date_Due,null AS Date_Complete,0 AS Complete, 21 AS yearID,6110 AS JobID FROM Operations.MaintenanceTasks WHERE yearID = 20 AND JobID = 4000



INSERT INTO Operations.MaintenanceTasks
(Job_Name,AssignedTo,routineDuty,Department_short,Routine_number,hierachy,functionID,ComponentShort,ComponentNumber,Date_Created,Date_Due,Date_Complete,Complete,yearID,JobID)
SELECT name,role,1 AS routineDuty,Department_short,number,heirachy,functionID,"GMDSS",1,'2022-04-13' AS Date_Created,'2022-05-13' AS Date_Due,null AS Date_Complete,0 AS Complete,22 AS yearID,24500 AS JobID FROM Operations.routineJobs WHERE number = 5 AND Department_short = "ELE"


