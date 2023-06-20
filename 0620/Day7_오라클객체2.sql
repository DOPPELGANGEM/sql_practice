-- Oracle Object, ����Ŭ��ü
-- 1.VIEW
-- 2.SEQUENCE (������Ʈ���������̾�)
-- 3.INDEX
-- 4.SYNONYM
-- 5.CURSOR
-- 6.PACKAGE
-- 7.ROLE
-- 8.PROCEDURE&FUNCTION

-- ================ 3.ROLE ================
-- -> ����ڿ��� �������� ������ �ѹ��� �ο��� �� �ִ� �����ͺ��̽� ��ü
-- -> ����ڿ��� ������ �ο��� �� �� ���� �ο��ϰ� �ȴٸ� ���� �ο� �� ȸ���� ������ ������.
-- # Oracle ��ġ�� �⺻ �����Ǵ� ROLE
-- CONNECT : ����ڰ� �����ͺ��̽��� ���� �����ϵ��� �ϱ� ���� ������ �ִ� ROLE
-- RESOURCE : ����ڰ� ��ü(���̺�, �ε���, ...)�� �����ϱ� ���� �ý��� ������ �ִ� ROLE
-- DBA : �ý��� �ڿ��� ���������� ��밡���ϸ� �ý��� ������ �ϱ� ���� �������� �ִ� ROLE
CREATE USER KHUSER03 IDENTIFIED BY KHUSER03;
GRANT CONNECT, RESOURCE TO KHUSER03 -- CONNECT, RESOURCE �� ���̴�.

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT'; 
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'RESOURCE';
SELECT * FROM USER_SYS_PRIVS;

-- ������ �������� Ȯ���ؾ��Ѵ�.
-- ROLE�ȿ��� �������� ������ �ִ�.
-- CONNECT�� 1���ۿ�����
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'DBA';

-- ========= ���ο� ROLE ����� =========
CREATE ROLE VIEWRESOURCE;
GRANT CREATE VIEW TO VIEWRESOURCE;
GRANT SELECT ON KHUSER01.COFFEE TO VIEWRESOURCE;

-- ���ο� ROLE�� KHUSER02 ����ڿ��� ���� �ο�
GRANT VIEWRESOURCE TO KHUSER02;

-- ���� Ȯ�ο� SQL
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM ROLE_TAB_PRIVS; -- ROLE�� �ο��� ���̺����
SELECT * FROM ROLE_SYS_PRIVS; -- ������ ���� ��üȮ��(?) �������Ѱ� ����

-- ���� ȸ���ϱ�
REVOKE VIEWRESOURCE FROM KHUSER02;

-- ================ 4.INDEX (�߿��ϰ� ȸ�翡�����̾���) => �������ϱ⿣����� ================
-- -> SQL ��ɹ��� ó���ӵ��� ����Ű�� ���ؼ� �÷��� ���ؼ� �����ϴ� ����Ŭ ��ü
-- - key-value ���·� ������ �Ǹ� key���� �ε����� ���� �÷���, value���� ���� ����� �ּҰ��� �����.
-- * ����  
-- �˻��ӵ��� �������� �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����ų �� ����.
-- * ����  
-- 1.�ε����� ���� �߰� ���� ������ �ʿ��ϰ�, �ε����� �����ϴµ� �ð��� �ɸ�.
-- 2. �������� �����۾�(INSERT/UPDATE/DELETE) �� ���� �Ͼ�� ���̺� INDEX ������ ������ �������ϰ� �߻��Ҽ� �ִ�.
-- * � �÷��� �ε����� ����� ������?
-- -> �����Ͱ��� �ߺ��� ���� ���� ������ �����Ͱ��� ������ �÷��� ����� ���� ���� ����.
-- �׸��� ���� ���Ǵ� �÷��� ����� ����.

-- * ȿ������ �ε��� ��� ��
-- where���� ���� ���Ǵ� �÷��� �ε��� ����
-- > ��ü ������ �߿��� 10% ~ 15% �̳��� �����͸� �˻��ϴ� ���, �ߺ��� ���� ���� �÷��̾�� ��.
-- > �� �� �̻��� �÷� WHERE���̳� ����(join) �������� ���� ���Ǵ� ���
-- > �� �� �Էµ� �������� ������ ���� �Ͼ�� �ʴ� ���
-- > �� ���̺� ����� ������ �뷮�� ����� Ŭ ���
-- DDL ���� (CREATE, ALTER, DROP)
SELECT * FROM EMPLOYEE;
CREATE INDEX EMP_IND_NND
ON EMPLOYEE(EMP_NAME);
SELECT * FROM USER_IND_COLUMNS
WHERE INDEX_NAME = 'EMP_IND_NND';
DROP INDEX EMP_IND_NND;

CREATE INDEX IDX_EMP_COLUMNS
ON EMPLOYEE(EMP_NAME, EMP_NO, HIRE_DATE);

-- SET TIMING ON , SET TIMING OFF �������� ���ͳݼӵ�? �׷��ſ�����޶� ��Ȯ�Ѻ񱳴¾�ƴ�
SET TIMING ON
SELECT * FROM EMPLOYEE
WHERE EMP_NO LIKE '%04%';
SET TIMING OFF

EXPLAIN PLAN FOR
SELECT * FROM EMPLOYEE
WHERE EMP_NO LIKE '%04%';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




























