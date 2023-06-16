SELECT * FROM TB_CLASS;
SELECT * FROM TB_PROFESSOR;

--1. BASIC SELECT
--   1,6)김현우
--   2,7)권태우
--   3,8)한창희
--   4,9)강정대
--   5,10)이기진
--   

--3) 
SELECT STUDENT_NAME , DEPARTMENT_NO, STUDENT_SSN, ABSENCE_YN 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' -- DEPARTMENT_NO가 001 인 쿼리
AND STUDENT_SSN LIKE '%-2%' -- 앞뒤에 무슨 글자가 오던지 -2 이라는 문자가 있는 것을 출력
AND ABSENCE_YN = 'Y'; -- ABSENCE_YN이 Y일때

--8)
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


--8)춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
--이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오
SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

--13) 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
SELECT DEPARTMENT_NO "학과코드명", COUNT(*) ABSENCE_YN FROM TB_STUDENT
GROUP BY DEPARTMENT_NO, ABSENCE_YN
HAVING ABSENCE_YN = 'Y' 
ORDER BY DEPARTMENT_NO;

--3. Additional SELECT(option)
--   1,6,11,16)김현우
--   2,7,12,17)권태우
--   3,8,13,18)한창희
--   4,9,14,19)강정대
--   5,10,15)이기진

--3) 
SELECT STUDENT_NAME AS 학생이름,DEPARTMENT_NO AS 학번 ,STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT;


--8)
SELECT A.CLASS_NAME "과목 이름", B.PROFESSOR_NAME "교수 이름"
FROM TB_CLASS_PROFESSOR "CP"
LEFT JOIN TB_CLASS "A" ON CP.CLASS_NO = A.CLASS_NO
LEFT JOIN TB_PROFESSOR "B" ON CP.PROFESSOR_NO = B.PROFESSOR_NO;

-- 13)

-- 18)
SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT
WHERE STUDENT_NO = '9931165';

  
  
--4. DDL
--   1,6,11)김현우
--   2,7,12)권태우
--   3,8,13)한창희
--   4,9,14)강정대
--   5,10,15)이기진

-- 혼자만든거
CREATE TABLE TB_CATEGORY (
  NAME VARCHAR2(20),
  USE_YN CHAR(1)
);

DROP TABLE TB_CATEGORY;

-- 3)
--NAME VARCHAR2(20) CONSTRAINT USER_PRIMARY_KEY PRIMARY KEY;
   
-- 8)
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT; 

-- 13)
  
  
  
  
--5. DML
--   1,6)김현우
--   2,7)권태우
--   3,8)한창희
--   4)강정대
--   5)이기진


--3)
CREATE TABLE TB_국어국문학과(
  STUDENT_NO NUMBER,
  STUDENT_NAME VARCHAR2(20),
  STUDENT_BIRTH NUMBER,
  PROFESSOR_NAME VARCHAR2(20)
);

INSERT INTO TB_국어국문학과 VALUES(20121649, '한창희', 1993,'전성욱');
SELECT * FROM TB_국어국문학과;


--8)

ALTER TABLE TB_GRADE DROP COLUMN POINT;

