USE FinalDB;

-- user 테이블
CREATE TABLE user (
  user_id        VARCHAR(30) PRIMARY KEY,
  name           VARCHAR(50) NOT NULL,
  password       VARCHAR(255) NOT NULL,
  birth_date     DATE NOT NULL,
  is_admin       BOOLEAN DEFAULT FALSE,
  profile_image  VARCHAR(255) DEFAULT 'default.png',
  join_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- timetable 테이블
CREATE TABLE timetable (
  timetable_id   INT AUTO_INCREMENT PRIMARY KEY,
  user_id        VARCHAR(30),
  day_of_week    VARCHAR(10),
  period         INT,
  subject        VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- study_group 테이블
CREATE TABLE study_group (
  group_id       INT AUTO_INCREMENT PRIMARY KEY,
  subject        VARCHAR(50) NOT NULL,
  max_members    INT NOT NULL,
  created_by     VARCHAR(30),
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES user(user_id)
);

-- study_member 테이블
CREATE TABLE study_member (
  group_id       INT,
  user_id        VARCHAR(30),
  role           ENUM('LEADER', 'MEMBER') DEFAULT 'MEMBER',
  joined_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (group_id, user_id),
  FOREIGN KEY (group_id) REFERENCES study_group(group_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- match_log 테이블
CREATE TABLE match_log (
  log_id         INT AUTO_INCREMENT PRIMARY KEY,
  group_id       INT,
  matched_users  TEXT,
  status         ENUM('RECRUITING', 'ONGOING', 'FINISHED') DEFAULT 'RECRUITING',
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (group_id) REFERENCES study_group(group_id)
);

-- board_post 테이블
CREATE TABLE board_post (
  post_id        INT AUTO_INCREMENT PRIMARY KEY,
  board_type     ENUM('FREE', 'QNA', 'RESOURCE') NOT NULL,
  writer_id      VARCHAR(30),
  title          VARCHAR(100) NOT NULL,
  content        TEXT NOT NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  filename       VARCHAR(255),
  is_private     BOOLEAN DEFAULT FALSE,
  views          INT DEFAULT 0,
  FOREIGN KEY (writer_id) REFERENCES user(user_id)
);

-- board_comment 테이블 (자유게시판 댓글)
CREATE TABLE board_comment (
  comment_id     INT AUTO_INCREMENT PRIMARY KEY,
  post_id        INT,
  writer_id      VARCHAR(30),
  content        TEXT NOT NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES board_post(post_id),
  FOREIGN KEY (writer_id) REFERENCES user(user_id)
);

-- board_reply 테이블 (QNA 답변)
CREATE TABLE board_reply (
  reply_id       INT AUTO_INCREMENT PRIMARY KEY,
  post_id        INT,
  writer_id      VARCHAR(30),
  content        TEXT NOT NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES board_post(post_id),
  FOREIGN KEY (writer_id) REFERENCES user(user_id)
);