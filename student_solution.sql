-- ============================================
-- RDBMS PROGRAM 13
-- NORMALIZATION UP TO THIRD NORMAL FORM (3NF)
-- ============================================

-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS CollegeDB;

-- Step 2: Select Database
USE CollegeDB;


-- ============================================
-- UNNORMALIZED TABLE
-- ============================================

-- Original table:
-- Student(StudentID, StudentName, CourseName,
--          FacultyName, DepartmentName)

-- The original table contains repeated information.
-- Normalize the table into 1NF, 2NF and 3NF.


-- ============================================
-- STEP 3: CREATE DEPARTMENT TABLE
-- 3NF
-- ============================================

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);


-- ============================================
-- STEP 4: INSERT DEPARTMENT RECORDS
-- ============================================

INSERT INTO Department VALUES
(10, 'Computer Science'),
(20, 'Mathematics');


-- ============================================
-- STEP 5: CREATE FACULTY TABLE
-- 3NF
-- ============================================

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);


-- ============================================
-- STEP 6: INSERT FACULTY RECORDS
-- ============================================

INSERT INTO Faculty VALUES
(501, 'Dr. Ravi', 10),
(502, 'Dr. Meena', 20);


-- ============================================
-- STEP 7: CREATE COURSE TABLE
-- 3NF
-- ============================================

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    FacultyID INT,
    FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID)
);


-- ============================================
-- STEP 8: INSERT COURSE RECORDS
-- ============================================

INSERT INTO Course VALUES
(201, 'Database Systems', 501),
(202, 'Data Structures', 501),
(203, 'Mathematics', 502);


-- ============================================
-- STEP 9: CREATE STUDENT TABLE
-- 3NF
-- ============================================

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);


-- ============================================
-- STEP 10: INSERT STUDENT RECORDS
-- ============================================

INSERT INTO Student VALUES
(1001, 'Arun'),
(1002, 'Priya'),
(1003, 'Kumar');


-- ============================================
-- STEP 11: CREATE STUDENT COURSE TABLE
-- 3NF
-- ============================================

CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);


-- ============================================
-- STEP 12: INSERT STUDENT COURSE RECORDS
-- ============================================

INSERT INTO StudentCourse VALUES
(1001, 201),
(1001, 202),
(1002, 203),
(1003, 201);


-- ============================================
-- NORMALIZED STRUCTURE
-- ============================================

-- Student
-- StudentID -> StudentName

-- Department
-- DepartmentID -> DepartmentName

-- Faculty
-- FacultyID -> FacultyName, DepartmentID

-- Course
-- CourseID -> CourseName, FacultyID

-- StudentCourse
-- StudentID + CourseID -> Enrollment


-- ============================================
-- DISPLAY NORMALIZED DATA
-- ============================================

SELECT
    Student.StudentID,
    Student.StudentName,
    Course.CourseName,
    Faculty.FacultyName,
    Department.DepartmentName
FROM Student
INNER JOIN StudentCourse
    ON Student.StudentID = StudentCourse.StudentID
INNER JOIN Course
    ON StudentCourse.CourseID = Course.CourseID
INNER JOIN Faculty
    ON Course.FacultyID = Faculty.FacultyID
INNER JOIN Department
    ON Faculty.DepartmentID = Department.DepartmentID;
