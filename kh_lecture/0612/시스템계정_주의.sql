-- ������ �Դϴ�.
-- ctrl + enter => ����  --:�ּ�
-- �����ڴ� ������ ������ �� �ֽ��ϴ�.
-- ������ �����ؼ� �����ͺ��̽��� ���ÿ� ����ϰ� �� �� �ֽ��ϴ�.
-- CREATE USER ���̵� IDENTIFIED BY ��й�ȣ
-- ��ɾ��� ���� �׻� �����ݷ����� �������־����.

show user;
CREATE USER KHUSER01 IDENTIFIED BY KHUSER01;
SELECT username FROM ALL_USERS;
SELECT USERNAME, ACCOUNT_STATUS, LOCK_DATE FROM DBA_USERS;

--������ ������ٰ� �ؼ� �ٷ� ���Ӱ����� ���� �ƴ�!
--���� ���� �ο� �ʿ�
GRANT CONNECT TO KHUSER01;
--���� ���� �ο� �Ϸ�
--���� ������ �ο���ٰ� �ؼ� ���̺��� ���� �� �ִ� ���� �ƴ�~
--��ü ���� ���� �ο� �ʿ�
GRANT RESOURCE TO KHUSER01;
--��ü ���� ���� �ο� �Ϸ�

-- �������鶩 �̷���!
CREATE USER KHUSER01 IDENTIFIED BY KHUSER01;
GRANT CONNECT, RESOURCE TO KHUSER01;

-- KHUSER02 ��������� ���ӱ��Ѱ� ��ü ���� ���� �ο����ּ���!
CREATE USER KHUSER02 IDENTIFIED BY KHUSER02;
GRANT CONNECT, RESOURCE TO KHUSER02;



