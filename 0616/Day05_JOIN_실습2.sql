-- JOIN
-- �ΰ� �̻��� ���̺��� �������� ������ �ִ� �����͵���
-- ���� �з��Ͽ� ���ο� ������ ���̺��� ����
-- -> ���� ���̺��� ���ڵ带 �����Ͽ� �ϳ��� ���ڵ�� ����
-- ANSI ǥ�� ����
SELECT EMP_NAME "�����", DEPT_CODE "�μ���"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT COUNT(*) FROM EMPLOYEE;

-- ����Ŭ ���� ����
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���"
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;

--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
-- JOIN���� �ϱ�
SELECT EMP_NAME "�����", DEPT_CODE "�μ���"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT COUNT(*)FROM EMPLOYEE;

-- JOIN ���� �ϱ�
SELECT EMP_NAME "�����"
, CASE 
  WHEN DEPT_CODE = 'D5' THEN '�ѹ���' 
  WHEN DEPT_CODE = 'D6' THEN '��ȹ��' 
  WHEN DEPT_CODE = 'D9' THEN '������' 
  END "�μ���"
FROM EMPLOYEE;



-- @�ǽ�����1
-- �μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE,LOCAL_NAME FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


-- ������ �μ��� ����ϼ���
-- EMPLOYEE / DEPARTMENT
-- DEPT_CODE / DEPT_ID


-- @�ǽ�����2
-- ������ ���޸��� ����ϼ���.
-- EMPLOYEE / JOB
-- JOB_CODE / JOB_CODE (�����ڵ�)
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- ORA-00918: column ambiguously defined 
-- �ذ���1 : �÷��տ� ���̺�� �ٿ��ֱ�!
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
-- �ذ���2 : USING ����ϱ�

-- �ǽ�����3
-- ������� �������� ����ϼ���.
-- LOCATION  / NATIONAL
-- NATIONAL_CODE / NATIONAL_CODE
-- 1.� ���̺� �ִ��� Ȯ��
-- 2.�� ���� ������ �� �ִ� ������ �÷��� �ִ��� Ȯ��
-- 3.JOIN ������ �̿��ؼ� ������ �ۼ�
SELECT LOCAL_NAME, NATIONAL_NAME
FROM LOCATION L1
JOIN NATIONAL N1 ON L1.NATIONAL_CODE = N1.NATIONAL_CODE;
--JOIN NATIONAL USING(NATIONAL_CODE);

-- ============= JOIN�� ���� ============
-- 1. INNER JOIN : �Ϲ������� ����ϴ� ����(������)
-- 2. OUTER JOIN : ��� ����ϴ� ����(������)
-- ������ �μ����� ����Ͻÿ�.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E1
JOIN DEPARTMENT D1 ON E1.DEPT_CODE = D1.DEPT_ID;
-- �̷��� ���������� ��µǴ� ���� INNER JOIN��.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E1
LEFT OUTER JOIN DEPARTMENT D1 ON E1.DEPT_CODE = D1.DEPT_ID;
-- �̷��� ���������� ��µǴ� ���� OUTER JOIN��.
-- LEFT OUTER JOIN�� ������ ���̺��� �������ִ� ��� �����͸� ����ϴ� ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E1
RIGHT OUTER JOIN DEPARTMENT D1 ON E1.DEPT_CODE = D1.DEPT_ID;
-- RIGHT OUTER JOIN�� ������ ���̺��� �������ִ� ��� �����͸� ����ϴ� ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E1
FULL OUTER JOIN DEPARTMENT D1 ON E1.DEPT_CODE = D1.DEPT_ID;
-- FULL OUTER JOIN�� ��� ���̺��� ������ �ִ� ��� �����͸� ����ϴ� ����
-- INNER + LEFT + RIGHT JOIN�� ���
-- 21 + 2 + 3 = 26


SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
-- ����Ŭ ���� ���� JOIN ���� (�̰ž�������ξ��� ANSI���̾�)
-- 1. INNER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT WHERE DEPT_CODE = DEPT_ID;

-- 2. LEFT OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);

-- 3. RIGHT OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;

-- 4. FULL OUTER JOIN
-- �������� ����



-- =================== ������ ����2 =======================
-- ��������,��ȣ����,��������,��������,
-- �������� : �������� ���ι��� �ѹ��� ����� �� ����.
-- �����, �μ���, �ٹ��ϰ� �ִ� �������� ���
-- 1. EMPLOYEE, DEPARTMENT(DEPT_CODE, DEPT_ID)
-- 2. DEPARTMENT, LOCATION (LOACATION_ID, LOCAL_CODE)

-- 1.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 2.
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
--SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID FROM DEPARTMENT;
--SELECT LOCAL_CODE, LOCAL_NAME FROM LOCATION;

-- �������� ����
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E1
JOIN DEPARTMENT D1 ON E1.DEPT_CODE = D1.DEPT_ID
JOIN LOCATION L1 ON D1.LOCATION_ID = L1.LOCAL_CODE;

--RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--RIGHT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
--LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


--@�ǽ�����1
-- ������ �븮�̸鼭, ASIA ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ�������, �޿��� ����Ͻÿ�
SELECT 
  EMP_ID "���"
  ,EMP_NAME "�̸�"
  ,JOB_NAME "���޸�"
  ,DEPT_TITLE "�μ���"
  ,LOCAL_NAME "�ٹ�������"
  ,TO_CHAR(SALARY, 'L999,999,999') "�޿�"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID -- ��������μ���
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE -- ����� �ٹ�������
WHERE JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';


-- 2023�� 12�� 25���� ���� ���� ��ȸ�ϴ� �������� �ۼ����ּ���.
SELECT TO_CHAR(TO_DATE('20231225'), 'day') FROM DUAL;

-- @JOIN ���սǽ�
--1. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, 
--���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN JOB USING(JOB_CODE)
WHERE (SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79) 
AND SUBSTR(EMP_NO,8,1) IN ('2', '4');

--2. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%��%';

--3. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE LIKE '�ؿܿ���_��';

--4. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�����", NVL(BONUS,0) "���ʽ�����Ʈ", DEPT_TITLE "�μ���", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

--5. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME , JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';
--WHERE JOB_CODE = 'J2';

--6. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
-- ������ ����
-- S2 5999999 -> 6200000 (600�����̻�޴»���ճ����� -> ��� �����;���)
SELECT EMP_NAME "�����", JOB_NAME "���޸�", SALARY "�޿�", SALARY*12 "����"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY > MAX_SAL;

--7. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING(NATIONAL_CODE)
--WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');
WHERE NATIONAL_CODE IN ('KO', 'JP');



--8. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�. ��, join�� IN ����� ��


--9. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.



























