# k_정규화 > a_정규화

/*
	1. 정규화(Normalization) 개요
    : 중복된 데이터를 제거하고, 데이터의 무결성을 유지하기 위해 테이블을 구조적으로 나누는 과정
    
    >> 정규화를 하지 않으면
		, 데이터 중복과 이상현상(삽입, 수정, 삭제 이상) 발생 가능
    
    2. 정규화 목적
		1) 중복 최소화: 데이터의 재사용성과 저장 공간 효율 증가
        2) 무결성 유지: 데이터의 일관성과 정확성 유지
        3) 이상 현상 방지: 삽입, 수정, 삭제 시 발생하는 오류 제거
        4) 유지보수 용이: 테이블 구조가 명확해짐 - 관리하기 쉬움
	
    3. 정규화 종류
    제 1 정규형 (1NF - Noraml Form)
    제 2 정규형 (2NF)
    제 3 정규형 (3NF)
    BCNF(Boyce-Code 보이스코드 정규형)
    
    cf) 정규형(Normal Form)
		: 데이터베이스 정규화 과정에서 달성하고자 하는 일정한 규칙이나 기준
        
	4. 정규화의 필요성
		id / name / course_id / course_name / course_instructor
        1	김태양		101		슬립테크			김준일
        1	김태양		102		IoT				이승아
        2	홍기수		102		IoT				이승아
        
        >> 위 테이블의 문제점
			1) 중복 데이터: 학생, 강의, 강사 정보가 중복 저장됨
            2) 이상 현상 발생
				- 삽입 이상: 수강생 없이 강의만 등록 불가
                - 수정 이상: 같은 강사명이나 학생명을 여러 행에 걸쳐 모두 수정
                - 삭제 이상: 학생 삭제 시, 강의 정보까지 삭제될 위험			
            
            cf) 이상 현상
				: 비정규화 된 테이블에서 발생하는 데이터 무결성 문제
                >> 삽입 이상, 갱신 이상, 삭제 이상
	
    5. 정규화의 단계
		1) 제 1 정규형
			: 모든 컬럼이 원자값을 가져야 함
            - 반복되는 그룹 제거 (EX: 하나의 셀에 여러 값 저장 금지)
        
		2) 제 2 정규형
			: 1NF 만족 + 기본키에 대한 완전 함수 종속
            - 부분 종속 제거 (복합키의 일부 컬럼에만 의존하는 속성 분리)
        
		3) 제 3 정규형
			: 2NF 만족 + 이행적 종속 제거
            - 비주요 속성이 다른 비주요 속성에 의존하지 않도록 분리
        
		4) BCNF 정규형
			: 후보키가 아닌 결정자가 존재하지 않아야 함
            - 3NF보다 조금 더 엄격한 조건 (모든 결정자가 후보키여야 함)
*/

create database `normal`;

use `normal`;

drop table if exists `student_course`;

create table if not exists `student_course` (
	student_id bigint not null,
    student_name varchar(50) not null,
    course_id bigint not null,
    course_name varchar(50) not null,
    course_instructor varchar(50) not null,
    
    primary key (student_id, course_id) # student_id + course_id는 중복 허용 X / 비워질 수 없음
);

insert into `student_course`
values
	(1, '이상은', 101, '생성형AI', '김준일'),
	(1, '이상은', 102, '챗GPT', '이승아'),
	(2, '박진영', 102, '챗GPT', '이승아'),
	(3, '오신혁', 103, '빅데이터', '안근수');
    
select * from `student_course`;

### 이상 현상 예시 ###
# 1) 삽입 이상
-- insert into `student_course` (course_id, course_name, course_instructor)
-- values
-- 	(104, '코리아IT', '조승범');
# Error Code: 1364. Field 'student_id' doesn't have a default value

# 2) 수정 이상
# 오류 X, 각 행에서 조건을 찾아 일일이 변경해야 함 >> 메모리 부담 존재
update `student_course`
set course_instructor = '김준이'
where
	course_id = 101;
    
set SQL_SAFE_UPDATES=0;
set SQL_SAFE_UPDATES=1;

# 3) 삭제 이상
delete from `student_course`
where
	student_id = 3;

select * from `student_course`;

### 정규화 예시 ###
# 학생, 과목, 학생-과목 테이블
# 학생과 과목 간의 관계 (N:M - 다대다)
create table `students` (
	student_id int primary key,
    student_name varchar(50) 
);

create table `courses` (
	course_id int primary key,
    course_name varchar(50),
    course_instructor varchar(50)
);

create table `student_course_connect` (
	# 학생/과목 관계 테이블
    student_id int,
    course_id int,
    primary key (student_id, course_id), -- 복합키 설정
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id)
);

insert into `students`
values
	(1, '김세훈'),
	(2, '권민현'),
	(3, '안미향');
    
insert into `courses`
values
	(101, '챗봇', '이승아'),
	(102, 'ERP', '김준일'),
    (103, '코리아IT', '조승범');

insert into `student_course_connect`
values
	(1, 101),
    (1, 102),
    (2, 102),
    (3, 103);
    
select * from `students`;
select * from `courses`;
select * from `student_course_connect`;

-- 수강생 없이 새로운 과목만 둥록
insert into `courses`
values
	(104, 'SAAS', '안근수');

-- 강사 이름 갱신
update `courses`
set
	course_instructor = '김준삼'
where
	course_id = 102;

-- 수강 정보 삭제 시 학생과 과목에 영향을 미치지 않음
delete from `student_course_connect`
where
	student_id = 3;

select * from `students`; -- 3번 학생 정보 유지
select * from `courses`;
select * from `student_course_connect`; -- 3번 학생 삭제

### 정규화 사용 모범 사례 ###
# 정규화가 무조건적인 정답은 아님!
# : 과도한 정규화는 JOIN이 많아져 성능 저하의 우려 발생
# - 실무에서는 3NF + 일부 반정규화를 조합 (성능과 무결성 사이 균형 유지!)

# cf) 베스트 프렉티스(best practice)
# : 특정 문제를 해결하거나 목표를 달성함에 있어 가장 효과적이고 검증된 방법