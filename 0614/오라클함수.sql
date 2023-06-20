-- ����Ŭ�Լ�
-- ������ �Լ� : �� �ึ�� �ݺ������� ����Ǿ� �Է� ���� ���� ������ŭ ����� ��ȯ
--, �׷��Լ� :
-- 1. ���� ó�� �Լ�
-- LENGTH, LENGTHB, INSTR(@�� ��ġ �˷���), SUBSTR(���� �ڸ�), 
-- LPAD, RPAD(�������ϰ� ������ ä����), LTRIM, RTRIM, TRIM(��������)
-- =========================== @�ǽ����� ===========================
---- ������� ���� �ߺ����� ���������� ����ϼ���.
SELECT EMP_NAME, SUBSTR(EMP_NAME, 1, 1) "��"
FROM EMPLOYEE
ORDER BY 1 ASC;
-- �ߺ����� ����� ��� �ϴ°ɱ�? DISTINCT
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) "��"
FROM EMPLOYEE
ORDER BY 1 ASC;

-- LENGTH, LENGTHB, INSTR, SUBSTR, LPAD/RPAD, LTRIN/RTRIM/TRIM, REPLACE(��ü�ϱ�)
-- SUBSTR (�÷���, ������ġ, ���ڰ���)

-- =========================== @�ǽ����� ===========================
-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID, EMP_NAME, 
SUBSTR(EMP_NO, 1, 8) ||'******', RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*'),
SALARY*12
FROM EMPLOYEE
--WHERE EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%';
WHERE SUBSTR(EMP_NO,8,1) = 1 OR SUBSTR(EMP_NO,8,1) = 3; 

-- LPAD("��", "�� ���ڱ���", "ä����") : ������ ���̸�ŭ ���ʺ��� ä���ڷ� ä��.
-- ä���ڸ� �������� ������ �������� �ش� ���̸�ŭ ���ڸ� ä���.   (��, LPAD(deptno, 5))
-- RPAD("��", "�� ���ڱ���", "ä����") : ������ ���̸�ŭ �����ʺ��� ä���ڷ� ä��, 
-- ä���ڸ� �������� ������ �������� �ش� ���̸�ŭ ���ڸ� ä���.   (��, RPAD(deptno, 5))
SELECT EMP_ID, EMP_NAME,
SUBSTR(EMP_NO, 1, 8) || '******', RPAD(SUBSTR(EMP_NO,1, 8),14, '*'),
SALARY*12
FROM EMPLOYEE
--WHERE EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%';
WHERE SUBSTR(EMP_NO,8,1) = 1 OR SUBSTR(EMP_NO,8,1) = 3;

-- ���پ���� --
SELECT SUBSTR(EMP_NO, 1, 8) FROM EMPLOYEE;
SELECT RPAD(SUBSTR(EMP_NO, 1, 8), 14,'*') FROM EMPLOYEE;
SELECT SUBSTR(EMP_NO, 8, 1) FROM EMPLOYEE; -- SUBSTR (�÷���, ������ġ, ���ڰ���)


-- =========================== @�ǽ����� ===========================
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
--TRIM �Լ��� ���ڿ��� ���� ������ �����ϴ� �⺻���� �Լ��̴�. 
--LTRIM �Լ�, RTRIM �Լ��� ���ʰ� �������� ������ ������ �� ��밡�� ������, �ݺ����� ���ڳ� Ư�� ���ڸ� ������ �� ���� ����Ѵ�.
-- LTRIM �Լ��� ���ڿ��� ����(����)���� ����, ���� ���� LTRIM("���ڿ�", "�ɼ�")
-- RTRIM �Լ��� ���ڿ���  ������(����) ����  ����,  RTRIM("���ڿ�", "�ɼ�") 
SELECT RTRIM(LTRIM('982341678934509hello89798739273402' ,'0123456789'), '0123456789') FROM DUAL;

SELECT LTRIM('982341678934509hello89798739273402' ,'0123456789') FROM DUAL;
SELECT RTRIM(LTRIM('982341678934509hello89798739273402' ,'0123456789'),'0123456789') FROM DUAL;

-- ' KH ', 'KH'
-- ============== DUAL ���̺� ==============
-- �� ���� �̷���� Ư���� ���̺�, SYSDATE, USER, �������� ���� �ǻ��÷� ���ÿ� ����ϵ��� ����
SELECT * FROM DUAL; --VARCHAR2(1) : 'x'���� ������

-- ============== LTRIM/RTRIM/TRIM ==============
SELECT RTRIM(LTRIM('  KH  ')) FROM DUAL; -- KH
SELECT TRIM('  KH  ') FROM DUAL; --KH
SELECT RTRIM(LTRIM('123KH123','123'), '123') FROM DUAL; --KH
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; --KH
SELECT SYSDATE FROM DUAL; --23/06/19 (���糯¥)


-- LENGTH, LENGTHB, INSTR, SUBSTR, LPAD/RPAD, LTRIM/RTRIM/TRIM, REPLACE,
-- CONCAT, ||, LOWER, UPPER, INITCAP
-- ============== REPLACE �Լ� ==============
-- '����� ������ ���ﵿ' -> �Ｚ��
-- �Լ����� : REPLACE("Į���� or ���ڿ�", "ã������", "ġȯ����")
SELECT REPLACE ('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;


-- ============== �ǽ�����4 ==============
-- EMPLOYEE���� EMAIL�÷��� �ּҸ� gmail.com���� �ٲ��ּ���.
SELECT REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') , SALARY FROM EMPLOYEE
WHERE SALARY >= 3000000; -- �޿� 300���̻�

-- 2. ���� ó�� �Լ�
-- ROUND : �ݿø� , TRUNC("��", "�ɼ�") -> TRUNC�Լ��� �ַ� �Ҽ��� ���� �� ��¥�� �ð��� ���ٶ� ��� 
-- FLOOR:�Ҽ������ϴ¹����ǹ���, CEIL:�Ҽ������ϸ� ������ �ø�
SELECT (SYSDATE-HIRE_DATE) , TRUNC((SYSDATE-HIRE_DATE),1),
FLOOR(SYSDATE-HIRE_DATE),
CEIL(SYSDATE-HIRE_DATE), ROUND(SYSDATE-HIRE_DATE)
FROM EMPLOYEE;

SELECT TRUNC((SYSDATE-HIRE_DATE),1) FROM EMPLOYEE; -- 3785.8 ����
SELECT FLOOR(SYSDATE-HIRE_DATE) FROM EMPLOYEE;
SELECT CEIL(SYSDATE-HIRE_DATE) FROM EMPLOYEE;
SELECT ROUND(SYSDATE-HIRE_DATE) FROM EMPLOYEE;


-- 3. ��¥ ó�� �Լ�
-- SYSDATE,SYSTIMESTAMP
-- SYSDATE�� SYSTIMESTAMP�� �������ڿ� �ð��� ���� DATE, TIMESTAMP������ ��ȯ�Ѵ�.
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

--============== @�ǽ�����1 ==============
-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 3������ �� ��¥�� ��ȸ�Ͻÿ�
-- ADD_MONTHS()
-- ADD_MONTHS (date, integer) : ADD_MONTHS�Լ��� �Ű������� ���� ��¥�� interger ��ŭ�� ���� ���� ��¥�� ��ȯ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

SELECT HIRE_DATE, ADD_MONTHS(HIRE_DATE,3) 
FROM EMPLOYEE;

--============== @�ǽ�����2 ==============
-- MONTHS_BETWEEN()
-- MONTHS_BETWEEN(date1, date2) : �� ��¥ ������ �������� ��ȯ�ϴµ� date2�� date1���� ���� ��¥���´�.
--  EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �������� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1)
FROM EMPLOYEE;

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),1) FROM EMPLOYEE; -- 124.4����

--============== @�ǽ�����3 ==============
-- LAST_DAY()
-- LAST_DAY() : date ��¥�� �������� �ش� ���� ������ ���ڸ� ��ȯ�Ѵ�.
--ex) EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի���� ���������� ��ȸ�ϼ���
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)+1 --+1�ϸ� �״������� 1���� ����
FROM EMPLOYEE;

SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEE; -- 13/02/28 ����
SELECT LAST_DAY(HIRE_DATE)+1 FROM EMPLOYEE; -- LAST_DAY(HIRE_DATE)+1 �״������� 1���� ���� 13/03/01 ����


--============== @�ǽ�����4 ==============
--ex) EMPLOYEE ���̺��� ��� �̸�, �Ի� �⵵, �Ի� ��, �Ի� ���� ��ȸ�Ͻÿ�.
-- EXTRACT �Լ� : ��¥ ������ �����ͷκ��� ��¥ ������ �и��ؼ� ���ο� �÷��� ���·� �������ִ� �Լ�
-- YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) || '��' ||
EXTRACT(MONTH FROM HIRE_DATE) || '��' ||
EXTRACT(DAY FROM HIRE_DATE) || '��'
FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE;
SELECT EXTRACT(MONTH FROM HIRE_DATE) FROM EMPLOYEE;
SELECT EXTRACT(DAY FROM HIRE_DATE) FROM EMPLOYEE;


--@�ǽ�����
/*
     ���úη� �Ͽ��ھ��� ���뿡 �������ϴ�.
     ������ �Ⱓ�� 1�� 6������ �Ѵٶ�� �����ϸ�
     ù��°,�������ڸ� ���Ͻð�,
     �ι�°,�������ڱ��� �Ծ���� «���� �׷���� ���մϴ�.
     (��, 1�� 3���� �Դ´ٰ� �Ѵ�.)
*/

SELECT ADD_MONTHS(SYSDATE,18) "���볯¥",  (ADD_MONTHS(SYSDATE,18)-SYSDATE) * 3 "«���" FROM DUAL;

-- 4.����ȯ �Լ�
-- TO_CHAR, TO_DATE, TO_NUMBER
-- TO_CHAR(��¥������, ����) : ��¥�� ���Ŀ� ���缭 ���ڿ��� ��ȯ , TO_CHAR(��¥, '����') -> ���Ŀ� �´� ���ڿ� ��ȯ
-- TO_DATE(char,����) : ���ڸ� ��¥�� ��ȯ
-- TO_NUMBER �Լ� : ���ڿ��� ���� ����(����,�Ǽ�)�� ��ȯ�� �����ϴ�.

-- ============================= TO_DATE (CHAR -> DATE)=============================
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN TO_DATE('10/01/01') AND TO_DATE('12/12/31');
-- <input type="date"> -> '10-01-01','12-12-31'
SELECT TO_DATE('20100101', 'YY/MM/DD') FROM DUAL;
--SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL; --�������� ��� ���� 10/01/01 ����Ŭ��������ϴ³�¥����


-- ============================= TO_NUMBER (CHAR -> NUMBER) =============================
SELECT TO_NUMBER('1,000,000','9,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000','9,999,999') - TO_NUMBER('500,000','999,999') FROM DUAL;




-- ============================= ��Ÿ�Լ� =============================
-- 1.NVL (�� ó�� �Լ�)
-- NVL("��","������") => ���� null �� ���, ���� ���� ����ϰ� �׷��� ������ �������� �״�� ����Ѵ�.
SELECT NVL(BONUS,0)*SALARY FROM EMPLOYEE;
SELECT NVL(DEPT_CODE, 'D0') FROM EMPLOYEE;

SELECT BONUS FROM EMPLOYEE;
SELECT DEPT_CODE FROM EMPLOYEE;

-- 2.DECODE (IF��)
-- DECODE(�÷���, ����1, ���1, ����2, ���2, ����3, ���3, ....)
-- ���� ǥ���ϱ�
SELECT EMP_NAME, EMP_NO, SALARY, 
DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��','��') "����"
FROM EMPLOYEE;

SELECT SUBSTR(EMP_NO, 8, 1) FROM EMPLOYEE;

-- 3.CASE (switch��)
SELECT EMP_NAME, EMP_NO, SALARY
, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��','��') "����"
, CASE 
    WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '��' 
    WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '��' 
    WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '��' 
    WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '��' 
    ELSE '��'
  END AS ����
FROM EMPLOYEE;

-- ����ó���Լ�
-- @�Լ� �����ǽ�����
--1. ������� �̸��� , �̸��� ���̸� ����Ͻÿ�
--		  �̸�	    �̸���		�̸��ϱ���
--	ex)  ȫ�浿 , hong@kh.or.kr   	  13
-- LENGTH()
SELECT EMP_NAME "�̸�" , EMAIL AS �̸���, LENGTH(EMAIL) "�̸��ϱ���"
FROM EMPLOYEE;


--2. ������ �̸��� �̸��� �ּ��� ���̵� �κи� ����Ͻÿ�
--	ex) ���ö	no_hc
--	ex) ������	jung_jh
SELECT EMP_NAME "������", RTRIM(RTRIM(EMAIL,'kh.or.kr'),'@') "�̸���"
FROM EMPLOYEE;



--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. �׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
--	    ������    ���      ���ʽ�
--	ex) ������	    1962	    0.3
--	ex) ������	    1963  	    0
SELECT EMP_NAME AS ������, '19'||SUBSTR(EMP_NO,1,2) "���", NVL(BONUS,0) "���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

SELECT EMP_NAME AS ������, '19'||SUBSTR(EMP_NO,1,2) "���", NVL(BONUS,0) "���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

SELECT '19'||SUBSTR(EMP_NO,1,2) FROM EMPLOYEE;


--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ��ü ������ ����Ͻÿ�.(�غô���)
SELECT * FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
--	ex) ������		1997�� 3��
SELECT EMP_NAME "������" , 
EXTRACT(YEAR FROM HIRE_DATE) || '��' ||
EXTRACT(MONTH FROM HIRE_DATE) || '��' "�Ի���"
FROM EMPLOYEE;


--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä���� ��� �Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME "������", SUBSTR(EMP_NO,1,8) || '******' "�ֹι�ȣ(||)",
RPAD(SUBSTR(EMP_NO,1,8),14,'*') "�ֹι�ȣ(RPAD)"
FROM EMPLOYEE;


SELECT SUBSTR(EMP_NO,1,8) "�ֹι�ȣ(RPAD)" FROM EMPLOYEE;
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') FROM EMPLOYEE;


--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME "������", JOB_CODE "�����ڵ�", SALARY*12+SALARY*NVL(BONUS,0) "����",
TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999,999') "����(TO_CHAR)"
FROM EMPLOYEE;


SELECT TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999,999') "����(TO_CHAR)" FROM EMPLOYEE;
SELECT NVL(BONUS,0) FROM EMPLOYEE;


/* ======== TO_CHAR ���� ����(����)
Format		 ����			    ����
,(comma)   9,999		    �޸� �������� ��ȯ
.(period)	 99.99		    �Ҽ��� �������� ��ȯ
9          99999        �ش��ڸ��� ���ڸ� �ǹ���. ���� ���� ��� �Ҽ����̻��� ����, �Ҽ������ϴ� 0���� ǥ��.
0		       09999		    �ش��ڸ��� ���ڸ� �ǹ���. ���� ���� ��� 0���� ǥ��. ������ ���̸� ���������� ǥ���� ���.
$		       $9999		    $ ��ȭ�� ǥ��
L		       L9999		    Local ��ȭ�� ǥ��(�ѱ��� ��� \)
XXXX		   XXXX		      16������ ǥ��
FM         FM1234.56    ����9�κ��� ġȯ�� ����(��) �� �Ҽ�������0�� ����
*/


--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ��.
-- ��� ����� �μ��ڵ� �Ի���

-- IN ������ WHERE�� �ڿ� �ٿ��� �÷��� Ư������ ������ �ִ��� Ȯ���ϴ� �뵵�� ����
-- SELECT Į���� FROM ���̺�� WHERE Į���� IN (��1, ��2, ...)
-- Į���� ���� ��1 �Ǵ� ��2�� �ش��ϴ� ���� ���
-- SELECT Į���� FROM ���̺�� WHERE Į���� NOT IN (��1, ��2, ...)
-- Į���� ���� ��1 �Ǵ� ��2 ��𿡵� �ش����� �ʴ� �͸� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE , HIRE_DATE
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D9';
WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

SELECT EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE;

--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
-- MONTHS_BETWEEN('��¥1', '��¥2') => ��¥1 - ��¥2 = ������
-- ADD_MONTHS(HIRE_DATE,3) => 3������ ��¥���
SELECT EMP_NAME "������", HIRE_DATE "�Ի���", TRUNC(SYSDATE-HIRE_DATE) "�ٹ��ϼ�"
-- �Ի��Ͽ� �������� ���� ��¥
,TRUNC(SYSDATE - ADD_MONTHS(HIRE_DATE,MONTHS_BETWEEN(SYSDATE,HIRE_DATE))) "��"
FROM EMPLOYEE;


SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) FROM EMPLOYEE;
SELECT ADD_MONTHS(HIRE_DATE,MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) FROM EMPLOYEE;
SELECT ADD_MONTHS(HIRE_DATE,3) FROM EMPLOYEE;

--10. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--   ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	* �ֹι�ȣ�� �̻��� ������� ���ܽ�Ű�� ���� �ϵ���(200,201,214 �� ����)
--	* HINT : NOT IN ���

SELECT EMP_NAME, DEPT_CODE,
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))||'�� '||
EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO, 3, 2), 'MM'))||'�� '||
EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO, 5, 2), 'DDD'))||'��' "������� (TO_DATE)",
-- ��¥ ����ȯ�� �̿��� ���
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) "����(��)",
-- ���� ����ȯ�� �̿��� ���
EXTRACT(YEAR FROM SYSDATE) - (DECODE(SUBSTR(EMP_NO,8,1), '1', 1900, '2', 1900, '3', 2000, '4', 2000)
+TO_NUMBER(SUBSTR(EMP_NO,1,2))) "����(��)DECODE"
FROM EMPLOYEE;



SELECT SUBSTR(EMP_NO,1,2) FROM EMPLOYEE;
SELECT TO_DATE(SUBSTR(EMP_NO,1,2), 'RR') ||'��' FROM EMPLOYEE;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) ||'��' FROM EMPLOYEE;


/*
============================
����	        �ǹ�
============================
YYYY	   �⵵ǥ��(4�ڸ�)
YY	      �⵵ ǥ�� (2�ڸ�)
RR      �⵵ ǥ�� (2�ڸ�), 50�̻� 1900, 50�̸� 2000
MONTH   ���� LOCALE������ �°� ���(FULL)
MM	   �������ڷ�ǥ��  
MON	    ���� ���ĺ����� ǥ��(�����Ͼƴ�)
DDD     365�� ǥ��
DD	    ��¥ ǥ��	
D      ������ ���ڷ� ǥ��(1:�Ͽ���...) 
DAY	   ���� ǥ��	  
DY	   ������ ���� ǥ��	

HH HH12     �ð�
HH          �ð�(24�ð�)
MI
SS

AM PM A.M. P.M. ��������ǥ��

FM          ��, ��, ��,��, �ʾ��� 0�� ������.
*/


SELECT EMP_ID, EMP_NO FROM EMPLOYEE;
SELECT 
EXTRACT(YEAR FROM TO_DATE('01', 'YY')) 
, EXTRACT(YEAR FROM TO_DATE('94', 'RR'))  --RR�� ��� 50�̻� 1900���, 50�̸� 2000���
, EXTRACT(YEAR FROM TO_DATE('12', 'RR')) 
FROM DUAL;

SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2), 'RR')) "����⵵"
FROM EMPLOYEE;



SELECT TO_DATE('94', 'YY') FROM DUAL;



--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT DEPT_CODE
FROM EMPLOYEE;



























