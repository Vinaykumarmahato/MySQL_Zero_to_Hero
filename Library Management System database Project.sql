-- Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Create Tables
CREATE TABLE Authors (
   AuthorID INT AUTO_INCREMENT PRIMARY KEY,
   Name VARCHAR(100) NOT NULL,
   Bio TEXT
);

CREATE TABLE Books (
   BookID INT AUTO_INCREMENT PRIMARY KEY,
   Title VARCHAR(255) NOT NULL,
   AuthorID INT,
   PublicationYear INT,
   Genre VARCHAR(100),
   FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
   MemberID INT AUTO_INCREMENT PRIMARY KEY,
   Name VARCHAR(100) NOT NULL,
   Email VARCHAR(100),
   Phone VARCHAR(15),
   Address TEXT
);

CREATE TABLE BorrowRecords (
   RecordID INT AUTO_INCREMENT PRIMARY KEY,
   BookID INT,
   MemberID INT,
   BorrowDate DATE,
   ReturnDate DATE,
   FOREIGN KEY (BookID) REFERENCES Books(BookID),
   FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Fines (
   FineID INT AUTO_INCREMENT PRIMARY KEY,
   MemberID INT,
   Amount DECIMAL(10, 2),
   FineDate DATE,
   Paid BOOLEAN DEFAULT FALSE,
   FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert Sample Data
INSERT INTO Authors (Name, Bio) VALUES
('Vinay Kumar', 'Author of Harry Potter series'),
('Arjun Sahani', 'Author of A Song of Ice and Fire series');

INSERT INTO Books (Title, AuthorID, PublicationYear, Genre) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 1997, 'Fantasy'),
('A Game of Thrones', 2, 1996, 'Fantasy'),
('To Kill a Mockingbird', 3, 1960, 'Classic');

INSERT INTO Members (Name, Email, Phone, Address) VALUES
('Ankush', 'ankush@gmail.com', '1234567890', '123 Main St'),
('Rohit Kumar', 'rohit@gmail.com.com', '0987654321', '456 Oak St'),
('Vinay Kumar', 'vinaykumar860964@gmail.com', '9876543210', '789 Elm St');

INSERT INTO BorrowRecords (BookID, MemberID, BorrowDate, ReturnDate) VALUES
(1, 1, '2023-01-15', '2023-01-22'),
(2, 2, '2023-02-10', NULL),
(3, 3, '2023-03-05', NULL);

INSERT INTO Fines (MemberID, Amount, FineDate, Paid) VALUES
(1, 5.00, '2023-01-23', TRUE),
(2, 2.50, '2023-02-20', FALSE),
(3, 1.00, '2023-03-15', FALSE);

-- Sample Queries
-- List of books by a specific author
SELECT Title FROM Books WHERE AuthorID = 1;

-- Currently borrowed books
SELECT B.Title, M.Name FROM BorrowRecords BR
JOIN Books B ON BR.BookID = B.BookID
JOIN Members M ON BR.MemberID = M.MemberID
WHERE BR.ReturnDate IS NULL;

-- Overdue fines calculation
SELECT M.Name, SUM(F.Amount) AS TotalFines FROM Fines F
JOIN Members M ON F.MemberID = M.MemberID
WHERE F.Paid = FALSE
GROUP BY M.Name;
