CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL

);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(50),
  body VARCHAR(255),
  user_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id)

);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_id) REFERENCES replies(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  likes INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)

);

INSERT INTO
  users(id, fname, lname)
VALUES
  (1, 'Andrew', 'Lee'),
  (2, 'Justin', 'Austria'),
  (3, 'Bob', 'SQL');

INSERT INTO
  questions (id, title, body, user_id)
VALUES
  (1, 'What is your favorite programming language?',
  'Hey, What is your recommendation for a starter language?',
  (SELECT id FROM users WHERE fname = 'Bob')),
  (2, 'Why do you code?',
  'Hi, I would like to know the motivation behind why you code.',
  (SELECT id FROM users WHERE fname = 'Justin'));

INSERT INTO
  replies(id, question_id, parent_id, user_id, body)
VALUES
  (1, 1, NULL, 1, 'Javascript'),
  (2, 1, 1, 3, 'Thanks Andrew, I''ll check it out');

INSERT INTO
  question_likes(id, user_id, question_id, likes)
VALUES
  (1, 2, 1, 1);
