-- DCL(Data Control Language), GRANT, REVOKE
-- ���Ѻο�, ���� ȸ��
GRANT CONNECT, RESOURCE TO KHUSER01; --������ �������� �ؾ���.
-- ������ ����
-- 1.sys : ���۰�����, �����ͺ��̽� ����/���� ���� ����
-- �α��� �ɼ����� �ݵ�� as sysdba�� ����.
-- Data Dictionary �����ϰ� ����.

-- 2.system : �Ϲݰ�����, �����ͺ��̽� ����/���� ���� ����.
-- �ѿ� ���� ������ ���� Ȯ��
SELECT * FROM ROLE_SYS_PRIVS; -- ROLE�� �ο��� �ý��� ����
SELECT * FROM ROLE_TAB_PRIVS; -- ROLE�� �ο��� ���̺� ����
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';
SELECT * FROM USER_SYS_PRIVS;

--============================= KHUSER01 ���ǿ������� =============================--
CREATE TABLE COFFEE (
  PRODUCT_NAME VARCHAR2(20) PRIMARY KEY,
  PRICE NUMBER NOT NULL,
  COMPANY VARCHAR2(20) NOT NULL
);
-- ������ �߰�
-- INSERT�ѻ���� Ŀ���� ������Ѵ�.
INSERT INTO COFFEE VALUES('�ް�Ŀ��',3700,'MGC');
INSERT INTO COFFEE VALUES('�ƹٶ�',5600,'��Ÿ����');
INSERT INTO COFFEE VALUES('�ƾ�', 4700, 'Ŀ�Ǻ�');
INSERT INTO COFFEE VALUES('Ƽ����', 3000, '�ƽ�');
SELECT * FROM COFFEE;
COMMIT;
-- ============================= �ý��� �������� ����  =============================
GRANT SELECT ON KHUSER01.COFFEE TO KHUSER02;
GRANT INSERT ON KHUSER01.COFFEE TO KHUSER02;
-- Grant��(��) �����߽��ϴ�.
-- ============================= KHUSER02 �������� ����  =============================
SELECT * FROM KHUSER01.COFFEE;
INSERT INTO KHUSER01.COFFEE VALUES('ī��Ŀ��', 1500, 'ī��');
COMMIT;
-- ============================= �ý��� �������� ����  =============================
REVOKE SELECT ON KHUSER01.COFFEE FROM KHUSER02;
REVOKE INSERT ON KHUSER01.COFFEE FROM KHUSER02;
--Revoke��(��) �����߽��ϴ�.




















































