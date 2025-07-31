# g_프로그래밍 > a_변수

USE `market_db`;

# 테이블명의 단수, 복수 지정은 일관성이 중요!
SELECT * FROM `member`;
SELECT * FROM `buy`;

# 1. 변수 #
# : 데이터를 저장할 수 있는 임시 저장 공간 (그릇)
# - SQL에서는 간단한 데이터 연산, 조건 비교, 동적 쿼리 등에 사용

# 1) 변수 선언 규칙
# : =(등호)를 기준으로 우항의 데이터를 좌항의 변수에 저장
# >> set @변수명 = 데이터;

# 2) 변수 값 출력(사용)
# select @변수명;

# cf) SQL 변수 특징
# 1) MySQL 워크벤치 시작 시 유지, 종료할 경우 사라짐 (임시 저장 공간)
# 2) SQL 비절차적 언어: 원하는 구문을 따로 실행 (변수 선언문 실행 >> 변수 출력문 실행)

-- SQL 변수 사용 예제 --
# 변수 선언 #
set @myVar1 = 5;
set @myVar2 = 3.14; -- @ + lowerCamelCase

select @myVar1;
select @myVar2; -- 변수 초기화문을 실행하지 않으면 null값 출력

# 테이블 조회 시 변수 사용
select * from `member`;

# 166 이상인 그룹명 출력
set @txt = '가수 이름';
set @height = 166;
set @limitNumber = 1;

select
	@txt, mem_name, height
from
	`member`
where
	height > @height
limit 1;
-- limit @limitNumber;
# Error Code: 1064. You have an error in your SQL syntax;
#		check the manual that corresponds to your MySQL server version for the right syntax to use near '@limitNumber' at line
# > limit 키워드에는 제한 수의 값을 변수로 사용할 수 없음!

-- 동적 프로그래밍을 사용한 변수 사용 --
# prepare(준비하다), execute(실행하다)

# cf) prepare: sql문을 실행하지 않고 준비
# >> ? 키워드를 사용하여 코드 작성 시 값이 채워지지 않지만, 실행 시에는 채워지는 코드 작성 가능

# cf) execute: prepare 코드 실행

# prepare 실행시킬문장명(코드블럭명)
#	from '실제 SQL문';
prepare mySQL
	from 'select * from `member` order by height limit ?';
# affected Statement prepared

# execute 실행시킬문장명 using 변수명;
# >> using 뒤의 변수값이 ? 키워드에 대입
set @count = 3;
execute mySQL using @count;

# set: 변수 선언 (+ 변수명 앞에 @ 기호)
# select 변수명: 변수 값 출력
# prepare: 쿼리 준비 (실행 X)
# execute: 준비된 쿼리 실행
# ?: 실행 시 채워질 자리 (플레이스 홀더)
# using: 플레이스 홀더에 넣을 값 지정