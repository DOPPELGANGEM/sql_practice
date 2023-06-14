-- 오라클함수
-- 단일행 함수 : 각 행마다 반복적으로 적용되어 입력 받은 행의 개수만큼 결과를 반환
--, 그룹함수 :
-- 1. 문자 처리 함수
-- LENGTH, LENGTHB, INSTR(@의 위치 알려줌), SUBSTR(문자 자름), 
-- LPAD, RPAD(길이정하고 나머지 채워줌), LTRIM, RTRIM, TRIM(공백제거)
-- =========================== @실습문제 ===========================
---- 사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT EMP_NAME, SUBSTR(EMP_NAME, 1, 1) "성"
FROM EMPLOYEE
ORDER BY 1 ASC;
-- 중복없이 출력은 어떻게 하는걸까? DISTINCT
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) "성"
FROM EMPLOYEE
ORDER BY 1 ASC;
-- LENGTH, LENGTHB, INSTR, SUBSTR, LPAD/RPAD, LTRIN/RTRIM/TRIM, REPLACE(교체하기)

-- =========================== @실습문제 ===========================
-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID, EMP_NAME, 
SUBSTR(EMP_NO, 1, 8) ||'******', RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*'),
SALARY*12
FROM EMPLOYEE
--WHERE EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%';
WHERE SUBSTR(EMP_NO,8,1) = 1 OR SUBSTR(EMP_NO,8,1) = 3; 

-- =========================== @실습문제 ===========================
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402' ,'0123456789'), '0123456789') FROM DUAL;




-- ' KH ', 'KH'
-- ============== DUAL 테이블 ==============
-- 한 열로 이루어진 특별한 테이블, SYSDATE, USER, 산술연살과 같은 의사컬럼 선택에 사용하도록 해줌
SELECT * FROM DUAL; --VARCHAR2(1) : 'x'값이 존재함
-- ============== LTRIM/RTRIM/TRIM ==============
SELECT RTRIM(LTRIM('  KH  ')) FROM DUAL;
SELECT TRIM('  KH  ') FROM DUAL;
SELECT RTRIM(LTRIM('123KH123','123'), '123') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT SYSDATE FROM DUAL;
-- LENGTH, LENGTHB, INSTR, SUBSTR, LPAD/RPAD, LTRIM/RTRIM/TRIM, REPLACE,
-- CONCAT, ||, LOWER, UPPER, INITCAP
-- ============== REPLACE 함수 ==============
-- '서울시 강남구 역삼동' -> 삼성동
SELECT REPLACE ('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
-- ============== 실습문제4 ==============
-- EMPLOYEE에서 EMAIL컬럼의 주소를 gmail.com으로 바꿔주세요.
SELECT REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 숫자 처리 함수
SELECT (SYSDATE-HIRE_DATE), TRUNC((SYSDATE-HIRE_DATE),1), 
FLOOR(SYSDATE-HIRE_DATE),
CEIL(SYSDATE-HIRE_DATE), ROUND(SYSDATE-HIRE_DATE) FROM EMPLOYEE;

-- 3. 날짜 처리 함수
--============== @실습문제1 ==============
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오
-- ADD_MONTHS()
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

--============== @실습문제2 ==============
-- MONTHS_BETWEEN()
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오
SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1)
FROM EMPLOYEE;

--============== @실습문제3 ==============
--LAST_DAY()
--ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)+1 --+1하면 그다음달의 1일을 추출
FROM EMPLOYEE;


--============== @실습문제4 ==============
--ex) EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오.
SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) || '년' ||
EXTRACT(MONTH FROM HIRE_DATE) || '월' ||
EXTRACT(DAY FROM HIRE_DATE) || '일'
FROM EMPLOYEE;

--@실습문제
/*
     오늘부로 일용자씨가 군대에 끌려갑니다.
     군복무 기간이 1년 6개월을 한다라고 가정하면
     첫번째,제대일자를 구하시고,
     두번째,제대일자까지 먹어야할 짬밥의 그룻수를 구합니다.
     (단, 1일 3끼를 먹는다고 한다.)
*/

SELECT ADD_MONTHS(SYSDATE,18) "제대날짜",  (ADD_MONTHS(SYSDATE,18)-SYSDATE) * 3 "짬밥수" FROM DUAL;

-- 4.형변환 함수
-- TO_CHAR, TO_DATE, TO_NUMBER
-- ============================= TO_DATE (CHAR -> DATE)=============================
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN TO_DATE('10/01/01') AND TO_DATE('12/12/31');
-- <input type="date"> -> '10-01-01','12-12-31'
SELECT TO_DATE('20100101', 'YY/MM/DD') FROM DUAL;
--SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL; --위에꺼랑 결과 같음 10/01/01 오라클에서사용하는날짜형식

-- ============================= TO_NUMBER (CHAR -> NUMBER) =============================
SELECT TO_NUMBER('1,000,000','9,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000','9,999,999') - TO_NUMBER('500,000','999,999') FROM DUAL;

-- ============================= 기타함수 =============================
-- 1.NVL (널 처리 함수)
SELECT NVL(BONUS,0)*SALARY FROM EMPLOYEE;
SELECT NVL(DEPT_CODE, 'D0') FROM EMPLOYEE;

-- 2.DECODE (IF문)
-- 성별 표시하기
SELECT EMP_NAME, EMP_NO, SALARY, 
DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여','무') "성별"
FROM EMPLOYEE;

-- 3.CASE (switch문)
SELECT EMP_NAME, EMP_NO, SALARY
, DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여','무') "성별"
, CASE 
    WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남' 
    WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여' 
    WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '남' 
    WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '여' 
    ELSE '무'
  END AS 성별
FROM EMPLOYEE;







-- 문자처리함수
-- @함수 최종실습문제
--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex)  홍길동 , hong@kh.or.kr   	  13
-- LENGTH()
SELECT EMP_NAME "이름" , EMAIL AS 이메일, LENGTH(EMAIL) "이메일길이"
FROM EMPLOYEE;


--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh
SELECT EMP_NAME "직원명", RTRIM(RTRIM(EMAIL,'kh.or.kr'),'@') "이메일"
FROM EMPLOYEE;

--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0
SELECT EMP_NAME AS 직원명, '19'||SUBSTR(EMP_NO,1,2) "년생", NVL(BONUS,0) "보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;


--4. '010' 핸드폰 번호를 쓰지 않는 사람의 전체 정보를 출력하시오.(해봤던거)
SELECT * FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월
SELECT EMP_NAME "직원명" , 
EXTRACT(YEAR FROM HIRE_DATE) || '년' ||
EXTRACT(MONTH FROM HIRE_DATE) || '월' "입사년월"
FROM EMPLOYEE;

--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서 출력 하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME "직원명", SUBSTR(EMP_NO,1,8) || '******' "주민번호(||)",
RPAD(SUBSTR(EMP_NO,1,8),14,'*') "주민번호(RPAD)"
FROM EMPLOYEE;

--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME "직원명", JOB_CODE "직급코드", SALARY*12+SALARY*NVL(BONUS,0) "연봉",
TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999,999') "연봉(TO_CHAR)"
FROM EMPLOYEE;

/* ======== TO_CHAR 형식 문자(숫자)
Format		 예시			    설명
,(comma)   9,999		    콤마 형식으로 변환
.(period)	 99.99		    소수점 형식으로 변환
9          99999        해당자리의 숫자를 의미함. 값이 없을 경우 소수점이상은 공백, 소수점이하는 0으로 표시.
0		       09999		    해당자리의 숫자를 의미함. 값이 없을 경우 0으로 표시. 숫자의 길이를 고정적으로 표시할 경우.
$		       $9999		    $ 통화로 표시
L		       L9999		    Local 통화로 표시(한국의 경우 \)
XXXX		   XXXX		      16진수로 표시
FM         FM1234.56    포맷9로부터 치환된 공백(앞) 및 소수점이하0을 제거
*/


--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 입사일
SELECT EMP_ID, EMP_NAME, DEPT_CODE , HIRE_DATE
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D9';
WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME "직원명", HIRE_DATE "입사일", TRUNC(SYSDATE-HIRE_DATE) "근무일수"
-- 입사일에 개월차를 더한 날짜
,TRUNC(SYSDATE - ADD_MONTHS(HIRE_DATE,MONTHS_BETWEEN(SYSDATE,HIRE_DATE))) "일"
FROM EMPLOYEE;

--10. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용



--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.




























