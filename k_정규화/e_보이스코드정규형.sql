# k_정규화 > e_보이스코드정규형

### 보이스코드 정규화(BCNF, Boyce-Codd Normal Form) ###
# : 3.5 정규화 (제3정규형을 강화한 정규형)
# - '모든 결정자'가 '후보키'가 되어야 한다는 조건을 만족하는 정규형
# - 3NF 조건 만족 + 모든 결정자가 후보키
# > 테이블에 존재하는 모든 함수 종속 관계의 결정자가 반드시 후보키!

/*
	=== 키(Key) 개념 정리 ===
    1) 후보키(Candidate Key)
    : 테이블의 각 행을 유일하게 식별할 수 있는 최소 속성 집합
    - 유일성과 최소성을 가짐
    - 하나ㅡ이 테이블에는 여러 개의 후보키가 존재할 수 있음
    EX) 학생 테이블 '학번', '나이', '성별'
		> '학번'(후보키): '나이', '성별'을 제거해도 학생 구별 가능
        > 학번, 주민번호, 이메일 등
	
    2) 기본키(Primary Key)
    : 후보키 중 대표로 선택된 키
    - 반드시 NULL이 아니고, 중복되지 않아야 함
    - 하나의 테이블에 반드시 한 개만 존재!
    > '학번'
    
    3) 대체키(Alternate Key)
    : 후보키 중 기본키로 선택되지 않은 키
    > '주민번호', '이메일' 등
    
    cf) 결정자(Determinant)
		: 어떤 속성 집합이 다른 속성을 '결정(함수 종속)'할 수 있다면
			, 해당 속성 집합은 '결정자'
		> '학번', '주민번호' 등 대부분의 후보키가 결정자가 될 수 있음
*/

# 3NF는 비주요 속성이 후보키가 아니어도 허용
# : BCNF는 모든 결정자가 반드시 후보키(유일성, 최소성)여야 함!

# - 유일성: 중복 X, 최소성: 최소한의 속성들로만 키를 구성

### 3NF 만족 O - BCNF 만족 X ###
use `normal`;
create table if not exists `wrong_bcnf` (
	student_id int,
    student_name varchar(50),
    course_id int,
    score int,
    course_name varchar(50),
    
    primary key (student_id, course_id)
);

# 함수 종속 관계
# student_id + course_id (복합키) >> score, course_name 결정

# 과목ID(결정자)
# >> course_name 결정 (course_id는 결정자 O 그러나 후보키 X)
# >> BCNF 위반

### 해결 방법 (BCNF 예시) ###
create table 과목 (
	과목코드 int primary key, -- 결정자를 후보키로 정의
    과목명 varchar(50)
);

create table 성적 (
	학번 int,
    과목코드 int,
    점수 int,
    primary key (학번, 과목코드),
    foreign key (과목코드) references 과목(과목코드)
);

# 1NF(원자값)
# 2NF(완전함수종속) - 기본키 일부에만 종속된 속성 제거
# 3NF(이행종속제거) - A > B > C 형태 제거
# BCNF(모든 결정자가 반드시 후보키)