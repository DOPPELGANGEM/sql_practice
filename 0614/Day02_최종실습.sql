-- ���� �ǽ� ����
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
-- SYSDATE => ���� ��¥�� �ð������� �˷��ش�.
-- BETWEEN A AND B : A��  B ������ ������ �˻��ؼ� ��Ÿ����� �ǹ��Դϴ�.
SELECT SYSDATE-1 FROM DUAL; --����
SELECT SYSDATE FROM DUAL; -- ����
SELECT SYSDATE+1 FROM DUAL; -- ����

SELECT EMP_NAME "�̸�", EMP_NO "�ֹι�ȣ", SALARY "�޿�", HIRE_DATE "�Ի���"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE) / 365 BETWEEN 5 AND 10;
--WHERE (SYSDATE - HIRE_DATE)/365 >= 5 AND (SYSDATE - HIRE_DATE)/365 <=10;

--DESC EMPLOYEE;

-- ����2.
-- �������� �ƴ� ������ �̸�(EMP_NAME),�μ��ڵ�(DEPT_CODE), �����(HIRE_DATE), �ٹ��Ⱓ(3650��), ��������(ENT_DATE) �˻��Ͽ��� 
--(��� ���� : ENT_YN)
SELECT EMP_NAME "�̸�", DEPT_CODE AS �μ��ڵ�, HIRE_DATE AS "�����", (ENT_DATE - HIRE_DATE) || '��' "�ٹ��Ⱓ"
, ENT_DATE "������" FROM EMPLOYEE WHERE ENT_YN = 'Y';

-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME "�̸�", SALARY*1.5 "�޿�", CEIL(((SYSDATE - HIRE_DATE) / 365)) "�ټӳ��"
FROM EMPLOYEE
WHERE ((SYSDATE - HIRE_DATE)/365) >= 10
ORDER BY "�ټӳ��" ASC;

--SELECT EMP_NAME "�̸�" , SALARY*1.5 "�޿�", CEIL(((SYSDATE - HIRE_DATE) / 365)) 
--FROM EMPLOYEE
--WHERE ((SYSDATE - HIRE_DATE) / 365) >= 10
--ORDER BY 3 ASC; -- Ŀ���� ������ �´� ���ڸ� �ᵵ ���� ����

-- SELECT �������
-- FROM - WHERE - SELECT - ORDER BY


--����
-- 1,2,3,4,5(��������)
-- 10,9,8,7,6(��������)
-- ��,��,��,��,��,��,��,��,...
-- ��,��,��,��,��,��
SELECT * FROM EMPLOYEE
--ORDER BY SALARY DESC; -> �������� (��������:ASC, �������� : DESC)
--ORDER BY EMP_NAME DESC; --������ ����
--ORDER BY BONUS DESC; -- �����Խ� ASC�� �ڷΰ�, DESC�� �� �����ο�
ORDER BY HIRE_DATE DESC; --��¥����, ��¥�� DESC�϶� �ֽż�


-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME "�̸�", EMP_NO "�ֹι�ȣ", EMAIL "�̸���", PHONE "����ȣ", SALARY "�޿�"
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND SALARY <= 2000000;

-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE, '����') "DEPT_CODE"
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000
AND EMP_NO LIKE '__04__-2%'
ORDER BY 2 DESC; -- ������ �÷��� ������ �´� ���ڷ� ���� ����
--ORDER BY EMP_NO DESC; 


-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME, FLOOR((SYSDATE-HIRE_DATE)/ 1000)*(SALARY*0.1) "Ư�����ʽ�(���ݾ�)"
FROM EMPLOYEE
WHERE (EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%') AND BONUS IS NULL
ORDER BY 1;

