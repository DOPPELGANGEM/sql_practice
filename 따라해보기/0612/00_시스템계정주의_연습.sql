-- ������ �Դϴ�.
-- ctrl + enter => ����  --:�ּ�
-- �����ڴ� ������ ������ �� �ֽ��ϴ�.
-- ������ �����ؼ� �����ͺ��̽��� ���ÿ� ����ϰ� �� �� �ֽ��ϴ�.
-- CREATE USER ���̵� IDENTIFIED BY ��й�ȣ
-- ��ɾ��� ���� �׻� �����ݷ����� �������־����.

show user;
CREATE USER KHUSER01_PRACTICE IDENTIFIED BY KHUSER01_PRACTICE;
SELECT username FROM ALL_USERS;
SELECT USERNAME, ACCOUNT_STATUS, LOCK_DATE FROM DBA_USERS;

--������ ������ٰ� �ؼ� �ٷ� ���Ӱ����� ���� �ƴ�!
--���� ���� �ο� �ʿ�
GRANT CONNECT TO KHUSER01_PRACTICE;
--���� ���� �ο� �Ϸ�
--���� ������ �ο��ؼ� ���̺��� ���� �� �ִ� ���� �ƴ�~
--��ü ���� ���� �ο� �ʿ�
GRANT RESOURCE TO KHUSER01_PRACTICE;
--��ü ���� ���� �ο� �Ϸ�

-- �������鶩 �̷���!
CREATE USER KHUSER01_PRACTICE IDENTIFIED BY KHUSER01_PRACTICE;
GRANT CONNECT, RESOURCE TO KHUSER01_PRACTICE;

CREATE USER KHUSER02_PRACTICE IDENTIFIED BY KHUSER02_PRACTICE;
GRANT CONNECT, RESOURCE TO KHUSER02_PRACTICE;










