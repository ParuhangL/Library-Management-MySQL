CREATE DATABASE LibraryDB;
USE LibraryDB;

# Create a Book table
CREATE TABLE Book(
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    author VARCHAR(50),
    genre VARCHAR(50),
    published_year INT,
    copies_available INT DEFAULT 1
);

# Create member table
CREATE TABLE Members (
	member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR (15) UNIQUE,
    joined_date DATE DEFAULT (CURDATE())
);

# Create borrowed book table
CREATE TABLE BorrowedBook (
	borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE DEFAULT (CURDATE()),
    return_date DATE,
    FOREIGN KEY(book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    FOREIGN KEY(member_id) REFERENCES Members(member_id) ON DELETE CASCADE
);

INSERT INTO Book (title, author, genre, published_year, copies_available) 
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 3),
('1984', 'George Orwell', 'Dystopian', 1949, 5),
('The Alchemist', 'Paulo Coelho', 'Philosophical', 1988, 2);

INSERT INTO Members (name, email, phone) 
VALUES 
('John Doe', 'john@example.com', '1234567890'),
('Jane Smith', 'jane@example.com', '9876543210');

-- # View all Books
SELECT * FROM Book

# Transaction to borrow book
START TRANSACTION;
INSERT INTO borrowedbook(book_id, member_id) VALUES (1, 1);
UPDATE book
SET copies_available = copies_available - 1
WHERE book_id = 1;
COMMIT;

# List book borrowed by a specific member
SELECT m.name, b.title, br.borrow_date, br.return_date
FROM borrowedbook AS br
JOIN book AS b ON br.book_id = b.book_id
JOIN members AS m ON br.member_id = m.member_id
WHERE m.member_id= 1;

# Return a borrowed book
UPDATE borrowedbook
SET return_date = CURDATE()
WHERE borrow_id = 1;

UPDATE book
SET copies_available = copies_available + 1
WHERE book_id = 1;

