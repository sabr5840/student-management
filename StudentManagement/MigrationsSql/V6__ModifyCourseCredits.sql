-- V6__ModifyCourseCredits.sql

BEGIN TRANSACTION;

CREATE TABLE Courses_temp (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Credits DECIMAL(5,2) NOT NULL,
    InstructorId INTEGER NOT NULL,
    FOREIGN KEY (InstructorId) REFERENCES Instructors(Id) ON DELETE CASCADE
);

INSERT INTO Courses_temp (Id, Title, Credits, InstructorId)
SELECT Id, Title, Credits, InstructorId FROM Courses;

DROP TABLE Courses;

ALTER TABLE Courses_temp RENAME TO Courses;

COMMIT;
