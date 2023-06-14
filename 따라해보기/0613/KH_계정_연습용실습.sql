SHOW USER;
SELECT * FROM USER_ROLE_PRIVS;

SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;


--SELECT 실행 순서
--FROM - WHERE - (GROUP BY - HAVING) - SELECT - (ORDER BY)

-- 실습문제

--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
-- 지연, 수연, 태연 , 서연, 기연 , ...
-- 와일드카드 : %(0개 이상의 모든 문자를 매칭), _(하나의 자리에 해당하는 모든 문자를 매칭)
-- SELECT의 결과물은 ResultSet
-- 1-1. 전씨 성을 가진 직원의 이름과 급여를 조회하시오


--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오


--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
--AND DEPT_CODE IN ('D9', 'D6');


--4. EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?

--5. EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?


-- 6. 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  직원의 이름 조회


-- 7. 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회


--8. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함), 
-- 실수령액(총 수령액-(월급*세금 3%*12))
--가 출력되도록 하시오



--9. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 
--(SYSDATE를 사용하면 현재 시간 출력)



-- 2021.06.01 입사를 했다면 나의 근무일수는 어떻게 구하나요?
-- 2023.06.13 - 2021.06.01
-- 그렇다면 근속년수는 어떻게 구하나요?


--10. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오.











