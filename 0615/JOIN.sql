-- JOIN
-- �ΰ� �̻��� ���̺����� �������� ������ �ִ� �����͵���
-- ���� �з��Ͽ� ���ο� ������ ���̺��� ����
-- -> ���� ���̺��� ���ڵ带 �����Ͽ� �ϳ��� ���ڵ�� ����
-- ANSI ǥ�� ����
SELECT EMP_NAME, DEPT_CODE 
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT COUNT(*) FROM EMPLOYEE;

-- ����Ŭ ���� ����
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���"
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;

--11. �������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
-- JOIN���� �ϱ�

--SELECT <�� ���>
--FROM ù��°���̺�
-- JOIN <�ι�°���̺�> ON <��������> = �ι�°���̺����ִ� DEPT_ID�� 
--EMPLOYEE ���̺� DEPT_CODE ��Ͽ� ��ģ��. =>�������ּ�
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
-- �μ����� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE, LOCAL_NAME --NATIONAL_CODE, LOCAL_CODE������..
FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


SELECT * FROM DEPARTMENT;
SELECT LOCAL_NAME FROM LOCATION;










