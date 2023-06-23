-- ====================================== PL/SQL의 반복문 (8일차로 ㄱㄱ / 230621) ======================================
SET SERVEROUTPUT ON; -- 껏다가 키면 무조건실행해야됨!!!!!

-- 1.LOOP
-- 예제. 1 ~ 5까지 반복 출력하기
DECLARE
  N NUMBER := 1;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N + 1;
--    IF (N > 5)
--      THEN EXIT;
--    END IF;
  EXIT WHEN N > 5;
  END LOOP;
END;
/

-- @실습문제1
-- 1 ~ 10사이의 난수를 5개 출력해보시오.
-- DBMS_RANDOM.VALUE(low,high); -- 난수 발생함수, low보다 크거나 같고, high보다 작은 범위의 난수 발생. 
DECLARE
  N NUMBER := 0;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(TRUNC(DBMS_RANDOM.VALUE(1,11)));
    N := N + 1;
    EXIT WHEN N > 9;
  END LOOP;
END;
/

-- 2.WHILE LOOP
-- 제어조건이 TRUE인 동안만 문장이 반복실행됨
-- LOOP를 실행할 때 조건이 처음부터 FALSE이면 한번도 수행되지 않을 수 있음.
-- EXIT절 없이도 조건절에 반복문 중지 조건을 기술할 수 있음.
-- WHITE (조건식) LOOP (실행문) END LOOP;
-- 1 ~ 5 까지 출력
DECLARE
  N NUMBER := 1;
BEGIN
  WHILE (N <= 5) LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N + 1;
  END LOOP;
END;
/

-- @실습문제2
-- 사용자로부터 2~9사이의 수를 입력받아 구구단을 출력하시오.
DECLARE
  N NUMBER := 1;
  DAN NUMBER;
BEGIN
  DAN := &단;
  IF (DAN BETWEEN 2 AND 9)
  THEN
      WHILE (N <= 9)
      LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || ' = ' ||DAN * N);
        N := N + 1;
        --EXIT WHEN N > 9 -- > EXIT를 안스기위해 WHILE 씀
      END LOOP;
  ELSE DBMS_OUTPUT.PUT_LINE('2~9사이의 수를 입력하세요.');
  END IF;
END;
/

-- 예제, 1 ~ 30까지의 수 중에서 홀수만 출력하시오.
DECLARE
  N NUMBER := 1;
BEGIN
  WHILE (N <= 30)
  LOOP
    IF (MOD(N,2) != 0)
    THEN DBMS_OUTPUT.PUT_LINE(N);
    END IF;
    N := N + 1;
  END LOOP;
END;
/

DECLARE
  N NUMBER := 0; -- 1부터 출력해야해서 0
BEGIN
  WHILE (N <= 30)
  LOOP
    N := N + 1;
    CONTINUE WHEN MOD(N,2) = 0; --continue문은 해당 '조건문만' 실행하지 않고, 반복문은 이어서 실행하는 제어문이다.
    DBMS_OUTPUT.PUT_LINE(N); 
  END LOOP;
END;
/

-- 3.FOR LOOP
-- FOR LOOP문에서 카운트용 변수는 자동 선언되므로, 따로 변수 선언할 필요가 없음.
-- 카운트 값은 자동으로 1씩 증가함.
-- REVERSE는 1씩 감소함.
-- 1 ~ 5까지 출력하시오.
BEGIN
  FOR N IN REVERSE 1..5
  LOOP
    DBMS_OUTPUT.PUT_LINE(N);
  END LOOP;
END;
/

-- @실습문제1
-- EMPLOYEE 테이블의 사번이 200 ~ 210까지의 모든 직원의 사원번호, 사원명, 이메일을 출력하시오.
DECLARE
  EINFO EMPLOYEE%ROWTYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('ID      NAME     EMAIL');
  DBMS_OUTPUT.PUT_LINE('-----------------------');
  FOR I IN 0..10
  LOOP
    SELECT * 
    INTO EINFO
    FROM EMPLOYEE
    WHERE EMP_ID = 200+I;
    DBMS_OUTPUT.PUT_LINE(EINFO.EMP_ID || '      ' || EINFO.EMP_NAME|| '           '||EINFO.EMAIL);
  END LOOP;
END;
/


-- @실습문제1
-- KH_NUMBER_TBL은 숫자타입의 컬럼 NO와 날짜타임의 컬럼 INPUT_DATE를 가지고 있다.
-- 해당 테이블에 0 ~ 99 사이의 난수를 10개 저장하시오.
CREATE TABLE KH_NUMBER_TBL(
  NO NUMBER(3),
  INPUT_DATE DATE DEFAULT SYSDATE
);
BEGIN
  FOR N IN 1..10
  LOOP
    INSERT INTO KH_NUMBER_TBL VALUES(TRUNC(DBMS_RANDOM.VALUE(0,99)), DEFAULT);
  END LOOP;
  COMMIT;
END;
/

ROLLBACK;
SELECT * FROM KH_NUMBER_TBL;


-- ====================================== PL/SQL 예외처리 ======================================
-- 시스템 오류(메모리초과, 인덱스 중복 키 등)는 오라클이 정의하는 에러로
-- 보통 PL/SQL 실행 엔진이 오류 조건을 탐지하여 발생시키는 예외임
-- 1. 미리 정의된 예외처리
-- 2. 사용자 정의 예외처리
-- 3. 미리 정의되지 않은 예외처리(심화)
--NO_DATA_FOUND
--SELECT INTO 문장의 결과로 선택된 행이 하나도 없을 경우
--DUP_VAL_ON_INDEX
--UNIQUE 인덱스가 설정된 컬럼에 중복 데이터를 입력할 경우
--CASE_NOT_FOUND
--CASE문장에서 ELSE구문도 없고 WHEN절에 명시된 조건을 만족하는 것이 없을 경우
--ACCESS_INTO_NULL
--초기화되지 않은 오브젝트에 값을 할당하려고 할 때
--COLLECTION_IS_NULL
--초기화되지 않은 중첩 테이블이나 VARRAY같은 컬렉션을 EXISTS외의 다른 메소드로 접근을 시도할 경우
--CURSOR_ALREADY_OPEN
--이미 오픈된 커서를 다시 오픈하려고 시도하는 경우
--INVALID_CURSOR
--허용되지 않은 커서에 접근할 경우 (OPEN되지 않은 커서를 닫으려고 할 경우)
--INVALID_NUMBER
--SQL문장에서 문자형 데이터를 숫자형으로 변환할 때 제대로 된 숫자로 변환되지 않을 경우
--LOGIN_DENIED
--잘못된 사용자명이나 비밀번호로 접속을 시도할 때

-- 예제
-- 이미 존재하는 사번으로 데이터를 입력하려고 할때 예외처리 하기!
-- EXCEPTION없으면 이미 존재하는 사번입니다. 가 아닌 오류메시지가 뜸 
BEGIN
  INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
  VALUES(200, '이백용자', '990621-1104323', '01033378383', 'J5', 'S5');
EXCEPTION 
--  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다!.');
  WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/

-- 링크 참조
-- https://docs.oracle.com/cd/E11882_01/timesten.112/e21639/exceptions.htm#TTPLS210














































