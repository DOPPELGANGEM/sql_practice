-- ====================== PL/SQL ======================
-- Oracle's Procedural Language Extensin to SQL의 약자
-- -> 오라클 자체에 내장되어 있는 절차적 언어로써, SQL의 단점을 보완하여 SQL문장 내에서
-- 변수의 정의, 조건처리, 반복처리 등을 지원함.


-- PL/SQL의 유형
-- 1.익명블록 (Anonymous Block)
-- 2.프로시저 (Procedure)
-- 3.함수 (Function)

-- PL/SQL의 구조(익명블록)
-- 1. 선언문 (선택 : 강제하지않음)
-- 2. 실행부 (필수)
-- 3. 예외처리부 (선택 : 강제하지않음)
-- 4. END; (필수)
-- 5. / (필수)
    --DECLARE
    --BEGIN
    --EXCEPTION
    --END;
    --/
SET SERVEROUTPUT ON; 
-- SQLDEVELOPER 껏다 키면 다시 실행!
SET TIMING ON;
SET TIMING OFF; -- 시간안나오게한다

BEGIN 
  DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

-- PL/SQL 실행해보기
DECLARE
  vid NUMBER;
BEGIN
  SELECT EMP_ID
  INTO vid
  FROM EMPLOYEE
  WHERE EMP_NAME = '선동일'; -- 선동이 NO DATA~
  DBMS_OUTPUT.PUT_LINE('ID = '||vid);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA~');
END;
/

-- ========================== PL/SQL 변수 ==========================
-- # 변수의 자료형
-- 1. 기본자료형
-- VARCHAR2, NUMBER, DATE, BOOLEAN, ...
-- 2. 복합자료형
-- Record, Cursor, Collection

-- 2.1 %TYPE 변수
DESC EMPLOYEE;
DECLARE 
  VEMPNO EMPLOYEE.EMP_NO%TYPE;
  VENAME EMPLOYEE.EMP_NAME%TYPE;
  -- %TYPE 속성을 사용하여 선언한 VEMPNO 변수는 해당 테이블의 컬럼과 같은 자료형과 크기를 
  -- 그대로 참조해서 만들어짐.
  -- 컬럼의 자료형이 변경되면 참조하는 레퍼런스 변수의 자료형과 크기도 자동으로 반영되므로
  -- 별도로 수정할 필요가 업승.
BEGIN
  SELECT EMP_NO, EMP_NAME
  INTO VEMPNO, VENAME
  FROM EMPLOYEE
  WHERE EMP_ID = '200';
  DBMS_OUTPUT.PUT_LINE(VENAME||' : '||VEMPNO);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO Data!!');
END;
/

-- 2.2 %ROWTYPE
-- 행(ROW) 단위로 참조하는 %ROWTYPE 속성도 있음.

DECLARE
  VEMP EMPLOYEE%ROWTYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME
  INTO VEMP.EMP_ID, VEMP.EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_NAME = '선동일';
  DBMS_OUTPUT.PUT_LINE(VEMP.EMP_ID || ' : ' || VEMP.EMP_NAME);
END;
/


DECLARE
  VEMP EMPLOYEE%ROWTYPE;
BEGIN
  -- * 과 ROWTYPE 변수를 이용해서 한 레코드를 통째로 담을 수 있음 (위에구문과 똑같은 결과를 나타냄!)
  SELECT *
  INTO VEMP
  FROM EMPLOYEE
  WHERE EMP_NAME = '선동일';
  DBMS_OUTPUT.PUT_LINE(VEMP.EMP_ID || ' : ' || VEMP.EMP_NAME);
END;
/


-- @실습문제1
-- 사번, 사원명, 직급명을 담을 수 있는 참조변수를 통해서
-- 송종기 사원의 사번,사원명 직급명을 익명블럭을 통해 출력하세요~

DECLARE
  VEMPID EMPLOYEE.EMP_ID%TYPE;
  VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
  VJOBNAME JOB.JOB_NAME%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, JOB_NAME
  INTO VEMPID, VEMPNAME, VJOBNAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  WHERE EMP_NAME = '송종기';
  DBMS_OUTPUT.PUT_LINE(' 송종기 사번 :  ' ||VEMPID||', 사원명: '||VEMPNAME||', 직급명 : '||VJOBNAME);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;
/


-- ======================= PL/SQL 입력 받기 =======================
-- 사원번호를 입력받아서 사원의 사원번호, 이름, 급여, 입사일을 출력하시오.

DECLARE
  VINFO EMPLOYEE%ROWTYPE;
BEGIN
  SELECT * 
  INTO VINFO
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID'; -- 메시지역할 띄어쓰기하면안됨
  DBMS_OUTPUT.PUT_LINE('사원번호 : '||VINFO.EMP_ID||', 이름 : '||VINFO.EMP_NAME||', 급여 : ' ||
  VINFO.SALARY||', 입사일 : '||VINFO.HIRE_DATE);
END;
/

-- @실습문제2
-- 사원번호를 입력받아서 해당사원의 사원번호, 이름, 부서코드, 부서명을 출력하세요.
DECLARE
  VEMPID EMPLOYEE.EMP_ID%TYPE;
  VNAME EMPLOYEE.EMP_NAME%TYPE;
  VDCODE DEPARTMENT.DEPT_ID%TYPE;
  VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  INTO VEMPID, VNAME, VDCODE, VDTITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
  WHERE EMP_ID = '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사원번호 : '||VEMPID||', 이름 : '||VNAME||', 부서코드 : '||VDCODE||', 부서명 : '||VDTITLE);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다.');
END;
/


BEGIN 
  INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '칠용자', 77);
  COMMIT;
END;
/

-- @실습문제3
-- EMPLOYEE 테이블에서 사번의 마지막번호를 구한뒤, +1한 사번에 사용자로부터
-- 입력받은 이름, 주민번호, 전화번호,직급코드, 급여등급을 등록하는 PL/SQL을 작성하시오.
DECLARE
  LAST_NUM EMPLOYEE.EMP_ID%TYPE;
BEGIN
  SELECT MAX(EMP_ID)
  INTO LAST_NUM
  FROM EMPLOYEE;
  
  INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
  VALUES(LAST_NUM+1, '&NAME', '&PERSON_NO', '&MOBILE', '&JCODE', '&SCODE');
  COMMIT;
END;
/

SELECT * FROM EMPLOYEE ORDER BY 1 DESC;

-- PL/SQL: ORA-00947: not enough values
-- 원인과 조치방안, 해결방안을 작성하시오.
-- 컬럼이 14개인데 6개 밖에 작성하지 않았음. 컬럼의 갯수가 부족해서 발생하는 오류임.
-- 해결방안 1. 6개 -> 14개로 늘리면 됨.
-- 해결방안 2. 6개만 입력되도록 하는 것.


SELECT * FROM KH_SEQUENCE_TBL;
ROLLBACK;

SELECT * FROM USER_SEQUENCES;


-- ====================================== PL/SQL의 조건문 ======================================
-- 1. IF (조건식) THEN (실행문) END IF;
-- @실습문제1
-- 사원번호를 입력받아서 사원의 사번, 이름, 급여, 보너스율을 출력하시오
-- 단, 직급코드가 J1인 경우 '저희 회사 대표님입니다.'를 출력하시오.
DECLARE
    EMP_INFO EMPLOYEE%ROWTYPE;
BEGIN
    --SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    SELECT *
    INTO EMP_INFO
    FROM EMPLOYEE
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('사번 : '|| EMP_INFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| EMP_INFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| EMP_INFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스율 : '|| EMP_INFO.BONUS*100||'%');
    
    IF (EMP_INFO.JOB_CODE = 'J1')
    THEN DBMS_OUTPUT.PUT_LINE('저희 회사 대표님입니다.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다.');
END;
/

-- 2. IF (조건식) THEN (실행문) ELSE (실행문) END IF;
-- @실습문제2
-- 사원번호를 입력답아서 사원의 사번, 이름 부서명 직급명을 출력하시오
-- 단 ,직급코드가 J1인 경우 '대표', 그 외에는 '일반직원'으로 출력하시오.
-- 사번 : 200
-- 이름 : 선동일
-- 부서명 : 총무부
-- 직급명 : 부사장
-- 소속 : 일반직원

-- 변수 Type을 명시적으로 작성하지 않는 방법 %TYPE
DECLARE
  EMPID EMPLOYEE.EMP_ID%TYPE; 
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
  JCODE JOB.JOB_CODE%TYPE;
  JNAME JOB.JOB_NAME%TYPE;
  EMPTEAM VARCHAR2(20);
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_CODE, JOB_NAME
  INTO EMPID, EMPNAME, DTITLE, JCODE, JNAME
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
  LEFT JOIN JOB USING(JOB_CODE)
  WHERE EMP_ID = '&EMP_ID';
  
  IF (JCODE = 'J1') THEN EMPTEAM := '대표';
  ELSIF (JCODE = 'J2') THEN EMPTEAM := '임원진';
  ELSE EMPTEAM := '일반직원';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('사번 : '|| EMPID);
  DBMS_OUTPUT.PUT_LINE('이름 : '|| EMPNAME);
  DBMS_OUTPUT.PUT_LINE('부서명 : '|| DTITLE);
  DBMS_OUTPUT.PUT_LINE('직급명 : '|| JNAME);
  DBMS_OUTPUT.PUT_LINE('소속 : '|| EMPTEAM);
END;
/



-- 3. IF (조건식) THEN (실행문) ELSEIF (조건식) THEN (실행문) ELSE (실행문) END IF;
--@실습문제 
--사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오
--500만원 이상(그외) : A
--400만원 ~ 499만원 : B
--300만원 ~ 399만원 : C
--200만원 ~ 299만원 : D
--100만원 ~ 199만원 : E
--0만원 ~ 99만원 : F

/*
  -- 참고 url : https://ldgeao99-developer.tistory.com/225
  [declare begin end 기본구조 설명 및 문법실행]
  1. declare begin end - PL/SQL 기본으로 쿼리, 문법을 실행할 수 있습니다
  2. declare [선언부] - 변수, 상수를 선언할 수 있습니다
  3. begin [실행부] - 제어, 반복문, 함수 등 다양한 로직 기술을 실행합니다
  4. end [종료부] - 실행된 로직의 종료를 선언합니다
  5. 실행한 결과는 DBMS_OUTPUT에서 확인할 수 있습니다
*/

-- 변수 Type을 명시적으로 작성하지 않는 방법 %TYPE
DECLARE
  EMPID EMPLOYEE.EMP_ID%TYPE;
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  SALLEVEL EMPLOYEE.SAL_LEVEL%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY --테이블에서 조회할 컬럼 선택
  INTO EMPID, EMPNAME, SALARY -- 조회된결과를 받아올변수 (INTO : 데이터를 삽입)
  FROM EMPLOYEE
  WHERE EMP_ID = '&사번';
  SALARY := SALARY;
  IF (SALARY BETWEEN 0 AND 990000) THEN SALLEVEL := 'F';
  ELSIF (SALARY BETWEEN 1000000 AND 1990000) THEN SALLEVEL := 'E';
  ELSIF (SALARY BETWEEN 2000000 AND 2990000) THEN SALLEVEL := 'D';
  ELSIF (SALARY BETWEEN 3000000 AND 3990000) THEN SALLEVEL := 'C';
  ELSIF (SALARY BETWEEN 4000000 AND 4990000) THEN SALLEVEL := 'B';
  ELSE SALLEVEL := 'A';
  END IF;
  DBMS_OUTPUT.PUT_LINE('사번 : '||EMPID);
  DBMS_OUTPUT.PUT_LINE('이름 : '||EMPNAME);
  DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
  DBMS_OUTPUT.PUT_LINE('급여등급 : '||SALLEVEL);
END;
/

-- ======= 급여등급 출력문 CASE문으로 바꿔보기 =======
DECLARE
  EMPID EMPLOYEE.EMP_ID%TYPE;
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  SALLEVEL EMPLOYEE.SAL_LEVEL%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMPID, EMPNAME, SALARY 
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    SALARY := TRUNC(SALARY / 1000000);
    CASE SALARY
      WHEN 0 THEN SALLEVEL := 'F'; -- 0~99 -> 0
      WHEN 1 THEN SALLEVEL := 'E'; -- 100 ~ 199 -> 1
      WHEN 2 THEN SALLEVEL := 'D'; -- 200 ~ 299 -> 2
      WHEN 3 THEN SALLEVEL := 'C'; -- 300 ~ 399 -> 3
      WHEN 4 THEN SALLEVEL := 'B'; -- 400 ~ 499 -> 4
      ELSE SALLEVEL := 'A';
    END CASE;
  DBMS_OUTPUT.PUT_LINE('사번 : '||EMPID);
  DBMS_OUTPUT.PUT_LINE('이름 : '||EMPNAME);
  DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
  DBMS_OUTPUT.PUT_LINE('급여등급 : '||SALLEVEL);
END;
/

-- 4.CASE문, 
-- CASE 
--    WHEN 값1 THEN 실행문1 
--    WHEN 값1 THEN 실행문1 
--    WHEN 값1 THEN 실행문1 
--    ELSE 실행문2
-- END CASE;
-- 입력받은 값이 10이면 빨간색입니다. 2면 노랑색입니다. 3이면 초록색입니다. 를 출력하세요
DECLARE 
  INPUTVAL NUMBER;
BEGIN
  INPUTVAL := '&INPUTVAL';
  CASE INPUTVAL
    WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('빨간색입니다.');
    WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('노랑색입니다.');
    WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('초록색입니다.');
    ELSE DBMS_OUTPUT.PUT_LINE('잘못입력하셨습니다.');
  END CASE;
END;
/

-- ====================================== PL/SQL의 반복문 (8일차로 ㄱㄱ) ======================================









































































