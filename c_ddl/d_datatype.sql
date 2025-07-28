### c_ddl > d_datatype ###

# 날짜형, 열거형 데이터 타입

/*
	5. 날짜형
    : 날짜 및 시간을 저장할 때 사용
    - data (3byte)
		: 날짜만 저장 / YYYY-MM-DD 형식
        EX) 기념일, 생일 등
        
	- time (3byte)
		: 시간만 저장 / HH:mm:SS 형식
        EX) 수업 시간, 타이머 등
        
	- datetime(8byte)
		: 날짜와 시간을 저장 / YYYY-MM-DD HH:mm:SS 형식
        EX) 주문 시간 / 가입 일자 등
*/

create database if not exists `example`;
use `example`;

create table `event` (
	event_name varchar(100),
    event_data date
);

insert into `event`
values ('Birthday', '2025-03-14');

/*
	6. 열거형(enum)
    : 사전에 정의된 값의 집합 중 하나의 값을 저장
    - 제한된 값 목록 중 선택
*/

create table `rainbow` (
	color enum('red', 'orange', 'yellow', 'purple'),
    description varchar(100)
);

insert into `rainbow`
values
	('red', '빨강'),
	('orange', '주황'),
	('yellow', '노랑'),
	('purple', '보라');

select * from `rainbow`;

-- insert into `rainbow`
-- values ('green', '초록');
# Error Code: 1265. Data truncated for column 'color' at row 1
# >> ENUM 목록에 존재하지 않는 데이터 삽입 시 발생

/*
	Database(데이터베이스)
	: SQL 언어 사용
    - 내부는 관련된 테이블로 구성 (RDBMS)
	- 데이터베이스 & 테이블 정의 문법 (DDL - CREATE, ALTER, DROP, TRUNCATE)
    
    +) DataType
*/
