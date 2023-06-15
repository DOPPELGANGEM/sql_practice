-- JOIN
-- 두개 이상의 테이블에서 연관성을 가지고 있는 데이터들을
-- 따로 분류하여 새로운 가상의 테이블을 만듬
-- -> 여러 테이블의 레코드를 조합하여 하나의 레코드로 만듬
-- ANSI 표준 구문
SELECT EMP_NAME "사원명", DEPT_CODE "부서명"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT COUNT(*)FROM EMPLOYEE;

-- 오라클 조인 구문
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명"
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;

--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
-- JOIN으로 하기
SELECT EMP_NAME "사원명", DEPT_CODE "부서명"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT COUNT(*)FROM EMPLOYEE;

-- JOIN 없이 하기
SELECT EMP_NAME "사원명"
, CASE 
  WHEN DEPT_CODE = 'D5' THEN '총무부' 
  WHEN DEPT_CODE = 'D6' THEN '기획부' 
  WHEN DEPT_CODE = 'D9' THEN '영업부' 
  END "부서명"
FROM EMPLOYEE;



-- @실습문제1
-- 부서명과 지역명을 출력하세요. DEPARTMENT, LOCATION 테이블 이용.
SELECT DEPT_TITLE, LOCAL_NAME FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;













