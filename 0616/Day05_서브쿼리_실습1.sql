-- ======================= 서브쿼리 (SubQuery)=======================
-- 하나의 sql문 안에 포함되어 있는 또 다른 SQL문
-- 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계
-- 서브쿼리는 반드시 소괄호로 묶어야함 ex) ( SELECT ... ) 형태
-- 서브쿼리 안에 ORDER BY는 지원 안됨!

-- 1.단일행 서브쿼리
-- 전지연 직원의 관리자 이름을 출력하세요.
SELECT EMP_NAME, MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '전지연';

SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = '214';

SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = 
(SELECT MANAGER_ID FROM EMPLOYEE 
WHERE EMP_NAME = '전지연');


-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름 , 직급코드, 급여를 출력하세요.
SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE WHERE SALARY > (SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEE);


-- ======================= 서브쿼리 종류 =======================
-- 1. 단일행 서브쿼리
-- 2. 다중행 서브쿼리
-- 3. 다중열 서브쿼리
-- 4. 다중행 다중열 서브쿼리
-- 5. 상(호연)관 서브쿼리
-- 6. 스칼라 서브쿼리

-- ======================= 다중행 서브쿼리 =======================
-- 송종기나 박나라가 속한 부서에 속한 사원들의 전체 정보를 출력하세요.
-- 1. 부서코드 구하고
-- 2. 전체정보 출력
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '박나라';  --D9, D5
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('송종기','박나라');
SELECT * FROM EMPLOYEE WHERE DEPT_CODE IN('D9','D5');

SELECT * FROM EMPLOYEE WHERE DEPT_CODE 
IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('송종기','박나라'));
-- 다중행 서브쿼리 완성

-- @실습문제1
--차태연, 전지연 사원의 급여등급과 같은 사원의 직급명, 사원명을 출력하세요.
SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN('차태연','전지연');

SELECT JOB_NAME, EMP_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SAL_LEVEL 
IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN('차태연','전지연'))
AND EMP_NAME NOT IN ('차태연', '전지연'); --차태연,전지연빼고출력


-- @실습문제2
-- 2.Asia1지역에 근무하는 직원의 정보(부서코드, 사원명)를 출력하세요.
-- 조인사용
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

-- 서브쿼리사용
SELECT DEPT_CODE ,EMP_NAME 
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_ID FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1');
-- 사람의 정보(EMPLOYEE)
-- EMPLOYEE 테이블에 지역 정보가 없음
-- 부서코드 DEPT_CODE/DEPT_ID
-- DEPARTMENT 테이블에 지역 정보가 있음


SELECT DEPT_ID FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

SELECT * FROM LOCATION;



-- ================== 5.상(호연)관 서브쿼리 ==================
-- 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음 그 결과를 다시 메인쿼리로 변환해서 
-- 상호연관 관계를 가지고 실행하는 쿼리
-- > 서브쿼리의 WHERE절 수행을 위해서 메인쿼리가 먼저 수행되는 구조
-- > 메인 쿼리 테이블의 레코드에 따라 서브쿼리의 결과값도 바뀜
-- 상관 서브쿼리 VS 일반 서브쿼리

-- 부하직원이 한명이라도 있는 직원의 정보를 출력하시오.
SELECT * 
FROM EMPLOYEE E WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

SELECT * FROM EMPLOYEE WHERE 1 = 1; -- 행 참거짓


-- 실습문제 
-- 가장 많은 급여를 받는 사원을 출력하세오.(FEAT. 상관 서브쿼리)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY > E.SALARY);

-- 일반서브쿼리
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE); 

-- 가장 적은 급여를 받는 직원을 출력하시오.(FEAT. 상관 서브쿼리)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);

-- 일반서브쿼리
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE); 

-- 실습문제3
-- 심봉선 사원과 같은 부서의 사원의 부서코드, 사원명, 월평균급여를 조회하시오.
-- 상관 서브쿼리
SELECT DEPT_CODE, EMP_NAME, (SELECT AVG(SALARY) FROM EMPLOYEE)
FROM EMPLOYEE E WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE
AND EMP_NAME = '심봉선'); --D5만 나오게된다.

SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
AND EMP_NAME = '심봉선';

-- 일반 서브쿼리
SELECT * FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선');
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선';


-- 실습문제4
-- 직급이 J1, J2, J3이 아닌 사원중에서 자신의 부서별 평균급여보다 많은 급여를 받는 직원의
-- 부서코드, 사원명, 급여, (부서별 급여평균) 정보를 출력하시오.
-- 1. JOIN

SELECT E1.DEPT_CODE, EMP_NAME, SALARY, AVG_SAL
FROM EMPLOYEE E1
JOIN
(SELECT DEPT_CODE, ROUND(AVG(SALARY)) "AVG_SAL"
FROM EMPLOYEE
GROUP BY DEPT_CODE) E2
ON E1.DEPT_CODE = E2.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1', 'J2', 'J3') AND SALARY > AVG_SAL;

-- 2. 상관쿼리
SELECT DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE E 
--WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE > E.DEPT_CODE);
WHERE JOB_CODE NOT IN ('J1', 'J2', 'J3') AND
SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE);
-- 급여평균을 구하는데 있어서 같은 부서코드가 있는 데이터들의 부서 평균을 구하기 때문에
-- SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE 부서의 급여평균이 됨.
SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

SELECT JOB_CODE FROM EMPLOYEE;
SELECT SALARY FROM EMPLOYEE;







