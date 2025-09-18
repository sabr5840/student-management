
CREATE TABLE Instructors (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email TEXT NOT NULL,
    HireDate TEXT NOT NULL
);

ALTER TABLE Courses ADD COLUMN InstructorId INTEGER NOT NULL DEFAULT 0;

PRAGMA foreign_keys = off;

CREATE TABLE Courses_new (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Credits INTEGER NOT NULL,
    InstructorId INTEGER NOT NULL,
    FOREIGN KEY (InstructorId) REFERENCES Instructors(Id) ON DELETE CASCADE
);

INSERT INTO Courses_new (Id, Title, Credits, InstructorId)
SELECT Id, Title, Credits, InstructorId FROM Courses;

DROP TABLE Courses;
ALTER TABLE Courses_new RENAME TO Courses;

PRAGMA foreign_keys = on;
