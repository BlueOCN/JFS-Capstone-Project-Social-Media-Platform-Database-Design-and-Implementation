

/*
    Database Schema
*/

-- Create a MySQL database named SocialMediaPlatform.

-- Design tables for Users (user_id, username, email, password, date_of_birth, profile_picture)
-- Design tables for Posts (post_id, user_id, post_text, post_date, media_url)
-- Design tables for Comments (comment_id, post_id, user_id, comment_text, comment_date)
-- Design tables for Likes (like_id, post_id, user_id, like_date)
-- Design tables for Follows (follower_id, following_id, follow_date)
-- Design tables for Messages (message_id, sender_id, receiver_id, message_text, message_date, is_read)
-- Design tables for Notifications (notification_id, user_id, notification_text, notification_date, is_read)


/*
    Insert Sample Data
*/

-- Populate the tables with diverse and extensive sample data.
-- Include various users, posts, comments, likes, follows, messages, and notifications.


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
