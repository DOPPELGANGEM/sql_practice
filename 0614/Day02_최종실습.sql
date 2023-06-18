-- 최종 실습 문제
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
-- SYSDATE => 현재 날짜와 시각정보를 알려준다.
-- BETWEEN A AND B : A와  B 사이의 내용을 검색해서 나타내라는 의미입니다.
SELECT SYSDATE-1 FROM DUAL; --어제
SELECT SYSDATE FROM DUAL; -- 오늘
SELECT SYSDATE+1 FROM DUAL; -- 내일

SELECT EMP_NAME "이름", EMP_NO "주민번호", SALARY "급여", HIRE_DATE "입사일"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE) / 365 BETWEEN 5 AND 10;
--WHERE (SYSDATE - HIRE_DATE)/365 >= 5 AND (SYSDATE - HIRE_DATE)/365 <=10;

--DESC EMPLOYEE;

-- 문제2.
-- 재직중이 아닌 직원의 이름(EMP_NAME),부서코드(DEPT_CODE), 고용일(HIRE_DATE), 근무기간(3650일), 퇴직일을(ENT_DATE) 검색하여라 
--(퇴사 여부 : ENT_YN)
SELECT EMP_NAME "이름", DEPT_CODE AS 부서코드, HIRE_DATE AS "고용일", (ENT_DATE - HIRE_DATE) || '일' "근무기간"
, ENT_DATE "퇴직일" FROM EMPLOYEE WHERE ENT_YN = 'Y';

-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME "이름", SALARY*1.5 "급여", CEIL(((SYSDATE - HIRE_DATE) / 365)) "근속년수"
FROM EMPLOYEE
WHERE ((SYSDATE - HIRE_DATE)/365) >= 10
ORDER BY "근속년수" ASC;

--SELECT EMP_NAME "이름" , SALARY*1.5 "급여", CEIL(((SYSDATE - HIRE_DATE) / 365)) 
--FROM EMPLOYEE
--WHERE ((SYSDATE - HIRE_DATE) / 365) >= 10
--ORDER BY 3 ASC; -- 커럼의 순서에 맞는 숫자를 써도 정렬 가능

-- SELECT 실행순서
-- FROM - WHERE - SELECT - ORDER BY


--정렬
-- 1,2,3,4,5(오름차순)
-- 10,9,8,7,6(내림차순)
-- ㄱ,ㄴ,ㄷ,ㄹ,ㅁ,ㅂ,ㅅ,ㅇ,...
-- ㅎ,ㅍ,ㅌ,ㅊ,ㅈ,ㅇ
SELECT * FROM EMPLOYEE
--ORDER BY SALARY DESC; -> 숫자정렬 (오름차순:ASC, 내림차순 : DESC)
--ORDER BY EMP_NAME DESC; --사전순 정렬
--ORDER BY BONUS DESC; -- 널포함시 ASC는 뒤로감, DESC일 때 앞으로옴
ORDER BY HIRE_DATE DESC; --날짜정렬, 날짜는 DESC일때 최신순


-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME "이름", EMP_NO "주민번호", EMAIL "이메일", PHONE "폰번호", SALARY "급여"
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND SALARY <= 2000000;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE, '없음') "DEPT_CODE"
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000
AND EMP_NO LIKE '__04__-2%'
ORDER BY 2 DESC; -- 정렬은 컬럼의 순서에 맞는 숫자로 정렬 가능
--ORDER BY EMP_NO DESC; 


-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME, FLOOR((SYSDATE-HIRE_DATE)/ 1000)*(SALARY*0.1) "특별보너스(계산금액)"
FROM EMPLOYEE
WHERE (EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%') AND BONUS IS NULL
ORDER BY 1;

