SELECT * FROM IDOL_GROUP;

CREATE OR REPLACE VIEW V1_IDOL AS 
SELECT COMPANY, GROUP_NAME FROM IDOL_GROUP WHERE GROUP_NAME = 'BTS';

SELECT * FROM V1_IDOL;

CREATE OR REPLACE VIEW V2_IDOL AS 
SELECT A.COMPANY, A.GROUP_NAME, B.MEMBER_NAME, B.REAL_NAME
FROM IDOL_GROUP A, IDOL_MEMBER B
WHERE  A.GROUP_NAME = B.GROUP_NAME
AND A.GROUP_NAME = 'BTS';

SELECT * FROM V2_IDOL;

DROP VIEW V1_IDOL;
DROP VIEW V2_IDOL;

SELECT * FROM V1_IDOL;
SELECT * FROM V2_IDOL;

-- �並 ����ϴ�����
-- 1.������ó�� ����ϱ����ؼ� (������� �� �ϳ��� ������ ������ �� VIEW�� �����ϴ� ���ø����̼� �ܿ� �ִ� ���query ���� ������ ���� �ʰ� ���query ���� ����)
-- 2.������ ������ query�� VIEW�� �������� ��쿡�� �ҽ� �ܿ� �ִ� query�� �ſ� �����������ִ�.
-- �߿��Ѱ� ���Ȼ��� ������ �並 ���� �����! (���Ȼ����� �̽��� �Ǵ� ���̺��� ������ �Ϸ��� �� �� VIEW�� ������ �ؼ� ������ �Ѵ�!)



-- =============== ������ ��ųʸ� ���� ���� ===============
-- 1. USER_XXXX : �ڽ��� ������ ������ ��ü � ���� ������ ��ȸ��.
-- 2. ALL_XXXX : �ڽ��� ������ ������ ��ü � ���� ������ ��ȸ��. (���Ѻο�������)
-- 3. DBA_XXXX : �����ͺ��̽� �����ڸ� ������ ������ ��ü ���� ���� ��ȸ
-- �����ͺ��̽� �����ڴ� SYS ������ SYSTEM
-- �����ͺ��̽� �����ڴ� DBA��� ��.
-- ������ �м� �����ڵ� �ְ� DA��� ��. 

-- VIEW ��������
SHOW USER;

SELECT * FROM DBA_TABLES; -- �ý��۰������� �����ؾ��� (�̰ź���!!!!)
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_VIEWS;
GRANT CREATE VIEW TO IDOL_MEMBER;

SELECT * FROM USER_VIEWS;




