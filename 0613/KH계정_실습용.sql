SHOW USER;
SELECT * FROM USER_ROLE_PRIVS;

SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- SELECT �������
-- FROM - WHERE - (GROUP BY - HAVING) - SELECT - (ORDER BY)

-- �ǽ�����

--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME = '���¿�' OR EMP_NAME = '������';
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME = '���¿�' AND EMP_NAME= '������';
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME LIKE '%��'; 
-- ��, ����, ������, ��������, ...
-- '%��'; => �տ� ���� ���ڰ� ������ '��'���� ������ ���ڰ� �ִ� ROW�� ����Ѵ�.
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME LIKE '_��';
-- ����, ����, �¿� , ����, �⿬ , ...
-- �ι�° ���ڰ� ���� ����̸� (������ ����)
-- ���ϵ�ī�� : %(0�� �̻��� ��� ���ڸ� ��Ī), _(�ϳ��� �ڸ��� �ش��ϴ� ��� ���ڸ� ��Ī)
-- SELECT�� ������� ResultSet

-- 1-1. ���� ���� ���� ������ �̸��� �޿��� ��ȸ�Ͻÿ�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
-- ��% => �տ� �������ڰ� ������ '��'���� �����ϴ� ���ڰ� �ִ� ROW�� ���


--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�
SELECT EMP_NAME, PHONE FROM EMPLOYEE WHERE PHONE NOT LIKE '010%';


--3. EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
--AND DEPT_CODE IN ('D9', 'D6');
-- IN : ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ������
SELECT *
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';
WHERE EMAIL LIKE '%s%' 
AND (DEPT_CODE IN('D9', 'D6')) AND
--WHERE HIRE_DATE >= '12/12/12' AND HIRE_DATE <= '13/12/31';
(HIRE_DATE BETWEEN '90/01/01' AND '01/12/01') 
AND SALARY >= 2700000;


--4. EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';
-- '_____@%'; => �ڿ��� �ƹ� ���� ���� ������� 5���ڵڿ� @���ڰ� �ִ� row�� ����Ѵ�.


--5. EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
-- ESCAPE: ���ϵ�ī���������ְ� ���ڷ� �����ϰ����ش�.
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- ESCAPE ���ڸ� ������ �Ŀ�, Ư�� ���ھտ� ESCAPE ���ڸ� �־��ش�. �̷��ԵǸ� ESCAPE
-- �̷��� �Ǹ� ESCAPE ���� �ڿ� �ִ� ���ڸ� �Ϲݹ��ڷ� �ν��ϰԵǾ� _(�����)�� ���ɰ˻�.
-- ESCAPE���ڴ� � ���ڷε� ��������

-- 6. ������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ���� ������ �̸� ��ȸ
SELECT MANAGER_ID, DEPT_CODE, EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
--WHERE MANAGER_ID IS NOT NULL

-- 7. �μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


--8. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����), 
-- �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%*12))
--�� ��µǵ��� �Ͻÿ�
--NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
--- �Լ�  :  NVL("��", "������") 

SELECT EMP_NAME, SALARY*12 "����",
SALARY*12 + SALARY*NVL(BONUS,0) "�Ѽ��ɾ�(���ʽ�����)",
(SALARY*12 + SALARY*NVL(BONUS,0)) - (SALARY*0.03*12) "�Ǽ��ɾ�"
FROM EMPLOYEE;


--9. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� 
--(SYSDATE�� ����ϸ� ���� �ð� ���)
-- select sysdate from dual; ----dual : ����Ŭ������ �ο����ִ����̺�
-- ROUND(�ݿø�), CEILING(����,�ø�), FLOOR(����,����), 
SELECT SYSDATE FROM EMPLOYEE;
SELECT (SYSDATE - HIRE_DATE) FROM EMPLOYEE;
SELECT FLOOR(SYSDATE - HIRE_DATE) FROM EMPLOYEE;
SELECT FLOOR((SYSDATE - HIRE_DATE)/365) FROM EMPLOYEE;

-- ����
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) "�ٹ��ϼ�",
FLOOR((SYSDATE - HIRE_DATE)/365) "�ټӳ��"
FROM EMPLOYEE;
-- 2021.06.01 �Ի縦 �ߴٸ� ���� �ٹ��ϼ��� ��� ���ϳ���?
-- 2023.06.13 - 2021.06.01
-- �׷��ٸ� �ټӳ���� ��� ���ϳ���?

--10. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�.
--SELECT EMP_NAME "�̸�", SALARY "����", BONUS AS ���ʽ���
--FROM EMPLOYEE
--WHERE FLOOR((SYSDATE - HIRE_DATE) / 365) >= 20;

SELECT EMP_NAME "�̸�" , SALARY "����", BONUS "���ʽ���", FLOOR((SYSDATE - HIRE_DATE)/365) "�ټӳ��" 
FROM EMPLOYEE
WHERE FLOOR((SYSDATE - HIRE_DATE)/365) >= 20;







DESC EMPLOYEE;











