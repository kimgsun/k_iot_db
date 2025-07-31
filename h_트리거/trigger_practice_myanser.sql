# h_트리거 > trigger_practice
USE baseball_league;

select * from players;
select * from teams;

/*
	=== 문제1 ===
	선수(players)가 삭제될 때, 
	해당 선수의 이름과 삭제 시각을 player_delete_logs 테이블에 기록하는 트리거를 생성
    
	>> 로그 테이블이 없으면 먼저 생성하고, 트리거명: after_player_delete
*/
create table if not exists player_delete_logs (
	log_id bigint auto_increment primary key,
    player_name varchar(100),
    log_msg char(2),
    deleted_time datetime
);

drop trigger if exists after_player_delete;

delimiter $$
create trigger after_player_delete
	after delete
    on players
    for each row
begin
	insert into player_delete_logs (player_name, log_msg, deleted_time)
    values
		(OLD.name, '삭제', now());
end $$
delimiter ;

select * from player_delete_logs;

delete from players
where
	player_id = 101;
    
select * from players;
select * from player_delete_logs;

/*
	=== 문제2 ===
	선수(players)의 포지션(position)이 변경될 경우
		, 이전 포지션과 변경된 포지션, 선수 이름을 player_position_logs에 기록하는 트리거를 생성
	
    >> 로그 테이블이 없으면 먼저 생성하고,트리거명: after_player_position_update
*/
create table if not exists player_position_logs (
	log_id bigint auto_increment primary key,
    player_name varchar(100),
    old_position varchar(20),
    new_position varchar(20),
    log_msg char(10),
    changed_time datetime
);

drop trigger if exists after_player_position_update;

delimiter $$
create trigger after_player_position_update
	after update
    on players
    for each row
begin
	insert into player_position_logs
		values
			(log_id, OLD.name, OLD.position, NEW.position, '변경', now());
end $$
delimiter ;

select * from player_position_logs;
select * from players;

update players set position = '내야수' where player_id = 102;
update players set position = '투수' where player_id = 102;

select * from player_position_logs;
select * from players;

/*
	=== 문제3 ===
	선수가 추가되거나 삭제될 때마다 해당 팀의 선수 수(player_count)를 자동으로 업데이트하는 트리거 2개	
    (after_player_insert_count, after_player_delete_count)
	
    >> ※ teams 테이블에 player_count 컬럼이 이미 존재한다고 가정함
	
    ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;
*/

ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;
select * from teams;
select * from players;

# 1) 선수 삽입---------------------
drop trigger if exists after_player_insert_count;

delimiter $$
create trigger after_player_insert_count
	after insert
	on players
    for each row
begin
	update teams
    set player_count = player_count + 1
    where team_id = NEW.team_id;
end $$
delimiter ;

insert into players
values (101, 'Kim min', '타자', '1992-05-20', 1);

select * from teams;
select * from players;

# 2) 선수 삭제---------------------
drop trigger if exists after_player_delete_count;

delimiter $$
create trigger after_player_delete_count
	after delete
	on players
    for each row
begin
	update teams
    set player_count = player_count - 1
    where team_id = OLD.team_id;
end $$
delimiter ;

select * from players;

delete from players where player_id = 102;

select * from players;
select * from teams;
select * from player_delete_logs;

insert into players
values
	(102, 'Lee Joon', '투수', '1990-08-15', 2);

show triggers from baseball_league; -- DB에 생성된 모든 트리거 조회


-- 선수 추가 시
-- insert into players
-- values
-- 	(101, 'Kim min', '타자', '1992-05-20', 1),
-- 	(102, 'Lee Joon', '투수', '1990-08-15', 2),
-- 	(103, 'Choi Hyeon', '내야수', '1988-03-05', 3),
-- 	(104, 'Park seo', '외야수', '1994-11-22', 1),
-- 	(105, 'Jung Tae', '타자', '1993-07-30', 2);

-- 실수 시 지워야 함
-- drop table player_position_logs;
-- drop table player_delete_logs;
-- drop trigger if exists after_player_delete;
-- drop trigger if exists after_player_position_update;
-- ALTER TABLE teams DROP COLUMN player_count;
-- drop trigger if exists after_player_insert_count;
-- drop trigger if exists after_player_delete_count;