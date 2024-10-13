-- Create database if not exists
CREATE DATABASE IF NOT EXISTS BlogCMSDB;

-- Use the database
USE BlogCMSDB;

-- Authors Table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each author
    author_name VARCHAR(100) NOT NULL, -- Author's name
    email VARCHAR(255) NOT NULL UNIQUE, -- Author's email (must be unique)
    bio TEXT, -- Author's biography
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the author record was created
);

-- Posts Table
CREATE TABLE IF NOT EXISTS Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each post
    title VARCHAR(255) NOT NULL, -- Post title
    content TEXT, -- Post content
    author_id INT, -- Author who wrote the post
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the post was created
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE -- Linking posts to authors
);

-- Comments Table
CREATE TABLE IF NOT EXISTS Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each comment
    post_id INT, -- Post to which this comment belongs
    commenter_name VARCHAR(100) NOT NULL, -- Name of the commenter
    comment TEXT, -- Comment text
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the comment was posted
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE -- Linking comments to posts
);

-- Procedures for CRUD operations

-- Procedure to insert author
DELIMITER //

CREATE PROCEDURE InsertAuthor(
    IN p_name VARCHAR(100), -- Input parameter: author name
    IN p_email VARCHAR(255), -- Input parameter: author email
    IN p_bio TEXT -- Input parameter: author biography
)
BEGIN
    INSERT INTO Authors (author_name, email, bio)
    VALUES (p_name, p_email, p_bio);
END //

DELIMITER ;

-- Procedure to select author by id
DELIMITER //

CREATE PROCEDURE SelectAuthorById(
    IN p_author_id INT -- Input parameter: author id
)
BEGIN
    SELECT * FROM Authors WHERE author_id = p_author_id;
END //

DELIMITER ;

-- Procedure to update author
DELIMITER //

CREATE PROCEDURE UpdateAuthor(
    IN p_author_id INT, -- Input parameter: author id to update
    IN p_name VARCHAR(100), -- Input parameter: new author name
    IN p_email VARCHAR(255), -- Input parameter: new author email
    IN p_bio TEXT -- Input parameter: new author biography
)
BEGIN
    UPDATE Authors
    SET author_name = p_name,
        email = p_email,
        bio = p_bio
    WHERE author_id = p_author_id;
END //

DELIMITER ;

-- Procedure to delete author
DELIMITER //

CREATE PROCEDURE DeleteAuthor(
    IN p_author_id INT -- Input parameter: author id to delete
)
BEGIN
    DELETE FROM Authors WHERE author_id = p_author_id;
END //

DELIMITER ;

-- Procedure to insert post
DELIMITER //

CREATE PROCEDURE InsertPost(
    IN p_title VARCHAR(255), -- Input parameter: post title
    IN p_content TEXT, -- Input parameter: post content
    IN p_author_id INT -- Input parameter: author id who wrote the post
)
BEGIN
    INSERT INTO Posts (title, content, author_id)
    VALUES (p_title, p_content, p_author_id);
END //

DELIMITER ;

-- Procedure to select post by id
DELIMITER //

CREATE PROCEDURE SelectPostById(
    IN p_post_id INT -- Input parameter: post id
)
BEGIN
    SELECT * FROM Posts WHERE post_id = p_post_id;
END //

DELIMITER ;

-- Procedure to update post
DELIMITER //

CREATE PROCEDURE UpdatePost(
    IN p_post_id INT, -- Input parameter: post id to update
    IN p_title VARCHAR(255), -- Input parameter: new post title
    IN p_content TEXT -- Input parameter: new post content
)
BEGIN
    UPDATE Posts
    SET title = p_title,
        content = p_content
    WHERE post_id = p_post_id;
END //

DELIMITER ;

-- Procedure to delete post
DELIMITER //

CREATE PROCEDURE DeletePost(
    IN p_post_id INT -- Input parameter: post id to delete
)
BEGIN
    DELETE FROM Posts WHERE post_id = p_post_id;
END //

DELIMITER ;

-- Procedure to insert comment
DELIMITER //

CREATE PROCEDURE InsertComment(
    IN p_post_id INT, -- Input parameter: post id to comment on
    IN p_commenter_name VARCHAR(100), -- Input parameter: commenter name
    IN p_comment TEXT -- Input parameter: comment text
)
BEGIN
    INSERT INTO Comments (post_id, commenter_name, comment)
    VALUES (p_post_id, p_commenter_name, p_comment);
END //

DELIMITER ;

-- Procedure to select comments by post id
DELIMITER //

CREATE PROCEDURE SelectCommentsByPostId(
    IN p_post_id INT -- Input parameter: post id
)
BEGIN
    SELECT * FROM Comments WHERE post_id = p_post_id;
END //

DELIMITER ;

-- Example of usage:
-- Insert an author
CALL InsertAuthor('John Doe', 'john.doe@example.com', 'Writer and blogger.');

-- Select an author by id
CALL SelectAuthorById(1);

-- Update an author
CALL UpdateAuthor(1, 'Jane Smith', 'jane.smith@example.com', 'Experienced blogger and content creator.');

-- Delete an author
CALL DeleteAuthor(1);

-- Insert a post
CALL InsertPost('Introduction to Blogging', 'This is a sample blog post introducing blogging.', 1);

-- Select a post by id
CALL SelectPostById(1);

-- Update a post
CALL UpdatePost(1, 'Getting Started with Blogging', 'This is an updated blog post on how to start blogging.');

-- Delete a post
CALL DeletePost(1);

-- Insert a comment
CALL InsertComment(1, 'Guest User', 'Great article! Looking forward to more.');

-- Select comments for a post
CALL SelectCommentsByPostId(1);

-- Procedures drop (optional after usage)
DROP PROCEDURE IF EXISTS InsertAuthor, SelectAuthorById, UpdateAuthor, DeleteAuthor,
                      InsertPost, SelectPostById, UpdatePost, DeletePost,
                      InsertComment, SelectCommentsByPostId;

