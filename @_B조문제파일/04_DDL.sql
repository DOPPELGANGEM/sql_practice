SELECT * FROM TB_CLASS;
SELECT * FROM TB_PROFESSOR;


-- DDL
--   1,6,11)������
--   2,7,12)���¿�
--   3,8,13)��â��
--   4,9,14)������
--   5,10,15)�̱���
--   


--1)
CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);
--2)

--3) 


--4)

--5)

--6)
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CATEGORY RENAME COLUMN USE_YN TO CATEGORY_USE_YN;


--7)

--8) 


--9)

--10)

--11)



--12)
--13)
--14)
--15)
--16)

--17)
--18)
--19)