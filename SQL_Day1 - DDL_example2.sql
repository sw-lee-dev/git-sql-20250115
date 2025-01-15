-- 축구 경기 (football) 데이터베이스

-- 참가팀	(team)	 [국가명(nation), 조(seed), 감독(manager), 피파랭킹(lanking)]
-- 선수	(player) [이름(name), 생년월일(birth), 포지션(position), 등번호(uniform_number), 국가(country)]
-- 경기장	(stadium)[이름(name), 주소(address), 좌석(seats)]
-- 심판	(referee)[이름(name), 생년월일(birth), 국가(country), 포지션(position)]

-- 사용자 : football_developer @ % / 비밀번호 : foot!@
-- 		: football_broadcast @ % /        : foot#$

-- 예시) 참가팀 [ 대한민국, A, 홍길동, 30 ]
--      선수	 [ 이성계, 1998-01-15, 공격수, 10, 대한민국 ]
--      경기장 [ 한양메인스타디움, 대한민국 서울특별시 강남구, 2000 ]
--      심판	 [ 이방원, 1994-06-05, 대한민국, 주심 ]

CREATE DATABASE football;
USE football;
CREATE TABLE team (
	nation VARCHAR(50), # VARCHAR(60) -> 외국 국가 감안, 한글로 20자
    seed VARCHAR(3),
    manager VARCHAR(15), # VARCHAR(100) -> 외국인 이름 감안
    lanking INT
);
CREATE TABLE player (
	name VARCHAR(15), # VARCHAR(100) -> 외국인 이름 감안
    birth VARCHAR(12), # VARCHAR(10) -> 사이즈 정해져 있어서 / DATE 타입도 가능
    position VARCHAR(15), # VARCHAR(12) -> 최대 한글 4자(미드필더)
    uniform_number INT,
    country VARCHAR(50) # VARCHAR(60) -> 외국 국가 감안, 한글로 20자
);
CREATE TABLE stadium (
	name VARCHAR(40), # VARCHAR(255) -> 단어가 길다고 생각했을때 일반적으로 넣는값 255
    address TEXT,
    seats INT
);
CREATE TABLE referee (
	name VARCHAR(15), # VARCHAR(100) -> 외국인 이름 감안
    birth VARCHAR(12), # VARCHAR(10) -> 사이즈 정해져 있어서 / DATE 타입도 가능
    country VARCHAR(50), # VARCHAR(60) -> 외국 국가 감안, 한글로 20자
    position VARCHAR(7) # VARCHAR(6) -> 주심, 부심 2가지
);
-- 7. 계정 생성
CREATE USER 'football_developer'@'%' IDENTIFIED BY 'foot!@';
CREATE USER 'football_broadcast'@'%' IDENTIFIED BY 'foot#$';

ALTER TABLE team MODIFY COLUMN manager VARCHAR(100);
ALTER TABLE player MODIFY COLUMN name VARCHAR(100);
ALTER TABLE referee MODIFY COLUMN name VARCHAR(100);

-- 8. 심판과 선수의 birth 컬럼의 데이터 타입을 DATE로 변경
ALTER TABLE player MODIFY COLUMN birth DATE;
ALTER TABLE referee MODIFY COLUMN birth DATE; # CHANGE 도 가능


