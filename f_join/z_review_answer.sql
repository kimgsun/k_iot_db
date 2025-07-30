# f_join > z_review_answer
USE korea_db;

-- 문제 1
-- 모든 회원의 이름, 등급, 구매한 상품 코드, 구매일, 구매 금액(amount)을 조회하세요.
-- 구매 기록이 없는 회원도 모두 포함되도록 하세요.
-- 단, 구매일이 오래된 순으로 정렬하세요.
SELECT 
    m.name AS 회원이름,
    m.grade AS 회원등급,
    p.product_code AS 상품코드,
    p.purchase_date AS 구매일,
    p.amount AS 구매금액
FROM 
    members m
LEFT JOIN 
    purchases p ON m.member_id = p.member_id
ORDER BY 
    p.purchase_date ASC;


-- 문제 2
-- 2023년 이후 가입한 회원 중 구매 총액이 30000원 이상인 
-- 회원의 이름, 지역코드, 총 구매금액을 조회하세요.
SELECT 
    m.name AS 회원이름,
    m.area_code AS 지역코드,
    SUM(p.amount) AS 총구매금액
FROM 
    members m
JOIN 
    purchases p ON m.member_id = p.member_id
WHERE 
    m.join_date >= '2023-01-01'
GROUP BY 
    m.member_id, m.name, m.area_code
HAVING 
    SUM(p.amount) >= 30000;

-- 문제 3
-- 회원 등급별로 구매 총액 평균을 구하고,
-- 회원 등급(grade), 구매건수(COUNT), 구매총액합계(SUM), 구매평균(AVG)을 모두 출력하세요.
-- 단, 구매가 한 건도 없는 등급은 제외하세요.

SELECT 
    m.grade AS 회원등급,
    COUNT(p.purchase_id) AS 구매건수,
    SUM(p.amount) AS 총구매금액,
    ROUND(AVG(p.amount), 2) AS 평균구매금액
FROM 
    members m
JOIN 
    purchases p ON m.member_id = p.member_id
GROUP BY 
    m.grade;