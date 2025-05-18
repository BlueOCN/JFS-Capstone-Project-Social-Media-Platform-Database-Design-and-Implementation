# JFS-Capstone-Project-Social-Media-Platform-Database-Design-and-Implementation
In this capstone project, you will design and implement a relational database for a comprehensive social media platform using MySQL. This project will strengthen your ability to develop a sophisticated database system capable of handling complex data structures and relationships found in real-world applications. You will tackle the core components of a social networking system, including managing user profiles, posts, comments, likes, messages, and notifications, while creating efficient queries for data retrieval and modification.

### Project Objective
Throughout this section, you will gain hands-on experience in

- Develop a complete relational database schema for a social media platform.
- Populate the database with diverse sample data to simulate realistic social media interactions.
- Write SQL queries to perform essential data retrieval, modifications, and complex operations.
- Implement advanced SQL features such as stored procedures and triggers for automated tasks and user notifications.

### Problem Statement
Design and implement a sophisticated relational database for a comprehensive social media platform using MySQL. The database should handle various aspects of a social networking system, including user profiles, posts, comments, likes, messages, and notifications.

## Requirements

### Database Schema

- Create a MySQL database named SocialMediaPlatform.
  
- Design tables for
  
  - Users (user_id, username, email, password, date_of_birth, profile_picture)
  - Posts (post_id, user_id, post_text, post_date, media_url)
  - Comments (comment_id, post_id, user_id, comment_text, comment_date)
  - Likes (like_id, post_id, user_id, like_date)
  - Follows (follower_id, following_id, follow_date)
  - Messages (message_id, sender_id, receiver_id, message_text, message_date, is_read)
  - Notifications (notification_id, user_id, notification_text, notification_date, is_read)

---

### Insert Sample Data

- Populate the tables with diverse and extensive sample data.
- Include various users, posts, comments, likes, follows, messages, and notifications.

---

### Queries
Write SQL queries for the following operations

- Retrieve the posts and activities of a user's timeline.
- Retrieve the comments and likes for a specific post.
- Retrieve the list of followers for a user.
- Retrieve unread messages for a user.
- Retrieve the most liked posts.
- Retrieve the latest notifications for a user.

---

### Data Modification
Implement SQL queries to

- Add a new post to the platform.
- Comment on a post.
- Update user profile information.
- Remove a like from a post.

---

### Complex Queries
Write complex SQL queries to

- Identify users with the most followers.
- Find the most active users based on post count and interaction.
- Calculate the average number of comments per post.

---

### Advanced Topics
Implement stored procedures or triggers to

- Automatically notify users of new messages.
- Update post counts and follower counts for users.
- Generate personalized recommendations for users to follow.

---

### Documentation
Provide comprehensive documentation that includes the database schema, sample data, and explanations for each query.
