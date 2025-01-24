CREATE DATABASE board;

USE board;

CREATE TABLE user (
	email VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(20) NOT NULL UNIQUE,
    tel_number VARCHAR(15) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    address_detail TEXT,
    profile_image TEXT,
    agreed_personal BOOLEAN NOT NULL,
    
    CONSTRAINT user_pk PRIMARY KEY (email)
);

CREATE TABLE board (
	board_number INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    contents TEXT NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT NOW(),
    favorite_count INT NOT NULL DEFAULT 0,
    comment_count INT NOT NULL DEFAULT 0,
    view_count INT NOT NULL DEFAULT 0,
    writer_email VARCHAR(50) NOT NULL,
    
    CONSTRAINT board_pk PRIMARY KEY (board_number),
    CONSTRAINT user_board_fk FOREIGN KEY (writer_email) REFERENCES user (email)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

CREATE TABLE comment (
	comment_number INT NOT NULL,
    contents TEXT NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT NOW(),
    user_email VARCHAR(50) NOT NULL,
    board_number INT NOT NULL, 
    
    CONSTRAINT comment_pk PRIMARY KEY (comment_number),
    CONSTRAINT user_comment_fk FOREIGN KEY (user_email) REFERENCES user (email)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT board_comment_fk FOREIGN KEY (board_number) REFERENCES board (board_number)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

-- board 와 comment 의 email 외래키 이름 어떻게 동일하게 사용??

CREATE TABLE favorite (
	user_email VARCHAR(50) NOT NULL,
    board_board_number INT NOT NULL,
    
    CONSTRAINT favorite_pk PRIMARY KEY (user_email, board_board_number),
    CONSTRAINT user_favorite_fk FOREIGN KEY (user_email) REFERENCES user (email)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT board_favorite_fk FOREIGN KEY (board_board_number) REFERENCES board (board_number)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

CREATE TABLE board_image (
	sequence INT NOT NULL AUTO_INCREMENT,
    board_number INT NOT NULL,
    image_url TEXT,
    
    CONSTRAINT board_image_pk PRIMARY KEY (sequence),
    CONSTRAINT board_image_fk FOREIGN KEY (board_number) REFERENCES board (board_number)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

CREATE TABLE search_log (
	sequence INT NOT NULL,
    search_word TEXT NOT NULL,
    relation_word TEXT,
    relation BOOLEAN NOT NULL,
    
    CONSTRAINT search_log_pk PRIMARY KEY (sequence)
);

ALTER TABLE comment MODIFY COLUMN comment_number INT NOT NULL AUTO_INCREMENT;
ALTER TABLE search_log MODIFY COLUMN sequence INT NOT NULL AUTO_INCREMENT;

SELECT * FROM user;
SELECT * FROM board;
SELECT * FROM comment;
SELECT * FROM favorite;
SELECT * FROM board_image;
SELECT * FROM search_log;

-- 1번
INSERT INTO user (email, password, nickname, tel_number, address, address_detail, agreed_personal)
VALUES ('email@email.com', 'P!ssw0rd', 'rose', '010-1234-5678', '부산광역시 사하구', '낙동대로', true);

-- 2번
UPDATE user SET profile_image = 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg'
WHERE email = 'email@email.com';

-- 3번 삽입 실패
INSERT INTO board (title, contents, writer_email)
VALUES ('첫번째 게시물', '반갑습니다. 처음뵙겠습니다.', 'email2@email.com');
-- board 테이블의 writer_email 컬럼은 user 테이블의 기본키인 email 컬럼을 참조하는 외래키이다.
-- user 테이블의 email 컬럼에는 email@email.com 만 삽입되어 있다.
-- 아직 생성되지도 않은 email 데이터 값인 email2@email.com 는 board 테이블에서는  참조할 수 없는 값이라서 참조 무결성에 위배되어 삽입에 실패한다.

-- 4번
INSERT INTO board (title, contents, writer_email)
VALUES ('첫번째 게시물', '반갑습니다. 처음뵙겠습니다.', 'email@email.com');

-- 5번
INSERT INTO board_image (board_number, image_url)
VALUES (1, 'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg');

-- 6번
UPDATE board SET favorite_count = 1
WHERE board_number = 1;

-- 7번
SELECT
	B.board_number 'board_number',
	B.title 'title',
	B.contents 'contents',
	B.view_count 'view_count',
	B.comment_count 'comment_count',
	B.favorite_count 'favorite_count',
	B.write_datetime 'write_datetime',
	B.writer_email 'writer_email',
	U.profile_image 'writer_profile_image',
	U.nickname 'writer_nickname'
FROM board B INNER JOIN user U
ON B.writer_email = U.email;

-- 8번
CREATE VIEW board_view AS
SELECT
	B.board_number 'board_number',
	B.title 'title',
	B.contents 'contents',
	B.view_count 'view_count',
	B.comment_count 'comment_count',
	B.favorite_count 'favorite_count',
	B.write_datetime 'write_datetime',
	B.writer_email 'writer_email',
	U.profile_image 'writer_profile_image',
	U.nickname 'writer_nickname'
FROM board B INNER JOIN user U
ON B.writer_email = U.email;

SELECT * FROM board_view;

-- 9번
SELECT * FROM board_view WHERE title LIKE ('%반갑%') OR contents LIKE ('%반갑%');

-- 10번
CREATE INDEX board_title_idx ON board (title);

-- 11번
SELECT writer_email '작성자', COUNT(board_number) '게시물의 수'
FROM board
GROUP BY writer_email;
