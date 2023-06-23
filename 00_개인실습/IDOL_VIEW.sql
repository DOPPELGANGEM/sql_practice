SELECT * FROM IDOL_GROUP;

CREATE OR REPLACE VIEW V1_IDOL AS 
SELECT COMPANY, GROUP_NAME FROM IDOL_GROUP WHERE GROUP_NAME = 'BTS';

SELECT * FROM V1_IDOL;

CREATE OR REPLACE VIEW V2_IDOL AS 
SELECT A.COMPANY, A.GROUP_NAME, B.MEMBER_NAME, B.REAL_NAME
FROM IDOL_GROUP A, IDOL_MEMBER B
WHERE  A.GROUP_NAME = B.GROUP_NAME
AND A.GROUP_NAME = 'BTS';

SELECT * FROM V2_IDOL;

DROP VIEW V1_IDOL;
DROP VIEW V2_IDOL;

SELECT * FROM V1_IDOL;
SELECT * FROM V2_IDOL;

-- 뷰를 사용하는이유
-- 1.공통모듈처럼 사용하기위해서 (예를들어 뷰 하나를 생성해 놓으면 이 VIEW를 참조하는 어플리케이션 단에 있는 모드query 들을 수정을 하지 않고도 모드query 수정 가능)
-- 2.굉장히 복잡한 query를 VIEW로 생성했을 경우에는 소스 단에 있는 query가 매우 간결해질수있다.
-- 중요한건 보안상의 이유로 뷰를 많이 사용함! (보안상으로 이슈가 되는 테이블을 연동을 하려고 할 때 VIEW로 생성을 해서 제공을 한다!)



-- =============== 데이터 딕셔너리 뷰의 종류 ===============
-- 1. USER_XXXX : 자신의 계정이 소유한 객체 등에 관한 정보를 조회함.
-- 2. ALL_XXXX : 자신의 계정이 소유한 객체 등에 관한 정보를 조회함. (권한부여받은것)
-- 3. DBA_XXXX : 데이터베이스 관리자만 접근이 가능한 객체 등으 정보 조회
-- 데이터베이스 관리자는 SYS 계정과 SYSTEM
-- 데이터베이스 관리자는 DBA라고도 함.
-- 데이터 분석 설계자도 있고 DA라고도 함. 

-- VIEW 계정내용
SHOW USER;

SELECT * FROM DBA_TABLES; -- 시스템계정에서 실행해야함 (이거부터!!!!)
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_VIEWS;
GRANT CREATE VIEW TO IDOL_MEMBER;

SELECT * FROM USER_VIEWS;




