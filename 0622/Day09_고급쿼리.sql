-- ==================================== ������� ====================================
-- ==================================== 1. TOP-N�м� ====================================
-- 1. TOP-N�м�
-- 2. WITH ����
-- 3. ������ ����(Hierarchical Query)
-- 4. ������ �Լ�

-- Ư�� �÷����� ���� ū N���� �� �Ǵ� ���� ���� N���� ���� ���ؾ� �� ��찡 ����.
-- ��) ���� ���� �ȸ� ��ǰ 10������? ȸ�翡�� ���� �ҵ��� ���� ��� 3����?
SELECT MAX(SALARY) FROM EMPLOYEE;
-- # ROWNUM, ROWID
-- ���̺��� �����ϸ� �ڵ����� �������
-- ROWID : ���̺��� Ư�� ���ڵ带 �����ϰ� �����ϱ� ���� ������ �ּҰ�
-- ROUNUM : �� �࿡ ���� �Ϸù�ȣ, ����Ŭ���� ���������� �ο��ϴ� �÷�.
SELECT ROWNUM, ROWID, EMP_ID FROM EMPLOYEE;
-- ROWNUM�� �ο��� �� ORDER BY�� �ϸ� ROWNUM�� ���������� ������ ����.
SELECT ROWNUM, EMPLOYEE.* FROM EMPLOYEE 
ORDER BY SALARY DESC;
-- �ذ��� : �׷��ٸ� ORDER BY �Ŀ� ROWNUM�� �ο��ϸ� ���� ������?
SELECT ROWNUM, E.*
FROM
(SELECT * FROM EMPLOYEE 
ORDER BY SALARY DESC) E
WHERE ROWNUM < 6;


-- @�ǽ�����1
-- 1. D5�μ����� ���� TOP3�� ��ü������ ����ϼ���.
SELECT ROWNUM, E.*
FROM
(SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
ORDER BY SALARY DESC) E
WHERE ROWNUM < 4;

-- @�ǽ�����2
-- �μ��� �޿���� TOP3 �μ��� �μ��ڵ�� �μ���, ��ձ޿��� ����ϼ���.
SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) "AVG_SAL"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY 3 DESC;
-- ORA-00937: not a single-group group function
-- �ζ��κ� ���, ROWNUM���� ���� �ɱ�
SELECT ROWNUM, ED.*
FROM
(SELECT DEPT_CODE, DEPT_TITLE, TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999') "AVG_SAL"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY 3 DESC) ED
WHERE ROWNUM < 4;

-- 4������ 6�� ���ϱ�
SELECT *
FROM(
SELECT ROWNUM RNUM , ED.*
FROM
(SELECT DEPT_CODE, DEPT_TITLE, TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999') "AVG_SAL"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY 3 DESC) ED) EED
WHERE RNUM BETWEEN 4 AND 6;

-- ROWNUM = 1�϶������� ROWNUM = 1(1 = 1) TRUE   ROWNUM = 2(2 != 1) FALSE --> �׷��� ���� ���΢Z��...

SELECT ROWNUM RNUM , ED.*
FROM
(SELECT DEPT_CODE, DEPT_TITLE, TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999') "AVG_SAL"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY 3 DESC) ED
WHERE ROWNUM = 1;

-- SELECT ROWNUM WHERE ROWNUM = 1;������ 2�ϸ������� �����ʴ´� 


-- ==================================== 2. WITH ====================================
-- ���������� �̸��� �ٿ��ְ� �ζ��κ�� ���� ���������� �̸��� FROM���� ����� �� ����.
-- ���� ���������� ������ ���� ��� �ߺ� �ۼ��� ���� �� �ְ� ����ӵ��� �������� ������ ����.
-- �����
-- WITH ���������� AS (��������)
-- SELECT * FROM (����������);
-- ���� TOP 5 ������ ��ü������ ����ϼ���
WITH TOPN_SAL AS (SELECT * FROM EMPLOYEE ORDER BY SALARY DESC)
SELECT ROWNUM, TOPN_SAL.*
FROM
--(SELECT * FROM EMPLOYEE ORDER BY SALARY DESC) E 
TOPN_SAL
WHERE ROWNUM <= 5;


-- @�ǽ�����1
-- D5�μ����� ���� TOP3�� ��ü������ ����ϼ���.
WITH TOPN_D5_SAL AS (SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D5' ORDER BY SALARY DESC)
SELECT ROWNUM, TOPN_D5_SAL.*
FROM TOPN_D5_SAL
WHERE ROWNUM <= 3;


-- @�ǽ�����2
-- �μ��� �޿���� TOP3 �μ��� �μ��ڵ�� �μ���, ��ձ޿��� ����ϼ���.
WITH TOP_DEPT_SAL AS (SELECT DEPT_CODE, DEPT_TITLE, ROUND(AVG(SALARY)) "AVG_SAL"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE ORDER BY AVG_SAL DESC)
SELECT *
FROM
(SELECT ROWNUM RNUM, TOP_DEPT_SAL.*
FROM TOP_DEPT_SAL)
WHERE RNUM BETWEEN 4 AND 6;



-- ==================================== 3. ������ ���� ====================================
-- JOIN�� ���� ���������� �����÷��� �����Ų �Ͱ� �޸� �����÷��� ������ �������� ���踦 ����.
-- ������, �޴�, �亯�� �Խ��� �� ����Ż ������ ǥ���� ������.
-- ����Ŭ���� ���Ǵ� ����
-- 1. START WITH : �θ��� (��Ʈ)�� ����
-- 2. CONNECT BY : �θ�-�ڽİ��踦 ����
-- 3. PRIOR : START WITH ������ ������ �θ����� �����÷��� ������
-- 4. LEVEL : �ǻ��÷�(PSEUDO COLUMN), ���������� ��Ÿ���� �����÷�, SELECT, WHERE, ORDER BY���� ��밡��

-- 1���̶� ������ �����ϴ� �Ŵ����� ������ ����ϼ���.
SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE E WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);
SELECT LEVEL, EMP_ID, EMP_NAME, MANAGER_ID 
FROM EMPLOYEE
START WITH EMP_ID = 200
CONNECT BY PRIOR EMP_ID = MANAGER_ID;
--ORDER BY LEVEL; --> ������κ�����
-- PRIOR ������ ������ �÷��� START WITH���� �����÷�
-- =(EQUAL) ������ ������ �÷��� START WITH �� ���� �ٸ� �� �÷�
SELECT LPAD(' ',(3-1)*5,' ') FROM DUAL;
SELECT NVL2(MANAGER_ID,MANAGER_ID,'') FROM EMPLOYEE;

SELECT LPAD(' ',(LEVEL-1)*5,' ') ||EMP_NAME||NVL2(MANAGER_ID,'('||MANAGER_ID||')','') "������"
FROM EMPLOYEE
--START WITH EMP_ID = 200
START WITH MANAGER_ID IS NULL
CONNECT BY PRIOR EMP_ID = MANAGER_ID;

-- @�ǽ�����1
-- MENU_TBL ���̺��� �����ϴµ� ������ NO �÷��� PRIMARY KEY�� �ְ�, ���ڷ� ũ�Ⱑ 100��
-- MENU_NAME �÷��� �ְ�, ���ڷ� �� PARENT_NO�̶�� �ϴ� �÷��� ����.
DROP TABLE MENU_TBL;
CREATE TABLE MENU_TBL
(
  NO NUMBER PRIMARY KEY,
  MENU_NAME VARCHAR2(100),
  PARENT_NO NUMBER
);
INSERT INTO MENU_TBL VALUES(100, '�ָ޴�1', null);
INSERT INTO MENU_TBL VALUES(1000, '����޴�A', 100);
INSERT INTO MENU_TBL VALUES(1001, '�󼼸޴�A1', 1000);
INSERT INTO MENU_TBL VALUES(1002, '�󼼸޴�A2', 1000);
INSERT INTO MENU_TBL VALUES(1003, '�󼼸޴�A3', 1000);
INSERT INTO MENU_TBL VALUES(200, '�ָ޴�2', null);
INSERT INTO MENU_TBL VALUES(2000, '����޴�B', 200);
INSERT INTO MENU_TBL VALUES(300, '�ָ޴�3', null);
INSERT INTO MENU_TBL VALUES(3000, '����޴�C', 300);
INSERT INTO MENU_TBL VALUES(3001, '�󼼸޴�C1', 3000);
SELECT * FROM MENU_TBL; COMMIT;

SELECT LPAD(' ',(LEVEL-1)*5,' ')||MENU_NAME "�޴�"
FROM MENU_TBL
START WITH PARENT_NO IS NULL
CONNECT BY PRIOR NO = PARENT_NO;


-- ==================================== 4.������ �Լ� ====================================
-- 1. �����Լ�
-- a. RANK() OVER
-- ����
-- RANK() OVER (ORDER BY �÷��� ASC | DESC)
-- -> Ư�� �÷� �������� ��ŷ �ο���, �ߺ� ���� ������ �ش� ������ŭ �ǳʶٰ� ��ȯ��. 19 -> 21 (20�����)
-- ����
-- ȸ���� ���� ������ ����Ͻÿ�.
SELECT ROWNUM "��������", E.* 
FROM
(SELECT EMP_NAME, SALARY FROM EMPLOYEE
ORDER BY SALARY DESC) E;

-- WITH�� �������� �̸� �����ֱ�
WITH TOPN_SAL 
AS (SELECT EMP_NAME, SALARY FROM EMPLOYEE
ORDER BY SALARY DESC)
SELECT ROWNUM, TOPN_SAL.*
FROM TOPN_SAL;

-- �����Լ� ����غ���
SELECT EMP_NAME, SALARY
, RANK() OVER(ORDER BY SALARY DESC) AS "��������"
FROM EMPLOYEE;

-- @�ǽ�����1
-- �Ի����� ���� ������ ������ ���Ͽ� ����Ͻÿ�.
-- �̸�, �Ի���, ����

SELECT EMP_NAME, HIRE_DATE, RANK() OVER(ORDER BY HIRE_DATE ASC) AS "�Ի����"
FROM EMPLOYEE;


-- b. DENSE_RANK() OVER
-- -> �ߺ� ���� ������� ���������� ��ȯ, ������ ���� ������ ������ �ο��� 19-> 20-> 21 ������

SELECT EMP_NAME, SALARY
, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;

-- @�ǽ�����2
-- �⺻�޿��� ����� 1����� 10������� ����� ������ �̸�, �޿�, ������ ����ϼ���.
WITH RANK_SAL 
AS (SELECT EMP_NAME, SALARY
, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE)
SELECT * 
FROM RANK_SAL
WHERE ���� BETWEEN 1 AND 10;







--- ========================================== ���蹮������(Ű������) ==========================================
CREATE TABLE USER_INFO
(
  USER_ID VARCHAR2(20) PRIMARY KEY,
  USER_PW VARCHAR2(20) NOT NULL,
  USER_NAME VARCHAR2(20) NOT NULL,
  PHONE NUMBER NOT NULL
);
ALTER TABLE USER_INFO
MODIFY PHONE VARCHAR2(20);
INSERT INTO USER_INFO VALUES('kh_hong1', 'pass01', 'ȫ�浿', '01055557777');
SELECT * FROM USER_INFO;
DELETE FROM USER_INFO;


CREATE TABLE SHOP_MEMBER
(
  MEMBER_ID VARCHAR2(20) PRIMARY KEY,
  MEMBER_PW VARCHAR2(20) NOT NULL,
  PHONE VARCHAR2(11) NOT NULL
);

CREATE TABLE SHOP_BUY
(
  BUY_NO NUMBER PRIMARY KEY,
  BUY_ITEM VARCHAR2(20) NOT NULL,
  BUY_MEMBER VARCHAR2(20) NOT NULL,
  BUY_DATE DATE DEFAULT SYSDATE,
  FOREIGN KEY(BUY_MEMBER) REFERENCES SHOP_MEMBER(MEMBER_ID) ON DELETE SET NULL
);
-- �θ����̺��� ��������� �ڽ����̺� ����鼭 �÷��ϳ��� FOREIGN�� ����
-- ON DELETE SET NULL => �θ����̺��� ���� �����Ǹ� ���÷��ǰ����� null�̵ȴٴ°���
-- �⺻�ɼ��̶�⺸�� �׳� �׷��� �����ϴ� ��

DROP TABLE SHOP_MEMBER;
DROP TABLE SHOP_BUY;
SELECT * FROM SHOP_MEMBER;
SELECT * FROM SHOP_BUY;
-- DROP TABLE SHOP_BUY; �ϰ� CREATE TABLE~~ NOT NULL ���������� �����ش�.























