-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS E_library;

-- Select the database to use
USE E_library;

-- Create the Users table to store user information
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each user
    name VARCHAR(100) NOT NULL, -- User's full name
    email VARCHAR(100) NOT NULL UNIQUE, -- Unique email for each user
    password VARCHAR(255) NOT NULL, -- Hashed password for security
    signup_date DATETIME DEFAULT CURRENT_TIMESTAMP -- Timestamp of user registration
);

-- Create the Books table to store book details
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each book
    title VARCHAR(200) NOT NULL, -- Title of the book
    author VARCHAR(100) NOT NULL, -- Author of the book
    genre VARCHAR(50), -- Genre/category of the book
    publication_year INT(4), -- Year the book was published
    language VARCHAR(50) -- Language of the book
);

-- Create the Categories table to store book categories
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each category
    category_name VARCHAR(100) NOT NULL UNIQUE -- Unique category name
);

-- Create the Book_Categories table to link books with their respective categories
CREATE TABLE IF NOT EXISTS Book_Categories (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the record
    book_id INT NOT NULL, -- Reference to the book
    category_id INT NOT NULL, -- Reference to the category
    book_name VARCHAR(200) NOT NULL, -- Redundant but useful for quick queries
    category_name VARCHAR(100) NOT NULL, -- Redundant but useful for quick queries
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE, -- Ensures referential integrity
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Create the Reading_History table to track books read by users
CREATE TABLE IF NOT EXISTS Reading_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the record
    user_id INT NOT NULL, -- Reference to the user
    book_id INT NOT NULL, -- Reference to the book
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the user started reading the book
    end_date DATETIME, -- When the user finished reading the book
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Create the Reviews table to store user reviews and ratings for books
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the review
    user_id INT NOT NULL, -- Reference to the user who wrote the review
    book_id INT NOT NULL, -- Reference to the reviewed book
    rating TINYINT CHECK (rating BETWEEN 1 AND 5), -- Rating between 1 and 5
    review_text TEXT, -- User's review text
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- Timestamp of the review
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Create the Favorites table to store users' favorite books
CREATE TABLE IF NOT EXISTS Favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the record
    user_id INT NOT NULL, -- Reference to the user
    book_id INT NOT NULL, -- Reference to the book
    added_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- When the book was added to favorites
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);
