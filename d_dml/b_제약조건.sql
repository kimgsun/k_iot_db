# d_dml > b_제약조건

### 제약조건(Constraint) ###
# : 데이터의 정확성, 일관성, 신뢰성, 무결성을 유지하기 위해
#		, DB 시스템을 활용하여 강제하는 규칙

# 1. 제약 조건 사용 목적
# 무결성 유지: 잘못된 데이터 삽입 방지
# 오류 방지: 잘못된 입력, 삭제, 변경 등을 방지
# 관계 유지: 테이블 간의 연결을 확실하게 유지

# 2. 제약 조건의 종류
# 1) Primary Key(기본 키)
# 2) Foriegn Key(외래, 참조 키)
# 3) Unique
# 4) Check
# 5) Not NULL
# 6) Default

/*
	1. PK (Primary Key)
    : 기본 키, 각 행을 고유하게 구분하는 역할(레코드 구분의 식별자)
    - 중복 불가(고유성), null 허용 X(반드시 유효한 데이터를 포함)
    
    cf) 유일성 제약
		- 하나의 테이블 당 하나의 기본 키만 지정 가능!
		> 테이블의 특성을 반영한 열 선택 권장 || PK 컬럼을 따로 생성 권장
		EX) members(member_id), books(book_id | isbn)
*/

drop database if exists `example`;
create database `example`;

use `example`;

# 기본 키 지정 방법
# 1) 테이블 생성 시 PK 컬럼에 명시: 컬럼명 데이터타입 PRIMARY KEY,
# 2) 테이블 생성 시 마지막 열에 제약 조건 명시: PRIMARY KEY (설정할 컬럼명)
create table `students` (
	# student_id bigint primary key,
    student_id bigint,
    name varchar(100),
    primary key (student_id)
);

desc `students`; # 테이블의 구조 확인 (데이터 확인 X)

insert into `students`
values
	(1, '이승아'),
	(2, '이도경'),
	(3, '조승범');
    
select * from `students`; # 테이블 내부의 실질적인 데이터 확인

-- insert into `students`
-- values
-- 		(1, '김명진');
# Error Code: 1062. Duplicate entry '1' for key 'students.PRIMARY'
# > PRIMARY KEY는 값이 중복 불가!

# cf) DDL의 수정 키워드 alter
# : 테이블 구조의 제약 조건 수정
alter table `students`
drop primary key;

# 기존 테이블의 기본 키 제약 조건 삭제 시 not null에 대한 조건은 사라지지 않음
desc `students`;

alter table `students`
modify `student_id` bigint null; -- not null 조건을 null로 수정

desc `students`;

# '기존 테이블'에 제약 조건 추가
alter table `students`
add primary key (student_id);

desc `students`;

/*
	2. FK (Foreign Key)
    : 외래, 참조 키
    - 두 테이블 사이의 관계를 연결, 데이터의 무결성 유지
    - 다른 테이블의 기본 키(PK)를 참조하여 관계를 표현
    - 두 테이블 간의 연결 (RDBMS)
    
    +) 기본 테이블 (기본 키가 있는 테이블)
    +) 참조 테이블 (외래 키가 있는 테이블)
    
    회원(members) - 주문(orders)
    > 고객이 실제로 존재하는 지 확인, 고객과 주문 간의 관계 명시
*/

create table `members` (
	member_id bigint primary key,
    name varchar(100)
);

drop table if exists `members`;

create table `orders` (
	order_id bigint primary key,
    order_date date,
    member_id bigint, -- 주문자 정보
    # 외래 키 지정 방법
    # foreign key (참조컬럼, 현 테이블의 컬럼명) references 기본테이블(기본컬럼, pk컬럼)
    foreign key (member_id) references `members`(member_id)
);

drop table if exists `orders`;

-- insert into `orders`
-- values
-- 		(1, '2025-07-29', 123);
# Error Code: 1452. Cannot add or update a child row
# : a foreign key constraint fails (`example`.`orders`, CONSTRAINT `orders_ibfk_1`
# FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`))
# > `members`의 member_id 123 이 없어서 삽입 불가

insert into `members`
values
	(123, '김보민');
    
insert into `orders`
values
	(1, '2025-07-29', 123);
    
### 외래 키 제약 조건 수정 (삭제 & 추가) ###
# cf) 외래 키 제약 조건 삭제 시
#		- 해당 데이터를 참조하는 데이터가 있을 경우 삭제 불가!
-- alter table `orders`
-- drop foreign key member_id;

truncate table `orders`;

# 1) 제약 조건 이름 검색 필수
# where 조건 내에서 테이블명과 컬럼명을 데이터처럼 사용: 따옴표 지정('')
# > 문법 그 자체로 인식
select constraint_name
from information_schema.key_column_usage
where table_name = 'orders' and column_name = 'member_id';

# >>> `orders_ibfk_1'

# 2) 참조 테이블의 외래 키 삭제
alter table `orders`
drop foreign key orders_ibfk_1;

desc `orders`;
# > MUL: 외래 키 지정 시 MySQL이 자동으로 인덱스(index) 생성
#		- 외래 키 삭제 후에도 존재

select constraint_name
from information_schema.key_column_usage
where table_name = 'orders' and column_name = 'member_id';
# >> foreign key 제거 완료!

# 기존 테이블의 외래 키 제약 조건 추가
alter table `orders`
add constraint
	foreign key (member_id)
	references `members`(member_id);

desc `orders`;
# : foreign key 설정은 desc에서 MUL로 표시
desc `members`;