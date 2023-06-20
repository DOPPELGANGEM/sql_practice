-- 오라클 객체 (서브쿼리의 FROM절과 연결)
-- 서브쿼리를 사용할 수 있는 위치는?
-- SELECT절 뒤에, WHERE절 뒤에, ORDER BY절 뒤에, FROM절 뒤에
--SELECT *
--FROM (SELECT EMP_NAME, EMP_NO, HIRE_DATE, SALARY, '1' "임시" FROM EMPLOYEE);

SELECT 임시
FROM (SELECT EMP_NAME, EMP_NO, HIRE_DATE, SALARY, '1' "임시" FROM EMPLOYEE);

-- 오라클 객체
-- ================================= 1.VIEW =================================
-- FROM절 뒤에 적는 서브쿼리에 이름을 붙여서 가상의 테이블로 사용하는 것
-- 실제테이블에 근거한 논리적인 가상의 테이블(사용자에게 하나의 테이블처럼 사용가능하게 함)
-- 이름을 붙이기 전 INLINE VIEW, 이름을 붙인 건 STORED VIEW
-- VIEW를 생성하려면 권한이 필요함
CREATE VIEW EMP_VIEW1
AS SELECT EMP_NAME, EMP_NO, PHONE, EMAIL FROM EMPLOYEE;

SELECT * FROM EMP_VIEW1;

SHOW USER;
SELECT * FROM USER_ROLE_PRIVS; --0613 에햇던 Day_02_DCL_실습.sql실습에있다  ROLE은 ROLE대로 있어야됨
SELECT * FROM USER_SYS_PRIVS; -- CREATE VIEW가있어야된다.

-- ================================= 뷰의 특징 =================================
-- 테이블에 있는 데이터를 보여줄 뿐이며, 데이터 자체를 포함하고 있는 것은 아님
-- - 저장장치 내에 물리적으로 존재하지 않고 가상태이블로 만들어짐
-- - 물리적인 실제 테이블과의 링크 개념
-- * 뷰를 사용하면 특정 사용자가 원본 테이블에 접근하여 모든 데이터를 보게 하는 것을 방지할 수 있음
-- - 원본 테이블이 아닌 뷰를 통한 특정 데이터만 보여지게 만듬
-- * 뷰를 만들기 위해서는 권한이 필요함!!! (기본 RESOURCE롤에 포함 안됨!)

SELECT * FROM USER_VIEWS;
DROP VIEW EMP_VIEW1;

-- ================================= 뷰의 특징2 =================================
-- 1. 컬럼뿐만 아니라 산술 연산처리함 VIEW 생성도 가능함.
-- 연봉정보를 가지고 있는 VIEW를 생성하시오.
CREATE VIEW ANNUAL_SALARY_VIEW(EMP_ID, EMP_NAME, SALARY, ANNUAL_SALARY)
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;
SELECT * FROM ANNUAL_SALARY_VIEW;

-- 2. JOIN을 활용한 VIEW 생성도 가능함.
-- 전체 직원의 사번, 이름 , 직급명, 부서명, 지역명을 볼 수 있는 VIEW를 생성하시오. (ALL_INFO_VIEW)
CREATE VIEW ALL_INFO_VIEW
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- 위에 AS SELECT 뒤에있는 거만된다!!!! 46번째행
SELECT LOCAL_NAME FROM ALL_INFO_VIEW;

-- =============== VIEW 수정해보기 ===============
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
--  FROM EMPLOYEE;

SELECT * FROM USER_VIEWS;
SELECT * FROM V_EMPLOYEE;

SELECT * FROM V_EMPLOYEE WHERE EMP_ID = 200;

-- 선동일의 DEPT_CODE를 D8로 바꾸는 DML작성하시오
UPDATE V_EMPLOYEE SET DEPT_CODE = 'D8'
WHERE EMP_ID = '200';
-- 1행 이 (가) 업데이트되었습니다.
SELECT * FROM EMPLOYEE WHERE EMP_ID = '200';
-- 원본 테이블을 확인해보니 수정되어 있음.
-- 결론 : VIEW는 수정 가능함!!!!
ROLLBACK;


UPDATE V_EMPLOYEE
SET SALARY = 7000000
WHERE EMP_ID = '200';
-- 없는 컬럼 수정은 안됨!!!


-- ================== VIEW 옵션 ==================
-- 1. OR REPLACE
-- 수정할때 DROP 후 CREATE, 바로 재생성
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE;
SELECT * FROM V_EMPLOYEE;

--CREATE OR REPLACE VIEW V_EMPLOYEE
--AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
--FROM EMPLOYEE WITH CHECK OPTION;
--SELECT * FROM V_EMPLOYEE;

-- 2. FORCE / NOFORCE (잘안씀)
-- 기본 테이블이 존재하지 않더라도 뷰를 생성함
-- ex) CREATE FORCE VIEW ~~

-- 3. WITH CHECK OPTION
-- WHERE절 조건에 사용한 컬럼의 값을 수정하지 못하게 함.

-- 4. WITH READ ONLY
-- 뷰에 대해 조회만 가능하며 DML 불가능하게 함.

-- @실습예제1
-- --kh계정 소유의 한 employee, job, department테이블의 일부정보를 사용자에게 공개하려고 한다.
-- 사원아이디, 사원명, 직급명, 부서명, 관리자명, 입사일의 컬럼정보를 뷰(V_EMP_INFO)를 (읽기 전용으로) 생성하여라.
CREATE OR REPLACE VIEW V_EMP_INFO(사원아이디, 사원명, 직급명, 부서명, 관리자명, 입사일)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, 
NVL((SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID), '없음'), 
HIRE_DATE
FROM EMPLOYEE E
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WITH READ ONLY;

UPDATE V_EMP_INFO
SET 사원아이디 = '220' WHERE 사원아이디 = '214';
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

SELECT * FROM V_EMP_INFO;
DROP VIEW V_EMP_INFO;


-- =============== 데이터 딕셔너리(DD, Data Dictionary) ===============
-- -> 자원을 효율적으로 관리하기 위해 다양한 정보를 저장한 시스템 테이블
-- -> 데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의 작업을 할때
-- 데이터베이스 서버에 의해 자동으로 갱신되는 테이블임.
-- 사용자는 데이터 딕셔너리의 내용을 직접 수정하거나 삭제할 수 없음.
-- 데이터 딕셔너리 안에는 중요한 정보가 많이 있기 때문에 사용자는 이를 활용하기 위해서는
-- 데이터 딕셔너리 뷰를 사용하게됨.

SELECT * FROM USER_VIEWS;
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;

-- =============== 데이터 딕셔너리 뷰의 종류 ===============
-- 1. USER_XXXX : 자신의 계정이 소유한 객체 등에 관한 정보를 조회함.
-- 2. ALL_XXXX : 자신의 계정이 소유한 객체 등에 관한 정보를 조회함. (권한부여받은것)
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_VIEWS;
-- 3. DBA_XXXX : 데이터베이스 관리자만 접근이 가능한 객체 등으 정보 조회
-- 데이터베이스 관리자는 SYS 계정과 SYSTEM
-- 데이터베이스 관리자는 DBA라고도 함.
-- 데이터 분석 설계자도 있고 DA라고도 함. 
SELECT * FROM DBA_TABLES; -- 시스템계정에서 실행해야함


-- =============== 2. SEQUENCE(시퀀스) ===============
-- 순차적으로 정수 값을 자동으로 생성하는 객체, 자동 번호 발생기(채번기)의 역할을 함.
CREATE SEQUENCE SEQ_USER_NO;
CREATE SEQUENCE SEQ_USER_NO2
MINVALUE 10
MAXVALUE 999999999
START WITH 10
INCREMENT BY 1
CYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
-- =============== 시퀀스 옵션 ===============
-- START WITH 숫자 : 처음 발생시킬 시작 값 지정, 기본값 1
-- INCREMENT BY : 다음 값에 대한 증가치, 기본값1
-- MINVALUE : 발생시킬 최소값 지정
-- MAXVALUE : 발생시킬 최대값 지정
-- CYCLE/NOCYCLE : 시퀀스 값이 최대값까지 증가를 완료하면 CYCLE은 START WITH로 NOCYCLE은 에러 발생
-- CACHE/NOCACHE : 메모리상에서 시퀀스값을 관리, 기본값 20, 시퀀스 객체의 접근빈도를 줄여서 효율적인 운영 가능,

CREATE TABLE KH_SEQUENCE_TBL
(
  NO NUMBER PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  AGE NUMBER NOT NULL
);
DESC KH_SEQUENCE_TBL;
INSERT INTO KH_SEQUENCE_TBL VALUES(1, '일용자', '11');
INSERT INTO KH_SEQUENCE_TBL VALUES(2, '이용자', '22');
INSERT INTO KH_SEQUENCE_TBL VALUES(3, '삼용자', '33');
SELECT * FROM KH_SEQUENCE_TBL;
DELETE FROM KH_SEQUENCE_TBL WHERE NO = 2;
ROLLBACK;

CREATE SEQUENCE SEQ_KH_SNO;
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '일용자', '11');
-- 1 행 이(가) 삽입되었습니다
SELECT * FROM KH_SEQUENCE_TBL;

INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '이용자', '22');
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '삼용자', '33');
DELETE FROM KH_SEQUENCE_TBL WHERE NO = 2;
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '사용자', '44');
SELECT SEQ_KH_SNO.NEXTVAL FROM DUAL;
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '오용자', '55');

DROP SEQUENCE SEQ_KH_SNO; -- 시퀀스 삭제
CREATE SEQUENCE SEQ_KH_SNO; -- 시퀀스 생성
SELECT SEQ_KH_SNO.NEXTVAL FROM DUAL; -- 시퀀스 START 및 증가
SELECT SEQ_KH_SNO.CURRVAL FROM DUAL; -- 현재 시퀀스값 증가시키지 않고 확인
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '육용자', '66');
SELECT * FROM KH_SEQUENCE_TBL;


-- @실습문제
-- 고객이 상품주문시 사용할 테이블 ORDER_TBL을 만들고, 다음과 같이 컬럼을 구성하세요
-- ORDER_NO(주문 NO) : PK
-- USER_ID(고객아이디)
-- PRODUCT_CNT(주문개수)
-- ORDER_DATE : DEFAULT SYSDATE

-- ORDER_NO은 시퀀스 SEQ_ORDER_NO를 만들고 다음 데이터를 추가하세요.(현재시각 기준)
-- *kang님이 saewookkang상품을 5개 주문하셨습니다.
-- *gam님이 gamjakkang상품을 5개 주문하셨습니다.
-- *ring님이 onionring상품을 5개 주문하셨습니다.


CREATE TABLE ORDER_TBL(
  ORDER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(40),
  PRODUCT_ID VARCHAR2(40),
  PRODUCT_CNT NUMBER,
  ORDER_DATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_ORDER_NO;
--Sequence SEQ_ORDER_NO이(가) 생성되었습니다.
DESC ORDER_TBL
-- ORDER_NO은 시퀀스 SEQ_ORDER_NO를 만들고 다음 데이터를 추가하세요.(현재시각 기준)
-- *kang님이 saewookkang상품을 5개 주문하셨습니다.
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 30 , DEFAULT);
-- *gam님이 gamjakkang상품을 30개 주문하셨습니다.
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30 , DEFAULT);
-- *ring님이 onionring상품을 50개 주문하셨습니다.
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50 , DEFAULT);
SELECT * FROM ORDER_TBL;
COMMIT;


CREATE TABLE ORDER_NEW_TBL(
  ORDER_NO VARCHAR2(30) CONSTRAINT PK_ORDER_NO PRIMARY KEY,
  USER_ID VARCHAR2(40) NOT NULL,
  PRODUCT_ID VARCHAR2(40)NOT NULL,
  PRODUCT_CNT NUMBER(3),
  ORDER_DATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_ORDER_NEW_NO;
INSERT INTO ORDER_NEW_TBL
VALUES ('kh-'||
TO_CHAR(SYSDATE, 'yyyymmdd')|| '-'||
SEQ_ORDER_NEW_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO ORDER_NEW_TBL
VALUES ('kh-'||
TO_CHAR(SYSDATE, 'yyyymmdd')|| '-'||
SEQ_ORDER_NEW_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
SELECT * FROM ORDER_NEW_TBL;
COMMIT;


-- @실습문제2
-- KH_MEMBER 테이블을 생성
-- 컬럼
-- MEMBER_ID NUMBER
-- MEMBER_NAME VARCHAR2(20)
-- MEMBER_AGE NUMBER
-- MEMBER_JOIN_COM NUMBER

CREATE TABLE KH_MEMBER(
  MEMBER_ID NUMBER,
  MEMBER_NAME VARCHAR2(20),
  MEMBER_AGE NUMBER,
  MEMBER_JOIN_COM NUMBER
);

-- 이때 해당사원들의 정보를 INSERT 해야함
-- ID값과 JOIN_COM은 SEQUENCE를 이용하여 정보를 넣고자 함

-- 1.ID값은 500번 부터 시작하여 10씩 증가해 저장 하고자 함
CREATE SEQUENCE SEQ_MEMBER_ID
START WITH 500
INCREMENT BY 10
MAXVALUE 10000
NOCYCLE
NOCACHE;

DROP SEQUENCE SEQ_MEMBER_ID;


-- 2.JOIN_COM 값은 1번부터 시작하여 1씩 증가하여 저장 해야 함
--(ID값과 JOIN_COM 값의 MAX는 10000으로 설정)
-- SEQ_MEMBER_JOIN_COM
CREATE SEQUENCE SEQ_MEMBER_JOIN_COM
START WITH 1
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

DROP SEQUENCE SEQ_MEMBER_JOIN_COM;
DROP TABLE KH_MEMBER;

INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '홍길동', '20', SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '김말똥', '30', SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '삼식이', '40', SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '고길똥', '24', SEQ_MEMBER_JOIN_COM.NEXTVAL);

SELECT * FROM KH_MEMBER;
DELETE FROM KH_MEMBER;
COMMIT;

SELECT SEQ_MEMBER_JOIN_COM.CURRVAL FROM DUAL;
DROP SEQUENCE SEQ_MEMBER_JOIN_COM;










