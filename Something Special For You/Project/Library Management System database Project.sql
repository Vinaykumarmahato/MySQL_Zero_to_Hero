-- Create database
CREATE DATABASE IF NOT EXISTS LibraryManagementSystem; -- Yeh command LibraryManagementSystem naam ka naya database banata hai, agar pehle se nahi hai toh.

-- Istemal hone wale database
USE LibraryManagementSystem; -- Yeh command LibraryManagementSystem database ko istemal karta hai.

-- Table banane ke liye commands

-- Authors table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY, -- Authors table me author_id column hai jo ki unique identifier hai har author ke liye.
    name VARCHAR(100) NOT NULL, -- name column hai jo author ka naam store karta hai, NULL hone ki anumati nahi hai.
    biography TEXT, -- biography column hai jo author ki jeevani (biography) store karta hai.
    website VARCHAR(255) -- website column hai jo author ki website ka URL store karta hai.
);

-- Books table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY, -- Books table me book_id column hai jo ki unique identifier hai har book ke liye.
    title VARCHAR(255) NOT NULL, -- title column hai jo kitaab ka naam store karta hai, NULL hone ki anumati nahi hai.
    isbn VARCHAR(20), -- isbn column hai jo kitaab ka ISBN number store karta hai.
    publish_date DATE, -- publish_date column hai jo kitaab ka prakashan tarikh store karta hai.
    author_id INT, -- author_id column hai jo author ka unique identifier hai jo is kitaab ke likhne wale hai.
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE SET NULL -- author_id column foreign key hai jo Authors table ki author_id column se jura hua hai. Agar author delete ho jata hai toh NULL set hota hai.
);

-- Members table
CREATE TABLE IF NOT EXISTS Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY, -- Members table me member_id column hai jo ki unique identifier hai har member ke liye.
    name VARCHAR(100) NOT NULL, -- name column hai jo member ka naam store karta hai, NULL hone ki anumati nahi hai.
    email VARCHAR(100), -- email column hai jo member ka email address store karta hai.
    phone VARCHAR(20), -- phone column hai jo member ka phone number store karta hai.
    address TEXT -- address column hai jo member ka postal address store karta hai.
);

-- Transactions table
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY, -- Transactions table me transaction_id column hai jo ki unique identifier hai har transaction ke liye.
    book_id INT, -- book_id column hai jo transaction me shamil kitaab ka unique identifier hai.
    member_id INT, -- member_id column hai jo transaction me shamil member ka unique identifier hai.
    issue_date DATE, -- issue_date column hai jo transaction ki kitab jari karne ki tarikh ko store karta hai.
    return_date DATE, -- return_date column hai jo transaction ki kitab vapas karne ki tarikh ko store karta hai.
    fine DECIMAL(10,2), -- fine column hai jo agar kitaab ko deri se vapas kiya gaya hai to fine ka raashi store karta hai.
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE, -- book_id column foreign key hai jo Books table ki book_id column se jura hua hai. Agar kitaab delete ho jati hai to transaction bhi delete hota hai.
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE -- member_id column foreign key hai jo Members table ki member_id column se jura hua hai. Agar member delete ho jata hai to transaction bhi delete hota hai.
);

-- CRUD (Create, Read, Update, Delete) operations ke liye stored procedures banane ke commands

-- Insert Author procedure
DELIMITER //

CREATE PROCEDURE InsertAuthor(
    IN p_name VARCHAR(100), -- p_name parameter hai jo procedure ke through author ka naam input leta hai.
    IN p_biography TEXT, -- p_biography parameter hai jo procedure ke through author ki jeevani input leta hai.
    IN p_website VARCHAR(255) -- p_website parameter hai jo procedure ke through author ki website URL input leta hai.
)
BEGIN
    INSERT INTO Authors (name, biography, website) VALUES (p_name, p_biography, p_website); -- Authors table me naya author insert karta hai.
END //

DELIMITER ;

-- Insert Book procedure
DELIMITER //

CREATE PROCEDURE InsertBook(
    IN p_title VARCHAR(255), -- p_title parameter hai jo procedure ke through kitaab ka naam input leta hai.
    IN p_isbn VARCHAR(20), -- p_isbn parameter hai jo procedure ke through kitaab ka ISBN input leta hai.
    IN p_publish_date DATE, -- p_publish_date parameter hai jo procedure ke through kitaab ka prakashan tarikh input leta hai.
    IN p_author_id INT -- p_author_id parameter hai jo procedure ke through likhne wale author ka unique identifier input leta hai.
)
BEGIN
    INSERT INTO Books (title, isbn, publish_date, author_id) VALUES (p_title, p_isbn, p_publish_date, p_author_id); -- Books table me nayi kitaab insert karta hai.
END //

DELIMITER ;

-- Insert Member procedure
DELIMITER //

CREATE PROCEDURE InsertMember(
    IN p_name VARCHAR(100), -- p_name parameter hai jo procedure ke through member ka naam input leta hai.
    IN p_email VARCHAR(100), -- p_email parameter hai jo procedure ke through member ka email input leta hai.
    IN p_phone VARCHAR(20), -- p_phone parameter hai jo procedure ke through member ka phone number input leta hai.
    IN p_address TEXT -- p_address parameter hai jo procedure ke through member ka postal address input leta hai.
)
BEGIN
    INSERT INTO Members (name, email, phone, address) VALUES (p_name, p_email, p_phone, p_address); -- Members table me naya member insert karta hai.
END //

DELIMITER ;

-- Insert Transaction procedure
DELIMITER //

CREATE PROCEDURE InsertTransaction(
    IN p_book_id INT, -- p_book_id parameter hai jo procedure ke through transaction me shamil kitaab ka unique identifier input leta hai.
    IN p_member_id INT, -- p_member_id parameter hai jo procedure ke through transaction me shamil member ka unique identifier input leta hai.
    IN p_issue_date DATE, -- p_issue_date parameter hai jo procedure ke through transaction ki kitab jari karne ki tarikh input leta hai.
    IN p_return_date DATE -- p_return_date parameter hai jo procedure ke through transaction ki kitab vapas karne ki tarikh input leta hai.
)
BEGIN
    INSERT INTO Transactions (book_id, member_id, issue_date, return_date) VALUES (p_book_id, p_member_id, p_issue_date, p_return_date); -- Transactions table me naya transaction insert karta hai.
END //

DELIMITER ;

-- Select procedures

-- Select all Authors procedure
DELIMITER //

CREATE PROCEDURE SelectAllAuthors()
BEGIN
    SELECT * FROM Authors; -- Sabhi authors ki list ko select karta hai.
END //

DELIMITER ;

-- Select all Books procedure
DELIMITER //

CREATE PROCEDURE SelectAllBooks()
BEGIN
    SELECT * FROM Books; -- Sabhi books ki list ko select karta hai.
END //

DELIMITER ;

-- Select all Members procedure
DELIMITER //

CREATE PROCEDURE SelectAllMembers()
BEGIN
    SELECT * FROM Members; -- Sabhi members ki list ko select karta hai.
END //

DELIMITER ;

-- Select all Transactions procedure
DELIMITER //

CREATE PROCEDURE SelectAllTransactions()
BEGIN
    SELECT * FROM Transactions; -- Sabhi transactions ki list ko select karta hai.
END //

DELIMITER ;

-- Update procedures

-- Update Book procedure
DELIMITER //

CREATE PROCEDURE UpdateBook(
    IN p_book_id INT, -- p_book_id parameter hai jo procedure ke through update karne wali kitaab ka unique identifier input leta hai.
    IN p_title VARCHAR(255), -- p_title parameter hai jo procedure ke through update karne wali kitaab ka naam input leta hai.
    IN p_isbn VARCHAR(20), -- p_isbn parameter hai jo procedure ke through update karne wali kitaab ka ISBN input leta hai.
    IN p_publish_date DATE, -- p_publish_date parameter hai jo procedure ke through update karne wali kitaab ka prakashan tarikh input leta hai.
    IN p_author_id INT -- p_author_id parameter hai jo procedure ke through update karne wali kitaab ke likhne wale author ka unique identifier input leta hai.
)
BEGIN
    UPDATE Books SET title = p_title, isbn = p_isbn, publish_date = p_publish_date, author_id = p_author_id WHERE book_id = p_book_id; -- Books table me ek specific book ko update karta hai.
END //

DELIMITER ;

-- Update Member procedure
DELIMITER //

CREATE PROCEDURE UpdateMember(
    IN p_member_id INT, -- p_member_id parameter hai jo procedure ke through update karne wale member ka unique identifier input leta hai.
    IN p_name VARCHAR(100), -- p_name parameter hai jo procedure ke through update karne wale member ka naam input leta hai.
    IN p_email VARCHAR(100), -- p_email parameter hai jo procedure ke through update karne wale member ka email input leta hai.
        IN p_phone VARCHAR(20), -- p_phone parameter hai jo procedure ke through update karne wale member ka phone number input leta hai.
    IN p_address TEXT -- p_address parameter hai jo procedure ke through update karne wale member ka postal address input leta hai.
)
BEGIN
    UPDATE Members SET name = p_name, email = p_email, phone = p_phone, address = p_address WHERE member_id = p_member_id; -- Members table me ek specific member ko update karta hai.
END //

DELIMITER ;

-- Update Transaction procedure
DELIMITER //

CREATE PROCEDURE UpdateTransaction(
    IN p_transaction_id INT, -- p_transaction_id parameter hai jo procedure ke through update karne wale transaction ka unique identifier input leta hai.
    IN p_book_id INT, -- p_book_id parameter hai jo procedure ke through update karne wali transaction me shamil kitaab ka unique identifier input leta hai.
    IN p_member_id INT, -- p_member_id parameter hai jo procedure ke through update karne wali transaction me shamil member ka unique identifier input leta hai.
    IN p_issue_date DATE, -- p_issue_date parameter hai jo procedure ke through update karne wali transaction ki kitab jari karne ki tarikh input leta hai.
    IN p_return_date DATE -- p_return_date parameter hai jo procedure ke through update karne wali transaction ki kitab vapas karne ki tarikh input leta hai.
)
BEGIN
    UPDATE Transactions SET book_id = p_book_id, member_id = p_member_id, issue_date = p_issue_date, return_date = p_return_date WHERE transaction_id = p_transaction_id; -- Transactions table me ek specific transaction ko update karta hai.
END //

DELIMITER ;

-- Delete procedures

-- Delete Author procedure
DELIMITER //

CREATE PROCEDURE DeleteAuthor(
    IN p_author_id INT -- p_author_id parameter hai jo procedure ke through delete karne wale author ka unique identifier input leta hai.
)
BEGIN
    DELETE FROM Authors WHERE author_id = p_author_id; -- Authors table se ek specific author ko delete karta hai.
END //

DELIMITER ;

-- Delete Book procedure
DELIMITER //

CREATE PROCEDURE DeleteBook(
    IN p_book_id INT -- p_book_id parameter hai jo procedure ke through delete karne wali kitaab ka unique identifier input leta hai.
)
BEGIN
    DELETE FROM Books WHERE book_id = p_book_id; -- Books table se ek specific book ko delete karta hai.
END //

DELIMITER ;

-- Delete Member procedure
DELIMITER //

CREATE PROCEDURE DeleteMember(
    IN p_member_id INT -- p_member_id parameter hai jo procedure ke through delete karne wale member ka unique identifier input leta hai.
)
BEGIN
    DELETE FROM Members WHERE member_id = p_member_id; -- Members table se ek specific member ko delete karta hai.
END //

DELIMITER ;

-- Delete Transaction procedure
DELIMITER //

CREATE PROCEDURE DeleteTransaction(
    IN p_transaction_id INT -- p_transaction_id parameter hai jo procedure ke through delete karne wale transaction ka unique identifier input leta hai.
)
BEGIN
    DELETE FROM Transactions WHERE transaction_id = p_transaction_id; -- Transactions table se ek specific transaction ko delete karta hai.
END //

DELIMITER ;

-- Examples of usage:

-- Ek author insert karna
CALL InsertAuthor('Stephen King', 'Stephen King ek prasiddh lekhak hai jo unki kahaniyo aur daravne upanyaso ke liye jaane jaate hai.', 'https://www.stephenking.com');

-- Ek kitaab insert karna
CALL InsertBook('IT', '9781982123617', '1986-09-15', 1);

-- Ek member insert karna
CALL InsertMember('John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA');

-- Ek transaction insert karna
CALL InsertTransaction(1, 1, '2024-06-28', '2024-07-05');

-- Sabhi authors ko select karna
CALL SelectAllAuthors();

-- Ek kitaab ko update karna
CALL UpdateBook(1, 'IT (Updated)', '9781982123617', '1986-09-15', 1);

-- Ek member ko delete karna
CALL DeleteMember(1);

-- Sabhi books ko select karna
CALL SelectAllBooks();

-- Ek author ko delete karna
CALL DeleteAuthor(1);

-- Procedures ko drop karna (yeh optional hai istemal ke baad)
DROP PROCEDURE IF EXISTS InsertAuthor, InsertBook, InsertMember, InsertTransaction, 
SelectAllAuthors, SelectAllBooks, SelectAllMembers, SelectAllTransactions, 
UpdateBook, UpdateMember, UpdateTransaction, DeleteAuthor, DeleteBook, DeleteMember, DeleteTransaction;


