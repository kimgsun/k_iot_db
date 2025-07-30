# f_join > d_practice

# korea_db에서 구매 금액(amount)이 가장 높은 회원의
#	member_id, name, total_amount(총 구매 금액) 조회

SELECT
	M.member_id, M.name, SUM(P.amount) AS total_amount
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
GROUP BY
	M.member_id
ORDER BY
	total_amount DESC
LIMIT 1;

## baseball_league 사용 예제 (JOIN) ##
USE `baseball_league`;

SELECT * FROM `players`; -- player_id(PK), name(선수 이름), position, birth_date, team_id(FK)
SELECT * FROM `teams`; -- team_id(PK), name(팀 이름), city, founded_year

# 1. 내부 조인
# 1) 타자인 선수와 해당 선수가 속한 팀 이름 가져오기
# - players 테이블(선수 이름)
# - teams 테이블(팀 이름)
SELECT
	P.name, T.name, P.position
FROM
	`players` P -- 기준 테이블
    INNER JOIN `teams` T
    ON P.team_id = T.team_id
WHERE
	P.position = '타자';
    
# 2) 1990년 이후에 창단된 팀의 선수 목록 가져오기
SELECT
	T.name, P.name
FROM
	`teams` T
    JOIN `players` P
    ON T.team_id = P.team_id
WHERE
	T.founded_year >= 1990; # DOSAN, SSG

# 2. 외부 조인
# 1) 모든 팀과 그 팀에 속한 선수 목록 가져오기
SELECT
	T.name team_name, P.name player_name
FROM
	`teams` T
    LEFT JOIN `players` P
    ON T.team_id = P.team_id;
    
# 2) 모든 선수와 해당 선수가 속한 팀 이름 가져오기
SELECT
	P.name player_name, T.name team_name
FROM
	`players` P
    LEFT JOIN `teams` T
    ON T.team_id = P.team_id;
    
# 모든 팀과 해당 팀에 속한 타자 목록 가져오기
SELECT
	T.name team_name, P.name player_name
FROM
	`teams` T
    LEFT JOIN `players` P
    ON T.team_id = P.team_id
WHERE
	P.position = '타자';