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
-- SUBSTR (컬럼명, 시작위치, 문자개수)

-- =========================== @실습문제 ===========================
-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID, EMP_NAME, 
SUBSTR(EMP_NO, 1, 8) ||'******', RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*'),
SALARY*12
FROM EMPLOYEE
--WHERE EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%';
WHERE SUBSTR(EMP_NO,8,1) = 1 OR SUBSTR(EMP_NO,8,1) = 3; 

-- LPAD("값", "총 문자길이", "채움문자") : 지정한 길이만큼 왼쪽부터 채움문자로 채움.
-- 채움문자를 지정하지 않으면 공백으로 해당 길이만큼 문자를 채운다.   (예, LPAD(deptno, 5))
-- RPAD("값", "총 문자길이", "채움문자") : 지정한 길이만큼 오른쪽부터 채움문자로 채움, 
-- 채움문자를 지정하지 않으면 공백으로 해당 길이만큼 문자를 채운다.   (예, RPAD(deptno, 5))
SELECT EMP_ID, EMP_NAME,
SUBSTR(EMP_NO, 1, 8) || '******', RPAD(SUBSTR(EMP_NO,1, 8),14, '*'),
SALARY*12
FROM EMPLOYEE
--WHERE EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%';
WHERE SUBSTR(EMP_NO,8,1) = 1 OR SUBSTR(EMP_NO,8,1) = 3;

-- 한줄씩까보기 --
SELECT SUBSTR(EMP_NO, 1, 8) FROM EMPLOYEE;
SELECT RPAD(SUBSTR(EMP_NO, 1, 8), 14,'*') FROM EMPLOYEE;
SELECT SUBSTR(EMP_NO, 8, 1) FROM EMPLOYEE; -- SUBSTR (컬럼명, 시작위치, 문자개수)


-- =========================== @실습문제 ===========================
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
--TRIM 함수는 문자열의 양쪽 공백을 제거하는 기본적인 함수이다. 
--LTRIM 함수, RTRIM 함수는 왼쪽과 오른쪽의 공백을 제거할 때 사용가능 하지만, 반복적인 문자나 특정 문자를 제거할 때 자주 사용한다.
-- LTRIM 함수는 문자열의 왼쪽(좌측)공백 제거, 문자 뒤쪽 LTRIM("문자열", "옵션")
-- RTRIM 함수는 문자열의  오른쪽(우측) 공백  제거,  RTRIM("문자열", "옵션") 
SELECT RTRIM(LTRIM('982341678934509hello89798739273402' ,'0123456789'), '0123456789') FROM DUAL;

SELECT LTRIM('982341678934509hello89798739273402' ,'0123456789') FROM DUAL;
SELECT RTRIM(LTRIM('982341678934509hello89798739273402' ,'0123456789'),'0123456789') FROM DUAL;

-- ' KH ', 'KH'
-- ============== DUAL 테이블 ==============
-- 한 열로 이루어진 특별한 테이블, SYSDATE, USER, 산술연살과 같은 의사컬럼 선택에 사용하도록 해줌
SELECT * FROM DUAL; --VARCHAR2(1) : 'x'값이 존재함

-- ============== LTRIM/RTRIM/TRIM ==============
SELECT RTRIM(LTRIM('  KH  ')) FROM DUAL; -- KH
SELECT TRIM('  KH  ') FROM DUAL; --KH
SELECT RTRIM(LTRIM('123KH123','123'), '123') FROM DUAL; --KH
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; --KH
SELECT SYSDATE FROM DUAL; --23/06/19 (현재날짜)


-- LENGTH, LENGTHB, INSTR, SUBSTR, LPAD/RPAD, LTRIM/RTRIM/TRIM, REPLACE,
-- CONCAT, ||, LOWER, UPPER, INITCAP
-- ============== REPLACE 함수 ==============
-- '서울시 강남구 역삼동' -> 삼성동
-- 함수사용법 : REPLACE("칼럼명 or 문자열", "찾을문자", "치환문자")
SELECT REPLACE ('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;


-- ============== 실습문제4 ==============
-- EMPLOYEE에서 EMAIL컬럼의 주소를 gmail.com으로 바꿔주세요.
SELECT REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') , SALARY FROM EMPLOYEE
WHERE SALARY >= 3000000; -- 급여 300만이상

-- 2. 숫자 처리 함수
-- ROUND : 반올림 , TRUNC("값", "옵션") -> TRUNC함수는 주로 소수점 절사 및 날짜의 시간을 없앨때 사용 
-- FLOOR:소수점이하는무조건버림, CEIL:소수점이하를 무조건 올림
SELECT (SYSDATE-HIRE_DATE) , TRUNC((SYSDATE-HIRE_DATE),1),
FLOOR(SYSDATE-HIRE_DATE),
CEIL(SYSDATE-HIRE_DATE), ROUND(SYSDATE-HIRE_DATE)
FROM EMPLOYEE;

SELECT TRUNC((SYSDATE-HIRE_DATE),1) FROM EMPLOYEE; -- 3785.8 형식
SELECT FLOOR(SYSDATE-HIRE_DATE) FROM EMPLOYEE;
SELECT CEIL(SYSDATE-HIRE_DATE) FROM EMPLOYEE;
SELECT ROUND(SYSDATE-HIRE_DATE) FROM EMPLOYEE;


-- 3. 날짜 처리 함수
-- SYSDATE,SYSTIMESTAMP
-- SYSDATE와 SYSTIMESTAMP는 현재일자와 시간을 각각 DATE, TIMESTAMP형으로 반환한다.
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

--============== @실습문제1 ==============
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오
-- ADD_MONTHS()
-- ADD_MONTHS (date, integer) : ADD_MONTHS함수는 매개변수로 들어온 날짜에 interger 만큼의 월을 더한 날짜를 반환
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

SELECT HIRE_DATE, ADD_MONTHS(HIRE_DATE,3) 
FROM EMPLOYEE;

--============== @실습문제2 ==============
-- MONTHS_BETWEEN()
-- MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월수를 반환하는데 date2가 date1보다 빠른 날짜가온다.
--  EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오
SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1)
FROM EMPLOYEE;

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1) FROM EMPLOYEE; -- 124.4형식

--============== @실습문제3 ==============
-- LAST_DAY()
-- LAST_DAY() : date 날짜를 기준으로 해당 월의 마지막 일자를 반환한다.
--ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)+1 --+1하면 그다음달의 1일을 추출
FROM EMPLOYEE;

SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEE; -- 13/02/28 형식
SELECT LAST_DAY(HIRE_DATE)+1 FROM EMPLOYEE; -- LAST_DAY(HIRE_DATE)+1 그다음달의 1일을 추출 13/03/01 형식


--============== @실습문제4 ==============
--ex) EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오.
-- EXTRACT 함수 : 날짜 유형의 데이터로부터 날짜 정보를 분리해서 새로운 컬럼의 형태로 추출해주는 함수
-- YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) || '년' ||
EXTRACT(MONTH FROM HIRE_DATE) || '월' ||
EXTRACT(DAY FROM HIRE_DATE) || '일'
FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE;
SELECT EXTRACT(MONTH FROM HIRE_DATE) FROM EMPLOYEE;
SELECT EXTRACT(DAY FROM HIRE_DATE) FROM EMPLOYEE;


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
-- TO_CHAR(날짜데이터, 형식) : 날짜를 서식에 맞춰서 문자열로 변환 , TO_CHAR(날짜, '서식') -> 서식에 맞는 문자열 반환
-- TO_DATE(char,서식) : 문자를 날짜로 변환
-- TO_NUMBER 함수 : 문자열을 쉽게 숫자(정수,실수)로 변환이 가능하다.

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
-- NVL("값","지정값") => 값이 null 인 경우, 지정 값을 출력하고 그렇지 않으면 원래값을 그대로 출력한다.
SELECT NVL(BONUS,0)*SALARY FROM EMPLOYEE;
SELECT NVL(DEPT_CODE, 'D0') FROM EMPLOYEE;

SELECT BONUS FROM EMPLOYEE;
SELECT DEPT_CODE FROM EMPLOYEE;

-- 2.DECODE (IF문)
-- DECODE(컬럼명, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3, ....)
-- 성별 표시하기
SELECT EMP_NAME, EMP_NO, SALARY, 
DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여','무') "성별"
FROM EMPLOYEE;

SELECT SUBSTR(EMP_NO, 8, 1) FROM EMPLOYEE;

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

SELECT EMP_NAME AS 직원명, '19'||SUBSTR(EMP_NO,1,2) "년생", NVL(BONUS,0) "보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

SELECT '19'||SUBSTR(EMP_NO,1,2) FROM EMPLOYEE;


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


SELECT SUBSTR(EMP_NO,1,8) "주민번호(RPAD)" FROM EMPLOYEE;
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') FROM EMPLOYEE;


--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME "직원명", JOB_CODE "직급코드", SALARY*12+SALARY*NVL(BONUS,0) "연봉",
TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999,999') "연봉(TO_CHAR)"
FROM EMPLOYEE;


SELECT TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999,999') "연봉(TO_CHAR)" FROM EMPLOYEE;
SELECT NVL(BONUS,0) FROM EMPLOYEE;


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
-- 사번 사원명 부서코드 입사일

-- IN 구문은 WHERE절 뒤에 붙여서 컬럼이 특정값을 가지고 있는지 확인하는 용도로 쓰임
-- SELECT 칼럼명 FROM 테이블명 WHERE 칼럼명 IN (값1, 값2, ...)
-- 칼럼의 값이 값1 또는 값2에 해당하는 값만 출력
-- SELECT 칼럼명 FROM 테이블명 WHERE 칼럼명 NOT IN (값1, 값2, ...)
-- 칼럼의 값이 값1 또는 값2 어디에도 해당하지 않는 것만 출력
SELECT EMP_ID, EMP_NAME, DEPT_CODE , HIRE_DATE
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D9';
WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

SELECT EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE;

--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
-- MONTHS_BETWEEN('날짜1', '날짜2') => 날짜1 - 날짜2 = 개월수
-- ADD_MONTHS(HIRE_DATE,3) => 3개월후 날짜출력
SELECT EMP_NAME "직원명", HIRE_DATE "입사일", TRUNC(SYSDATE-HIRE_DATE) "근무일수"
-- 입사일에 개월차를 더한 날짜
,TRUNC(SYSDATE - ADD_MONTHS(HIRE_DATE,MONTHS_BETWEEN(SYSDATE,HIRE_DATE))) "일"
FROM EMPLOYEE;


SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) FROM EMPLOYEE;
SELECT ADD_MONTHS(HIRE_DATE,MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) FROM EMPLOYEE;
SELECT ADD_MONTHS(HIRE_DATE,3) FROM EMPLOYEE;

--10. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용

SELECT EMP_NAME, DEPT_CODE,
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))||'년 '||
EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO, 3, 2), 'MM'))||'월 '||
EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO, 5, 2), 'DDD'))||'일' "생년월일 (TO_DATE)",
-- 날짜 형변환을 이용한 방법
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) "나이(만)",
-- 숫자 형변환을 이용한 방법
EXTRACT(YEAR FROM SYSDATE) - (DECODE(SUBSTR(EMP_NO,8,1), '1', 1900, '2', 1900, '3', 2000, '4', 2000)
+TO_NUMBER(SUBSTR(EMP_NO,1,2))) "나이(만)DECODE"
FROM EMPLOYEE;



SELECT SUBSTR(EMP_NO,1,2) FROM EMPLOYEE;
SELECT TO_DATE(SUBSTR(EMP_NO,1,2), 'RR') ||'년' FROM EMPLOYEE;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) ||'년' FROM EMPLOYEE;


/*
============================
형식	        의미
============================
YYYY	   년도표현(4자리)
YY	      년도 표현 (2자리)
RR      년도 표현 (2자리), 50이상 1900, 50미만 2000
MONTH   월을 LOCALE설정에 맞게 출력(FULL)
MM	   월을숫자로표현  
MON	    월을 알파벳으로 표현(월요일아님)
DDD     365일 표현
DD	    날짜 표현	
D      요일을 숫자로 표현(1:일요일...) 
DAY	   요일 표현	  
DY	   요일을 약어로 표현	

HH HH12     시각
HH          시각(24시간)
MI
SS

AM PM A.M. P.M. 오전오후표기

FM          월, 일, 시,분, 초앞의 0을 제거함.
*/


SELECT EMP_ID, EMP_NO FROM EMPLOYEE;
SELECT 
EXTRACT(YEAR FROM TO_DATE('01', 'YY')) 
, EXTRACT(YEAR FROM TO_DATE('94', 'RR'))  --RR인 경우 50이상 1900년대, 50미만 2000년대
, EXTRACT(YEAR FROM TO_DATE('12', 'RR')) 
FROM DUAL;

SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2), 'RR')) "출생년도"
FROM EMPLOYEE;



SELECT TO_DATE('94', 'YY') FROM DUAL;



--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT DEPT_CODE
FROM EMPLOYEE;



























