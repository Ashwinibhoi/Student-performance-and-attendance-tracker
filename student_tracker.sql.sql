
CREATE DATABASE IF NOT EXISTS StudentTracker;
USE StudentTracker;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Grades, Attendance, Enrollments, Courses, Faculty, Students, Departments;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Departments (
  department_id INT PRIMARY KEY AUTO_INCREMENT,
  department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  dob DATE,
  gender VARCHAR(10),
  email VARCHAR(120),
  phone_number VARCHAR(20),
  address VARCHAR(150),
  admission_date DATE NOT NULL,
  department_id INT NOT NULL,
  FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Faculty (
  faculty_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(120),
  phone_number VARCHAR(20),
  department_id INT NOT NULL,
  experience_years INT DEFAULT 0,
  FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Courses (
  course_id INT PRIMARY KEY AUTO_INCREMENT,
  course_name VARCHAR(100) NOT NULL,
  faculty_id INT,
  department_id INT NOT NULL,
  FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id) ON DELETE SET NULL,
  FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Enrollments (
  enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  UNIQUE (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE TABLE Attendance (
  attendance_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  attendance_date DATE NOT NULL,
  status ENUM('Present','Absent','Late') NOT NULL,
  UNIQUE (student_id, course_id, attendance_date),
  FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE TABLE Grades (
  grade_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  marks_obtained DECIMAL(5,2) NOT NULL CHECK (marks_obtained BETWEEN 0 AND 100),
  grade VARCHAR(5),
  UNIQUE (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);


INSERT INTO Departments (department_name)
VALUES ('Computer Science'), ('IT'), ('Commerce');

INSERT INTO Students
(name, dob, gender, email, phone_number, address, admission_date, department_id)
VALUES
('Aarav Sharma','2005-04-12','Male','aarav@example.com','9876500001','Surat','2023-06-15',1),
('Diya Patel','2005-08-20','Female','diya@example.com','9876500002','Surat','2023-06-20',1),
('Rohan Shah','2004-12-02','Male','rohan@example.com','9876500003','Vadodara','2022-06-18',2),
('Meera Joshi','2005-02-14','Female','meera@example.com','9876500004','Surat','2023-07-01',1);

INSERT INTO Faculty (name,email,phone_number,department_id,experience_years)
VALUES
('Neha Verma','neha@example.com','9898000001',1,7),
('Amit Trivedi','amit@example.com','9898000002',2,4);

INSERT INTO Courses (course_name,faculty_id,department_id)
VALUES ('Database Management',1,1),('Python Programming',1,1),
       ('Web Development',2,2),('Computer Networks',NULL,1);

INSERT INTO Enrollments (student_id,course_id,enrollment_date)
VALUES (1,1,'2023-07-01'),(1,2,'2023-07-01'),
       (2,1,'2023-07-02'),(3,3,'2023-07-03'),(4,2,'2023-07-04');

INSERT INTO Attendance (student_id,course_id,attendance_date,status)
VALUES
(1,1,'2024-01-01','Present'),(1,1,'2024-01-02','Present'),
(2,1,'2024-01-01','Absent'),(2,1,'2024-01-02','Present'),
(3,3,'2024-01-01','Present'),(4,2,'2024-01-01','Late');

INSERT INTO Grades (student_id,course_id,marks_obtained,grade)
VALUES (1,1,95,'A+'),(1,2,91,'A+'),(2,1,68,'C'),
       (3,3,84,'A'),(4,2,87,'A');

-- CRUD examples
SELECT * FROM Students;

-- Students in Computer Science
SELECT s.name, d.department_name
FROM Students s JOIN Departments d USING (department_id)
WHERE d.department_name='Computer Science';

-- Top 10 students by average marks
SELECT s.name, ROUND(AVG(g.marks_obtained),2) AS average_marks
FROM Students s JOIN Grades g USING (student_id)
GROUP BY s.student_id, s.name
ORDER BY average_marks DESC LIMIT 10;

-- Attendance below 75%
SELECT s.name,
       ROUND(100*AVG(a.status IN ('Present','Late')),2) AS attendance_pct
FROM Students s JOIN Attendance a USING (student_id)
GROUP BY s.student_id, s.name
HAVING attendance_pct < 75;

-- Students alphabetically
SELECT name FROM Students ORDER BY name;

-- Student count per department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Departments d LEFT JOIN Students s USING (department_id)
GROUP BY d.department_id, d.department_name;

-- Average, highest and lowest marks per course
SELECT c.course_name, AVG(g.marks_obtained) AS average_marks,
       MAX(g.marks_obtained) AS highest_marks,
       MIN(g.marks_obtained) AS lowest_marks
FROM Courses c LEFT JOIN Grades g USING (course_id)
GROUP BY c.course_id, c.course_name;

-- Faculty not assigned to any course
SELECT f.name FROM Faculty f
WHERE NOT EXISTS (SELECT 1 FROM Courses c WHERE c.faculty_id=f.faculty_id);

-- Students with marks above the overall average
SELECT s.name, g.marks_obtained
FROM Students s JOIN Grades g USING (student_id)
WHERE g.marks_obtained > (SELECT AVG(marks_obtained) FROM Grades);

-- Faculty experience of at least 5 years
SELECT c.course_name, f.name
FROM Courses c JOIN Faculty f USING (faculty_id)
WHERE f.experience_years >= 5;

-- Date formatting and admission years
SELECT name, DATE_FORMAT(admission_date,'%d-%m-%Y') AS admission_date,
       TIMESTAMPDIFF(YEAR,admission_date,CURDATE()) AS years_since_admission
FROM Students;

-- String functions
SELECT UPPER(name) AS faculty_name FROM Faculty;
SELECT TRIM(name) AS student_name,
       COALESCE(email,'Email Not Provided') AS email FROM Students;

-- Rank students by average marks (MySQL 8+)
WITH averages AS (
  SELECT s.student_id,s.name,AVG(g.marks_obtained) AS avg_marks
  FROM Students s JOIN Grades g USING(student_id)
  GROUP BY s.student_id,s.name
)
SELECT name,ROUND(avg_marks,2) AS average_marks,
       RANK() OVER(ORDER BY avg_marks DESC) AS student_rank
FROM averages;

-- Performance levels using CASE
SELECT s.name,c.course_name,g.marks_obtained,
  CASE WHEN g.marks_obtained>90 THEN 'Excellent'
       WHEN g.marks_obtained BETWEEN 75 AND 90 THEN 'Good'
       ELSE 'Needs Improvement' END AS performance
FROM Grades g JOIN Students s USING(student_id)
JOIN Courses c USING(course_id);

-- Attendance categories using CASE
SELECT s.name,
 ROUND(100*AVG(a.status IN ('Present','Late')),2) AS attendance_pct,
 CASE WHEN 100*AVG(a.status IN ('Present','Late'))>80 THEN 'Regular'
      WHEN 100*AVG(a.status IN ('Present','Late'))>=50 THEN 'Irregular'
      ELSE 'Defaulter' END AS attendance_status
FROM Students s JOIN Attendance a USING(student_id)
GROUP BY s.student_id,s.name;
