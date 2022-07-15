 CREATE TABLE Operations.Components (
 ComponentShort char(10),
 ComponentNumber int(6) zerofill not null,

 heirachy char(3),
 function int(6) zerofill not null ,

 Maker varchar(30),
 Model varchar(30),
 SerialNumber varchar(50),

 CONSTRAINT pk_components PRIMARY KEY (ComponentShort,ComponentNumber),
 CONSTRAINT fk_com_function FOREIGN KEY (heirachy,function) REFERENCES Operations.functions(heirachy,function)
);

INSERT INTO Operations.Components
(
ComponentShort,
ComponentNumber,
heirachy,
function,
Maker,
Model,
SerialNumber
)
VALUES
(
"FireDet",
1,
"GBA",
1,
"Consillium",
"CON Loops",
"con-m85-00001"
),
(
"FireDet",
2,
"GBA",
2,
"Consillium",
"CON Loops",
"con-m85-00002"
),
(
"FireDet",
3,
"GBA",
3,
"Consillium",
"CON Loops",
"con-m85-00003"
)



INSERT INTO Operations.Components
(
ComponentShort,
ComponentNumber,
heirachy,
function,
Maker,
Model,
SerialNumber
)
VALUES
(
"LifeBoat",
1,
"GD",
1,
"Fassmer",
"TELB14T",
"14T0001"
),
(
"LifeBoat",
2,
"GD",
2,
"Fassmer",
"TELB14T",
"14T0002"
),
(
"LifeBoat",
3,
"GD",
3,
"Fassmer",
"TELB14",
"14LB0001"
),
(
"LifeBoat",
4,
"GD",
4,
"Fassmer",
"TELB14",
"14LB0002"
)



INSERT INTO Operations.Components
(
ComponentShort,
ComponentNumber,
heirachy,
function,
Maker,
Model,
SerialNumber
)
VALUES
("GMDSS",
1,
"CC",
1,
"Sailor",
"6600",
"s100")