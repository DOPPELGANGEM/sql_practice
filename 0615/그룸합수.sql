-- 1. ���� ó�� �Լ�
-- LENGTH, LENGTHB, INSTR(@�� ��ġ �˷���), SUBSTR(���� �ڸ�), 
-- LPAD, RPAD(�������ϰ� ������ ä����), LTRIM, RTRIM, TRIM(��������)
-- 2. ���� ó�� �Լ�
-- 3. ��¥ ó�� �Լ�

/* =================== TO_CHAR ���� ����(����)+=====================
Format		 ����			����
,(comma)    9,999		�޸� �������� ��ȯ
.(period)	99.99		�Ҽ��� �������� ��ȯ
9           99999       �ش��ڸ��� ���ڸ� �ǹ���. ���� ���� ��� �Ҽ����̻��� ����, �Ҽ������ϴ� 0���� ǥ��.
0		    09999		�ش��ڸ��� ���ڸ� �ǹ���. ���� ���� ��� 0���� ǥ��. ������ ���̸� ���������� ǥ���� ���.
$		    $9999		$ ��ȭ�� ǥ��
L		    L9999		Local ��ȭ�� ǥ��(�ѱ��� ��� \)
XXXX		XXXX		16������ ǥ��
FM         FM1234.56    ����9�κ��� ġȯ�� ����(��) �� �Ҽ�������0�� ����
*/

/*
Format		 ����			����
,(comma)    	9,999		�޸� �������� ��ȯ
.(period)	    99.99		�Ҽ��� �������� ��ȯ
9           99999       �ش��ڸ��� ���ڸ� �ǹ���. ���� ���� ��� �Ҽ����̻��� ����, �Ҽ������ϴ� 0���� ǥ��.
0		    09999		�ش��ڸ��� ���ڸ� �ǹ���. ���� ���� ��� 0���� ǥ��. ������ ���̸� ���������� ǥ���� ���.
$		    $9999		$ ��ȭ�� ǥ��
L		    L9999		Local ��ȭ�� ǥ��(�ѱ��� ��� \)
XXXX		XXXX		16������ ǥ��
FM         FM1234.56    ����9�κ��� ġȯ�� ����(��) �� �Ҽ�������0�� ����
*/


-- ����Ŭ�Լ�
-- ������ �Լ� : �� �ึ�� �ݺ������� ����Ǿ� �Է� ���� ���� ������ŭ ����� ��ȯ
-- , �׷��Լ�: Ư���� ����� �������� �׷��� �����Ǿ� �����, �׷�� 1���� ����� ��ȯ
-- ��� �� 1�ุ ����.
SELECT SALARY FROM EMPLOYEE;
-- SUM, AVG, COUNT, MAX , MIN, ...
SELECT SUM(SALARY) FROM EMPLOYEE; -- ��ü��
SELECT AVG(SALARY) FROM EMPLOYEE; -- ��ü���
SELECT COUNT(SALARY) FROM EMPLOYEE; -- ��ü ���ڵ� ����
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE; -- �ִ� �ּڰ�

SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE -- ��Ģ�� DEPT_CODE�� ����
GROUP BY DEPT_CODE ORDER BY 1;



-- GROUP BY��
-- ������ �׷��������� ����� �׷��Լ��� �� �Ѱ��� ������� �����ϱ� ������,
-- �׷��Լ��� �̿��Ͽ� �������� ������� �����ϱ� ���ؼ���
-- �׷��Լ��� ����� �׷��� ������  GROUP BY���� ����Ͽ� ����ؾ���



-- �ǽ�����1
--[EMPLOYEE] ���̺��� �μ��ڵ� �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��), �ο����� ��ȸ�ϰ�, �μ��ڵ� ������ ����
SELECT SUM(SALARY), TRUNC(AVG(SALARY)), COUNT(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;


SELECT SUM(SALARY), TRUNC(AVG(SALARY)), COUNT(SALARY) , DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �ǽ�����2
--[EMPLOYEE] ���̺��� �μ��ڵ� �׷캰, ���ʽ��� ���޹޴� ��� ���� ��ȸ�ϰ� �μ��ڵ� ������ ����
--BONUS�÷��� ���� �����Ѵٸ�, �� ���� 1�� ī����.
--���ʽ��� ���޹޴� ����� ���� �μ��� ����.
SELECT DEPT_CODE, COUNT(BONUS) -- �μ��̸��˰������ DEPT_CODE �����ش�.
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;



-- �ǽ�����3
--EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���
SELECT JOB_CODE, COUNT(JOB_CODE), TRUNC(AVG(SALARY))
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1' -- !=�� ����
GROUP BY JOB_CODE
ORDER BY 1 DESC;



-- �ǽ�����4
--EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT EXTRACT(YEAR FROM HIRE_DATE), COUNT (HIRE_DATE)
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY 1 ASC;
-- TO_DATE('1994', 'YYYY')



-- �ǽ�����5
--[EMPLOYEE] ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�

--�غ�
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','4','��')
FROM EMPLOYEE;

--���
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','4','��'), TRUNC(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','4','��')
ORDER BY 3 DESC;

SELECT DEPT_CODE, SUM(SALARY) -- =AVERAGE(
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT JOB_CODE, SUM(SALARY) -- =SUM(
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �ǽ�����6
-- �μ��� ���޺� �޿��� �հ踦 ���Ͻÿ�.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE ASC;


-- �ǽ�����7
-- �μ��� ���� �ο����� ���Ͻÿ�
--SELECT DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','4','��'), COUNT(*)  
--FROM EMPLOYEE
--GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','4','��')
--ORDER BY 1 ASC;

SELECT DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��'), COUNT(*)  
FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3', '��','4','��')
ORDER BY 1 ASC;


-- HAVING ��
-- �׷��Լ��� ���� ���ؿ� �׷쿡 ���� ������ ������ �� �����
-- * WHERE�� HAVING�� ��򸮴� ��찡 ������ WHERE�� �׷�ȭ �ϱ� ���̰�, HAVING�� �׷�ȭ �Ŀ� �����Դϴ�.
-- WHERE ���� �����ؼ� ����� �� �˾ƾ� ��.
SELECT * FROM EMPLOYEE WHERE EMP_ID < 210;
-- �μ��� �ο����� ���غ�����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
HAVING COUNT(*) < 5
ORDER BY 1 DESC;



-- �ǽ�����1
-- �μ��� �ο��� 5���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

-- �ǽ�����2
--�μ��� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3
ORDER BY 1 ASC;


-- �ǽ�����3
--�Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ������̵�� �����ϴ� ������� ����ϼ���.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL;

-- ROLLUP�� CUBE
-- �μ��� ���޺� �޿��� �հ踦 ���Ͻÿ�.-
-- ����:url https://jddng.tistory.com/177

-- ROLLUP -> ROLLUP�� ���������� �߰� �հ踦 ����մϴ�.
-- ROLLUP�� ���������� �߰� �հ踦 ����մϴ�.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1 ASC;

-- �μ��� ���޺� �޿��� �հ踦 ���Ͻÿ�.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1 ASC; --21��

-- �μ��� ���޺� �޿��� �հ踦 ���Ͻÿ�.
-- CUBE -> CUBE�� ��� �߰��ղ��� ����մϴ�.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE) 
ORDER BY 1 ASC; --28�� (���̰� ���� 7���� ���޺� �հ��� ����)

-- �ؾߵɰ�
-- 1. ���� ������
-- - ������, ������, ������, ...
-- A = {1, 2, 3, 5, 8, 10}, B = {2, 3, 9 , 4}
-- A��B = {2, 3},  A��B = {1, 2, 3, 4, 5 , 8, 9, 10} A-B ={1,5,8,10}, B-A ={4,9}
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- A
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B
-- A��B
-- ���ؼ�, �ɺ���, ���ȥ
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- A
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B

-- A��B, UNION, UNION ALL(�ߺ����) -> ���̾���
-- 1.�÷��� ������ ���ƾ� �Ѵ�.
-- 2.�÷��� ������Ÿ���� ���ƾ� �Ѵ�.
DESC EMPLOYEE;
--ORA-01790: expression must have same datatype as corresponding expression
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- A
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B

--A-B
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- A
MINUS
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000; -- B

-- 2. JOIN(�ſ� �߿�)
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;



-- 3. SubQuery(�߿�)
-- 4. ����Ŭ��ü (View, Sequence, ...)
-- 5. PL/SQL -> Function, Stored Procedure (�ð��̵ȴٸ�..�絵������)








