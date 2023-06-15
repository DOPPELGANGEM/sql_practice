-- DCL(Data Control Language), GRANT, REVOKE
-- 권한부여, 권한 회수
GRANT CONNECT, RESOURCE TO KHUSER01; --관리자 계정으로 해야함.
-- 관리자 계정
-- 1.sys : 슈퍼관리자, 데이터베이스 생성/삭제 권한 있음
-- 로그인 옵션으로 반드시 as sysdba로 지정.
-- Data Dictionary 소유하고 있음.

-- 2.system : 일반관리자, 데이터베이스 생성/삭제 권한 없음.
-- 롤에 대한 권한의 종류 확인
SELECT * FROM ROLE_SYS_PRIVS; -- ROLE에 부여된 시스템 권한
SELECT * FROM ROLE_TAB_PRIVS; -- ROLE에 부여된 테이블 권한
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';
SELECT * FROM USER_SYS_PRIVS;

--============================= KHUSER01 세션에서실행 =============================--
CREATE TABLE COFFEE (
  PRODUCT_NAME VARCHAR2(20) PRIMARY KEY,
  PRICE NUMBER NOT NULL,
  COMPANY VARCHAR2(20) NOT NULL
);
-- 데이터 추가
-- INSERT한사람이 커밋을 해줘야한다.
INSERT INTO COFFEE VALUES('메가커피',3700,'MGC');
INSERT INTO COFFEE VALUES('아바라',5600,'스타벅스');
INSERT INTO COFFEE VALUES('아아', 4700, '커피빈');
INSERT INTO COFFEE VALUES('티오피', 3000, '맥심');
SELECT * FROM COFFEE;
COMMIT;
-- ============================= 시스템 세션으로 실행  =============================
GRANT SELECT ON KHUSER01.COFFEE TO KHUSER02;
GRANT INSERT ON KHUSER01.COFFEE TO KHUSER02;
-- Grant을(를) 성공했습니다.
-- ============================= KHUSER02 세션으로 실행  =============================
SELECT * FROM KHUSER01.COFFEE;
INSERT INTO KHUSER01.COFFEE VALUES('카누커피', 1500, '카누');
COMMIT;
-- ============================= 시스템 세션으로 실행  =============================
REVOKE SELECT ON KHUSER01.COFFEE FROM KHUSER02;
REVOKE INSERT ON KHUSER01.COFFEE FROM KHUSER02;
--Revoke을(를) 성공했습니다.




















































