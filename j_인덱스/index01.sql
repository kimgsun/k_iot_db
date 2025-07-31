# j_인덱스 > index01

### 인덱스 ###
# : select 문으로 데이터 조회 시, 원하는 데이터를 더 빠르게 찾아주는 도구
# - 데이터 검색 속도 향상 >> 전체 시스템 성능을 높임

# EX) 책에서 원하는 단어를 찾을 떄 사용하는 '찾아보기(색인)'

# 1. 인덱스 종류
# 1) 클러스터형 인덱스
# : 기본키(PK) 설정 시 자동 생성
# - 테이블 당 단 하나만 생성 가능!
# - 자동 정렬 기능 포함: 지정된 열(기본키 컬럼)을 기준으로 자동 정렬
SELECT * FROM `A`;
# >> 위의 커리문 처럼 order by(정렬)문이 없으면 클러스터형 인덱스를 기준으로 정렬

# EX) 영어사전, 국어사전: 내용이 미리 정렬

# 2) 보조 인덱스
# : 고유키(Unique Key) 설정 시 자동 생성
# - 테이블 당 여러 개 생성 가능
# - 자동 정렬 기능 포함 X
# EX) 일반 서적: 색인(찾아보기) 등의 페이지 번호를 보고 해당 위치로 이동해야 내용 확인 가능

## 인덱스 사용 예시 ##
create database if not exists idx_db;

use idx_db;

create table table1 (
	col1 int primary key,
    col2 int,
    col3 int
);

# 인덱스 정보 확인: show index from 테이블명;
show index from table1;
# Non_unique: 중복 가능 여부
# >> 0(False): 중복 허용 X 인덱스 (유일한 값)
# >> 1(True): 중복 가능한 인덱스

# Key_name: PRIMARY (기본 키 설정으로 자동 생성된 인덱스)
# Column_name: 인덱스가 부여된 컬럼명

# Seq_in_index: 인덱스 안에서의 컬럼 순서
# >> 복합키를 인덱스로 사용하는 복합인덱스에서 두 개의 컬럼의 순서(우선순위)

create table table2 (
	col1 int primary key,
    col2 int unique,
    col3 int unique
);

show index from table2;
# Key_name: 열 이름 지정 시 - 보조 인덱스
#		>> PRIMARY - 클러스터형 인덱스
# Non_unique: 고유키 중복 허용 X
# Null: YES (NULL 허용)

### 인덱스 활용 ###
drop database 인덱스;
create database 인덱스;
use 인덱스;

drop table if exists members, puchases;

create table members (
	mem_id char(8),
    mem_name varchar(10),
    mem_number int,
    address char(2)
);

insert into members
values
	('IVE', '아이브', 6, '서울'),
	('BLK', '블핑', 4, '부산'),
	('LSF', '르세라핌', 5, '경기'),
	('ASF', '에스파', 4, '경남');
    
SELECT * FROM members; -- 클러스터형 인덱스가 없는 경우(PK값이 없는 경우): 데이터 삽입 순서대로 출력

show index from members;

-- 기본키 설정 (클러스터형 인덱스 생성)
alter table members
add constraint primary key (mem_id);

SELECT * FROM members; -- mem_id를 기준으로 오름차순 정렬 (ASF > BLK > IVE > LSF)

show index from members;

insert into members
values
	('H2H', '하츠투하츠', 7, '대전');
    
SELECT * FROM members; -- 인덱스 저장 후(PK 설정 후) 추가 데이터 삽입 시: 정렬 기준에 따라 자동 정렬

-- 정렬되지 않는 보조 인덱스 --
# : 고유 키 지정 시 생성 /테이블 당 여러 개 가능 / 정렬 X
drop table if exists members;

create table members (
	mem_id char(8),
    mem_name varchar(10),
    mem_number int,
    address char(2)
);

insert into members
values
	('IVE', '아이브', 6, '서울'),
	('BLK', '블핑', 4, '부산'),
	('LSF', '르세라핌', 5, '경기'),
	('ASF', '에스파', 4, '경남');
    
select * from members;

show index from members;

alter table members
add constraint unique(mem_id);

select * from members; -- unique 설정 시 다른 점 X

show index from members;

insert into members
values
	('H2H', '하츠투하츠', 7, '대전');
    
select * from members; -- 데이터 삽입 순서 유지

### 보조 인덱스의 경우 정렬되지는 않지만 성능적인 향상이 이루어짐 ###
