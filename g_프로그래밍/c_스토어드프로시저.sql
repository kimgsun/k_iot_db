# g_프로그래밍 > c_스토어드프로시저

# 1. 스토어드 프로시저(Stored Procedure) #
# : MySQL에서 프로그래밍 기능이 필요할 때 사용되는 DB 개체

# cf) 데이터베이스 개체
# : 데이터베이스에서 표현할 수 있는 유형
# - 테이블, 뷰, 스토어드 프로시저, 함수 등

# 1. 스토어드 프로시저 구조

-- 구분 문자: delimiter (기본값 ;)
# : 스토어드 프로시저의 코드 부분을 일반 SQL문 종료와 구분하기 위해
# > 스토어드 프로시저의 구분문자를 변경

-- 구분 문자 변경 ($$ 사용 권장)
delimiter $$ -- 해당 코드 이후의 구분 문자는 $$

select * from `member`; -- 일반 SQL문의 종료
select * from `member`;

/*
	2. 스토어드 프로시저 형태
    
    delimiter $$
    
    create procedure `스토어드프로시저명`
    begin
		SQL 프로그래밍 코딩
		: 해당 영역의 쿼리문의 구분은 ;으로! ($$ 나오기 전까지는 스토어드 프로시저 종료가 아님!)
        
	end $$
    
    delimiter ;
    
    3. 스토어드 프로시저 실행
    call `스토어드프로시저명`();
*/

### SQL 프로그래밍 종류 ###
# 1) if문
delimiter $$

create procedure if1()
begin
	# 프로시저 내의 변수 선언 declare
    declare myNum int;
    
    set myNum = 200;  
    
	if 100 = myNum then
		select '100은 100과 같습니다.';
	# else SQL 문장
    else
		select '100과 같지 않습니다.';
    end if;
    
end $$

delimiter ;

call if1();

-- 프로시저 삭제
drop procedure if1;

### 1. switch - case문 ###
delimiter ^^

create procedure caseProc()
begin
	declare point int; -- 점수
    declare credit char(1); -- 학점 'A', 'B', ...
	
    set point = 88;
    
    # SQL의 switch case 문장은 case when 키워드로 작성
    case
		when point >= 90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		else
			set credit = 'F';
	end case;
    select concat('취득 점수: ', point), concat('학점: ', credit);
    
end ^^

delimiter ;

call caseProc();

-- 프로시저 삭제
drop procedure caseProc;

# 프로시저 변경 시 삭제 먼저 > 변경된 프로시저 다시 생성 > 호출