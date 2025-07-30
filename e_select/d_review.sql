# e_select > d_review

# korea_db 데이터베이스의 members, purchases 테이블을 기반!
# > select ~ from ~ where 구문 전체 복습!

USE `korea_db`;

# 1) 이름(name)을 기준으로 정렬
select * from `members`
order by name asc; -- 오름차순 asc 생략 가능

# 2) 3번째 레코드부터 2개의 행 조회
select * from `members` limit 2 offset 2;
select * from `members` limit 2, 2; -- offset 대신 ,(콤마)로 나열 가능

# 3) 포인트가 가장 높은 상위 3명의 회원 조회
select * from `members` order by points desc limit 3;

# 4) 서로 다른 등급 목록 조회 (중복 등급 생략)
select distinct grade from `members`;

# 5) 지역별 최대 포인트 조회
select area_code, max(points) as max_points -- as 키워드 생략 가능
from `members`
group by area_code;

# 6) 성별(gender)에 따른 평균 포인트 조회
-- 집계 함수: avg(), sum(), max(), min(), count()
select gender, avg(points) avg_points
from `members`
group by gender;

# 7) 평균 포인트가 250 이상인 등급만 조회
select grade, avg(points) avg_points
from `members`
group by grade
having avg(points) >= 250;

# 8) 등급별로 최소 포인트가 100 이상인 그룹 조회
select grade, min(points) min_points
from `members`
group by grade
having min(points) >= 100;