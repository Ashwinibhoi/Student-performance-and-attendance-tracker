# 🎓 Student Performance & Attendance Tracker

### A MySQL Database Management Project

A relational database project designed to manage student records, faculty information, course enrollments, attendance tracking, and academic performance using MySQL.

---

## 📌 Project Overview

The **Student Performance & Attendance Tracker** helps educational institutions organize student information and analyze academic performance through structured database tables and SQL queries.

This project demonstrates fundamental and advanced SQL concepts, including CRUD operations, joins, subqueries, aggregate functions, window functions, and `CASE` expressions.

## 🎯 Objectives

- Manage student and faculty records.
- Organize departments and courses.
- Track student enrollments and daily attendance.
- Store and analyze student marks and grades.
- Calculate attendance percentages.
- Generate academic reports using SQL.
- Maintain data consistency through primary and foreign keys.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| MySQL | Database management |
| SQL | Data manipulation and reporting |
| MySQL Workbench | Database development and query execution |

**Recommended Version:** MySQL 8.0+

## 🗄️ Database Information

**Database Name:** `StudentTracker`

```sql
CREATE DATABASE IF NOT EXISTS StudentTracker;
USE StudentTracker;
```

## 📂 Database Schema

The project contains seven relational tables.

| Table | Description |
|---|---|
| `Departments` | Department names and IDs |
| `Students` | Student personal and admission details |
| `Faculty` | Faculty details and experience |
| `Courses` | Course and faculty assignment details |
| `Enrollments` | Student course registrations |
| `Attendance` | Daily attendance records |
| `Grades` | Student marks and grades |

### 🔗 Relationships

- Departments → Students
- Departments → Faculty
- Departments → Courses
- Faculty → Courses
- Students → Enrollments
- Courses → Enrollments
- Students → Attendance and Grades
- Courses → Attendance and Grades

## 📊 Sample Database Records

The provided SQL script inserts the following sample data:

| Record Type | Total |
|---|---:|
| Departments | 3 |
| Students | 4 |
| Faculty Members | 2 |
| Courses | 4 |
| Enrollments | 5 |
| Attendance Records | 6 |
| Grade Records | 5 |

## ⚙️ SQL Concepts Implemented

### 1. CRUD Operations
- `INSERT` — Add new records
- `SELECT` — Retrieve records
- `UPDATE` — Modify existing records
- `DELETE` — Remove records

### 2. Filtering and Sorting
- `WHERE`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `AND`, `OR`, `NOT`

### 3. Aggregate Functions
- `COUNT()`
- `SUM()`
- `AVG()`
- `MAX()`
- `MIN()`

### 4. Joins and Subqueries
- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `UNION`
- Nested queries and `NOT EXISTS`

### 5. Date and String Functions
- `MONTH()`
- `DATE_FORMAT()`
- `TIMESTAMPDIFF()`
- `UPPER()`
- `TRIM()`
- `COALESCE()`

### 6. Advanced SQL
- Common Table Expressions (CTEs)
- Window functions using `RANK()`
- Running totals and cumulative attendance
- Conditional logic using `CASE`

## 📈 Key Features

- Student record management
- Faculty and course management
- Duplicate enrollment prevention
- Attendance percentage calculation
- Student marks analysis
- Top-performing student reports
- Department-wise student counts
- Course-wise average, highest, and lowest marks
- Attendance and performance classification

## 🚀 How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench and connect to your database server.
3. Open the `student_tracker.sql` script.
4. Execute the script to create the database, tables, and sample records.
5. Run the required SQL queries.
6. Review the results in the query output panel.

> **Important:** The script drops and recreates the project tables. Back up any important data before executing it again.

## 📁 Project Structure

```text
Student-Performance-Attendance-Tracker/
│
├── student_tracker.sql
└── README.md
```

## 📝 Attendance Rules

The supplied SQL queries count `Present` and `Late` as attended records.

| Attendance Percentage | Status |
|---|---|
| Above 80% | Regular |
| 50%–80%, inclusive | Irregular |
| Below 50% | Defaulter |

## 🎓 Learning Outcomes

Through this project, learners can practice:

- Designing relational databases.
- Creating tables with keys and constraints.
- Writing SQL queries for real-world requirements.
- Joining and analyzing data across multiple tables.
- Generating reports from academic records.
- Using advanced MySQL functions.

## ✅ Conclusion

The Student Performance & Attendance Tracker demonstrates how MySQL can be used to organize academic records, monitor student attendance, evaluate marks, and generate meaningful reports.

This project provides practical experience with database design, SQL programming, data integrity, and advanced query techniques.

---

**Project:** Student Performance & Attendance Tracker  
**Database:** MySQL  
**Category:** Database Management System (DBMS)
