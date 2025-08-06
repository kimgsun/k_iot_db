### n_dcl >>> control01 ###

### SQL 종류 ###
# 1. DDL (Definition): 데이터 정의 언어 (데이터베이스, 데이터베이스 개체 구조 정의) 
# 		- CREATE, ALTER, DROP, TRUNCATE
# 2. DML (Manipulation): 데이터 조작 언어 (데이터 CRUD) 
#		- INSERT, SELECT, UPDATE, DELETE
# 3. DCL (Control): 데이터 통제 언어 
#		- GRANT(승인하다), REVOKE(취소하다)

### DCL(Data Control Language) ###
# : 데이터베이스 사용자 권한을 제어하는 SQL 명령어
# - 보안과 접근 제어를 위한 역할 수행

# 1. GRANT
# : 특정 사용자에게 권한을 부여

# 2. REVOKE
# : 특정 사용자에게 부여된 권한을 회수 

### DCL 사용 목적 ###
# 1. 보안 강화: 민감한 데이터에 접근 가능한 사용자 제한 가능
# 2. 데이터 무결성 유지: 특정 사용자만 데이터를 수정할 수 있도록 제한 가능
# 3. 역할 기반 접근 제어: 사용자의 역할에 따라 필요한 권한만 부여 가능 

USE `korea_db`;
SELECT * FROM `members`;
SELECT * FROM `purchases`;

# 1) 사용자 계정 생성 
# : CREATE USER 명령어 사용 
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY '1234';

# '계정명'@'접속범위설정' IDENTIFIED BY '사용자_로그인_비밀번호_설정';

# cf) 접속 범위 설정
# - 'localhost': 현 시스템 컴퓨터 (MySQL 서버가 설치된 이 컴퓨터에서만 로그인 가능) 
# - '%': 어떤 IP든지 접속 가능을 의미 (보안상 위험!, 실습 외에는 권장하지 않음)
# - '127.0.0.1': 해당 IP 주소를 가진 컴퓨터에서만 로그인 가능 (>> 127.0.0.1: localhost와 동일)

# 2) 권한 부여
GRANT SELECT ON `korea_db`.* TO 'readonly_user'@'localhost';
GRANT SELECT ON `korea_db`.* TO 'readonly_user'@'127.0.0.1';

# GRANT(승인하다)
# SELECT(조회 권한만 부여)
# ON ~(해당 스키마의 해당 테이블을 대상으로 권한 부여)
# TO ~(특정 사용자에 대한 권한 부여) 

# 3) 권한 확인 방법
# : SHOW GRANTS FOR '권한명'@'접속범위';
SHOW GRANTS FOR 'readonly_user'@'localhost';

# cf) USAGE 권한 - 사실상 아무 권한도 없는 상태 
# >> 계정은 있지만, 어떤 작업도 할 수 없는 상태
# 1) CREATE USER 이후 자동으로 USAGE 권한만 가진 계정이 생성 
# 2) 권한을 모두 회수한 뒤에도 USAGE만 남음 

# CLI(명령어)로 로그인하는 방법 - 명령 프롬프트 창 
# mysql -u 사용자이름 -p -h 호스트(위치)
# mysql -u readonly_user -p -h localhost

### 모든 사용자 계정 목록 확인 ###
SELECT user, host FROM mysql.user;
# root 계정 / root 비밀번호
# readonly 계정 / 1234 비밀번호 

### 현재 로그인 한 사용자 확인 ###
SELECT CURRENT_USER(); # 현재접속된계정@권한위치; 

### 권한 부여 ###
# root가 readonly_user에게 권한 부여
GRANT INSERT, UPDATE, DELETE ON `korea_db`.`members` TO 'readonly_user'@'localhost';

### 권한 제거 ###
# 1) 일부 권한 제거 
# REVOKE [권한 목록] ON [데이터베이스].[테이블] FROM '사용자'@'호스트';
# REVOKE INSERT, UPDATE ON korea_db.members FROM 'readonly_user'@'localhost';

# 2) 모든 권한 제거 
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'readonly_user'@'localhost';
# - ALL PRIVILEGES(권한) 
# - GRANT OPTION(권한 위임 금지) 

### 사용자 삭제 ###
DROP USER 'readonly_user'@'localhost';