# d_dml > e_삭제명령어

# delete VS drop VS turncate

# 1) 공통점: 삭제를 담당하는 키워드

# 2) 차이점
# - delete (DML)
#	: 테이블의 틀은 남기면서 데이터를 삭제 - 적은 용량의 데이터 | 조건이 필요한 데이터 (where)

# - drop (DDL)
#	: 테이블 자체를 삭제 (틀 + 데이터)

# - turncate (DDL)
#	: 테이블의 틀은 남기면서 데이터를 삭제 - 대용량의 데이터

-- 대용량 테이블 생성
USE `company`;
create table `big1` (select * from `world`.`city`, `sakila`.`actor`);
create table `big2` (select * from `world`.`city`, `sakila`.`actor`);
create table `big3` (select * from `world`.`city`, `sakila`.`actor`);

-- 삭제 명령어 비교
delete from `big1`; -- 5.406초
# : truncate 보다 느림!
select * from `big1`;

drop table `big2`; -- 0.032
-- select * from `big2`;
# Error Code: 1146. Table 'company.big2' doesn't exist


truncate table `big3`; -- 0.016초
# : 테이블 형식은 남지만, 조건없이 삭제됨!
select * from `big3`;