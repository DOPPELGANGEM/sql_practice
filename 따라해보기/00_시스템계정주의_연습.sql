-- 관리자 입니다.
-- ctrl + enter => 실행  --:주석
-- 관리자는 계정을 생성할 수 있습니다.
-- 계정을 생성해서 데이터베이스를 동시에 사용하게 할 수 있습니다.
-- CREATE USER 아이디 IDENTIFIED BY 비밀번호
-- 명령어의 끝은 항상 세미콜론으로 구분해주어야함.

show user;
CREATE USER KHUSER01_PRACTICE IDENTIFIED BY KHUSER01_PRACTICE;
SELECT username FROM ALL_USERS;
SELECT USERNAME, ACCOUNT_STATUS, LOCK_DATE FROM DBA_USERS;

--계정을 만들었다고 해서 바로 접속가능한 것이 아님!
--접속 권한 부여 필요
GRANT CONNECT TO KHUSER01_PRACTICE;
--접속 권한 부여 완료
--접속 권한이 부여해서 테이블을 만들 수 있는 것은 아님~
--객체 생성 권한 부여 필요
GRANT RESOURCE TO KHUSER01_PRACTICE;
--객체 생성 권한 부여 완료

-- 계정만들땐 이렇게!
CREATE USER KHUSER01_PRACTICE IDENTIFIED BY KHUSER01_PRACTICE;
GRANT CONNECT, RESOURCE TO KHUSER01_PRACTICE;

CREATE USER KHUSER02_PRACTICE IDENTIFIED BY KHUSER02_PRACTICE;
GRANT CONNECT, RESOURCE TO KHUSER02_PRACTICE;










