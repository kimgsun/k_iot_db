# d_dml > d_dml

# cf) ddl (definition 정의) - DB 정의 언어
# : CREATA(생성), ALTER(수정), DROP(삭제), TRUNCATE(데이터 삭제)

### DML (Data Manipulation Language) ###
# : 데이터 조작(관리) 언어
# - 데이터를 삽입, 조회, 수정, 삭제 (CRUD)

CREATE DATABASE IF NOT EXISTS `company`;
USE `company`;

CREATE TABLE `example01` (
	name varchar(100),
    age int,
    major varchar(100)
);

/*
	1. 데이터 삽입 (insert)
    : 테이블에 행 데이터(레코드)를 입력
    
    # 기본 형식 #
    insert into 테이블명 (열1, 열2, ...)
    values (값1, 값2, ...);
    
    cf) 테이블명 뒤 열 이름의 나열을 생략할 경우
		: values 뒤의 값 순서는 테이블 정의 시 작성한 열의 순서 & 개수와 동일
        >> name(문자), age(숫자), major(문자) 순
        
	cf) 전체 테이블의 컬럼 순서 & 개수와 차이가 나는 경우 반드시! 원하고자하는 열 이름 나열!
*/

# 1) 컬럼명 지정 X
insert into `example01`
values
	('오신혁', 20, 'IT');
    
-- insert into `example01`
-- values
-- 		('박진영', 25);
# > major 값 누락 오류!

-- insert into `example01`
-- values
-- 		('박진영', 'cooking', 30);
# > 컬럼 정렬 순에 맞지 않는 오류!

# 2) 컬럼명 지정 O
insert into `example01` (major, name)
values
	('Health', '손태경');
    
# 데이터 삽입 시 NULL 허용 컬럼에 값 입력이 이루어지지 않은 경우
# : 자동으로 NULL값 지정(삽입)

# cf) "auto_increment"
# : 열을 정의할 때 1부터 1씩 증가하는 값을 입력
# - insert에서는 해당 열이 없다고 가정하고 입력
# - 해당 옵션이 지정된 컬럼은 반드시! PK 값으로 지정! (하나의 테이블에 한 번만 지정 가능!)
create table `example02` (
	# 컬럼명 데이터타입 [primary key] [auto_increment] / 옵션 순서 상관 없음
    id bigint auto_increment primary key,
    name varchar(50)
);

insert into `example02` (name)
values
	('최광섭'),
	('정은혜'),
	('정지훈');
    
select * from `example02`;

insert into `example02`
values
	(null, '김승민');
    
select * from `example02`;

# cf) auto_increment 최대값 확인
# select max(auto_increment컬럼명) from `테이블명`;
select max(id) from `example02`;

# cf) 시작 값 변경
alter table `example02` auto_increment=100; # 테이블 생성 시에도 동일

insert into `example02`
values
	(null, '박현우');
    
select * from `example02`;

# cf) 다른 테이블의 데이터를 한 번에 삽입하는 구문

# insert into `삽입받을 테이블`
# select ~~~(조회구문작성)

create table `example03` (
	id int,
    name varchar(100)
);

insert into `example03`
select * from `example02`; # 컬럼의 순서, 개수, 자료형이 반드시 일치 (옵션은 상관 없음)

select * from `example03`;

/*
	2. 데이터 수정(update)
    : 테이블의 내용을 수정
	
    # 기본 형식 #
    update `테이블명`
    set 열1=값1, 열2=값2, ...
    (where 조건);
    
    cf) where 조건이 없는 경우
		: 해당 열(컬럼)의 데이터가 해당 값으로 모두 변경
*/

USE `company`;

update `example02`
set name='권지애';
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
#					To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

# cf) Safe Update Mode 설정 위치 (MySQL Workbench 기준)
# Edit > Preferences > SQL Editor
# 맨 아래 Safe Updates 옵션 해제(WHERE 조건 제약 X) / 체크(WHERE 조건 제약 O)
# +) 재시작해야 적용됨!

# safe 모드 해제 후 실행 결과
# > 5 row(s) affected Rows matched: 5  Changed: 5  Warnings: 0
select * from `example02`;

# cf) 실행 중인 세션에서 일시적으로 Safe 모드 해제
SET SQL_SAFE_UPDATES=1; # 1: 모드 사용
SET SQL_SAFE_UPDATES=0; # 0: 모드 사용 해제 

update `example02`
set name="김동후"
where id=1;

select * from `example02`;

/*
	3. 데이터 삭제(delete)
    : 테이블의 데이터를 삭제하기 위한 키워드
    
    # 기본 형태 #
    delete from `테이블명`
    where 조건;
*/

select * from `example02`;

delete from `example02`;
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
#					To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

set sql_safe_updates=0;

delete from `example02`;

select * from `example02`;

set sql_safe_updates=1;

delete from `example02`
where id=1;