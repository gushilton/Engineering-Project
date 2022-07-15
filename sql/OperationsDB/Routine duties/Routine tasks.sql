CREATE TABLE Operations.routineJobs(
 Department_short char(3),
 number int(5) zerofill not null ,
 name varchar(40),
 heirachy char(3),
 functionID int(6) zerofill ,
 role int,
 frequency varchar(25),
 details varchar(255),

 CONSTRAINT PK_routine PRIMARY KEY (Department_short,number,heirachy,functionID),
 CONSTRAINT fk_function FOREIGN KEY (heirachy,functionID) REFERENCES Operations.functions(heirachy,function),
 CONSTRAINT fk_role FOREIGN KEY (role) REFERENCES personnel.CrewRoles(RoleID)
);

INSERT INTO Operations.routineJobs
(Department_short,number,name,heirachy,functionID,role,frequency,details)
VALUES
("",0,"","   ",0,1,"",""),
("ELE",1,"Alternator Inspection","AB",1,15,"Yearly",""),
("ELE",1,"Alternator Inspectionl","AB",2,15,"Yearly",""),
("ELE",1,"Alternator Inspection","AB",3,15,"Yearly",""),
("ELE",1,"Alternator Inspection","AB",4,15,"Yearly",""),
("ELE",2,"Lift Monthly Inspection","DA",1,16,"monthly",""),
("ELE",2,"Lift Monthly Inspection","DA",2,16,"monthly",""),
("ELE",2,"Lift Monthly Inspection","DA",3,16,"monthly",""),
("ELE",2,"Lift Monthly Inspection","DA",4,16,"monthly",""),
("ELE",3,"Lift Quaterly Inspection","DA",1,16,"3 monthly",""),
("ELE",3,"Lift Quaterly Inspection","DA",2,16,"3 monthly",""),
("ELE",3,"Lift Quaterly Inspection","DA",3,16,"3 monthly",""),
("ELE",3,"Lift Quaterly Inspection","DA",4,16,"3 monthly",""),
("ENG",1,"Engine Overhaul","AA",1,10,"Yearly",""),
("ENG",1,"Engine Overhaul","AA",2,10,"Yearly",""),
("ENG",1,"Engine Overhaul","AA",3,10,"Yearly",""),
("ENG",1,"Engine Overhaul","AA",4,10,"Yearly","");

INSERT INTO Operations.routineJobs
(Department_short,number,name,heirachy,functionID,role,frequency,details)
VALUES
("ELE",4,"GMDSS Monthly Battery Test","CC",1,15,30,"");