-- ======================= �������� (SubQuery)=======================
-- �ϳ��� sql�� �ȿ� ���ԵǾ� �ִ� �� �ٸ� SQL��
-- ���� ������ ���� ������ �����ϴ� �������� ����
-- ���������� �ݵ�� �Ұ�ȣ�� ������� ex) ( SELECT ... ) ����
-- �������� �ȿ� ORDER BY�� ���� �ȵ�!

-- 1.������ ��������
-- ������ ������ ������ �̸��� ����ϼ���.
SELECT EMP_NAME, MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = '214';

SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = 
(SELECT MANAGER_ID FROM EMPLOYEE 
WHERE EMP_NAME = '������');


-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸� , �����ڵ�, �޿��� ����ϼ���.
SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE WHERE SALARY > (SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEE);


-- ======================= �������� ���� =======================
-- 1. ������ ��������
-- 2. ������ ��������
-- 3. ���߿� ��������
-- 4. ������ ���߿� ��������
-- 5. ��(ȣ��)�� ��������
-- 6. ��Į�� ��������

-- ======================= ������ �������� =======================
-- �����⳪ �ڳ��� ���� �μ��� ���� ������� ��ü ������ ����ϼ���.
-- 1. �μ��ڵ� ���ϰ�
-- 2. ��ü���� ���
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ڳ���';  --D9, D5
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('������','�ڳ���');
SELECT * FROM EMPLOYEE WHERE DEPT_CODE IN('D9','D5');

SELECT * FROM EMPLOYEE WHERE DEPT_CODE 
IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('������','�ڳ���'));
-- ������ �������� �ϼ�

-- @�ǽ�����1
--���¿�, ������ ����� �޿���ް� ���� ����� ���޸�, ������� ����ϼ���.
SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN('���¿�','������');

SELECT JOB_NAME, EMP_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SAL_LEVEL 
IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN('���¿�','������'))
AND EMP_NAME NOT IN ('���¿�', '������'); --���¿�,�������������


-- @�ǽ�����2
-- 2.Asia1������ �ٹ��ϴ� ������ ����(�μ��ڵ�, �����)�� ����ϼ���.
-- ���λ��
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

-- �����������
SELECT DEPT_CODE ,EMP_NAME 
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_ID FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1');
-- ����� ����(EMPLOYEE)
-- EMPLOYEE ���̺� ���� ������ ����
-- �μ��ڵ� DEPT_CODE/DEPT_ID
-- DEPARTMENT ���̺� ���� ������ ����


SELECT DEPT_ID FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

SELECT * FROM LOCATION;



-- ================== 5.��(ȣ��)�� �������� ==================
-- ���������� ���� ���������� �ְ� ���������� ������ ���� �� ����� �ٽ� ���������� ��ȯ�ؼ� 
-- ��ȣ���� ���踦 ������ �����ϴ� ����
-- > ���������� WHERE�� ������ ���ؼ� ���������� ���� ����Ǵ� ����
-- > ���� ���� ���̺��� ���ڵ忡 ���� ���������� ������� �ٲ�
-- ��� �������� VS �Ϲ� ��������

-- ���������� �Ѹ��̶� �ִ� ������ ������ ����Ͻÿ�.
SELECT * 
FROM EMPLOYEE E WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

SELECT * FROM EMPLOYEE WHERE 1 = 1; -- �� ������


-- �ǽ����� 
-- ���� ���� �޿��� �޴� ����� ����ϼ���.(FEAT. ��� ��������)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY > E.SALARY);

-- �Ϲݼ�������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE); 

-- ���� ���� �޿��� �޴� ������ ����Ͻÿ�.(FEAT. ��� ��������)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);

-- �Ϲݼ�������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE); 

-- �ǽ�����3
-- �ɺ��� ����� ���� �μ��� ����� �μ��ڵ�, �����, ����ձ޿��� ��ȸ�Ͻÿ�.
-- ��� ��������
SELECT DEPT_CODE, EMP_NAME, (SELECT AVG(SALARY) FROM EMPLOYEE)
FROM EMPLOYEE E WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE
AND EMP_NAME = '�ɺ���'); --D5�� �����Եȴ�.

SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
AND EMP_NAME = '�ɺ���';

-- �Ϲ� ��������
SELECT * FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���');
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���';


-- �ǽ�����4
-- ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������
-- �μ��ڵ�, �����, �޿�, (�μ��� �޿����) ������ ����Ͻÿ�.
-- 1. JOIN

SELECT E1.DEPT_CODE, EMP_NAME, SALARY, AVG_SAL
FROM EMPLOYEE E1
JOIN
(SELECT DEPT_CODE, ROUND(AVG(SALARY)) "AVG_SAL"
FROM EMPLOYEE
GROUP BY DEPT_CODE) E2
ON E1.DEPT_CODE = E2.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1', 'J2', 'J3') AND SALARY > AVG_SAL;

-- 2. �������
SELECT DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE E 
--WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE > E.DEPT_CODE);
WHERE JOB_CODE NOT IN ('J1', 'J2', 'J3') AND
SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE);
-- �޿������ ���ϴµ� �־ ���� �μ��ڵ尡 �ִ� �����͵��� �μ� ����� ���ϱ� ������
-- SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE �μ��� �޿������ ��.
SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

SELECT JOB_CODE FROM EMPLOYEE;
SELECT SALARY FROM EMPLOYEE;







