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