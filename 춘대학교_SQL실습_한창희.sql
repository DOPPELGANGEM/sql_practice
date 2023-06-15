SELECT * FROM TB_CLASS;
SELECT * FROM TB_PROFESSOR;

--1. BASIC SELECT
--   1,6)김현우
--   2,7)권태우
--   3,8)한창희
--   4,9)강정대
--   5,10)이기진
--   

--3) "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이
--들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서
--찾아 내도록 하자)
SELECT STUDENT_NAME , DEPARTMENT_NO, STUDENT_SSN, ABSENCE_YN 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' -- DEPARTMENT_NO가 001 인 쿼리
AND STUDENT_SSN LIKE '%-2%' -- 앞뒤에 무슨 글자가 오던지 -2 이라는 문자가 있는 것을 출력
AND ABSENCE_YN = 'Y'; -- ABSENCE_YN이 Y일때

--8)수강신청을 하려고 핚다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
--과목들은 어떤 과목인지 과목번호를 조회해보시오.
SELECT CLASS_NO as CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;


--2. Additional SELECT
--   1,6,11)김현우
--   2,7,12)권태우
--   3,8,13)한창희
--   4,9,14)강정대
--   5,10,15)이기진


--3) 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
--이때 나이가 적은 사람에서 맋은 사람 순서로 화면에 출력되도록 맊드시오. (단, 교수 중
--2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 핚다. 나이는 ‘ 맊’ 으로
--계산핚다.)

select sysdate from dual;
select substr('1212122', 0 ,5) from dual;
select substr('1212122', 3 ,2) from dual; --3번째부터 2번째까지
--dual : 오라클내에서 부여해주는테이블

-- 한줄씩까보기
select SUBSTR(PROFESSOR_SSN,1,2) FROM TB_PROFESSOR;
select '19' || SUBSTR(PROFESSOR_SSN,1,2) FROM TB_PROFESSOR;
select TO_DATE('19' || SUBSTR(PROFESSOR_SSN,1,2), 'YYYY') FROM TB_PROFESSOR;
select EXTRACT(YEAR FROM TO_DATE('19' || SUBSTR(PROFESSOR_SSN,1,2), 'YYYY')) FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME "교수이름", 
EXTRACT(YEAR FROM SYSDATE)- 
EXTRACT(YEAR FROM TO_DATE('19' || SUBSTR(PROFESSOR_SSN,1,2),'YYYY')) "나이"
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN LIKE '%-1%'
ORDER BY 2 ASC;



--3. Additional SELECT(option)
--   1,6,11,16)김현우
--   2,7,12,17)권태우
--   3,8,13,18)한창희
--   4,9,14,19)강정대
--   5,10,15)이기진

--3) 주소지가 강원도나 경기도인 학생들 중 1900 년대 학번을 가진 학생들의 이름과 학번,
--주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는 "학생이름","학번",
--"거주지 주소" 가 출력되도록 핚다.

--8. 과목별 교수 이름을 찾으려고 핚다. 과목 이름과 교수 이름을 출력하는 SQL 문을
--작성하시오.

--SELECT A.CLASS_NAME "과목 이름", B.PROFESSOR_NAME "교수 이름"
--FROM TB_CLASS_PROFESSOR "CP"
--LEFT JOIN TB_CLASS "A" ON CP.CLASS_NO = A.CLASS_NO
--LEFT JOIN TB_PROFESSOR "B" ON CP.PROFESSOR_NO = B.PROFESSOR_NO;

  
--4. DDL
--   1,6,11)김현우
--   2,7,12)권태우
--   3,8,13)한창희
--   4,9,14)강정대
--   5,10,15)이기진
--   
--5. DML
--   1,6)김현우
--   2,7)권태우
--   3,8)한창희
--   4)강정대
--   5)이기진

