### c_ddl > a_ddl01 ###

### DDL(Data Definition Langauge) 문법 정리 ###
# : create, alter, drop, truncate

-- DB(스키마, Schema) 생성 --
### create: 데이터베이스 생성, 데이터를 저장하고 관리하는 첫 단계
# 기본 형태
# create database 데이터베이스명;
CREATE DATABASE example1; -- 문장과 문장 사이 ; 권장
CREATE DATABASE example2;
-- CREATE DATABASE example3 -- 다음 문장이 있는 경우 필수!

CREATE DATABASE example2; -- Can't create database 'example2'; database exists
# >> 데이터베이스 이름은 중복될 수 없음
# >> 같은 이름의 DB 두 번 생성 불가

-- 테이블 생성 --
### create: 테이블 생성, 테이블에 저장될 데이터의 형태와 특성을 정의
# 데이터타입, 제약조건, 기본값 등의 설정 가능
# 기본형태
# CREATE TABLE 데이터베이스.테이블명 (
# 		컬럼1 데이터타입 [선택적옵션],
# 		컬럼2 데이터타입 [선택적옵션],
# 		컬럼3 데이터타입 [선택적옵션],
# 		...
# 		컬럼N 데이터타입 [선택적옵션]
# );

CREATE DATABASE school;

CREATE TABLE `school`.`student` (
	student_id int,			-- 학생 고유번호 (정수형)
    student_name char(8),	-- 학생 이름 (문자, 최대 8자리)
    student_gender char(8)	-- 학생 성별 (문자, 최대 8자리)
);

-- cf) 문자 인코딩 추가 테이블
# : UTF-8 문자 인코딩을 사용하여 한글 등의 문자 정보를 올바르게 저장할 수 있도록 설정
CREATE TABLE `student_encoding` (
	student_id int,			-- 학생 고유번호 (정수형)
    student_name char(8),	-- 학생 이름 (문자, 최대 8자리)
    student_gender char(8)	-- 학생 성별 (문자, 최대 8자리)
)
default CHARACTER set = utf8mb4
COLLATE = utf8mb4_unicode_ci; # 정렬 방식 (문자열끼리 비교하고 정렬할 때 어떤 기준으로 할지 정하는 설정)
# cf) ci (case-insensitive): 대소문자 구분하지 않음 ('abc' = 'ABC')
# cf) utf8mb4_general_ci: 속도가 빠름, 정확도 낮음

# uft8(문자까지만 인코딩) VS utf8mb4(모든 유니코드 문자 저장 - 이모지 & 한자 포함)

# No database selected Select the default DB to be used by double-clicking its name in the SCHEMAS list in the sidebar.
# > DB(스키마)를 지정하지 않으면 테이블 생성 불가!
# 1) 테이블명 앞에 'DB명.' 첨부
# 2) 위의 오류 설명처럼 SCHEMAS 내에서 원하는 DB(ex. school) 더블 클릭

# +) 테이블명 또한 중복될 수 X

-- 데이터베이스 & 테이블 삭제
# drop: DB와 테이블의 구조와 데이터 전체를 삭제
# 기본 형태
# drop database `데이터베이스명`;
# drop table `데이터베이스명`.`테이블명`;

drop table `school`.`student`;
drop database `school`;
drop database `example1`;
drop database `example2`;
# drop database `example3`;