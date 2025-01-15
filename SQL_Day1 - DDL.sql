# 주석 > MySQL에서만 쓰임
-- 주석 > 단순한 주석을 달때 주로 사용

-- 데이터 정의어(DDL)
-- 데이터베이스, 테이블, 인덱스, 사용자를 정의하고 관리하는데 사용되는 언어

-- CREATE : 구조를 생성하는 명령어
-- CREATE 생성할구조 구조이름 [ 구조별 옵션 ];

-- 데이터베이스 생성
CREATE DATABASE practice_sql;
-- 데이터베이스 사용 : 데이터베이스 작업을 수행하기 전에 반드시 사용할 데이터베이스를 선택해야함
USE practice_sql;

-- 테이블 생성
CREATE TABLE example_table (
	example_column1 INT,
    example_column2 BOOLEAN
);

-- 컬럼의 데이터 타입
CREATE TABLE data_type (
	-- INT : 정수 타입
    int_c INT,
    -- DOUBLE : 실수 타입
    double_c DOUBLE,
    -- FLOAT : 실수 타입,
    float_c FLOAT,
    -- BOOLEAN : 논리 타입 (실제로는 정수 0과 1을 다루는 tiny_int)
    boolean_c BOOLEAN,
    -- VARCHAR(문자열의 길이) : 가변길이 문자열 타입, 한글은 2 ~ 3byte, 모든 제약조건 사용 가능
    varchar_c VARCHAR(5),
    -- TEXT : 고정된 크기를 가지는 문자열 타입,(64KB) index, default 제약조건 사용 불가능, varchar와 저장공간이 달라서 저장공간을 효율적으로 쓰고 싶을때 사용하기도 함
    text_c TEXT,
    -- DATE : 날짜(연월일), 관리가 힘듦 >> 기록용도 X(불편함)
    date_c DATE,
    -- DATETIME : 날짜 및 시간, 관리가 힘듦 >> 기록용도 X(불편함)
    datetime_c DATETIME
);

-- 사용자 생성
-- CREATE USER '사용자명'@'접속IP(도메인, 호스트)' IDENTIFIED BY '비밀번호';
-- % 모든 호스트를 지정
CREATE USER 'developer'@'%' IDENTIFIED BY 'Password!';
CREATE USER 'guest2'@'192.168.1.101' IDENTIFIED BY 'qwer1234';

-- DROP 데이터 구조를 삭제할 때 사용하는 명령어
-- DROP 구조이름

-- 사용자 삭제
DROP USER 'guest2'@'192.168.1.101';

-- 테이블 삭제
DROP TABLE data_type;

-- 데이터베이스 삭제
DROP DATABASE practice_sql;

-- ALTER : 데이터 구조를 변경하는 명령어

-- 테이블 컬럼 추가
ALTER TABLE example_table ADD example_column3 VARCHAR(10);

-- 테이블 컬럼 삭제
ALTER TABLE example_table DROP COLUMN example_column3;

-- 테이블 컬럼 타입 수정
ALTER TABLE example_table MODIFY COLUMN example_column2 TEXT;

-- 테이블 컬럼 전체 수정 >> 컬럼명 변경에 유용, 데이터 타입은 X
ALTER TABLE example_table CHANGE example_column1 column1 VARCHAR(5);

-- 데이터베이스 문자셋 수정
ALTER DATABASE practice_sql DEFAULT CHARACTER SET utf8;