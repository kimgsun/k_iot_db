# e_select > a_select

/*
	=== select(선택하다, 조회하다) ===
    : DB는 '어떻게'보다 '무엇을' 가지고 오는지가 중요
    > '무엇을' 선택할 것인지 결정하는 키워드 - select
    
    ## select 문의 기본 구조 ('작성 순서') ##
    1. select 컬럼명(열 목록): 원하는 컬럼(열) 지정
    2. from 테이블명: 어떤 테이블에서 데이터를 가져올 지 결정
    ---
    (선택 사항)
    3. where 조건식: 특정 조건에 맞는 데이터만 선택(필터링)
    4. group by 그룹화할컬럼명: 특정 열을 기준으로 그룹화
    5. having 그룹조건: 그룹화 된 데이터에 대한 조건 지정
    6. order by 정렬 컬럼명: 결과를 특정 컬럼의 순서로 정렬
    7. limit 컬럼 수 제한: 반환할 행(레코드)의 수를 제한
    
    cf) DB 내부 실제 실행 순서
    FROM 테이블 > JOIN(추가 테이블 데이터 가져오기)
    > WHERE(필터링) > group by(그룹화) > having(조건) > select(컬럼 추출)
    > order by(정렬) > limit(제한)
*/

USE korea_db;

# 1. 기본 조회
# : select 컬럼명 from `데이터베이스명`.`테이블명`;
select `name` from `korea_db`.`members`;
# > 정렬하지 않고 조회 시 데이터 입력 순서대로 출력

# cf) 전체 컬럼 조회 (전체 테이블 조회)
# 컬럼명 작성에 *(전체)를 사용하여 조회
select * from `korea_db`.`members`; -- 회원 테이블
select * from `korea_db`.`purchases`; -- 구매 목록 테이블

# cf) 두 개 이상의 컬럼 조회 시 ,(콤마)로 구분하여 나열
select
	`member_id`, `name`, `contact`
from
	`members`;
    
# cf) alias 별칭 부여 조회 (as 키워드)
# : 별칭 부여하지 않을 경우 테이블 생성 시 지정한 컬럼명으로 조회
# - 컬럼명이 변경 X, 조회 당시에 사용
# - 공백 사용시 따옴표로 반드시 지정
select
	`member_id` as 고유번호, `name` as '회원 이름', `contact` as '회원 연 락 처'
from
	`members`;

# 2. 특정 조건에 부합하는 데이터 조회
# : select A from B where C (A: 컬럼명, B: 테이블명, C: 조건식-연산자)

select
	`member_id`, `name`, `points`
from
	`members`
where
	# 조건절에는 true/false(논리값)를 반환하는 연산자 사용
	points > 200;
    
# 1) 관계 연산자
# : 이상, 이하, 초과, 미만, 일치(=), 불일치(!=)
select * from `members`
where
	name = 'Minji';
    
# 2) 논리 연산자
# and, or, not
# : 여러 조건을 조합하여 데이터 조회

# and - 모든 조건이 참
select * from `members`
where
	area_code = 'Jeju' and points >= 400;

# or - 조건 중 하나라도 참
select * from `members`
where
	area_code = 'Busan' or area_code = 'Seoul';
    
# not - 조건이 거짓일 때 (결과를 반대)
select * from `members`
where
	not area_code = 'Busan';
    
# 3) null값 연산
# : 직접적인 연산 X
-- select * from `members`
-- where
-- 		points = null;

# cf) null이 '값이 없음'을 나타냄: 그 어떤 값과도 비교하거나 연산이 불가
#	>> is null, is not null 연산자 사용 - null 여부 확인 가능(true/false)

# A is null
# null인 경우 true, 아닌 경우 false

# A is not null
# null인 경우 false, 아닌 경우 true

select * from `members`
where
	points is null;
    
select * from `members`
where
	points is not null;

# 4) between A and B 연산자
# : A와 B 사이에
# - 숫자형 데이터, 날짜형 데이터에 주로 사용
select * from `members`
where
	points between 200 and 400; -- 이상, 이하
    
select * from `members`
where
	join_date between '2021-12-31' and '2022-01-09';
    
# 5) in 연산자
# : 지정할 범위의 문자 데이터를 나역
# - 지정된 리스트 중에서 일치하는 값이 있으면 true
select * from `members`
where
	area_code in('Seoul', 'Busan', 'Jeju');
# > 문자열 데이터에 대한 or식 간소화

# 6) like 연산자
# : 문자열 일부를 검색

# cf) 와일드 카드 문자
# _(언더스코어), %(퍼센트)
# _: 하나의 기호가 한 글자를 허용 (정확하게 하나의 임의의 문자 공간을 나타냄)
# %: 무엇이든지 허용 (0개 이상의 임의의 문자 공간을 나타냄)

select * from `members`;

# 시작이 J이고 뒤는 0개 이상의 문자를 허용 검색: J%
select * from `members`
where
	name like 'J%';
    
# 시작이 J이고 뒤는 3개의 임의의 문자를 허용 검색: J___
select * from `members`
where
	name like 'J___';
    
# 어떤 문자열 내에서든 'un'이 포함만 되면 허용 검색: %un%
select * from `members`
where
	name like '%un%';
    
# 1개의 임의의 문자 + u + 0개 이상의 임의의 문자 허용 검색
#	(이름의 두 번째 글자가 u인 모든 회원 조회): _u%
select * from `members`
where
	name like '_u%';
    
# 이름이 4글자인 모든 회원 조합: ____
select * from `members`
where
	name like '____';
    
## 날짜와 시간 조회 ##
# date: 'YYYY-MM-DD'
# time: 'HH:mm:ss'

# 일치, 불일치(=, !=)
# 기간값 조회 (between A and B)

# cf) 특정 시간 기준 그 이후의 데이터 조회
select * from `members`
where
	join_date > '2022-01-02';
    
# cf) 날짜나 시간의 특정 부분과 일치하는 데이터 조회
# 날짜: year(컬럼명), month(컬럼명), day(컬럼명)
# 시간: hour(컬럼명), minute(컬럼명), second(컬럼명)
select * from `members`
where
	year(join_date) = '2024';
    
# cf) 현재 날짜나 시간을 기준으로 조히
# curdate(): 현재 날짜만 반환
# now(): 현재 날짜 + 시간 반환
select * from `members`
where
	join_date < curdate();
    
select curdate();
select now();