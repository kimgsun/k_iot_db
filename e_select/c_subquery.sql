# e_select > c_subquery

/*
	=== 서브쿼리(subquery) ===
    : 메인 쿼리 내부에서 실행되는 하위 쿼리(중첩 쿼리)
    - () 괄호 안에 작성하여 필요한 값을 먼저 추출한 뒤 메인 쿼리에
		, 필요한 데이터를 동적으로 제공해주는 역할
        
	=== 특징 ===
    1) select, from, where 등 다양한 곳에서 사용 가능
    2) 하나의 값(단일 행) 또는 여러 값(다중 행)을 반환 가능
    
    == 필요성 ==
    ? 어떤 사람의 포인트가 가장 많을지
    ? 평균보다 높은 포인트를 가진 사람은 누구일지
		>> 한 번에 구할 수 없고, 값을 두 번 나누어서 찾을 경우
*/

USE `korea_db`;

# 1. 서브쿼리 예시
#	>> Bronze 등급이 아닌 회원의 이름과 등급 보기

# 1) 서브쿼리 없이 작성
SELECT name, grade
FROM `members`
WHERE
	grade != 'Bronze';
    
# 2) 서브쿼리 사용해서 작성
SELECT name, grade
FROM `members`
WHERE grade NOT IN (
	SELECT grade
    FROM `members`
    WHERE grade = 'Bronze'
);
# : NOT IN은 괄호 속 값들을 제외하라는 의미!
# >> 해당 쿼리는 Bronze를 먼저 뽑고, 해당 데이터를 제외하고 출력

# >> SELECT name, grade FROM `members` WHERE grade NOT IN ('Silver', 'Gold', 'Platinum', 'Diamond');

-- (현재 예시) 서브쿼리 사용 VS 서브쿼리 미사용 --
# 서브쿼리 없이(!= 'Bronze')
# : 'Bronze'라는 값을 직접 비교
# - 정적인 조건 O (고정된 값)
# - 유연성 낮음
#		>> 'Bronze'외에 다른 등급이 생기거나 이름이 바뀌면 수정

# 서브쿼리 사용(동적으로 비교)
# : 서브쿼리로 먼저 'Bronze'를 찾아서, 해당 등급을 제외한 회원만 보여주는 방식
# - 서브쿼리를 통해 제외할 대상을 동적으로 구해오는 방식

# 차이점
# > 조건이 단순하고 고정: 빠르고 간단 (서브쿼리 X)
# > 조건이 복잡하거나 동적으로 바뀔 수 있음: 더 유연하고 안전 - NOT IN (서브쿼리)

SELECT * FROM `members`;
SELECT * FROM `purchases`; # 구매 ID(PK), 구매 회원 ID(FK), 상품 코드, 구매일, 가격, 수량

# == 서브쿼리가 반드시 필요한 예시 == #
# 1) 구매한 이력이 있는 회원을 제외한 회원만 조회 (구매 이력이 없는 회원 조회)
SELECT name, member_id
FROM `members`
WHERE member_id NOT IN (
	-- 서브 쿼리 값이 동적으로 바뀔 수 있음
    SELECT DISTINCT member_id
	FROM `purchases`
);

# 2) 가장 포인트가 높은 회원 조회
SELECT name, points
FROM `members`
WHERE points = (
	-- 동적으로 가장 높은 포인트 점수를 계산해서 그 값과 일치한 레코드를 조회
    -- 항상 최신의 최대값을 반영 가능
    SELECT MAX(points)
    FROM `members`
);

-- SELECT name, points
-- FROM `members`
-- WHERE points = 600;

# 3) 평균보다 높은 포인트를 가진 회원 조회
SELECT AVG(points)
FROM `members`; -- 평균: 325

SELECT name, points
FROM `members`
WHERE points > (
	SELECT AVG(points)
    FROM `members`
);

# 4) 구매금액이 가장 높은 회원 조회
#	>> 그룹화 + 그룹 조건 + 정렬 + 제한
SELECT member_id
FROM `purchases`
GROUP BY
	member_id
ORDER BY
	SUM(amount) DESC
LIMIT 1;

# 위의 서브쿼리를 활용한 조회
SELECT name, points
FROM `members`
WHERE member_id = (
	SELECT member_id
	FROM `purchases`
	GROUP BY
		member_id
	ORDER BY
		SUM(amount) DESC
	LIMIT 1
);

# >> purchases에서 회원별 구매 총액을 계산하고 가장 높은 사람 1명만 추출
#		: LIMIT, ORDER BY를 사용한 서브쿼리

### 어떠한 범위를 제외하거나(EX. 한 번도 구매하지 않은 회원 제외), 동적인 데이터 계산에 필수 ###
# +) 집계, 조건 비교, 연관 데이터 추출에도 사용