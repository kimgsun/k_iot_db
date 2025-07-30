# e_select > z_review

# 1. DDL VS DML

# 1) DDL(Data Definition Language)
# : 데이터베이스의 구조 정의
# - CREATE, ALTER, DROP, TRUNCATE

# 2) DML(Data Manipulation Language)
# : 데이터 조작(CRUD)
# - INSERT, SELECT, UPDATE, DELETE

# 2. SELECT문 기본 구조 (작성 순서)
/*
	SELECT
		컬럼명
        1) 여러 개 나열시 ,(콤마)로 구분
        2) 모든 컬럼 조회시 *: 테이블 정의 시 작성되는 컬럼순으로 표시
        3) 조회 시의 컬럼 별칭: as 키워드로 작성 (+ 생략 가능)
	from
		테이블명
	where
		조건 (cf. update, delete는 조건 권장!)
	group by
		그룹기준 (그룹화를 하기 위해서는 묶일 수 있는 데이터만 조회 가능)
	having
		그룹 조건 (반드시! 그룹화 된 이후 사용)
	order by
		정렬 기준
		1) asc: 오름차순 - 기본값(생략 시)
        2) desc: 내림차순 - 작성 필수
			cf) desc 테이블명: 테이블 구조 확인 (컬럼 구조)
			cf) show database: 데이터베이스 목록 확인
	limit
		개수 제한;
        +) offset 시작 열 지정 가능 (0부터 시작)
*/

# 3. SELECT문 실행 순서
/*
	1) FROM: 조회할 테이블 선택
    2) WHERE: 조건에 맞는 행 필터링
    3) GROUP BY: 그룹 기준 설정
    4) HAVING: 그룹 조건 필터링
    5) SELECT: 필요한 컬럼 선택
    6) ORDER BY: 정렬
    7) LIMIT: 출력할 행 제한
    
    cf) distinct: 해당 컬럼에서 중복되는 데이터를 제거하고 딱 하나만 남김
*/

/*
	WHERE 절 연산자 정리
    
    1) 비교 연산자: 값 비교
		>> 부등호, =(일치), !=(불일치)
        
	2) 논리 연산자: 조건 연결
		>> AND, OR, NOT
        
	3) NULL 체크: NULL 여부 확인
		>> IS NULL, IS NOT NULL
        
	4) 범위 연산자: A 이상 B 이하 범위
		>> BETWEEN A AND B (숫자형, 날짜형)
        
	5) 목록 연산자: 여러 값 중 포함 여부
		>> IN (값1, 값2, ...)
        
	6) 패턴 연산자: 와일드 카드(_, %)로 문자열 검색
		>> LIKE '_a%'
			- _: 자릿수 1개
            - %: 0개 이상
            
	7) 집합 연산자: 결과 집합 병합/비교
		>> UNION(합), INTERSECT(교), EXCEPT(차)
			(MySQL은 UNION만 지원 - 합집합)
*/

USE `korea_db`;
SELECT * FROM `members`;

-- 2024년 회원 중에서 이름에 'ji'이 들어간 회원을 조회 (name, area_code 조회)
-- +) name과 area_code 컬럼은 각각 '회원 이름', '지역 코드'로 컬럼명 조회
SELECT
	name '회원 이름', area_code '지역 코드' # as 키워드 생략 가능
FROM
	`members`
WHERE
	YEAR(join_date) = 2024
    AND name LIKE '%ji%';