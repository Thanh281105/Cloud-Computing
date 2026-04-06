-- =============================================
-- MyMiniCloud - Database Initialization
-- Phase 1: clouddb + notes table
-- Phase 2: studentdb + students table
-- =============================================

-- Phase 1: Main database
CREATE DATABASE IF NOT EXISTS clouddb;
USE clouddb;

CREATE TABLE IF NOT EXISTS notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO notes (title, content) VALUES
('Welcome to MyMiniCloud', 'This is the first note in our cloud database.'),
('Docker Setup', 'All 9 services are running in Docker containers.'),
('Monitoring', 'Prometheus and Grafana are configured for system monitoring.');

-- Phase 2: Student database
CREATE DATABASE IF NOT EXISTS studentdb;
USE studentdb;

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL UNIQUE,
    fullname VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    major VARCHAR(100) NOT NULL
);

INSERT INTO students (student_id, fullname, dob, major) VALUES
('SV001', 'Nguyen Van A', '2002-01-15', 'Computer Science'),
('SV002', 'Tran Thi B', '2001-06-20', 'Information Technology'),
('SV003', 'Le Van C', '2003-03-10', 'Software Engineering'),
('SV004', 'Pham Thi D', '2002-09-05', 'Data Science'),
('SV005', 'Hoang Van E', '2001-12-25', 'Cyber Security');
