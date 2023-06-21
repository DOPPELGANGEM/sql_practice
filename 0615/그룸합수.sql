-- 1. 문자 처리 함수
-- LENGTH, LENGTHB, INSTR(@의 위치 알려줌), SUBSTR(문자 자름), 
-- LPAD, RPAD(길이정하고 나머지 채워줌), LTRIM, RTRIM, TRIM(공백제거)
-- 2. 숫자 처리 함수
-- 3. 날짜 처리 함수

/* =================== TO_CHAR 형식 문자(숫자)+=====================
Format		 예시			설명
,(comma)    9,999		콤마 형식으로 변환
.(period)	99.99		소수점 형식으로 변환
9           99999       해당자리의 숫자를 의미함. 값이 없을 경우 소수점이상은 공백, 소수점이하는 0으로 표시.
0		    09999		해당자리의 숫자를 의미함. 값이 없을 경우 0으로 표시. 숫자의 길이를 고정적으로 표시할 경우.
$		    $9999		$ 통화로 표시
L		    L9999		Local 통화로 표시(한국의 경우 \)
XXXX		XXXX		16진수로 표시
FM         FM1234.56    포맷9로부터 치환된 공백(앞) 및 소수점이하0을 제거
*/

/*
Format		 예시			설명
,(comma)    	9,999		콤마 형식으로 변환
.(period)	    99.99		소수점 형식으로 변환
9           99999       해당자리의 숫자를 의미함. 값이 없을 경우 소수점이상은 공백, 소수점이하는 0으로 표시.
0		    09999		해당자리의 숫자를 의미함. 값이 없을 경우 0으로 표시. 숫자의 길이를 고정적으로 표시할 경우.
$		    $9999		$ 통화로 표시
L		    L9999		Local 통화로 표시(한국의 경우 \)
XXXX		XXXX		16진수로 표시
FM         FM1234.56    포맷9로부터 치환된 공백(앞) 및 소수점이하0을 제거
*/


-- 오라클함수
-- 단일행 함수 : 각 행마다 반복적으로 적용되어 입력 받은 행의 개수만큼 결과를 반환
-- , 그룹함수: 특정한 행들의 집합으로 그룹이 형성되어 적용됨, 그룹당 1개의 결과를 반환
-- 결과 딱 1행만 나옴.
SELECT SALARY FROM EMPLOYEE;
-- SUM, AVG, COUNT, MAX , MIN, ...
SELECT SUM(SALARY) FROM EMPLOYEE; -- 전체합
SELECT AVG(SALARY) FROM EMPLOYEE; -- 전체평균
SELECT COUNT(SALARY) FROM EMPLOYEE; -- 전체 레코드 갯수
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE; -- 최댓값 최솟값

SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE -- 원칙은 DEPT_CODE만 가능
GROUP BY DEPT_CODE ORDER BY 1;



-- GROUP BY절
-- 별도의 그룹지정없이 사용한 그룹함수는 단 한개의 결과값만 산출하기 때문에,
-- 그룹함수를 이용하여 여러개의 결과값을 산축하기 위해서는
-- 그룹함수가 적용될 그룹의 기준을  GROUP BY절에 기술하여 사용해야함



-- 실습예제1
--[EMPLOYEE] 테이블에서 부서코드 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리), 인원수를 조회하고, 부서코드 순으로 정렬
SELECT SUM(SALARY), TRUNC(AVG(SALARY)), COUNT(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;


SELECT SUM(SALARY), TRUNC(AVG(SALARY)), COUNT(SALARY) , DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 실습예제2
--[EMPLOYEE] 테이블에서 부서코드 그룹별, 보너스를 지급받는 사원 수를 조회하고 부서코드 순으로 정렬
--BONUS컬럼의 값이 존재한다면, 그 행을 1로 카운팅.
--보너스를 지급받는 사원이 없는 부서도 있음.
SELECT DEPT_CODE, COUNT(BONUS) -- 부서이름알고싶으면 DEPT_CODE 적어준다.
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;



-- 실습예제3
--EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요
SELECT JOB_CODE, COUNT(JOB_CODE), TRUNC(AVG(SALARY))
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1' -- !=과 같음
GROUP BY JOB_CODE
ORDER BY 1 DESC;



-- 실습예제4
--EMPLOYEE테이블에서 직급이 J1을 제외하고,  입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT EXTRACT(YEAR FROM HIRE_DATE), COUNT (HIRE_DATE)
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY 1 ASC;
-- TO_DATE('1994', 'YYYY')



-- 실습예제5
--[EMPLOYEE] 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오

--준비운동
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','4','여')
FROM EMPLOYEE;

--본운동
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','4','여'), TRUNC(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','4','여')
ORDER BY 3 DESC;

SELECT DEPT_CODE, SUM(SALARY) -- =AVERAGE(
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT JOB_CODE, SUM(SALARY) -- =SUM(
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 실습문제6
-- 부서내 직급별 급여의 합계를 구하시오.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE ASC;


-- 실습문제7
-- 부서내 성별 인원수를 구하시오
--SELECT DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','4','여'), COUNT(*)  
--FROM EMPLOYEE
--GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','4','여')
--ORDER BY 1 ASC;

SELECT DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여'), COUNT(*)  
FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3', '남','4','여')
ORDER BY 1 ASC;


-- HAVING 절
-- 그룹함수로 값을 구해온 그룹에 대해 조건을 설정할 때 사용함
-- * WHERE랑 HAVING을 헷깔리는 경우가 많은데 WHERE는 그룹화 하기 전이고, HAVING은 그룹화 후에 조건입니다.
-- WHERE 절과 구별해서 사용할 줄 알아야 함.
SELECT * FROM EMPLOYEE WHERE EMP_ID < 210;
-- 부서별 인원수를 구해보세요
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
HAVING COUNT(*) < 5
ORDER BY 1 DESC;



-- 실습문제1
-- 부서별 인원이 5명보다 많은 부서와 인원수를 출력하세요.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

-- 실습문제2
--부서별 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력하세요.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3
ORDER BY 1 ASC;


-- 실습문제3
--매니져가 관리하는 사원이 2명이상인 매니져아이디와 관리하는 사원수를 출력하세요.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL;

-- ROLLUP과 CUBE
-- 부서내 직급별 급여의 합계를 구하시오.-
-- 참고:url https://jddng.tistory.com/177

-- ROLLUP -> ROLLUP은 순차적으로 중간 합계를 출력합니다.
-- ROLLUP은 순차적으로 중간 합계를 출력합니다.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1 ASC;

-- 부서내 직급별 급여의 합계를 구하시오.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1 ASC; --21개

-- 부서내 직급별 급여의 합계를 구하시오.
-- CUBE -> CUBE는 모든 중간합께를 출력합니다.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE) 
ORDER BY 1 ASC; --28개 (차이가 나는 7개는 직급별 합계임 ㅇㅇ)

-- 해야될것
-- 1. 집합 연산자
-- - 합집합, 교집합, 차집합, ...
-- A = {1, 2, 3, 5, 8, 10}, B = {2, 3, 9 , 4}
-- A∩B = {2, 3},  A∪B = {1, 2, 3, 4, 5 , 8, 9, 10} A-B ={1,5,8,10}, B-A ={4,9}
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- A
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B
-- A∩B
-- 김해술, 심봉선, 대북혼
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- A
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B

-- A∪B, UNION, UNION ALL(중복허용) -> 많이쓴당
-- 1.컬럼의 갯수가 같아야 한다.
-- 2.컬럼의 데이터타입이 같아야 한다.
DESC EMPLOYEE;
--ORA-01790: expression must have same datatype as corresponding expression
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- A
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B

--A-B
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- A
MINUS
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B

-- 2. JOIN(매우 중요)
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;



-- 3. SubQuery(중요)
-- 4. 오라클객체 (View, Sequence, ...)
-- 5. PL/SQL -> Function, Stored Procedure (시간이된다면..양도좀많음)








