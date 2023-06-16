SELECT * FROM TB_CLASS;
SELECT * FROM TB_PROFESSOR;

-- Additional SELECT(option)
--   1,6,11,16)김현우
--   2,7,12,17)권태우
--   3,8,13,18)한창희
--   4,9,14,19)강정대
--   5,10,15)이기진


--1)
SELECT STUDENT_NAME AS "학생 이름",STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT ORDER BY 1;

--2)

--3) 


--4)

--5)

--6)
SELECT STUDENT_NO AS 학생번호, STUDENT_NAME AS 이름 
, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT ON  TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO ORDER BY 2;


--7)

--8) 
SELECT A.CLASS_NAME "과목 이름", B.PROFESSOR_NAME "교수 이름"
FROM TB_CLASS_PROFESSOR "CP"
LEFT JOIN TB_CLASS "A" ON CP.CLASS_NO = A.CLASS_NO
LEFT JOIN TB_PROFESSOR "B" ON CP.PROFESSOR_NO = B.PROFESSOR_NO;

--9)

--10)

--11)
SELECT DEPARTMENT_NAME, STUDENT_NAME,PROFESSOR_NAME
FROM TB_STUDENT
JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
JOIN TB_DEPARTMENT ON TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO
WHERE STUDENT_NO ='A313047';


--12)
--13)
--14)
--15)
--16)
SELECT TB_CLASS.CLASS_NO, TB_CLASS.CLASS_NAME, AVG(POINT)
FROM TB_CLASS 
JOIN TB_DEPARTMENT ON TB_CLASS.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO
JOIN TB_GRADE ON TB_CLASS.CLASS_NO = TB_CLASS.CLASS_NO
WHERE TB_CLASS.DEPARTMENT_NO = '034' AND TB_CLASS.CLASS_NO NOT LIKE 'C073%'
group by TB_CLASS.CLASS_NO, TB_CLASS.CLASS_NAME order by 1;
--17)
--18)
--19)