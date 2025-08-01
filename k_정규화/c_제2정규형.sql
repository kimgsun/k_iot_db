# k_정규화 > c_제2정규형

### 제2정규화(2NF: Second Normal Form) ###
# : 정규화의 두 번째 단계
# - 1NF(제1정규화)를 만족하면서 '모든 비기본 속성(일반 컬럼)'이 기본키에 완전히 종속된 상태
#		>> 완전 함수적 종속 상태

# cf) 함수적 종속
# - 기본키(Primary Key): 행을 고유하게 식별하는 속성(컬럼)
# - 비기본 속성: 기본키를 제외한 나머지 속성(컬럼)들
# - 완전 함수적 종속
#		: 비기본 속성이 기본키 전체에 종속
#		> 기본키의 일부만으로 결정할 수 없는 경우
#		EX) 기본키가 (A, B)일 때, C(비기본)가 A나 B 하나만으로 결정되지 않고
#			A와 B 모두 알아야 C가 정해지는 경우

# - 부분 함수적 종속
#		: 비기본 속성이 기본키의 일부에만 종속
#		> 2NF 위반
#		EX) 기본키가 (A, B)일 때, D(비기본)가 A만으로 결정 >> 부분 종속

### 2NF(제2정규형) 예시 ###
# 1) 1NF 만족 (원자값)
# 2) 기본키가 복합키일 때, 모든 비기본 속성이 기본키 전체에 의존!

-- 부서 테이블
create table departments (
	department_id bigint primary key, -- 기본키
    # 1NF 상태: 각 컬럼에 원자값만 존재
    # 기본키(department_id)
    # > 부서의 기본키를 제외한 부서 위치, 부서장 ID가 department_id에 완전 종속 O
    location varchar(50), -- 부서 위치
    supervisor_id bigint -- 부서장 ID
);

-- 직원 테이블
drop table if exists employees;

create table employees (
	employee_id bigint primary key, -- 기본키
    department_id bigint, -- 직원이 속한 부서 ID
    
    foreign key (department_id) references departments(department_id)
);

# 데이터 삽입
insert into departments
values
	(1, 'seoul', 101),
	(2, 'seoul', 102),
	(3, 'busan', 103),
	(4, 'ulsan', 104);
    
insert into employees
values
	(1, 1),
    (2, 3),
    (3, 4);
    
### 제2정규형을 위반한 테이블 ###
# 직원과 부서의 결합 테이블
create table wrong_2nf (
	employee_id bigint,
    department_id bigint,
    location varchar(50), -- 부서 위치 (2NF 위반! department 만으로 결정!)
    
    primary key (employee_id, department_id)
    # 직원ID + 부서 ID는 중복 될 수 없음
);

# >> 부분 종속이 발생하면 테이블을 분리하여 해결하는 것이 2NF를 지키는 방법
#		: 테이블을 나누어 각각 비기본 속성이 완전 종속되도록 설계

# 제2정규형 모범 사례 #
# 1) 1NF는 모든 테이블의 기본 요건
# 2) 2NF는 복합키가 있는 경우에만 고려! >> 단일 기본키 테이블은 대부분 2NF 자동 만족