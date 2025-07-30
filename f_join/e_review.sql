# f_join > e_review

# korea_db 스키마의 members, purchases 테이블 사용
USE `korea_db`;

# 1) 쿼리 작성 순서
# select / from / where / group by / having / order by / limit

# 2) 쿼리 실행 순서
# from (+ join) / where / group by / having / select / order by / limit

/*
	지역별로 여성 회원들의 총 구매 금액을 구하되, 총액이 30,000원 이상인 지역만 추출하고
		, 총액 기준으로 내림차순 정렬해서 상위 3개 지역 조회
	
	지역별로 -- group by
    여성 회원들의 -- where
    총 구매 금액을 구하되, -- 집계함수 sum()
    총액이 30,000원 이상인 지역만 추출하고, -- having
    총액 기준으로 내림차순 정렬해서 -- order by
    상위 3개 지역 조회 -- limit
*/

# 1) from + join
# : 회원 + 구매 내역이 합쳐진 하나의 가상 테이블 생성 (구매 정보가 있는 회원만 조회)
SELECT *
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id;
    
# 2) from + join + where
# : 조인된 결과에서 여성 회원들만 필터링
# - where은 그룹핑 전에 작동, 개별 행(row)에 대해 조건 적용
SELECT *
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Female';
    
# 3) from + join + where (+ group by)
# : 필터링된 여성 회원 데이터를 지역 코드를 기준으로 그룹화
SELECT
	M.area_code '지역 코드', SUM(P.amount) '총 구매금액', COUNT(distinct M.member_id) '회원 수'
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Female'
GROUP BY
	M.area_code;
# Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'korea_db.M.member_id'
#		which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
# > GROUP BY(그룹화)를 사용한 테이블의 모든 컬럼이 조회
# >> 그룹화 되지 않는 컬럼들에 대한 데이터 결합 오류 (area_code는 BUSAN이라 결합 가능하지만 member_id가 4, 8로 달라서 결합 불가)

# 4) 남은 데이터에서 having 조건 부여 (그룹화 된 데이터에 조건식 사용)
SELECT
	M.area_code '지역 코드', SUM(P.amount) '총 구매금액', COUNT(distinct M.member_id) '회원 수'
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Female'
GROUP BY
	M.area_code
HAVING
	SUM(P.amount) >= 30000;
    
# + 추가 조건 order by, limit
SELECT
	M.area_code '지역 코드', SUM(P.amount) '총 구매금액', COUNT(distinct M.member_id) '회원 수'
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Male'
GROUP BY
	M.area_code
HAVING
	SUM(P.amount) >= 30000
ORDER BY
	SUM(P.amount) desc
LIMIT 3;