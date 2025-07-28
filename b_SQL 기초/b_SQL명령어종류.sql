-- b_SQL 기초 > b_SQL 명령어 종류

### b_SQL 명령어 종류 ###

# SQL (Structured Query Language)
# : DB에서 데이터를 정의하고 조작하며 제어하기 위해 사용하는 표준 언어
# - 데이터베이스 구조 정의
# - 데이터를 조회, 삽입, 수정, 삭제
# - 사용자 권한 제어 등

# SQL 구성 요소
# DBMS에서 실행 할 수 있는 명령의 종류에 따라
#	>> DDL, DML, DCL로 분류

# 1. DDL (Data Definition Language)
# : 데이터 정의 언어
# - 데이터베이스 스키마와 구조를 정의하는 데 사용
# - CREATE, DROP, ALTER, TRUNCATE

# +) ctrl + shift + u (대문자 변환)

# 2. DML (Data Manipulation Language)
# : 데이터 조작 언어
# - 테이블에 데이터를 검색, 등록, 수정, 삭제하는 데 사용
# - SELECT, INSERT, UPDATE, DELETE

# 3. DCL (Data Control Language)
# : 데이터 제어 언어
# - 데이터베이스에 사용자 권한을 관리하는 데 사용
# - GRANT(승인하다), REVOKE(취소하다)

# SQL 특징
# - 비절차적 언어
#	: 결과를 '무엇을 원하는지(what)을 중심으로 작성
#	> '어떻게 가져오는지(how)'는 DBMS가 처리
# - 표준화
#	: ANSI에 의해 표준화, 대부분의 DBMS에서 사용 가능