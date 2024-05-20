DROP DATABASE IF EXISTS `IRUKA_CODE`;
CREATE DATABASE `IRUKA_CODE`;
USE IRUKA_CODE;

CREATE TABLE Users (
    id INT AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    image_url VARCHAR(255),
    password VARCHAR(128) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    deleted_flag BOOLEAN DEFAULT FALSE
);

CREATE TABLE Teams (
    team_id INT AUTO_INCREMENT,
    leader_id INT NOT NULL,
    team_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (team_id),
    deleted_flag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (leader_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT NOT NULL,
    project_name VARCHAR(255) NOT NULL,
    start_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_timestamp DATETIME NULL,
    is_open BOOLEAN DEFAULT TRUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    max_participant_count INT NOT NULL,
    max_class_num INT NOT NULL,
    deleted_flag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id) ON DELETE CASCADE
);

CREATE TABLE Leader_Access_Datetime (
    leader_id INT,
    project_id INT,
    access_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (leader_id, project_id),
    FOREIGN KEY (leader_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT,
    project_id INT,
    class_name VARCHAR(255) NOT NULL,
    start_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_timestamp DATETIME NULL,
    is_open BOOLEAN DEFAULT TRUE,
    deleted_flag BOOLEAN DEFAULT FALSE,
    max_participant_count INT not null,
    PRIMARY KEY (class_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

CREATE TABLE Class_memos(
    memo_id INT AUTO_INCREMENT,
    class_id INT,
    leader_id INT,
    memo_title VARCHAR(255) NOT NULL,
    memo_content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_flag BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (memo_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (leader_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT,
    user_id INT,
    class_id INT,
    access_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (member_id),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE
);

CREATE TABLE Member_Memos(
    member_memo_id INT AUTO_INCREMENT,
    member_id INT,
    memo_id INT,
    memo_content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_flag BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (member_memo_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (memo_id) REFERENCES Class_memos(memo_id) ON DELETE CASCADE
);

CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT,
    class_id INT,
    user_id INT,
    comment_title VARCHAR(255) NOT NULL,
    comment_content TEXT,
    is_solved BOOLEAN DEFAULT FALSE,
    is_answer BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_flag BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Comment_Targets (
    comment_id INT,
    target_id INT,
    PRIMARY KEY (comment_id, target_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id) ON DELETE CASCADE,
    FOREIGN KEY (target_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Comment_Tags(
    tag_id INT AUTO_INCREMENT,
    tag_name VARCHAR(50) NOT NULL,
    project_id INT,
    PRIMARY KEY (tag_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

CREATE TABLE Comment_Tag_Pivot(
    comment_id INT,
    tag_id INT,
    PRIMARY KEY (comment_id, tag_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Comment_Tags(tag_id) ON DELETE CASCADE
);

CREATE TABLE Comment_Files(
    file_id INT AUTO_INCREMENT,
    comment_id INT,
    file_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_flag BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (file_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id) ON DELETE CASCADE
);

CREATE TABLE Comment_Positions(
    position_id INT AUTO_INCREMENT,
    comment_id INT,
    start_text_position INT,
    end_text_position INT,
    coding_area_position VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_flag BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (position_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id) ON DELETE CASCADE
);

CREATE TABLE Answers (
    answer_id INT AUTO_INCREMENT,
    comment_id INT,
    user_id INT,
    answer_content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_flag BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (answer_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);
