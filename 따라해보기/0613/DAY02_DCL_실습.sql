-- DCL(Data Control Language), GRANT, REVOKE
-- ���Ѻο�, ���� ȸ��
GRANT CONNECT, RESOURCE TO KHUSER01; --������ �������� �ؾ���.
-- ������ ����

-- 1.sys : ���۰�����, �����ͺ��̽� ����/���� ���� ����
-- �α��� �ɼ����� �ݵ�� as sysdba�� ����.
-- Data Dictionary �����ϰ� ����.

-- 2.system : �Ϲݰ�����, �����ͺ��̽� ����/���� ���� ����.
-- �ѿ� ���� ������ ���� Ȯ��
SELECT * FROM ROLE_SYS_PRIVS;
SELECT * FROM ROLE_TAB_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';














