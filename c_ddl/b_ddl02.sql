### c_ddl > b_ddl02 ###

# --- 데이터베이스 ---
# 1. 생성(CREATE)
create database database_name;
drop database database_name;
# > 위 두개의 실행문은 여러 번 실행할 경우 Error 발생

# cf) if [not] exists 옵션
# : 데이터베이스의 유무를 확인하고 오류를 방지하는 SQL문
#		, 존재할 때 또는 존재하지 않을 때 실행

CREATE DATABASE IF NOT EXISTS database_name; # 존재하지 않을 때 > 생성
DROP DATABASE IF EXISTS database_name; # 존재할 때 > 삭제

# 2. 데이터베이스 선택(USE)
# : DB 선택 시 이후 모든 SQL 명령어가 선택된 DB 내에서 실행
# - GUI로 Navigator > Schemas > 스키마명 더블 클릭과 동일
USE database_name;

CREATE DATABASE IF NOT EXISTS example;
USE example;

# 3. 삭제(DROP)
# : 데이터베이스 삭제, 해당 작업은 실행 후 되돌릴 수 없음!
DROP DATABASE database_name;

# 4. 데이터베이스 목록 조회
# : 해당 SQL 서버에 존재하는 모든 DB(스키마) 목록 확인
SHOW DATABASES;

# --- 테이블 ---
# 1. 생성 (create)
USE example;

CREATE TABLE student (
	# 테이블 생성 시 DB명 필수 X
    # > USE 명령어를 통해 DB 지정이 되어 있는 경우 생략 가능
    # > 오류 방지를 위해 작성 권장!
	student_id int primary key,
    name varchar(100) not null,
    age int not null,
    major varchar(100)
);

# 2. 테이블 구조 조회 (describe, desc)
# : 정의된 컬럼, 데이터 타입, 키, 정보(제약 조건) 등을 조회
# - describe 테이블명;
# - desc 테이블명;

# cf) 테이블 구조
# Field: 각 컬럼의 이름
# Type: 각 컬럼의 데이터 타입
# Null: Null(데이터 생략, 비워짐) 허용 여부
# Key: 각 컬럼의 제약 사항
# Default: 기본값 지정
# Extra: 제약 사항 (추가 옵션)

# --- 테이블 수정 ---
# alter table
# : 이미 존재하는 테이블의 구조를 변경하는 데 사용
# - 컬럼 또는 제약 조건을 추가, 수정, 삭제

# 1) 컬럼
# : 컬럼 추가 (add)
# alter table 테이블명 add column 컬럼명 데이터타입 기타사항;
alter table `student` add column email varchar(255);

describe student;
desc student; # cf) descending(desc) 내림차순

# : 컬럼 수정 (modify)
# alter table 테이블명 modify column 컬럼명 새로운컬럼_데이터타입 [기타사항];
alter table student
modify column email varchar(100);

desc student;

# : 컬럼 삭제 (drop)
# alter table 테이블명 drop column 컬럼명;
alter table student
drop email;

describe student;

# cf) 테이블 수정 시 column 키워드 생략 가능
# add, modify, drop 만 작성 가능

# --- 테이블 데이터 삭제(초기화) ---
# : truncate
# : 테이블의 구조는 그대로 두고, 내부의 모든 데이터를 삭제 (초기 상태로 되돌림)
truncate table student;

desc student;

# if exists / if not exists
# > 선택적 키워드, 오류 방지 키워드