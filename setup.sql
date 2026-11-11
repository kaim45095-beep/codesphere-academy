-- Run on a local SQL Server or SQL Server Express LocalDB instance.
-- Creates a separate demonstration database and seeds course records only.
USE [master];
GO

IF DB_ID(N'CodeSphereAcademyDemo') IS NULL
    EXEC(N'CREATE DATABASE [CodeSphereAcademyDemo];');
GO

USE [CodeSphereAcademyDemo];
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

IF OBJECT_ID(N'dbo.Courses', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Courses (
        CourseID INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK_Courses PRIMARY KEY,
        Title NVARCHAR(150) NOT NULL,
        Description NVARCHAR(MAX) NULL,
        ImagePath NVARCHAR(255) NULL,
        DateAdded DATETIME NULL CONSTRAINT DF_Courses_DateAdded DEFAULT (GETDATE())
    );
END;

IF OBJECT_ID(N'dbo.Users', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Users (
        UserID INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK_Users PRIMARY KEY,
        FullName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL CONSTRAINT UQ_Users_Email UNIQUE,
        Password NVARCHAR(100) NOT NULL,
        Role NVARCHAR(20) NULL CONSTRAINT DF_Users_Role DEFAULT (N'Learner'),
        DateOfBirth DATE NULL
    );
END;

IF OBJECT_ID(N'dbo.Enrollments', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Enrollments (
        EnrollmentID INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK_Enrollments PRIMARY KEY,
        UserID INT NULL CONSTRAINT FK_Enrollments_Users REFERENCES dbo.Users (UserID),
        CourseID INT NULL CONSTRAINT FK_Enrollments_Courses REFERENCES dbo.Courses (CourseID),
        PurchaseDate DATETIME NULL CONSTRAINT DF_Enrollments_PurchaseDate DEFAULT (GETDATE()),
        ExpiryDate DATETIME NULL
    );
END;

INSERT INTO dbo.Courses (Title, Description)
SELECT demo.Title, demo.Description
FROM (VALUES
    (N'Intro to C#', N'Explore variables, control flow, and object-oriented programming in C#.'),
    (N'Intro to C++', N'Practise core C++ concepts with functions, loops, and classes.')
) AS demo (Title, Description)
WHERE NOT EXISTS (SELECT 1 FROM dbo.Courses AS course WHERE course.Title = demo.Title);

COMMIT TRANSACTION;
GO
