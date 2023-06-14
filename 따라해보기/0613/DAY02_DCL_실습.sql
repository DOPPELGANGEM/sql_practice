-- DCL(Data Control Language), GRANT, REVOKE
-- 권한부여, 권한 회수
GRANT CONNECT, RESOURCE TO KHUSER01; --관리자 계정으로 해야함.
-- 관리자 계정

-- 1.sys : 슈퍼관리자, 데이터베이스 생성/삭제 권한 있음
-- 로그인 옵션으로 반드시 as sysdba로 지정.
-- Data Dictionary 소유하고 있음.

-- 2.system : 일반관리자, 데이터베이스 생성/삭제 권한 없음.
-- 롤에 대한 권한의 종류 확인
SELECT * FROM ROLE_SYS_PRIVS;
SELECT * FROM ROLE_TAB_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';














