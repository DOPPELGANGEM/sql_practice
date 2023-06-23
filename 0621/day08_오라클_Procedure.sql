-- ====================== PL/SQL - Stored Procedure ======================
-- 프로시져는 일련의 작업 절차를 정리해서 저장해둔 것.
-- 함수와 달리 반환값이 없음.
-- 큰 업무를 분할해서 처리해 야 할 경우, 업무단위를 프로시져로 구현해서 처리함.
-- 여러 SQL문을 묶어서 미리 정의해두고 하나의 요청으로 실행할 수 있음
-- 저장 프로시져는 성능향상을 기대할 수 있음.
-- 사용법
-- CREATE OR REPLACE PROCEDURE 프로시져명(매개변수1, 매개변수2, ...)
-- -> 매개변수는 IN모드(데이터를 전달받을 때), OUT모드(수행된 결과를 받아갈 때)가 있음.
-- IS
--    변수선언가능(OUT모드)
-- 익명블록

-- 실행방법
-- EXECUTE 프로시져명

-- 생성된 프로시져 확인
SELECT * FROM USER_PROCEDURES; -- 우리가만든프로시져
SELECT * FROM ALL_PROCEDURES;


CREATE TABLE EMP_DUPLICATE
AS SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE PROC_DEL_ALL_EMP
IS
BEGIN
  DELETE FROM EMP_DUPLICATE;
END;
/
-- Procedure PROC_DEL_ALL_EMP이(가) 컴파일되었습니다.
-- 프로시저 삭제
EXECUTE PROC_DEL_ALL_EMP; 
-- 확인
SELECT * FROM EMP_DUPLICATE; 
 -- 롤백하고 다시확인하면 원복되있음 (ROLLBACK 최종커밋시점으로돌아감)
ROLLBACK;

-- Stored Procedure로 만들어보기 (PROC_ADD_ALL_EMP)
CREATE OR REPLACE PROCEDURE PROC_ADD_ALL_EMP
IS
BEGIN
  INSERT INTO EMP_DUPLICATE (SELECT * FROM EMPLOYEE);
  COMMIT;
  DMBS_OUTPUT.PUT_LINE('데이터가 모두 추가되었습니다.');
END;
/
EXEC PROC_ADD_ALL_EMP;
SELECT * FROM EMP_DUPLICATE;
ROLLBACK;

CREATE OR REPLACE PROCEDURE PROC_DEL_ONE_EMP(P_EMPID IN EMP_DUPLICATE.EMP_ID%TYPE) -- 매개변수역할
IS
BEGIN
  DELETE FROM EMP_DUPLICATE WHERE EMP_ID = P_EMPID;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE(P_EMPID ||' 사원이 삭제되었습니다.');
END;
/
EXEC PROC_DEL_ONE_EMP('&EMPID');
SELECT * FROM EMP_DUPLICATE;
EXECUTE PRO_DEL_ALL_EMP;
EXEC PROC_ADD_ALL_EMP;

-- ====================================== PROCEDURE 매개변수 IN, OUT모드 ======================================
CREATE OR REPLACE PROCEDURE PROC_SELECT_EMP_INFO(
    P_EMPID IN EMPLOYEE.EMP_ID%TYPE,
    P_ENAME OUT EMPLOYEE.EMP_NAME%TYPE,
    P_SALARY OUT EMPLOYEE.SALARY%TYPE,
    P_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS,0)
    INTO P_ENAME, P_SALARY, P_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMPID;
END;
/
-- 바인드 변수 선언
VAR B_ENAME VARCHAR2(30);
VAR B_SALARY NUMBER;
VAR B_BONUS NUMBER;
-- 바인드 변수 사용 -> 변수명 앞에 : 붙여 주기!
EXEC PROC_SELECT_EMP_INFO('&EMP_ID', :B_ENAME, :B_SALARY, :B_BONUS);

PRINT B_ENAME;
PRINT B_SALARY;
PRINT B_BONUS;

VAR RESULT VARCHAR2(200);
EXEC : RESULT := (:B_ENAME||', '||:B_SALARY||', '||:B_BONUS);
PRINT RESULT;


--@실습문제
--기존부서테이블의 DEPT_ID, DEPT_TITLE만 복제한 DEPT_COPY를 생성한다.
--DEPT_ID 컬럼 PK추가. DEPT_ID 컬럼 확장 CHAR(3)
--DEPT_COPY를 관리하는 프로시져 PROC_MAN_DEPT_COPY를 생성한다.
-- 첫번째 인자로 FLAG값 UPDATE/DELETE를 받는다.
-- UPDATE시, 데이터가 존재하지 않으면 INSERT, 데이터가 존재하면, UPDATE
-- DELETE시, 해당부서에 사원이 존재하는지를 검사해서, 존재하면, 경고메세지와 함께 실행취소함. 그렇지 않으면, 삭제.
-- 하는 프로시저를 생성하시오.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
SELECT * FROM USER_CONSTRAINTS UC
WHERE UC.TABLE_NAME = 'DEPT_COPY';
-- PK 추가 (DEPARTMENT에는 PK가 있지만 복사하면 NOT NULL만 복사 되므로 PK추가 필요)
ALTER TABLE DEPT_COPY
ADD CONSTRAINT PK_DEPT_ID PRIMARY KEY(DEPT_ID);
-- 컬럼 확장
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3);
DESC DEPT_COPY;
DESC DEPARTMENT;


CREATE OR REPLACE PROCEDURE PROC_MAN_DEPT_COPY(
    P_FLAG IN VARCHAR2,
    P_DEPTID IN DEPARTMENT.DEPT_ID%TYPE,
    P_DTITLE IN DEPARTMENT.DEPT_TITLE%TYPE
)
IS
    P_CNT NUMBER := 0;
BEGIN
    -- UPDATE시, 데이터가 존재하지 않으면 INSERT, 데이터가 존재하면, UPDATE
    IF P_FLAG = 'UPDATE'
    THEN
        -- P_CNT를 이용해서 부서의 존재여부를 체크
        SELECT COUNT(*)
        INTO P_CNT
        FROM DEPT_COPY
        WHERE DEPT_ID = P_DEPTID;
        IF P_CNT > 0
        THEN
            -- 존재함.
            UPDATE DEPT_COPY
            SET DEPT_TITLE = P_DTITLE
            WHERE DEPT_ID = P_DEPTID;
        ELSE
            -- 존재하지 않음.
            INSERT INTO DEPT_COPY VALUES(P_DEPTID, P_DTITLE, 'L1');
        END IF;
-- DELETE시, 해당부서에 사원이 존재하는지를 검사해서, 존재하면, 경고메세지와 함께 실행취소함. 그렇지 않으면, 삭제.
    ELSIF P_FLAG = 'DELETE'
    THEN
        -- P_CNT를 이용해서 부서원의 존재여부를 체크
        SELECT COUNT(*)
        INTO P_CNT
        FROM EMPLOYEE
        WHERE DEPT_CODE = P_DEPTID;
        IF P_CNT > 0
        THEN
            -- 부서원이 존재함.
            DBMS_OUTPUT.PUT_LINE('ERROR : 해당 부서원이 존재하므로, 부서를 삭제할 수 없습니다.');
            RETURN;
        ELSE
            -- 부서원이 존재하지 않음.
            DELETE FROM DEPT_COPY WHERE DEPT_ID = P_DEPTID;
            DBMS_OUTPUT.PUT_LINE('SUCCESS : 부서가 삭제되었습니다.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR : 해당 작업은 존재하지 않습니다.');
        RETURN;
    END IF;
    COMMIT;
END;
/
EXEC PROC_MAN_DEPT_COPY('UPDATE', 'D10', '경리부');
EXEC PROC_MAN_DEPT_COPY('DELETE', 'D10', '');
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY;
INSERT INTO DEPT_COPY (SELECT * FROM DEPARTMENT);
COMMIT;
ROLLBACK;
DROP TABLE DEPT_COPY;

-- ====================================== PL/SQL의 FUNCTION ======================================
-- -> 리턴 값이 존재하는 Stored Procedure
-- 사용법
-- CREATE OR REPLACE FUNCTION 함수명(매개변수1, 매개변수2, ..)
-- RETURN 자료형
-- IS
--     지역변수 선언
-- BEGIN
--     실행문
-- END;
-- /
-- 실행방법
-- EXEC 바인드 변수 := 함수명(매개변수1, 매개변수2, ...);

-- 예제
-- 문자열을 입력받아 양 옆에 d와b를 붙여 헤드폰을 씌어주세요
-- ^_^ -> d^_^b
CREATE OR REPLACE FUNCTION GET_HEADPHONE
(
  P_STR VARCHAR2
)

RETURN VARCHAR2
IS
  RESULT VARCHAR2(100);
BEGIN
  RESULT := 'd'||P_STR||'b';
  RETURN RESULT;
END;
/
VAR vStr VARCHAR2;
EXEC :vStr := GET_HEADPHONE('&arg');
PRINT vStr;
  
  
-- @실습예제1
-- 사번을 입력받아 해당 사원의 연봉을 계산하여 리턴하는 저장함수를 만들어 출력하시오.
-- 함수명 : FN_SALARY_CALC, 바인드 변수명 : VAR_CALC
CREATE OR REPLACE FUNCTION FN_SALARY_CALC
(
  V_EMPID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS
  -- SELECT한 SALARY값 받을 변수
  V_SALARY EMPLOYEE.SALARY%TYPE;
  -- 계산한 결과값 받을 변수
  CALC_SAL NUMBER;
BEGIN
  SELECT SALARY
  INTO V_SALARY
  FROM EMPLOYEE
  WHERE EMP_ID = V_EMPID;
  CALC_SAL := V_SALARY * 12;
  RETURN CALC_SAL;
END;
/

VAR VAR_CALC NUMBER;
EXEC :VAR_CALC := FN_SALARY_CALC('&EMP_ID');
PRINT VAR_CALC;
-- SELECT문에서 실행해보기
SELECT FN_SALARY_CALC('&EMP_ID') FROM DUAL;
SELECT EMP_NAME "사원명", FN_SALARY_CALC(EMP_ID) "연봉" FROM EMPLOYEE;


-- @실습문제2
-- 사원번호를 입력받아서 성별을 리턴하는 저장함수 FN_GET_GENDER를 생성하고, 실행하세요.
CREATE OR REPLACE FUNCTION FN_GET_GENDER
(
  V_EMPID VARCHAR2  
)
RETURN CHAR
IS
  -- 지역변수 선언
  V_GENDER CHAR(3);
BEGIN
  SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여')
  INTO V_GENDER
  FROM EMPLOYEE
  WHERE EMP_ID = V_EMPID;
  -- 결과값 반환
  RETURN V_GENDER;
END;
/
-- SELECT문으로 출력하기 
SELECT FN_GET_GENDER('207') FROM DUAL;
SELECT EMP_NAME, FN_GET_GENDER(EMP_ID) FROM EMPLOYEE;


-- @실습예제3
-- 사용자로부터 입력받은 사원명으로 검색하여 해당사원의 직급명을 얻어 오는 저장함수
-- FN_GET_JOB_NAME를 작성하세요. (해당사원이 없다면 '해당사원없음' 출력)

CREATE OR REPLACE FUNCTION FN_GET_JOB_NAME
(
  V_ENAME EMPLOYEE.EMP_NAME%TYPE
)
RETURN VARCHAR2
IS
  V_JNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT JOB_NAME
    INTO V_JNAME
    FROM EMPLOYEE
    LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_NAME = V_ENAME;
    RETURN V_JNAME;
EXCEPTION
  WHEN NO_DATA_FOUND THEN RETURN '해당사원없음';
END;
/

-- SELECT로 출력해보기
SELECT FN_GET_JOB_NAME('선동일') FROM DUAL;







































