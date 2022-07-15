CREATE TABLE Operations.Function_Hierachy(
DivisionName varchar(40),
Division1 char(1),
Division2 char(1),
Division3 char(1)
);
INSERT INTO Operations.Function_Hierachy(
DivisionName,
Division1,
Division2,
Division3 
)
VALUES
(
"Power Generation",
"A",
"",
""
),
(
"Prime Mover",
"A",
"A",
""
),
(
"Alternators",
"A",
"B",
""
),
(
"Power Distribution",
"B",
"",
""
),
(
"Main Switchboard",
"B",
"A",
""
),
(
"Substations",
"B",
"B",
""
),
(
"Navigation",
"C",
"",
""
),
(
"Steering Gear",
"C",
"A",
""
),
(
"Nav Lights",
"C",
"B",
""
),
(
"GMDSS",
"C",
"C",
""
),
(
"ECDIS",
"C",
"D",
""
),
(
"Hotel",
"D",
"",
""
),
(
"Lifts",
"D",
"A",
""
),
(
"Laundry",
"D",
"B",
""
),
(
"Galley",
"E",
"",
""
),
(
"Workshop Equipment",
"F",
"",
""
),
(
"Electrical",
"F",
"A",
""
),
(
"Multimeters",
"F",
"A",
"A"
),
(
"Calibrators",
"F",
"A",
"B"
),
(
"Safety",
"G",
"",
""
),
(
"Emergency Power",
"G",
"A",
""
),
(
"Fire",
"G",
"B",
""
),
(
"Fire Detection",
"G",
"B",
"A"
),
(
"Fire Fighting",
"G",
"B",
"B"
);

INSERT INTO Operations.Function_Hierachy(
DivisionName,
Division1,
Division2,
Division3
)
VALUES
(
"Emergency Prime Mover",
"G",
"A",
"A"
),
(
"Emergency Alternator",
"G",
"A",
"B"
),
(
"Transitional Batteries",
"G",
"A",
"C"
);

INSERT INTO Operations.Function_Hierachy(
DivisionName,
Division1,
Division2,
Division3
)
VALUES
(
"Fast Rescue Craft",
"G",
"F",
""
)