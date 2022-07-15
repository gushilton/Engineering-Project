CREATE TABLE TaskNotes(
NoteID int AUTO INCREMENT NOT NULL,
JobID  int,
NoteDate DATE,
Note varchar(),
PRIMARY KEY(NoteID),
FORIEGN KEY(JobID) REFERENCE tasks(Job_ID)
);




