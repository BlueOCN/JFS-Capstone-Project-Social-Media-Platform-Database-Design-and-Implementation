# 📌 **Social Media Platform Database Documentation**
### **Version:** 1.0 | **Author:** Roberto | **Date:** May 2025

## 🔹 **Overview**
This documentation describes the **relational database design** for a social media platform using **MySQL**. It includes:
- **Database Schema**: Structured representation of tables.
- **Sample Data**: Real-world example records.
- **SQL Queries**: Essential database operations.
- **Stored Procedures & Triggers**: Automations for efficiency.
- **Reports & Analytics**: Key insights on platform activity.

---

## ✅ **Database Schema**
### **Users Table**
The `Users` table stores information about **registered users**, including personal details, security settings, and activity metrics.

- `user_id`: Unique identifier for each user.
- `username`: Custom name chosen by the user for their account.
- `email`: Unique email address used for login and communication.
- `password`: Securely stored, ensuring at least **8 characters** for strong authentication.
- `date_of_birth`: User's birthdate for profile personalization.
- `profile_picture`: URL linking to the user’s avatar or profile image.
- `post_count`: Tracks the total number of posts created by the user (**default: 0**).
- `follower_count`: Represents the number of users following the account (**default: 0**).
- `created_at`: Timestamp indicating when the account was first registered.
- `updated_at`: Automatically updates whenever user details are modified.
- **Indexes** on `username` and `email` ensure efficient user lookups.

📌 **Purpose:** Manages user account details for authentication, personalization, and social interactions within the platform.

---

#### **Posts Table**
The `Posts` table stores information about **user-generated content**, including text updates and media attachments.

- `post_id`: Unique identifier for each post.
- `user_id`: References the `Users` table (**nullable** to support deleted accounts).
- `post_text`: Text content of the post (**must not be empty** to ensure meaningful interaction).
- `post_date`: Timestamp indicating when the post was created.
- `updated_at`: Automatically updates whenever the post content is modified.
- `media_url`: Stores an optional image or video link attached to the post.
- **Foreign Key**: `user_id` links posts to their respective authors.
- **Indexes**: Optimized indexing on `user_id` ensures **efficient retrieval** of posts.

📌 **Purpose:** Enables users to share updates, multimedia, and engage with others through posts, fostering social interactions on the platform.

---

#### **Comments Table**
The `Comments` table stores information about **user interactions** on posts, allowing users to engage through discussions and feedback.

- `comment_id`: Unique identifier for each comment.
- `post_id`: References the `Posts` table, ensuring that each comment is linked to a valid post.
- `user_id`: References the `Users` table (**nullable to support deleted accounts or anonymous comments**).
- `comment_text`: Content of the comment (**must not be empty** to maintain meaningful discussion).
- `comment_date`: Timestamp indicating when the comment was created.
- `updated_at`: Automatically updates whenever the comment is modified.
- **Foreign Keys**:
  - `post_id` ensures that comments belong to valid posts (**deletes comments if the post is removed**).
  - `user_id` ensures comments are tied to users but allows **null values** for anonymous commenting.
- **Indexes**:
  - `post_id` helps retrieve all comments related to a specific post efficiently.
  - `user_id` optimizes queries involving user-specific comments.

📌 **Purpose:** Enables users to engage in discussions by commenting on posts, fostering community interaction within the platform.

---

#### **Likes Table**
The `Likes` table stores information about **user interactions** with posts, specifically tracking likes given by users.

- `like_id`: Unique identifier for each like interaction.
- `post_id`: References the `Posts` table, ensuring that each like is associated with a valid post.
- `user_id`: References the `Users` table (**nullable to support deleted accounts**).
- `like_date`: Timestamp indicating when the like was added.
- `updated_at`: Automatically updates whenever the like record is modified.
- **Foreign Keys**:
  - `post_id` ensures that likes belong to valid posts (**deletes likes if the post is removed**).
  - `user_id` ensures likes are tied to users but allows **null values** for accounts that no longer exist.
- **Unique Constraint**:
  - `UNIQUE(post_id, user_id)` prevents users from liking the same post multiple times.
- **Indexes**:
  - `post_id` helps efficiently retrieve all likes related to a post.
  - `user_id` optimizes queries involving user-specific likes.

📌 **Purpose:** Enables users to interact with posts through likes, promoting engagement and community interaction within the platform.

---

#### **Follows Table**
The `Follows` table stores information about **user connections**, enabling a social networking experience where users can follow others.

- `follower_id`: References the `Users` table, representing the user initiating the follow action.
- `following_id`: References the `Users` table, indicating the user being followed.
- `follow_date`: Timestamp indicating when the follow action occurred.
- **Primary Key**:
  - `(follower_id, following_id)` ensures uniqueness, preventing duplicate follow records.
- **Foreign Keys**:
  - `follower_id` ensures that the following action is linked to a valid user.
  - `following_id` ensures that users can only follow existing accounts.
  - **`ON DELETE CASCADE`** → If a user is deleted, their follow relationships are automatically removed.
- **Indexes**:
  - `follower_id` optimizes retrieval of users that a specific account follows.
  - `following_id` enhances query performance for followers of a specific user.

📌 **Purpose:** Enables users to follow others, creating connections and facilitating engagement across the platform.

---

#### **Messages Table**
The `Messages` table stores information about **direct user communications**, allowing private messaging between users.

- `message_id`: Unique identifier for each message.
- `sender_id`: References the `Users` table, representing the user who sent the message (**nullable to support deleted accounts**).
- `receiver_id`: References the `Users` table, indicating the recipient of the message (**nullable to support deleted accounts**).
- `message_text`: Content of the message (**must not be empty** to ensure meaningful communication).
- `message_date`: Timestamp indicating when the message was sent.
- `is_read`: Boolean flag (**0 = unread, 1 = read**) to track whether the recipient has opened the message.
- **Foreign Keys**:
  - `sender_id` ensures that messages are tied to existing users.
  - `receiver_id` ensures that messages are correctly linked to recipients.
  - **`ON DELETE SET NULL`** → If a user is deleted, their messages remain but are detached from an active account.
- **Indexes**:
  - `sender_id` optimizes retrieval of all messages sent by a user.
  - `receiver_id` enhances query performance for incoming messages.

📌 **Purpose:** Facilitates secure and efficient private communication between users, enhancing engagement within the platform.

---

#### **Notifications Table**
The `Notifications` table stores information about **system-generated alerts**, allowing users to receive important updates and interactions within the platform.

- `notification_id`: Unique identifier for each notification.
- `user_id`: References the `Users` table, ensuring the notification is associated with a valid user.
- `notification_text`: Message content of the notification (**must not be empty** to maintain meaningful alerts).
- `notification_date`: Timestamp indicating when the notification was generated.
- `is_read`: Boolean flag (**0 = unread, 1 = read**) to track whether the user has seen the notification.
- **Foreign Keys**:
  - `user_id` ensures notifications belong to active users.
  - **`ON DELETE CASCADE`** → If a user is deleted, their notifications are automatically removed.
- **Indexes**:
  - `user_id` optimizes retrieval of all notifications for a specific user.
  - `notification_date` enhances query performance for sorting and filtering notifications by timestamp.

📌 **Purpose:** Provides a structured way to deliver system alerts, message notifications, post interactions, and other events, ensuring users stay informed in real time.

## ✅ **Sample Data**

### ✅ Users
The `Users` table contains essential information about **registered individuals**, including their usernames, unique email addresses, securely stored passwords, and profile details. It plays a crucial role in user authentication, account management, and social interactions within the platform.

<div align="center">

| Username  | Email               | Password          | Date of Birth | Profile Picture          |
| --------- | ------------------- | ---------------- | ------------- | ------------------------- |
| Alice     | alice@example.com   | hashedpassword1  | 1995-06-15    | /images/alice.jpg        |
| Bob       | bob@example.com     | hashedpassword2  | 1990-08-22    | /images/bob.jpg          |
| Charlie   | charlie@example.com | hashedpassword3  | 1998-12-05    | /images/charlie.jpg      |
| David     | david@example.com   | hashedpassword4  | 1993-04-17    | /images/david.jpg        |
| Emma      | emma@example.com    | hashedpassword5  | 1989-10-30    | /images/emma.jpg         |
| Frank     | frank@example.com   | hashedpassword6  | 2000-01-25    | /images/frank.jpg        |

</div>

---

### ✅ Posts
The `Posts` table stores information about **user-generated content**, including text updates and media attachments. This table enables users to share personal thoughts, experiences, and multimedia, fostering social engagement within the platform.

<div align="center">

| User ID | Post Text                                              | Media URL            |
| ------- | ------------------------------------------------------ | --------------------- |
| 1       | Hello World! My first post on this platform.          | NULL                 |
| 2       | Just had an amazing meal. Anyone else love sushi?     | /images/sushi.jpg    |
| 3       | Feeling great today! Who else is having a good day?   | NULL                 |

</div>

---

### ✅ Comments
The `Comments` table stores **user interactions** with posts, allowing discussions and engagement within the platform. Each comment is tied to a specific post and user, facilitating meaningful exchanges between members.

<div align="center">

| Post ID | User ID | Comment Text                                       |
| ------- | ------- | -------------------------------------------------- |
| 1       | 2       | Welcome, Alice! Excited to see your posts!        |
| 1       | 2       | Happy posting!                                    |
| 2       | 3       | Sushi is the best! Where did you eat?             |
| 3       | 1       | Glad to hear! Hope you have an amazing day!       |

</div>

---

### ✅ Likes
The `Likes` table stores information about **user interactions** with posts, specifically tracking likes given by users. Each record represents a like action performed on a post by a user, enhancing engagement within the platform.

<div align="center">

| Post ID | User ID |
| ------- | ------- |
| 1       | 3       |
| 1       | 2       |
| 2       | 1       |
| 3       | 2       |

</div>

---

### ✅ Follows
The `Follows` table stores information about **user connections**, tracking relationships where one user follows another. This table enhances social networking by facilitating user engagement and interactions.

<div align="center">

| Follower ID | Following ID |
| ----------- | ------------ |
| 1           | 2            |
| 2           | 3            |
| 3           | 1            |
| 4           | 1            |

</div>

---

### ✅ Messages
The `Messages` table stores information about **direct user communications**, allowing private messaging between users. This table facilitates user engagement by enabling real-time conversations while tracking message status.

<div align="center">

| Sender ID | Receiver ID | Message Text                           | Is Read |
| --------- | ---------- | -------------------------------------- | ------- |
| 1         | 2          | Hey Bob, how are you?                  | 0       |
| 2         | 3          | Charlie, let’s grab coffee sometime!   | 1       |
| 3         | 1          | Alice, what’s up?                      | 0       |

</div>

---

### ✅ Notifications
The `Notifications` table stores information about **system-generated alerts**, keeping users informed about interactions and updates within the platform. This table allows users to stay engaged by tracking activities such as new followers, post likes, and comments.

<div align="center">

| User ID | Notification Text                  | Is Read |
| ------- | ---------------------------------- | ------- |
| 1       | Bob started following you.        | 0       |
| 1       | This is a notification.           | 0       |
| 2       | Charlie liked your post.          | 1       |
| 3       | Alice commented on your post.     | 0       |

</div>

## 🔍 SQL Queries

### ✅ Retrieve a user's timeline and activities
This query retrieves a **user's posts** along with associated **comments, commenters, and likes** from the `Posts` table. By filtering for `user_id = 1`, it efficiently compiles their timeline, including post details, interactions, and engagement metrics.

#### **Query Breakdown**
- Selects `post_id`, `post_text`, `post_date`, and optional `media_url` from the `Posts` table.
- Joins with `Users` to fetch the author's username.
- Aggregates all comments for each post using `GROUP_CONCAT` with a **separator (" | ")**.
- Retrieves a list of unique commenters for each post by joining `Users` with `Comments`.
- Counts the total number of likes per post, ensuring engagement tracking.

```SQL
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
```

📌 **Purpose:** This query compiles a **user's full timeline**, including posts, comments, commenters, and likes. It helps track engagement, analyze post popularity, and provide a **structured view of user activity** within the platform.

---

### ✅ Retrieve comments and likes for a specific post
This query retrieves all **comments** and the corresponding **like count** for a specified post from the `Comments` table. By filtering with `post_id = 1`, it efficiently compiles user interactions related to that post.

#### **Query Breakdown**
- Selects `post_id`, `comment_id`, and `comment_text` from the `Comments` table.
- Joins with the `Likes` table to count the total likes associated with each comment.
- Uses `COUNT(l.like_id)` to determine how many users liked the post.
- Applies `GROUP BY c.comment_id` to ensure distinct comments with corresponding like counts.
- Sorts the results in ascending order of `comment_date`, ensuring a chronological view of interactions.

```SQL
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
```

📌 **Purpose:** This query compiles a **complete view of a post's engagement**, including all comments and their respective like counts. It helps track discussions, analyze post popularity, and provide insights into user interactions within the platform.

---

### ✅ Retrieve a user's followers
This query retrieves a **list of users who follow a specific user** from the `Follows` table. By filtering for `following_id = 1`, it compiles details on followers, including their usernames and the date they started following.

#### **Query Breakdown**
- Selects `user_id` and `username` of followers.
- Joins the `Follows` table to establish follow relationships.
- Joins the `Users` table again to fetch the usernames of the followed accounts.
- Filters results to retrieve **followers of user_id = 1**.
- Sorts output **chronologically** by `follow_date`, then **alphabetically** by follower usernames.

```SQL
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
```

📌 **Purpose:** This query retrieves a **structured list of followers**, facilitating engagement analysis and social interaction tracking within the platform.

---

### ✅ Retrieve unread messages for a user
This query retrieves all **unread messages** for a specific user from the `Messages` table. By filtering with `receiver_id = 1`, it ensures that only messages **not marked as read** (`is_read = FALSE`) are fetched, allowing users to manage pending communications efficiently.

#### **Query Breakdown**
- Selects all columns (`*`) from the `Messages` table.
- Filters results by `is_read = FALSE` to retrieve **only unread messages**.
- Filters further by `receiver_id = 1` to target a specific user’s inbox.

```SQL
SELECT * FROM Messages m
WHERE m.is_read = FALSE 
AND m.receiver_id = 1;
```

📌 **Purpose:** This query enables **users to track unread messages**, ensuring effective communication management within the platform.

---

### ✅ Retrieve the most liked posts
This query retrieves the **top three most liked posts** from the `Posts` table by counting the unique likes each post has received. The results are ranked **in descending order** based on the total like count, ensuring the most popular posts are displayed first.

#### **Query Breakdown**
- Selects the `post_id`, `post_text`, and optional `media_url` from the `Posts` table.
- Counts the **distinct `like_id`** for each post to determine total likes.
- Groups results by `post_id` to compute individual like counts.
- Orders posts **by total likes in descending order**, ensuring highly engaged content appears first.
- Uses `LIMIT 3` to retrieve only the **top three posts**.

```SQL
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
```

📌 **Purpose:** This query helps identify the **most popular posts**, enhancing analytics and engagement tracking. It is valuable for social media insights, trend analysis, and content optimization.

---

### ✅ Retrieve the latest notification for a user
This query retrieves the **most recent notification** for a specified user from the `Notifications` table. By filtering for `user_id = 1` and ordering by `notification_date DESC`, it ensures that the latest system alert or interaction appears at the top.

#### **Query Breakdown**
- Selects all columns (`*`) from the `Notifications` table.
- Filters results to display **only notifications belonging to user_id = 1**.
- Orders notifications **in descending order** (`DESC`) based on the timestamp, ensuring the most recent alert is shown first.
- Uses `LIMIT 1` to retrieve **only the latest notification**.

```SQL
SELECT * FROM notifications
WHERE user_id = 1
ORDER BY notification_date DESC
LIMIT 1;
```

📌 **Purpose:** This query helps **users stay updated with their latest notification**, ensuring timely engagement and interaction tracking within the platform.

## 🔍 Data Modification

### ✅ Add a new post
This query **inserts a new post** into the `Posts` table, allowing users to share text updates along with optional media attachments. By specifying the `user_id`, `post_text`, and `media_url`, the platform records the post details and associates them with the respective author.

#### **Query Breakdown**
- `user_id`: Identifies the user who created the post.
- `post_text`: Stores the content of the post.
- `media_url`: Holds the file path of an optional image or video.

```SQL
INSERT INTO Posts (user_id, post_text, media_url) VALUES
(1, 'Happy Sunday everyone!', '/images/sunset.jpg');
```

---

### ✅ Add a comment to a post
This query **inserts a new comment** into the `Comments` table, allowing users to engage with posts through discussions and feedback. By specifying the `post_id`, `user_id`, and `comment_text`, the platform records the interaction and associates it with the relevant post and user.

#### **Query Breakdown**
- `post_id`: Identifies the post being commented on.
- `user_id`: References the user who is making the comment.
- `comment_text`: Stores the content of the user's comment.

```SQL
INSERT INTO Comments (post_id, user_id, comment_text) VALUES
(4, 2, 'Happy Sunday, Alice!');
```

---

### ✅ Update user profile information
This query **updates a user's profile details** in the `Users` table, allowing modifications to essential attributes such as username, email, password, birthdate, and profile picture. By filtering for `user_id = 1`, it ensures that only the specified user's information is modified.

#### **Query Breakdown**
- Updates the `username`, `email`, `password`, `date_of_birth`, and `profile_picture` fields.
- Uses `WHERE user_id = 1` to target the specific user, preventing unintended modifications.
- Ensures seamless profile updates without requiring the creation of a new user record.

```SQL
UPDATE Users
SET 
    username = 'Alice',
    email = 'alice@example.com',
    password = 'hashedpassword1',
    date_of_birth = '1995-06-15',
    profile_picture = '/images/alice.jpg'
WHERE user_id = 1;
```

---

### ✅ Remove a like from a post
This query **deletes a specific like** from the `Likes` table, ensuring that a user can remove their interaction with a post. By filtering for `like_id = 4` and `post_id = 1`, it targets a specific like entry and ensures that only the intended record is deleted.

#### **Query Breakdown**
- Uses `DELETE FROM Likes` to remove a like entry.
- Filters by `like_id = 4` and `post_id = 1` to ensure only the specified like is removed.
- Applies `LIMIT 1` to **restrict deletion** to a single record, preventing unintended removals.

```SQL
DELETE FROM Likes
WHERE like_id = 4 AND post_id = 1
LIMIT 1;
```

## 🔍 Complex Queries

### ✅ Identify users with the most followers
This query retrieves the **top three most followed users** from the `Follows` table by counting the total number of followers each user has. The results are ranked **in descending order** based on follower count, ensuring that the most popular accounts appear first.

#### **Query Breakdown**
- Selects `following_id` as `user_id` and retrieves associated usernames from the `Users` table.
- Counts the **total number of followers** (`COUNT(f.follower_id)`) for each user.
- Groups results by `following_id` to compute individual follower counts.
- Orders output **by follower count in descending order**, ensuring highly followed users are prioritized.
- Uses `LIMIT 3` to **return only the top three users**.

```SQL
SELECT 
    f.following_id AS user_id,
    u.username,
    COUNT(f.follower_id) AS follower_count
FROM Follows f
JOIN Users u ON f.following_id = u.user_id
GROUP BY f.following_id, u.username
ORDER BY follower_count DESC, u.username ASC
LIMIT 3;
```

---

### ✅ Identify the most active users
This query retrieves the **top five most active users** based on their engagement through posts and comments. By counting the number of distinct posts and comments made by each user, the query ranks them in **descending order of interaction**, helping to highlight key contributors within the platform.

#### **Query Breakdown**
- Selects `user_id` and `username` from the `Users` table.
- Uses `LEFT JOIN` with the `Posts` table to count **the number of posts** each user has made.
- Uses `LEFT JOIN` with the `Comments` table to count **the number of comments** each user has posted.
- Applies `COALESCE` to ensure users **without posts or comments** are assigned a default value of zero (`0`).
- Orders results by `comment_count DESC` first, ensuring users with the highest interactions appear at the top, followed by `post_count DESC` as a secondary sorting criteria.
- Uses `LIMIT 5` to **return only the top five most active users**.

```SQL
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
```

---

### ✅ Calculate the average number of comments per post
This query computes the **average number of comments per post** in the database by dividing the total number of comments by the total number of posts. It provides insights into engagement levels across all published content.

#### **Query Breakdown**
- `COUNT(*) FROM Comments` retrieves the total number of comments.
- `COUNT(*) FROM Posts` retrieves the total number of posts.
- The division operation calculates the **average number of comments per post**.
- The query returns a **single aggregated value**, helping analyze user interactions with posts.

```SQL
SELECT 
    (SELECT COUNT(*) FROM Comments) / 
    (SELECT COUNT(*) FROM Posts) AS avg_comments_per_post;
```

## 🔁 Complex Queries

### ✅ Automatically notify users of new messages
This query creates a **trigger** that automatically generates a notification whenever a new message is inserted into the `Messages` table. It ensures real-time alerts for recipients, enhancing communication within the platform.

#### **Trigger Breakdown**
- Executes **AFTER INSERT** on the `Messages` table, meaning it runs whenever a new message is added.
- Uses `FOR EACH ROW` to apply the trigger individually for every inserted message.
- Inserts a new record into the `Notifications` table, notifying the **recipient (`receiver_id`)**.
- Dynamically constructs the **notification text**, including the sender’s username.
- Uses `NOW()` to record the exact timestamp of the notification.
- Marks notifications as **unread (`is_read = 0`)** by default.

```SQL
CREATE TRIGGER after_message_insert
AFTER INSERT ON Messages
FOR EACH ROW
INSERT INTO Notifications (user_id, notification_text, notification_date, is_read)
VALUES (NEW.receiver_id, CONCAT('New message from ', (SELECT username FROM Users WHERE user_id = NEW.sender_id)), NOW(), 0);
```

---

### ✅ Update post counts and follower counts for users
This query updates **user statistics**, specifically their **follower count** and **post count**, ensuring accurate tracking of social interactions and content contributions within the platform.

#### **Query Breakdown**
- **Follower Count Update:**  
  - Counts the total number of followers for each user (`following_id`) from the `Follows` table.
  - Updates the `follower_count` field in the `Users` table accordingly.
  
- **Post Count Update:**  
  - Counts the total number of posts created by each user (`user_id`) from the `Posts` table.
  - Updates the `post_count` field in the `Users` table accordingly.

```SQL
UPDATE Users SET follower_count = (
    SELECT COUNT(*) FROM Follows WHERE following_id = user_id
);

UPDATE Users u SET u.post_count = (
    SELECT COUNT(*) FROM Posts p WHERE p.user_id = u.user_id
);
```

---

### ✅ Automatically update user statistics upon new posts and follows
This query creates **two triggers** that automatically update user statistics when new posts or follows are inserted into the database. These triggers ensure real-time updates to **post counts** and **follower counts**, improving data accuracy and engagement tracking.

#### **Trigger Breakdown**
- **Post Count Update (`after_post_insert`)**  
  - Executes **AFTER INSERT** on the `Posts` table.
  - Increases the `post_count` for the user who created the post (`NEW.user_id`).
  
- **Follower Count Update (`after_follows_insert`)**  
  - Executes **AFTER INSERT** on the `Follows` table.
  - Increases the `follower_count` for the user being followed (`NEW.following_id`).

```SQL
CREATE TRIGGER after_post_insert
AFTER INSERT ON Posts
FOR EACH ROW
UPDATE Users SET post_count = post_count + 1 WHERE user_id = NEW.user_id;

CREATE TRIGGER after_follows_insert
AFTER INSERT ON Follows
FOR EACH ROW
UPDATE Users SET follower_count = follower_count + 1 WHERE user_id = NEW.following_id;
```

---

### ✅ Generate personalized recommendations for users to follow
This query suggests **new users to follow** based on mutual connections, helping users discover relevant profiles within the platform. By analyzing shared followers, it identifies potential connections that the user has not yet followed.

#### **Query Breakdown**
- Selects `follower_id` as `user_id` and retrieves recommended usernames from the `Users` table.
- Joins the `Follows` table to find **mutual followers** between users.
- Filters results to exclude users the current user (`follower_id = 3`) is already following.
- Uses `COUNT(DISTINCT f2.follower_id)` to rank recommendations based on the number of mutual followers.
- Orders results **by mutual follower count in descending order**, ensuring the most relevant suggestions appear first.
- Limits output to **five recommendations** for efficiency.

```SQL
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
```