-- Oracle Object, 오라클객체
-- 1.VIEW
-- 2.SEQUENCE (프로젝트에서젤많이씀)
-- 3.INDEX
-- 4.SYNONYM
-- 5.CURSOR
-- 6.PACKAGE
-- 7.ROLE
-- 8.PROCEDURE&FUNCTION

-- ================ 3.ROLE ================
-- -> 사용자에게 여러개의 권한을 한번에 부여할 수 있는 데이터베이스 객체
-- -> 사용자에게 권한을 부여할 때 한 개씩 부여하게 된다면 권한 부여 및 회수의 관리가 불편함.
-- # Oracle 설치시 기본 제공되는 ROLE
-- CONNECT : 사용자가 데이터베이스에 접속 가능하도록 하기 위한 권한이 있는 ROLE
-- RESOURCE : 사용자가 객체(테이블, 인덱스, ...)를 생성하기 위한 시스템 권한이 있는 ROLE
-- DBA : 시스템 자원을 무제한으로 사용가능하며 시스템 관리를 하기 위한 모든권한이 있는 ROLE
CREATE USER KHUSER03 IDENTIFIED BY KHUSER03;
GRANT CONNECT, RESOURCE TO KHUSER03 -- CONNECT, RESOURCE 가 롤이다.

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT'; 
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'RESOURCE';
SELECT * FROM USER_SYS_PRIVS;

-- 관리자 계정으로 확인해야한다.
-- ROLE안에는 여러가지 권한이 있당.
-- CONNECT는 1개밖에없음
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'DBA';

-- ========= 새로운 ROLE 만들기 =========
CREATE ROLE VIEWRESOURCE;
GRANT CREATE VIEW TO VIEWRESOURCE;
GRANT SELECT ON KHUSER01.COFFEE TO VIEWRESOURCE;

-- 새로운 ROLE을 KHUSER02 사용자에게 권한 부여
GRANT VIEWRESOURCE TO KHUSER02;

-- 권한 확인용 SQL
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM ROLE_TAB_PRIVS; -- ROLE에 부여된 테이블권한
SELECT * FROM ROLE_SYS_PRIVS; -- 계정에 대한 전체확인(?) 계정에롤과 권한

-- 권한 회수하기
REVOKE VIEWRESOURCE FROM KHUSER02;

-- ================ 4.INDEX (중요하고 회사에서많이쓴다) => 신입이하기엔어려움 ================
-- -> SQL 명령문의 처리속도를 향상시키기 위해서 컬럼에 대해서 생성하는 오라클 객체
-- - key-value 형태로 생성이 되며 key에는 인덱스로 만들 컬럼값, value에는 행이 저장된 주소값이 저장됨.
-- * 장점  
-- 검색속도가 빨라지고 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킬 수 있음.
-- * 단점  
-- 1.인덱스를 위한 추가 저장 공간이 필요하고, 인덱스를 생성하는데 시간이 걸림.
-- 2. 데이터의 변경작업(INSERT/UPDATE/DELETE) 이 자주 일어나는 테이블에 INDEX 생성시 오히려 성능저하가 발생할수 있다.
-- * 어떤 컬럼에 인덱스를 만들면 좋을까?
-- -> 데이터값이 중복된 것이 없는 고유한 데이터값을 가지는 컬럼에 만드는 것이 제일 좋음.
-- 그리고 자주 사용되는 컬럼에 만들면 좋음.

-- * 효율적인 인덱스 사용 예
-- where절에 자주 사용되는 컬럼에 인덱스 생성
-- > 전체 데이터 중에서 10% ~ 15% 이내의 데이터를 검새하는 경우, 중복이 많지 않은 컬럼이어야 함.
-- > 두 개 이상의 컬럼 WHERE절이나 조인(join) 조건으로 자주 사용되는 경우
-- > 한 번 입력된 데이터의 변경이 자주 일어나지 않는 경우
-- > 한 테이블에 저장된 데이터 용량이 상당히 클 경우
-- DDL 종류 (CREATE, ALTER, DROP)
SELECT * FROM EMPLOYEE;
CREATE INDEX EMP_IND_NND
ON EMPLOYEE(EMP_NAME);
SELECT * FROM USER_IND_COLUMNS
WHERE INDEX_NAME = 'EMP_IND_NND';
DROP INDEX EMP_IND_NND;

CREATE INDEX IDX_EMP_COLUMNS
ON EMPLOYEE(EMP_NAME, EMP_NO, HIRE_DATE);

-- SET TIMING ON , SET TIMING OFF 서버나뭐 인터넷속도? 그런거에따라달라서 정확한비교는어렵다
SET TIMING ON
SELECT * FROM EMPLOYEE
WHERE EMP_NO LIKE '%04%';
SET TIMING OFF

EXPLAIN PLAN FOR
SELECT * FROM EMPLOYEE
WHERE EMP_NO LIKE '%04%';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




























