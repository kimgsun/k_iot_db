-- MySQL Workbench 환경 설정 (basic.sql)

-- === 1. 주석 ===
-- 1) 단축키: ctrl + /

-- 2) 한 줄 주석: 하이픈 2개 OR 샾 1개

# 안녕하세요 주석입니다 :)
-- 이것도 주석입니다 :)

-- 3) 여러 줄 주석 /**/

/*
	줄 수에 관계 없이
    주석 처리 가능
*/

-- 이 쿼리는 모든 데이터베이스를 보여줌
SHOW DATABASES;

/*
	이 쿼리는
    모든 데이터베이스를
    보여줌
*/
SHOW DATABASES;

-- === 2. 글자 크기 변경 ===
-- 1) ctrl + 마우스 휠 위.아래

-- 2) Edit > Preferences > Fonts & Colors
-- 	: Font명 글자크기값 (Consolas 10)

-- === 3. 명령어 대소문자 설정 ===
-- : 문법의 대소문자 구분 X
-- 		>> 일관성 있는 작성을 권장!
-- 1) 명령어(문법)는 대문자
-- 2) 테이블 & 컬럼명은 소문자

show databases; -- MySQL Workbench는 소문자 자동완성이 기본
SHOW DATABASES; 

-- 대문자 변환 단축키: ctrl + shift + u
-- Edit > Format > UPCASE(대문자) / lowercase(소문자) keywords

-- === 4. 단축키 ===
# 파일 저장: ctrl + s
# 한 줄 복사: ctrl + d
# 한 줄 삭제: ctrl + l
# 새로운 SQL 탭 생성: ctrl + t

# 실행 단축키
# 1) ctrl + enter
#		: 마우스 커서가 위치한 쿼리문 하나만 실행
#		> 세미콜론(;) 기준으로 분리된 문장 중, 커서가 있는 한 문장만 실행
# 2) ctrl + shift + enter
#		: 마우스로 드래그해서 선택한 쿼리 영역만 실행
#		> 여러 줄을 드래그해서 한 번에 실행할 때 사용
#		> ctrl + a (전체선택) 후 사용

# === 5. 다크 모드 설정 (선택) ===
# : Edit > Preferences > Fonts & Colors > Color Shemas (Window 8 선택)

# https://github.com/mleandrojr/mysql-workbench-dark-theme/blob/master/code_editor.xml
# >> 해당 리포지토리의 파일 다운
# 파일 탐색기 > C드라이브> Program Files > MySQL > MySQL Workbench 8.0 > data
#	: code_editor.xml 파일　（백업　권장：　C:\user\k2_iot_db　에　넣어놓기）

