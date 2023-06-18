SHOW USER;
SELECT * FROM USER_ROLE_PRIVS;

SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- SELECT 실행순서
-- FROM - WHERE - (GROUP BY - HAVING) - SELECT - (ORDER BY)

-- 실습문제

--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME = '차태연' OR EMP_NAME = '전지연';
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME = '차태연' AND EMP_NAME= '전지연';
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME LIKE '%연'; 
-- 연, 지연, 차지연, 내차지연, ...
-- '%연'; => 앞에 무슨 글자가 오던지 '연'으로 끝나는 문자가 있는 ROW를 출력한다.
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME LIKE '_연';
-- 지연, 수연, 태연 , 서연, 기연 , ...
-- 두번째 문자가 연인 사원이름 (없어서출력 ㄴㄴ)
-- 와일드카드 : %(0개 이상의 모든 문자를 매칭), _(하나의 자리에 해당하는 모든 문자를 매칭)
-- SELECT의 결과물은 ResultSet

-- 1-1. 전씨 성을 가진 직원의 이름과 급여를 조회하시오
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
-- 전% => 앞에 무슨글자가 오던지 '전'으로 시작하는 문자가 있는 ROW를 출력


--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오
SELECT EMP_NAME, PHONE FROM EMPLOYEE WHERE PHONE NOT LIKE '010%';


--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
--AND DEPT_CODE IN ('D9', 'D6');
-- IN : 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산자
SELECT *
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';
WHERE EMAIL LIKE '%s%' 
AND (DEPT_CODE IN('D9', 'D6')) AND
--WHERE HIRE_DATE >= '12/12/12' AND HIRE_DATE <= '13/12/31';
(HIRE_DATE BETWEEN '90/01/01' AND '01/12/01') 
AND SALARY >= 2700000;


--4. EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';
-- '_____@%'; => 뒤에는 아무 글자 오던 상관없이 5글자뒤에 @글자가 있는 row를 출력한다.


--5. EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
-- ESCAPE: 와일드카드기능을없애고 문자로 동작하게해준다.
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- ESCAPE 문자를 지정한 후에, 특수 문자앞에 ESCAPE 문자를 넣어준다. 이렇게되면 ESCAPE
-- 이렇게 되면 ESCAPE 문자 뒤에 있는 문자를 일반문자로 인식하게되어 _(언더바)가 들어간걸검색.
-- ESCAPE문자는 어떤 문자로든 지정가능

-- 6. 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은 직원의 이름 조회
SELECT MANAGER_ID, DEPT_CODE, EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
--WHERE MANAGER_ID IS NOT NULL

-- 7. 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


--8. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함), 
-- 실수령액(총 수령액-(월급*세금 3%*12))
--가 출력되도록 하시오
--NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
--- 함수  :  NVL("값", "지정값") 

SELECT EMP_NAME, SALARY*12 "연봉",
SALARY*12 + SALARY*NVL(BONUS,0) "총수령액(보너스포함)",
(SALARY*12 + SALARY*NVL(BONUS,0)) - (SALARY*0.03*12) "실수령액"
FROM EMPLOYEE;


--9. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 
--(SYSDATE를 사용하면 현재 시간 출력)
-- select sysdate from dual; ----dual : 오라클내에서 부여해주는테이블
-- ROUND(반올림), CEILING(절상,올림), FLOOR(절삭,내림), 
SELECT SYSDATE FROM EMPLOYEE;
SELECT (SYSDATE - HIRE_DATE) FROM EMPLOYEE;
SELECT FLOOR(SYSDATE - HIRE_DATE) FROM EMPLOYEE;
SELECT FLOOR((SYSDATE - HIRE_DATE)/365) FROM EMPLOYEE;

-- 정답
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) "근무일수",
FLOOR((SYSDATE - HIRE_DATE)/365) "근속년수"
FROM EMPLOYEE;
-- 2021.06.01 입사를 했다면 나의 근무일수는 어떻게 구하나요?
-- 2023.06.13 - 2021.06.01
-- 그렇다면 근속년수는 어떻게 구하나요?

--10. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오.
--SELECT EMP_NAME "이름", SALARY "월급", BONUS AS 보너스율
--FROM EMPLOYEE
--WHERE FLOOR((SYSDATE - HIRE_DATE) / 365) >= 20;

SELECT EMP_NAME "이름" , SALARY "월급", BONUS "보너스율", FLOOR((SYSDATE - HIRE_DATE)/365) "근속년수" 
FROM EMPLOYEE
WHERE FLOOR((SYSDATE - HIRE_DATE)/365) >= 20;







DESC EMPLOYEE;











