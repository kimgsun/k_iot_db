# f_join > c_etc

/*
	3. 상호 조인(CROSS JOIN)
    : 두 테이브르이 모든 조합을 반환하는 조인
    - A CROSS JOIN B는 A의 각 행과 B의 각 행을 모두 조합
		> 결과 행 수: A의 행 수 X B의 행 수
        
	cf) ON 절이 필요 X
		- where 절로 필터링하지 않을 경우 모든 조합이 출력되어 결과량이 많아질 수 있음
        
	cf) 더미 데이터 생산에 사용
*/
USE `korea_db`;

# 모든 회원가 모든 구매 정보 조합
select M.name, P.product_code, P.amount
from `members` M
	CROSS JOIN `purchases` P;

# 필터 조건과 함께 사용
# > 회원의 member_id와 구매의 member_id가 일치하는 겨웅 필터링
# > 내부 조인과 같은 결과
select M.name, P.product_code, P.amount
from `members` M
	CROSS JOIN `purchases` P
where
	M.member_id = P.member_id;
    
/*
	4. 자체 조인(SELF JOIN)
    : 자기 자신을 기준으로 한 조인
	- 실제 테이블은 자기 자신 하나이지만
		, 테이블을 두 번 사용하는 것처럼 별칭(alias)을 부여하여 조인
*/

# 같은 지역에 사는 회원끼리 묶기
# area_code
select
	A.name as '회원1', B.name as '회원2', A.area_code
from
	`members` A
    join `members` B
    on A.area_code = B.area_code
where
	-- 중복 제거
    A.member_id < B.member_id;

# 등급이 같은 회원끼리 묶기
select
	A.name '회원1', B.name '회원2', A.grade
from
	`members` A
    join `members` B
    on A.grade = B.grade
where
	A.member_id < B.member_id;