# h_트리거 > trigger01

### 트리거(trigger) ###
# '방아쇠', 자동 실행
# : 테이블에 특정 이벤트가 발생할 때 자동으로 실행되는 저장된 프로시저 형태의 객체

# 1. 트리거 사용 목적
-- 일정 작업 자동화: 일련의 동작을 같이 처리 (회원 가입 시 가입 로그 자동 기록)
-- 데이터 무결성: 수동으로 처리할 작업을 자동으로 처리 -> 데이터 오류 방지 (주문 후 결제 테이블 자동 삽입)

# 2. 트리거 사용 예시
-- 특정 레코드(행) 삭제 >> 삭제된 데이터에 대한 로그 기록 생성
-- 데이터 삽입 시 >> 자동으로 관련 값 계산 추가
-- 회원 정보 수정 시 >> 수정 시간 자동 갱신

# 3. 트리거 동작 방식
# 이벤트가 발생할 때만! 자동 실행 (call문으로 직접 실행 불가!)
# cf) DML 이벤트를 감지(insert, update, delete) - select는 감지 X

# 4. 트리거 종류
# 1) BEFORE 트리거: 해당 작업이 수행되기 전에 실행
# 2) AFTER 트리거: 해당 작업이 수행된 후 실행

# cf) 모든 트리거는 행(row) 단위로 실행 'for each row'

# 5. 트리거 실무 사용법 #
# : 특정 테이블에서 이벤트(insert, update, delete) 발생 시 자동 '로그 기록'
# - 재고 수량 자동 조정, 포인트 자동 적립 등 '자동화 된 비즈니스 로직 처리'

# cf) 주의점
# : 남용 시 디버깅 어렵고, 성능 저하 가능성 존재 >> 꼭! 필요한 곳에서만 사용!

# 6. 트리거 기본 문법 #
# : 스토어드 프로시저 유사 (call 문 사용 X)

create database if not exists `trigger`;
use `trigger`;

/*
	delimiter $$
    
    creat trigger 트리거명
		트리거시점(종류: after, before) 이벤트종류(insert, update, delete)
		on 테이블명
		for each row
	
    begin
		-- 실행 코드 --
	end $$
    
    delimiter ;
*/

-- 트리거 연습용 테이블
create table if not exists `trigger_table` (
	id int,
    txt varchar(10)
);

insert into `trigger_table`
values
	(1, '레드벨벳'),
    (2, '에스파'),
    (3, '하츠투하츠');

select * from `trigger_table`;

-- 트리거 생성

delimiter $$

create trigger myTrigger
	# 트리거종류 이벤트종류
    after delete -- delete 문이 발생된 이후에 작동!
    on trigger_table
    for each row -- 각 행 마다 적용 시킴 (모든 행에 트리거 적용)
    
    # 실제 트리거에서 작동할 부분
    begin
		set @msg = '가수 그룹이 삭제됨';
	end $$ -- 트리거 종료 구분 문자
    
    delimiter ;
    
    -- 트리거 사용 테스트
    set @msg = ''; # 변수 초기화
    
    # 1) 삽입 테스트
    insert into `trigger_table`
    values
		(4, '아이브');
        
	select @msg;
    
    # 2) 수정 테스트
    update
		`trigger_table`
    set
		txt = '피프티피프티'
    where
		id = 3;
        
	# cf) id값 PK 설정
    alter table `trigger_table`
    modify id int primary key;
    
    desc `trigger_table`;
    
    -- 수정
    update
		`trigger_table`
    set
		txt = '피프티피프티'
    where
		id = 3;
        
	select @msg;
    
	# 3) 삭제 테스트
    delete from `trigger_table` where id = 4;
    
    select @msg;
    
    ### 트리거(trigger) VS 트랜잭션(transaction) ###
    # 1) 트리거
    # : 이벤트 발생 시 '자동 처리'
    # - INSERT, UPDATE, DELETE 이벤트 발생 시
    # - 자동 실행, 개발자가 직접 제어 불가
    # > 자동화 된 응답 처리, 로그 기록 감시
    # EX) 게시글 수정 시 로그 자동 기록
    
    # 2) 트랜잭션
    # : 여러 작업을 하나의 작업 단위로 '묶음'
    # - 개발자가 직접 명시적으로 시작
    # - COMMIT(적용 시점), ROLLBACK(취소)로 직접 제어
    # > 데이터의 일관성 보장, 오류 복구
    # EX) 주문 처리 중 오류 시 전체 작업 롤백(취소)
    
    # cf) 원자성(Atomicitiy): 모두 성공 또는 모두 실패 (하나라도 실패 시 모두 롤백)