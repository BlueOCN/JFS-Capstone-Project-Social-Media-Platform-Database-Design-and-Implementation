-- Active: 1747454077714@@127.0.0.1@3306@socialmediaplatform


/*
    Database Schema
*/

-- Create a MySQL database named SocialMediaPlatform.
CREATE DATABASE SocialMediaPlatform;
SHOW DATABASES;
USE SocialMediaPlatform;

-- Design tables for Users (user_id, username, email, password, date_of_birth, profile_picture)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT, 
    username VARCHAR(50) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    password VARCHAR(255) NOT NULL CHECK(LENGTH(password) >= 8), 
    date_of_birth DATE NOT NULL, 
    profile_picture VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX(username),
    INDEX(email)
);

-- Design tables for Posts (post_id, user_id, post_text, post_date, media_url)
CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT, 
    user_id INT NULL, 
    post_text TEXT NOT NULL CHECK (LENGTH(post_text) > 0), 
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    media_url VARCHAR(500),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    INDEX(user_id)
);

-- Design tables for Comments (comment_id, post_id, user_id, comment_text, comment_date)
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT, 
    post_id INT NOT NULL, 
    user_id INT NULL, 
    comment_text TEXT NOT NULL CHECK (LENGTH(comment_text) > 0), 
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    INDEX(post_id),
    INDEX(user_id)
);

-- Design tables for Likes (like_id, post_id, user_id, like_date)
CREATE TABLE Likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT, 
    post_id INT NOT NULL, 
    user_id INT NULL, 
    like_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    UNIQUE(post_id, user_id),
    INDEX(post_id),
    INDEX(user_id)
);

-- Design tables for Follows (follower_id, following_id, follow_date)
CREATE TABLE Follows (
    follower_id INT NOT NULL, 
    following_id INT NOT NULL, 
    follow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (following_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX(follower_id),
    INDEX(following_id)
);

-- Design tables for Messages (message_id, sender_id, receiver_id, message_text, message_date, is_read)
CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT, 
    sender_id INT NULL, 
    receiver_id INT NULL, 
    message_text TEXT NOT NULL CHECK (LENGTH(message_text) > 0), 
    message_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    INDEX(sender_id),
    INDEX(receiver_id)
);

-- Design tables for Notifications (notification_id, user_id, notification_text, notification_date, is_read)
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT, 
    user_id INT NOT NULL, 
    notification_text TEXT NOT NULL CHECK (LENGTH(notification_text) > 0), 
    notification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX(user_id),
    INDEX(notification_date)
);

-- Verify table creation
SHOW TABLES;

-- Verify table details
DESCRIBE Users;
DESCRIBE Posts;
DESCRIBE Comments;
DESCRIBE Likes;
DESCRIBE Follows;
DESCRIBE Messages;
DESCRIBE Notifications;


/*
    Insert Sample Data
*/

-- Populate the tables with diverse and extensive sample data.

-- Include various users.
INSERT INTO Users (username, email, password, date_of_birth, profile_picture) VALUES
('Alice', 'alice@example.com', 'hashedpassword1', '1995-06-15', '/images/alice.jpg'),
('Bob', 'bob@example.com', 'hashedpassword2', '1990-08-22', '/images/bob.jpg'),
('Charlie', 'charlie@example.com', 'hashedpassword3', '1998-12-05', '/images/charlie.jpg');

-- Include posts.
INSERT INTO Posts (user_id, post_text, media_url) VALUES
(1, 'Hello World! My first post on this platform.', NULL),
(2, 'Just had an amazing meal. Anyone else love sushi?', '/images/sushi.jpg'),
(3, 'Feeling great today! Who else is having a good day?', NULL);

-- Include comments.
INSERT INTO Comments (post_id, user_id, comment_text) VALUES
(1, 2, 'Welcome, Alice! Excited to see your posts!'),
(2, 3, 'Sushi is the best! Where did you eat?'),
(3, 1, 'Glad to hear! Hope you have an amazing day!');

-- Include likes.
INSERT INTO Likes (post_id, user_id) VALUES
(1, 3),
(2, 1),
(3, 2);

-- Include follows.
INSERT INTO Follows (follower_id, following_id) VALUES
(1, 2),
(2, 3),
(3, 1);

-- Include messages.
INSERT INTO Messages (sender_id, receiver_id, message_text, is_read) VALUES
(1, 2, 'Hey Bob, how are you?', 0),
(2, 3, 'Charlie, let’s grab coffee sometime!', 1),
(3, 1, 'Alice, what’s up?', 0);

-- Include notifications.
INSERT INTO Notifications (user_id, notification_text, is_read) VALUES
(1, 'Bob started following you.', 0),
(2, 'Charlie liked your post.', 1),
(3, 'Alice commented on your post.', 0);

-- Verify tables
SELECT * FROM Users;
SELECT * FROM Posts;
SELECT * FROM Comments;
SELECT * FROM Likes;
SELECT * FROM Follows;
SELECT * FROM Messages;
SELECT * FROM Notifications;


/*
    Queries
*/

-- Retrieve the posts and activities of a user's timeline.
-- Retrieve the comments and likes for a specific post.
-- Retrieve the list of followers for a user.
-- Retrieve unread messages for a user.
-- Retrieve the most liked posts.
-- Retrieve the latest notifications for a user.


/*
    Data Modification
*/

-- Add a new post to the platform.
-- Comment on a post.
-- Update user profile information.
-- Remove a like from a post.


/*
    Complex Queries
*/

-- Identify users with the most followers.
-- Find the most active users based on post count and interaction.
-- Calculate the average number of comments per post.

/*
    Advanced Topics
*/

-- Automatically notify users of new messages.
-- Update post counts and follower counts for users.
-- Generate personalized recommendations for users to follow.
