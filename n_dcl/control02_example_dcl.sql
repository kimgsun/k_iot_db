USE korea_db;

### SELECT 가능 - 권한 있음 ###
SELECT * FROM members;

### INSERT 불가 - 권한 없음 ###
INSERT INTO members
	(name, gender, area_code, grade, contact, join_date)
VALUES
	('TEST', 'Male', 'JEJU', 'Bronze', '010-0000-0000', '2025-08-04');

# INSERT command denied to user 'readonly_user'@'localhost' for table 'members'

### 수정 권한 부여 ###
# : 다른 사용자에게 권한을 부여하는 명령
# - 현재 로그인 된 계정이 해당 권한에 대한 권한이 존재해야 함
-- GRANT INSERT, UPDATE, DELETE ON `korea_db`.`members` TO 'readonly_user'@'localhost';
INSERT INTO members
	(name, gender, area_code, grade, contact, join_date)
VALUES
	('TEST', 'Male', 'JEJU', 'Bronze', '010-0000-0000', '2025-08-04');

UPDATE members 
SET
	grade = 'Gold'
WHERE
	name = 'TEST';

DELETE FROM members
WHERE
	name = 'TEST';
    
-- 
DELETE FROM purchases
WHERE
	purchase_id = 1;
# Error Code: 1142. DELETE command denied to user 'readonly_user'@'localhost' for table 'purchases'