### ｍ_뷰 >>> view02 ###

# 뷰의 실제 생성, 수정, 삭제 #

USE market_db;

CREATE VIEW v_view_test01 
AS
	SELECT 
		B.mem_id "Member Id", M.mem_name as "Member Name"
        , B.prod_name 'Product Name'
        , concat(M.phone1, M.phone2) as 'Office Phone'
    FROM
		buy B
        join member M
        on B.mem_id = M.mem_id;
        
SELECT * FROM v_view_test01;
        
# 조회 시 컬럼 이름에 공백이 있을 경우 백틱(`)으로 지정 
SELECT distinct `Member Id`, `Member Name` FROM v_view_test01;
        
# 뷰의 수정 #
ALTER VIEW v_view_test01
AS
	SELECT B.mem_id '회원 아이디', M.mem_name '회원 이름'
		, B.prod_name '제품 이름', concat(M.phone1, M.phone2) as '연락처'
	FROM
		buy B
			join member M
            on B.mem_id = M.mem_id;
        
SELECT * FROM v_view_test01;

# cf) 테이블 생성 시 '존재 여부에 대한 옵션'
# 		if exists, if not exists

# >> 뷰 존재 여부에 관계없이 생성 
# : create or replace (생성 또는 대체) 
# - 기존에 뷰가 있으면 덮어쓰고, 없으면 새로 생성
create or replace view v_view_test02
as
	select mem_id, mem_name from member;

select * from v_view_test02;

# cf) 뷰 정보 확인
# : describe (desc) - 열(컬럼) 정보 확인 (PK, 제약조건은 확인 불가!)
describe v_view_test02;
desc v_view_test02;

# cf) show create view 뷰이름; 
# : 생성된 뷰의 SQL 쿼리 확인
show create view v_view_test02;
# VIEW `v_view_test02` 
# AS select `member`.`mem_id` AS `mem_id`,`member`.`mem_name` AS `mem_name` 
# from `member`', 'utf8mb4', 'utf8mb4_0900_ai_ci'

# cf) 뷰를 통한 데이터 수정/삭제 O #
# : 뷰를 통해 원본 테이블의 데이터 수정 가능 
# - 단! 뷰에 포함되지 않은 컬럼에 대한 제약조건이 있을 경우 제한 될 수 있음 (권장 X) 

# member 테이블 mem_id, mem_name(필수값, NOT NULL), addr 등 존재
# > member 테이블로 생성한 v_member 뷰는 mem_id, addr만 존재 
# > 뷰에서 데이터 삽입 시 mem_name 데이터에 대한 무결성 위반으로 삽입 불가! 