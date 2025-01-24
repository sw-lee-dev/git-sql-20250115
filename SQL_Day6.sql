CREATE DATABASE crud;

USE crud;

CREATE TABLE user (
	id VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nickname VARCHAR(50) NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
);

SELECT * FROM user;

CREATE TABLE board (
	board_number INT NOT NULL UNIQUE AUTO_INCREMENT,
	title TEXT NOT NULL,
    contents TEXT NOT NULL,
    write_date DATE NOT NULL,
	writer_id VARCHAR(20) NOT NULL,
    CONSTRAINT board_pk PRIMARY KEY (board_number),
    CONSTRAINT board_writer_fk FOREIGN KEY (writer_id) REFERENCES user(id)
);

SELECT * FROM board;

CREATE VIEW board_view AS
SELECT
	B.title title,
    B.contents cotnents,
    B.write_date write_date,
    B.board_number board_number,
    U.nickname writer_nickname
FROM board B INNER JOIN user U
ON B.writer_id = U.id;

SELECT *
FROM board_view
ORDER BY board_number DESC;

CREATE TABLE comment (
	comment_number INT NOT NULL UNIQUE AUTO_INCREMENT,
    board_number INT NOT NULL,
    writer_id VARCHAR(20) NOT NULL,
    contents TEXT NOT NULL,
    write_datetime DATETIME NOT NULL,
    status BOOLEAN NOT NULL,
    parent_comment INT,
    
    CONSTRAINT comment_pk PRIMARY KEY (comment_number),
    CONSTRAINT comment_board_fk FOREIGN KEY (board_number) REFERENCES board (board_number),
    CONSTRAINT comment_user_fk FOREIGN KEY (writer_id) REFERENCES user (id),
    CONSTRAINT parent_commnet_fk FOREIGN KEY (parent_comment) REFERENCES comment (comment_number)
);

SELECT * FROM comment;

CREATE TABLE good_thumb (
	thumb_id VARCHAR(20) NOT NULL,
    board_number INT NOT NULL,
    
    CONSTRAINT thumb_pk PRIMARY KEY (thumb_id, board_number),
    CONSTRAINT thumb_user_fk FOREIGN KEY (thumb_id) REFERENCES user (id),
    CONSTRAINT thumb_board_fk FOREIGN KEY (board_number) REFERENCES board (board_number)
);

SELECT * FROM good_thumb;

INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ('QWER', 1, 'qwer1234', now(), true, null);
INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ('QWER', 2, 'qwer1111', now(), true, null);
INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ('QWER', 1, 'qwer1111', now(), true, null);
INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ('QWERQWER', 1, 'qwer1111', now(), true, 1);
INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ('자식대댓글', 1, 'qwer1111', now(), true, 2);

UPDATE comment SET status = false WHERE comment_number = 3;

DELETE FROM comment WHERE comment_number = 4;

SELECT * FROM good_thumb WHERE thumb_id = 'qwer1111' AND board_number = 2;

INSERT INTO good_thumb VALUES ('qwer1111', 2);
INSERT INTO good_thumb VALUES ('qwer1111', 1);
INSERT INTO good_thumb VALUES ('qwer1234', 1);

DELETE FROM good_thumb WHERE thumb_id = 'qwer1111' AND board_number = 2;

-- 댓글 수 보기
SELECT board_number, COUNT(*) FROM comment WHERE board_number = 2 GROUP BY board_number;

-- 좋아요 수 보기
SELECT board_number, COUNT(*) FROM good_thumb WHERE board_number = 2 GROUP BY board_number;

-- 댓글과 좋아요 수 같이 보기
SELECT
	C.board_number 'board_number',
    IFNULL(C.count, 0) 'comment_count',
    IFNULL(G.count, 0) 'good_thumb_count'
FROM (
	SELECT board_number, COUNT(*) count
    FROM comment WHERE board_number = 2 
    GROUP BY board_number
) C 
LEFT JOIN (
	SELECT board_number, COUNT(*) count
    FROM good_thumb WHERE board_number = 2 
    GROUP BY board_number
) G
ON C.board_number = G.board_number;

DELETE FROM comment;
DELETE FROM good_thumb;