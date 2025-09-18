
PRAGMA foreign_keys = off;

CREATE TABLE Enrollments_new (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentId INTEGER NOT NULL,
    CourseId INTEGER NOT NULL,
    FinalGrade TEXT NOT NULL,
    FOREIGN KEY (StudentId) REFERENCES Students(Id) ON DELETE CASCADE,
    FOREIGN KEY (CourseId) REFERENCES Courses(Id) ON DELETE CASCADE
);

INSERT INTO Enrollments_new (Id, StudentId, CourseId, FinalGrade)
SELECT Id, StudentId, CourseId, Grade FROM Enrollments;

DROP TABLE Enrollments;
ALTER TABLE Enrollments_new RENAME TO Enrollments;

PRAGMA foreign_keys = on;
