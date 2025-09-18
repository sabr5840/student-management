-- V1__InitialSchema.sql

-- Opret Students tabel
CREATE TABLE Students (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email TEXT NOT NULL,
    EnrollmentDate TEXT NOT NULL
);

-- Opret Courses tabel
CREATE TABLE Courses (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Credits INTEGER NOT NULL
);

-- Opret Enrollments tabel
CREATE TABLE Enrollments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentId INTEGER NOT NULL,
    CourseId INTEGER NOT NULL,
    Grade TEXT NOT NULL,
    FOREIGN KEY (StudentId) REFERENCES Students(Id) ON DELETE CASCADE,
    FOREIGN KEY (CourseId) REFERENCES Courses(Id) ON DELETE CASCADE
);

-- Tilføj indeks for hurtigere opslag
CREATE INDEX IX_Enrollments_StudentId ON Enrollments(StudentId);
CREATE INDEX IX_Enrollments_CourseId ON Enrollments(CourseId);
