SELECT * FROM TB_CLASS;
SELECT * FROM TB_PROFESSOR;

--1. BASIC SELECT
--   1,6)������
--   2,7)���¿�
--   3,8)��â��
--   4,9)������
--   5,10)�̱���
--   

--3) "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--ã�� ������ ����)
SELECT STUDENT_NAME , DEPARTMENT_NO, STUDENT_SSN, ABSENCE_YN 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' -- DEPARTMENT_NO�� 001 �� ����
AND STUDENT_SSN LIKE '%-2%' -- �յڿ� ���� ���ڰ� ������ -2 �̶�� ���ڰ� �ִ� ���� ���
AND ABSENCE_YN = 'Y'; -- ABSENCE_YN�� Y�϶�

--8)������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
--������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO as CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;


--2. Additional SELECT
--   1,6,11)������
--   2,7,12)���¿�
--   3,8,13)��â��
--   4,9,14)������
--   5,10,15)�̱���


--3) �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
--�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
--2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� �� ���� ����
--�������.)

select sysdate from dual;
select substr('1212122', 0 ,5) from dual;
select substr('1212122', 3 ,2) from dual; --3��°���� 2��°����
--dual : ����Ŭ������ �ο����ִ����̺�

-- ���پ����
select SUBSTR(PROFESSOR_SSN,1,2) FROM TB_PROFESSOR;
select '19' || SUBSTR(PROFESSOR_SSN,1,2) FROM TB_PROFESSOR;
select TO_DATE('19' || SUBSTR(PROFESSOR_SSN,1,2), 'YYYY') FROM TB_PROFESSOR;
select EXTRACT(YEAR FROM TO_DATE('19' || SUBSTR(PROFESSOR_SSN,1,2), 'YYYY')) FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME "�����̸�", 
EXTRACT(YEAR FROM SYSDATE)- 
EXTRACT(YEAR FROM TO_DATE('19' || SUBSTR(PROFESSOR_SSN,1,2),'YYYY')) "����"
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN LIKE '%-1%'
ORDER BY 2 ASC;



--3. Additional SELECT(option)
--   1,6,11,16)������
--   2,7,12,17)���¿�
--   3,8,13,18)��â��
--   4,9,14,19)������
--   5,10,15)�̱���

--3) �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�,
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--"������ �ּ�" �� ��µǵ��� ����.

--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.

--SELECT A.CLASS_NAME "���� �̸�", B.PROFESSOR_NAME "���� �̸�"
--FROM TB_CLASS_PROFESSOR "CP"
--LEFT JOIN TB_CLASS "A" ON CP.CLASS_NO = A.CLASS_NO
--LEFT JOIN TB_PROFESSOR "B" ON CP.PROFESSOR_NO = B.PROFESSOR_NO;

  
--4. DDL
--   1,6,11)������
--   2,7,12)���¿�
--   3,8,13)��â��
--   4,9,14)������
--   5,10,15)�̱���
--   
--5. DML
--   1,6)������
--   2,7)���¿�
--   3,8)��â��
--   4)������
--   5)�̱���

