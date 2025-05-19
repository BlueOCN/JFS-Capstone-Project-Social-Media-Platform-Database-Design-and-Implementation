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
    post_count INT NOT NULL DEFAULT 0,
    follower_count INT NOT NULL DEFAULT 0,
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
('Charlie', 'charlie@example.com', 'hashedpassword3', '1998-12-05', '/images/charlie.jpg'),
('David', 'david@example.com', 'hashedpassword4', '1993-04-17', '/images/david.jpg'),
('Emma', 'emma@example.com', 'hashedpassword5', '1989-10-30', '/images/emma.jpg'),
('Frank', 'frank@example.com', 'hashedpassword6', '2000-01-25', '/images/frank.jpg');


-- Include posts.
INSERT INTO Posts (user_id, post_text, media_url) VALUES
(1, 'Hello World! My first post on this platform.', NULL),
(2, 'Just had an amazing meal. Anyone else love sushi?', '/images/sushi.jpg'),
(3, 'Feeling great today! Who else is having a good day?', NULL);

-- Include comments.
INSERT INTO Comments (post_id, user_id, comment_text) VALUES
(1, 2, 'Welcome, Alice! Excited to see your posts!'),
(1, 2, 'Happy posting!'),
(2, 3, 'Sushi is the best! Where did you eat?'),
(3, 1, 'Glad to hear! Hope you have an amazing day!');

-- Include likes.
INSERT INTO Likes (post_id, user_id) VALUES
(1, 3),
(1, 2),
(2, 1),
(3, 2);

-- Include follows.
INSERT INTO Follows (follower_id, following_id) VALUES
(1, 2),
(2, 3),
(3, 1),
(4, 1);

-- Include messages.
INSERT INTO Messages (sender_id, receiver_id, message_text, is_read) VALUES
(1, 2, 'Hey Bob, how are you?', 0),
(2, 3, 'Charlie, let’s grab coffee sometime!', 1),
(3, 1, 'Alice, what’s up?', 0);

-- Include notifications.
INSERT INTO Notifications (user_id, notification_text, is_read) VALUES
(1, 'Bob started following you.', 0),
(1, 'This is a notification.', 0),
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
SELECT 
    p.post_id,
    p.post_text,
    p.post_date,
    p.media_url,
    u.username AS author,
    (SELECT GROUP_CONCAT(c.comment_text SEPARATOR ' | ') 
     FROM Comments c 
     WHERE c.post_id = p.post_id) AS all_comments,
    (SELECT GROUP_CONCAT(cu.username SEPARATOR ', ') 
     FROM Users cu 
     JOIN Comments c ON cu.user_id = c.user_id 
     WHERE c.post_id = p.post_id) AS commenters,
    (SELECT COUNT(DISTINCT l.user_id) 
     FROM Likes l 
     WHERE l.post_id = p.post_id) AS like_count
FROM Posts p
JOIN Users u ON p.user_id = u.user_id
WHERE p.user_id = 1
ORDER BY p.post_date DESC;

-- Retrieve the comments and likes for a specific post.
SELECT
    c.post_id,
    c.comment_id,
    c.comment_text,
    COUNT(l.like_id) AS post_total_likes
FROM Comments c
JOIN Likes l ON c.post_id = l.post_id
WHERE c.post_id = 1
GROUP BY c.comment_id
ORDER BY c.comment_date ASC;

-- Retrieve the list of followers for a user.
SELECT 
    u.user_id AS follower_id,
    u.username AS follower_username,
    f.following_id,
    u2.username AS following_username,
    f.follow_date
FROM Users u
JOIN Follows f ON u.user_id = f.follower_id
JOIN Users u2 ON f.following_id = u2.user_id
WHERE f.following_id = 1
ORDER BY f.follow_date ASC, u.username DESC;

-- Retrieve unread messages for a user.
SELECT * FROM Messages m
WHERE m.is_read = FALSE 
AND m.receiver_id = 1;

-- Retrieve the most liked posts.
SELECT 
    p.post_id,
    P.post_text,
    p.media_url,
    COUNT(DISTINCT like_id) AS total_likes

FROM Posts p
JOIN Likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY COUNT(DISTINCT like_id) DESC, p.post_id ASC
LIMIT 3;

-- Retrieve the latest notifications for a user.
SELECT * FROM notifications
WHERE user_id = 1
ORDER BY notification_date DESC
LIMIT 1;


/*
    Data Modification
*/

-- Add a new post to the platform.
INSERT INTO Posts (user_id, post_text, media_url) VALUES
(1, 'Happy Sunday everyone!', '/images/sunset.jpg');

-- Comment on a post.
INSERT INTO Comments (post_id, user_id, comment_text) VALUES
(4, 2, 'Happy Sunday, Alice!');

-- Update user profile information.
UPDATE Users
SET 
    username = 'Alice',
    email = 'alice@example.com',
    password = 'hashedpassword1',
    date_of_birth = '1995-06-15',
    profile_picture = '/images/alice.jpg'
WHERE user_id = 1;

-- Remove a like from a post.
DELETE FROM Likes
WHERE like_id = 4 AND post_id = 1
LIMIT 1;


/*
    Complex Queries
*/

-- Identify users with the most followers.
SELECT 
    f.following_id AS user_id,
    u.username,
    COUNT(f.follower_id) AS follower_count
FROM Follows f
JOIN Users u ON f.following_id = u.user_id
GROUP BY f.following_id, u.username
ORDER BY follower_count DESC, u.username ASC
LIMIT 3;

-- Find the most active users based on post count and interaction.
SELECT 
    u.user_id,
    u.username,
    COALESCE(comment_count, 0) AS comment_count,
    COALESCE(post_count, 0) AS post_count
FROM Users u
LEFT JOIN (
    SELECT user_id, COUNT(DISTINCT post_id) AS post_count
    FROM Posts
    GROUP BY user_id
) p ON u.user_id = p.user_id
LEFT JOIN (
    SELECT user_id, COUNT(DISTINCT comment_id) AS comment_count
    FROM Comments
    GROUP BY user_id
) c ON u.user_id = c.user_id
ORDER BY comment_count DESC, post_count DESC
LIMIT 5;

-- Calculate the average number of comments per post.
SELECT 
    (SELECT COUNT(*) FROM Comments) / 
    (SELECT COUNT(*) FROM Posts) AS avg_comments_per_post;


/*
    Advanced Topics
*/

-- Automatically notify users of new messages.
CREATE TRIGGER after_message_insert
AFTER INSERT ON Messages
FOR EACH ROW
INSERT INTO Notifications (user_id, notification_text, notification_date, is_read)
VALUES (NEW.receiver_id, CONCAT('New message from ', (SELECT username FROM Users WHERE user_id = NEW.sender_id)), NOW(), 0);


-- Update post counts and follower counts for users.
Update Users SET follower_count = (
    SELECT COUNT(*) FROM Follows WHERE following_id = user_id
);

UPDATE Users u SET u.post_count = (
    SELECT COUNT(*) FROM Posts p WHERE p.user_id = u.user_id
);

CREATE TRIGGER after_post_insert
AFTER INSERT ON Posts
FOR EACH ROW
UPDATE Users SET post_count = post_count + 1 WHERE user_id = NEW.user_id;

CREATE TRIGGER after_follows_insert
AFTER INSERT ON Follows
FOR EACH ROW
UPDATE Users SET follower_count = follower_count + 1 WHERE user_id = NEW.following_id;


-- Generate personalized recommendations for users to follow.
SELECT 
    f1.follower_id AS user_id,
    u.username AS recommended_user,
    COUNT(DISTINCT f2.follower_id) AS mutual_followers
FROM Follows f1
JOIN Follows f2 ON f1.following_id = f2.following_id
JOIN Users u ON f2.follower_id = u.user_id
WHERE f1.follower_id = 3
AND f2.follower_id != f1.follower_id
AND f2.follower_id NOT IN (SELECT following_id FROM Follows WHERE follower_id = f1.follower_id) -- Avoid already followed users
GROUP BY f2.follower_id, u.username
ORDER BY mutual_followers DESC
LIMIT 5;
