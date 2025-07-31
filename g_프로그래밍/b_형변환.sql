# g_프로그래밍 > b_형변환
# : 한  데이터 타입을 다른 데이터 타입으로 바꾸는 것

USE `market_db`;

# 1) 명시적 형 변환
# case(값 as 데이터형식)
# convert(값, 데이터형식)
# >> 두 문법은 형식만 다르고 기능은 동일

select * from buy;

select avg(price) as '평균 가격'
from
	buy; # 142.9167

# cf) 형 변환 시 정수형 데이터 타입
#		>> signed, unsigned만 사용 가능 (tinyint, int 등 사용 불가!)
#		- signed: 부호가 있는 정수 (양수/음수 모두 가능)
#		- unsigned: 부호가 없는 정수

select * from buy;

select
	avg(price) as '평균 가격',
    cast(avg(price) as unsigned) as '정수 평균 가격', -- 143
    convert(avg(price), unsigned) '정수 평균 가격' -- 별칭 as 생략 가능
from
	buy;

-- 날짜 형 변환 (포맷 지정)
# date 타입: YYYY-MM-DD
# >> MySQL은 문자 형식을 자동으로 분석해서 YYYY-MM-DD 형식으로 변환
# cf) 형식이 너무 벗어나는 경우 오류 발생 (변환 X)

select cast('2025$07$31' as Date);
select cast('2025@07!31' as Date);
select cast('2025&07&31' as Date);
select cast('2025_07_31' as Date);

select convert('07/31/2025', Date); -- NULL

# cast: SQL 표준
# convert: MySQL 고유 문법

# 2) 묵시적 형 변환
# : 자동으로 데이터를 변환하느 것
select '100' + '200'; -- 300

# cf) 문자열을 이어서 작성
# concat('a', 'b') 함수를 사용
select concat('100', '200'); -- 100200