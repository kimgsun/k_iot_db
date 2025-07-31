### h_트리거 >>> trigger_practice_answer ###

##### 문제 1 #####
/*
	선수(players)가 삭제될 때, 
	해당 선수의 이름과 삭제 시각을 player_delete_logs 테이블에 기록하는 트리거를 생성
    
	>> 로그 테이블이 없으면 먼저 생성하고, 트리거명: after_player_delete
*/

-- 로그 테이블 생성
CREATE TABLE IF NOT EXISTS player_delete_logs (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50),
    deleted_time datetime
);

-- 기존 트리거 삭제
drop trigger if exists after_player_delete;

-- 트리거 생성
delimiter $$
create trigger after_player_delete
	after delete
    on players
    for each row
begin
	insert into player_delete_logs (player_name, deleted_time)
    values (OLD.name, now());
end $$
delimiter ;

-- 선수 삭제 시 로그 기록 확인
SELECT * FROM `players`;
SELECT * FROM `teams`;

-- 테스트용 선수 추가
INSERT INTO `players`
VALUES
	(201, '테스트 선수1', '타자', '1999-03-03', 2);

-- 삭제 전 로그 확인
SELECT * FROM player_delete_logs;

-- 테스트용 선수 삭제
DELETE FROM players WHERE player_id = 201;

-- 삭제 후 로그 확인
SELECT * FROM player_delete_logs;



##### 문제 2 #####
/*
	선수(players)의 포지션(position)이 변경될 경우
		, 이전 포지션과 변경된 포지션, 선수 이름을 player_position_logs에 기록하는 트리거를 생성
	
    >> 로그 테이블이 없으면 먼저 생성하고,트리거명: after_player_position_update
*/

-- 로그 테이블 생성
CREATE TABLE IF NOT EXISTS player_position_logs (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50),
    old_position VARCHAR(20),
    new_position VARCHAR(20),
    changed_time datetime
);

-- 기존 트리거 삭제
drop trigger if exists after_player_position_update;

-- 트리거 생성
delimiter $$
create trigger after_player_position_update
	after update
    on players
    for each row
begin
	if OLD.position != NEW.position then
		insert into player_position_logs (player_name, old_position, new_position, changed_time)
        values (NEW.name, OLD.position, NEW.position, now());
	end if;
end $$
delimiter ;

-- 선수 삭제 시 로그 기록 확인
SELECT * FROM `players`;
SELECT * FROM `teams`;

-- 테스트용 선수 추가
INSERT INTO `players`
VALUES
	(201, '테스트 선수1', '타자', '1999-03-03', 2);
    
-- 포지션 변경 전 로그 확인
SELECT * FROM player_position_logs;

-- 포지션 변경
UPDATE players SET position = '외야수' WHERE player_id = 201;

-- 포지션 변경 후 로그 확인
SELECT * FROM player_position_logs;

##### 문제 3 #####
/*
	선수가 추가되거나 삭제될 때마다 해당 팀의 선수 수(player_count)를 자동으로 업데이트하는 트리거 2개	
		(after_player_insert_count, after_player_delete_count)
		
		>> ※ teams 테이블에 player_count 컬럼이 이미 존재한다고 가정함
		
		ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;
*/

-- teams 테이블에 player_count 컬럼 추가 
ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;

-- 선수 추가 시 팀의 선수 수 증가 트리거
DROP TRIGGER IF EXISTS after_player_insert_count;

DELIMITER $$
CREATE TRIGGER after_player_insert_count
AFTER INSERT ON players
FOR EACH ROW
BEGIN
	UPDATE teams
	SET player_count = player_count + 1
	WHERE team_id = NEW.team_id;
END $$
DELIMITER ;

-- 선수 삭제 시 팀의 선수 수 감소 트리거
DROP TRIGGER IF EXISTS after_player_delete_count;

DELIMITER $$
CREATE TRIGGER after_player_delete_count
AFTER DELETE ON players
FOR EACH ROW
BEGIN
	UPDATE teams
	SET player_count = player_count - 1
	WHERE team_id = OLD.team_id;
END $$
DELIMITER ;

-- 테스트 전 player_count 초기 상태 확인
SELECT team_id, player_count FROM teams;

-- 선수 추가
INSERT INTO players (player_id, name, position, birth_date, team_id)
VALUES (303, '테스트선수3', '투수', '1994-07-07', 1);

-- 추가 후 player_count 확인
SELECT team_id, player_count FROM teams WHERE team_id = 1;

-- 선수 삭제
DELETE FROM players WHERE player_id = 303;

-- 삭제 후 player_count 확인
SELECT team_id, player_count FROM teams WHERE team_id = 1;