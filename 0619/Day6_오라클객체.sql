-- ����Ŭ ��ü (���������� FROM���� ����)
-- ���������� ����� �� �ִ� ��ġ��?
-- SELECT�� �ڿ�, WHERE�� �ڿ�, ORDER BY�� �ڿ�, FROM�� �ڿ�
--SELECT *
--FROM (SELECT EMP_NAME, EMP_NO, HIRE_DATE, SALARY, '1' "�ӽ�" FROM EMPLOYEE);

SELECT �ӽ�
FROM (SELECT EMP_NAME, EMP_NO, HIRE_DATE, SALARY, '1' "�ӽ�" FROM EMPLOYEE);

-- ����Ŭ ��ü
-- ================================= 1.VIEW =================================
-- FROM�� �ڿ� ���� ���������� �̸��� �ٿ��� ������ ���̺�� ����ϴ� ��
-- �������̺� �ٰ��� ������ ������ ���̺�(����ڿ��� �ϳ��� ���̺�ó�� ��밡���ϰ� ��)
-- �̸��� ���̱� �� INLINE VIEW, �̸��� ���� �� STORED VIEW
-- VIEW�� �����Ϸ��� ������ �ʿ���
CREATE VIEW EMP_VIEW1
AS SELECT EMP_NAME, EMP_NO, PHONE, EMAIL FROM EMPLOYEE;

SELECT * FROM EMP_VIEW1;

SHOW USER;
SELECT * FROM USER_ROLE_PRIVS; --0613 ���޴� Day_02_DCL_�ǽ�.sql�ǽ����ִ�  ROLE�� ROLE��� �־�ߵ�
SELECT * FROM USER_SYS_PRIVS; -- CREATE VIEW���־�ߵȴ�.

-- ================================= ���� Ư¡ =================================
-- ���̺� �ִ� �����͸� ������ ���̸�, ������ ��ü�� �����ϰ� �ִ� ���� �ƴ�
-- - ������ġ ���� ���������� �������� �ʰ� �������̺�� �������
-- - �������� ���� ���̺���� ��ũ ����
-- * �並 ����ϸ� Ư�� ����ڰ� ���� ���̺� �����Ͽ� ��� �����͸� ���� �ϴ� ���� ������ �� ����
-- - ���� ���̺��� �ƴ� �並 ���� Ư�� �����͸� �������� ����
-- * �並 ����� ���ؼ��� ������ �ʿ���!!! (�⺻ RESOURCE�ѿ� ���� �ȵ�!)

SELECT * FROM USER_VIEWS;
DROP VIEW EMP_VIEW1;

-- ================================= ���� Ư¡2 =================================
-- 1. �÷��Ӹ� �ƴ϶� ��� ����ó���� VIEW ������ ������.
-- ���������� ������ �ִ� VIEW�� �����Ͻÿ�.
CREATE VIEW ANNUAL_SALARY_VIEW(EMP_ID, EMP_NAME, SALARY, ANNUAL_SALARY)
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;
SELECT * FROM ANNUAL_SALARY_VIEW;

-- 2. JOIN�� Ȱ���� VIEW ������ ������.
-- ��ü ������ ���, �̸� , ���޸�, �μ���, �������� �� �� �ִ� VIEW�� �����Ͻÿ�. (ALL_INFO_VIEW)
CREATE VIEW ALL_INFO_VIEW
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- ���� AS SELECT �ڿ��ִ� �Ÿ��ȴ�!!!! 46��°��
SELECT LOCAL_NAME FROM ALL_INFO_VIEW;

-- =============== VIEW �����غ��� ===============
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
--  FROM EMPLOYEE;

SELECT * FROM USER_VIEWS;
SELECT * FROM V_EMPLOYEE;

SELECT * FROM V_EMPLOYEE WHERE EMP_ID = 200;

-- �������� DEPT_CODE�� D8�� �ٲٴ� DML�ۼ��Ͻÿ�
UPDATE V_EMPLOYEE SET DEPT_CODE = 'D8'
WHERE EMP_ID = '200';
-- 1�� �� (��) ������Ʈ�Ǿ����ϴ�.
SELECT * FROM EMPLOYEE WHERE EMP_ID = '200';
-- ���� ���̺��� Ȯ���غ��� �����Ǿ� ����.
-- ��� : VIEW�� ���� ������!!!!
ROLLBACK;


UPDATE V_EMPLOYEE
SET SALARY = 7000000
WHERE EMP_ID = '200';
-- ���� �÷� ������ �ȵ�!!!


-- ================== VIEW �ɼ� ==================
-- 1. OR REPLACE
-- �����Ҷ� DROP �� CREATE, �ٷ� �����
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE;
SELECT * FROM V_EMPLOYEE;

--CREATE OR REPLACE VIEW V_EMPLOYEE
--AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
--FROM EMPLOYEE WITH CHECK OPTION;
--SELECT * FROM V_EMPLOYEE;

-- 2. FORCE / NOFORCE (�߾Ⱦ�)
-- �⺻ ���̺��� �������� �ʴ��� �並 ������
-- ex) CREATE FORCE VIEW ~~

-- 3. WITH CHECK OPTION
-- WHERE�� ���ǿ� ����� �÷��� ���� �������� ���ϰ� ��.

-- 4. WITH READ ONLY
-- �信 ���� ��ȸ�� �����ϸ� DML �Ұ����ϰ� ��.

-- @�ǽ�����1
-- --kh���� ������ �� employee, job, department���̺��� �Ϻ������� ����ڿ��� �����Ϸ��� �Ѵ�.
-- ������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի����� �÷������� ��(V_EMP_INFO)�� (�б� ��������) �����Ͽ���.
CREATE OR REPLACE VIEW V_EMP_INFO(������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի���)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, 
NVL((SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID), '����'), 
HIRE_DATE
FROM EMPLOYEE E
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WITH READ ONLY;

UPDATE V_EMP_INFO
SET ������̵� = '220' WHERE ������̵� = '214';
-- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view

SELECT * FROM V_EMP_INFO;
DROP VIEW V_EMP_INFO;


-- =============== ������ ��ųʸ�(DD, Data Dictionary) ===============
-- -> �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ ������ �ý��� ���̺�
-- -> ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ���� �۾��� �Ҷ�
-- �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺���.
-- ����ڴ� ������ ��ųʸ��� ������ ���� �����ϰų� ������ �� ����.
-- ������ ��ųʸ� �ȿ��� �߿��� ������ ���� �ֱ� ������ ����ڴ� �̸� Ȱ���ϱ� ���ؼ���
-- ������ ��ųʸ� �並 ����ϰԵ�.

SELECT * FROM USER_VIEWS;
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;

-- =============== ������ ��ųʸ� ���� ���� ===============
-- 1. USER_XXXX : �ڽ��� ������ ������ ��ü � ���� ������ ��ȸ��.
-- 2. ALL_XXXX : �ڽ��� ������ ������ ��ü � ���� ������ ��ȸ��. (���Ѻο�������)
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_VIEWS;
-- 3. DBA_XXXX : �����ͺ��̽� �����ڸ� ������ ������ ��ü ���� ���� ��ȸ
-- �����ͺ��̽� �����ڴ� SYS ������ SYSTEM
-- �����ͺ��̽� �����ڴ� DBA��� ��.
-- ������ �м� �����ڵ� �ְ� DA��� ��. 
SELECT * FROM DBA_TABLES; -- �ý��۰������� �����ؾ���


-- =============== 2. SEQUENCE(������) ===============
-- ���������� ���� ���� �ڵ����� �����ϴ� ��ü, �ڵ� ��ȣ �߻���(ä����)�� ������ ��.
CREATE SEQUENCE SEQ_USER_NO;
CREATE SEQUENCE SEQ_USER_NO2
MINVALUE 10
MAXVALUE 999999999
START WITH 10
INCREMENT BY 1
CYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
-- =============== ������ �ɼ� ===============
-- START WITH ���� : ó�� �߻���ų ���� �� ����, �⺻�� 1
-- INCREMENT BY : ���� ���� ���� ����ġ, �⺻��1
-- MINVALUE : �߻���ų �ּҰ� ����
-- MAXVALUE : �߻���ų �ִ밪 ����
-- CYCLE/NOCYCLE : ������ ���� �ִ밪���� ������ �Ϸ��ϸ� CYCLE�� START WITH�� NOCYCLE�� ���� �߻�
-- CACHE/NOCACHE : �޸𸮻󿡼� ���������� ����, �⺻�� 20, ������ ��ü�� ���ٺ󵵸� �ٿ��� ȿ������ � ����,

CREATE TABLE KH_SEQUENCE_TBL
(
  NO NUMBER PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  AGE NUMBER NOT NULL
);
DESC KH_SEQUENCE_TBL;
INSERT INTO KH_SEQUENCE_TBL VALUES(1, '�Ͽ���', '11');
INSERT INTO KH_SEQUENCE_TBL VALUES(2, '�̿���', '22');
INSERT INTO KH_SEQUENCE_TBL VALUES(3, '�����', '33');
SELECT * FROM KH_SEQUENCE_TBL;
DELETE FROM KH_SEQUENCE_TBL WHERE NO = 2;
ROLLBACK;

CREATE SEQUENCE SEQ_KH_SNO;
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '�Ͽ���', '11');
-- 1 �� ��(��) ���ԵǾ����ϴ�
SELECT * FROM KH_SEQUENCE_TBL;

INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '�̿���', '22');
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '�����', '33');
DELETE FROM KH_SEQUENCE_TBL WHERE NO = 2;
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '�����', '44');
SELECT SEQ_KH_SNO.NEXTVAL FROM DUAL;
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '������', '55');

DROP SEQUENCE SEQ_KH_SNO; -- ������ ����
CREATE SEQUENCE SEQ_KH_SNO; -- ������ ����
SELECT SEQ_KH_SNO.NEXTVAL FROM DUAL; -- ������ START �� ����
SELECT SEQ_KH_SNO.CURRVAL FROM DUAL; -- ���� �������� ������Ű�� �ʰ� Ȯ��
INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, '������', '66');
SELECT * FROM KH_SEQUENCE_TBL;


-- @�ǽ�����
-- ���� ��ǰ�ֹ��� ����� ���̺� ORDER_TBL�� �����, ������ ���� �÷��� �����ϼ���
-- ORDER_NO(�ֹ� NO) : PK
-- USER_ID(�����̵�)
-- PRODUCT_CNT(�ֹ�����)
-- ORDER_DATE : DEFAULT SYSDATE

-- ORDER_NO�� ������ SEQ_ORDER_NO�� ����� ���� �����͸� �߰��ϼ���.(����ð� ����)
-- *kang���� saewookkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
-- *gam���� gamjakkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
-- *ring���� onionring��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.


CREATE TABLE ORDER_TBL(
  ORDER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(40),
  PRODUCT_ID VARCHAR2(40),
  PRODUCT_CNT NUMBER,
  ORDER_DATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_ORDER_NO;
--Sequence SEQ_ORDER_NO��(��) �����Ǿ����ϴ�.
DESC ORDER_TBL
-- ORDER_NO�� ������ SEQ_ORDER_NO�� ����� ���� �����͸� �߰��ϼ���.(����ð� ����)
-- *kang���� saewookkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 30 , DEFAULT);
-- *gam���� gamjakkang��ǰ�� 30�� �ֹ��ϼ̽��ϴ�.
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30 , DEFAULT);
-- *ring���� onionring��ǰ�� 50�� �ֹ��ϼ̽��ϴ�.
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50 , DEFAULT);
SELECT * FROM ORDER_TBL;
COMMIT;


CREATE TABLE ORDER_NEW_TBL(
  ORDER_NO VARCHAR2(30) CONSTRAINT PK_ORDER_NO PRIMARY KEY,
  USER_ID VARCHAR2(40) NOT NULL,
  PRODUCT_ID VARCHAR2(40)NOT NULL,
  PRODUCT_CNT NUMBER(3),
  ORDER_DATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_ORDER_NEW_NO;
INSERT INTO ORDER_NEW_TBL
VALUES ('kh-'||
TO_CHAR(SYSDATE, 'yyyymmdd')|| '-'||
SEQ_ORDER_NEW_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO ORDER_NEW_TBL
VALUES ('kh-'||
TO_CHAR(SYSDATE, 'yyyymmdd')|| '-'||
SEQ_ORDER_NEW_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
SELECT * FROM ORDER_NEW_TBL;
COMMIT;


-- @�ǽ�����2
-- KH_MEMBER ���̺��� ����
-- �÷�
-- MEMBER_ID NUMBER
-- MEMBER_NAME VARCHAR2(20)
-- MEMBER_AGE NUMBER
-- MEMBER_JOIN_COM NUMBER

CREATE TABLE KH_MEMBER(
  MEMBER_ID NUMBER,
  MEMBER_NAME VARCHAR2(20),
  MEMBER_AGE NUMBER,
  MEMBER_JOIN_COM NUMBER
);

-- �̶� �ش������� ������ INSERT �ؾ���
-- ID���� JOIN_COM�� SEQUENCE�� �̿��Ͽ� ������ �ְ��� ��

-- 1.ID���� 500�� ���� �����Ͽ� 10�� ������ ���� �ϰ��� ��
CREATE SEQUENCE SEQ_MEMBER_ID
START WITH 500
INCREMENT BY 10
MAXVALUE 10000
NOCYCLE
NOCACHE;

DROP SEQUENCE SEQ_MEMBER_ID;


-- 2.JOIN_COM ���� 1������ �����Ͽ� 1�� �����Ͽ� ���� �ؾ� ��
--(ID���� JOIN_COM ���� MAX�� 10000���� ����)
-- SEQ_MEMBER_JOIN_COM
CREATE SEQUENCE SEQ_MEMBER_JOIN_COM
START WITH 1
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

DROP SEQUENCE SEQ_MEMBER_JOIN_COM;
DROP TABLE KH_MEMBER;

INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, 'ȫ�浿', '20', SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '�踻��', '30', SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '�����', '40', SEQ_MEMBER_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES (SEQ_MEMBER_ID.NEXTVAL, '����', '24', SEQ_MEMBER_JOIN_COM.NEXTVAL);

SELECT * FROM KH_MEMBER;
DELETE FROM KH_MEMBER;
COMMIT;

SELECT SEQ_MEMBER_JOIN_COM.CURRVAL FROM DUAL;
DROP SEQUENCE SEQ_MEMBER_JOIN_COM;










