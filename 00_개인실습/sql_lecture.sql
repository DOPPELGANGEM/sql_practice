-- ============ �����ͺ��̽���? ============
-- �����ͺ��̽� : �����͸� �����ϴ� ����
-- SQL : �߿��ϰ� ����� �����͸� �ٷ�µ� ���Ǵ� ��� �����͸� ������ �����ϰ� �����ϱ� ���ؼ� SQL ���

-- ============ ���̺��̶�? ============
-- �����ͺ��̽� �ȿ� �����͸� ������ �Ҷ��� ���̺����·� �����Ѵ�.
-- �׸��� �� ���̺��� �÷��� �ο�� �̷������.

-- ============ CREATE ============
-- �ؽ�Ʈ ������ �����͸� ���� ��ȹ�̸� VARCHAR Ÿ������ �÷��� ����
-- ���������� �����͸� ���� ��ȹ�̸� NUMBER Ÿ��
-- ��¥ ������ �����͸� ���� ��ȹ�̸� DATE Ÿ������ �÷��� ������ش�.
-- * ����Ŭ������ VARCHAR Ÿ���� VARCHAR2�� ���Ǹ� ���� *

CREATE TABLE NETFLIX(
  VIDEO_NAME VARCHAR2(50),
  CATEGORY VARCHAR2(30),
  VIEW_CNT NUMBER(7),
  REG_DATE DATE
);

SELECT * FROM NETFLIX;

-- ============ ALTER ============
-- ������ ������ ���Ҵ� ���̺��� �����ϰ� ���� �� ����ϴ� ��ɾ�
-- ADD COLUMN���� �÷��� �߰��� ���� �ְ� DROP COLUMN���� �÷��� ������ ���� �ְ�
-- MODIFY COLUMN���� �÷��� �����Ҽ����ִ�.
SELECT * FROM NETFLIX n;

ALTER TABLE NETFLIX ADD (CAST_MEMBER VARCHAR2(20));
ALTER TABLE NETFLIX MODIFY (CAST_MEMBER VARCHAR2(50));
ALTER TABLE NETFLIX MODIFY (CAST_MEMBER NUMBER(2)); -- CAST_MEMBER�� NUMBERŸ������ ����
ALTER TABLE NETFLIX DROP (CAST_MEMBER);

-- ============ DROP / TRUNCATE ============
-- DROP TABLE : ���̺��� �����Ѵ�.
-- TRUNCATE TABLE : ���̺��� �ʱ�ȭ�Ѵ�. (���̺��� �״�� ���� ������ �� �ȿ� ����Ǿ� �ִ� �����Ͱ� ��� �����ȴ�)
-- ����� DROP�̳� TRUNCATE�� ������ ���̺�� �����ʹ� �ٽ� �����Ҽ�����!
CREATE TABLE CODELION(
  COL1 VARCHAR(3),
  COL2 VARCHAR(3)
);
SELECT * FROM CODELION;

INSERT INTO CODELION VALUES('AAA','BBB');
INSERT INTO CODELION VALUES('CCC','DDD');
COMMIT;

DROP TABLE CODELION;
TRUNCATE TABLE CODELION;

-- ============ INSERT ============
-- ���̺� ���ο� �����͸� �����ϴ� �����̴�.
-- INSERT query ����� �����Ͱ� �� ROW�� ���̺� �Է��̵ȴ�.
SELECT * FROM NETFLIX n;
INSERT INTO NETFLIX VALUES('���� ������','���',50,SYSDATE);
COMMIT;
INSERT INTO NETFLIX (VIDEO_NAME, VIEW_CNT) VALUES ('�ñ׳�',42);
ROLLBACK; -- ���� INSERT �޴� �۾��� ����ϴ� ����

INSERT INTO NETFLIX VALUES('�����϶� 1988', '���', 35, SYSDATE-30);
INSERT INTO NETFLIX VALUES('���¿�Ŭ��','���',30, SYSDATE-40);
INSERT INTO NETFLIX VALUES('�̽��ͼǻ���','���',22, SYSDATE-300);
DELETE FROM NETFLIX WHERE VIDEO_NAME = '�����϶� 1988';


-- ============ UPDATE ============
-- �����͸� �����Ѵ�.
-- UPDATE�� ����� �� ���������� WHERE �������� ���Ծ��� �� ��� �����Ͱ� ������ �� �����⶧���� ���� WHERE ���� ���ۼ��ϱ�
SELECT * FROM NETFLIX n;

UPDATE NETFLIX SET VIEW_CNT = 70 WHERE VIDEO_NAME = '���� ������';
COMMIT;
ROLLBACK;

UPDATE NETFLIX SET CATEGORY = '���',REG_DATE = TO_DATE('20210101','YYYYMMDD') WHERE VIDEO_NAME = '�ñ׳�';

-- ============ DELETE ============
-- ���̺� �����ϴ� �����͸� �����ϴ� query
-- TRUNCATE�� ���������� TRUNCATE�� ���̺��� ��� �����͸� �����ϴ� ������ �Ѵٸ� DELETE�� �������ϴ� �����͸� ��� ������ ���� �ִ�.
-- TRUNCATE�� �ѹ� �����ϸ� �ǵ��� �� ������ DELETE�� ROLLBACK�� �̿��Ͽ� �ǵ��� ���� �ִ�.
-- ��� �����͸� �����ϴ� ����� DELETE���� TRUNCATE�� ������.
SELECT * FROM NETFLIX n;

DELETE FROM NETFLIX n WHERE VIDEO_NAME = '�̽��ͼǻ���';
COMMIT;

DELETE FROM NETFLIX n WHERE CATEGORY = '���' AND VIEW_CNT < 35;
ROLLBACK;
DELETE FROM NETFLIX WHERE VIDEO_NAME IN ('�ñ׳�','���� ������');
DELETE FROM NETFLIX n;

-- ============ SELECT ============
SELECT * FROM NETFLIX n;

SELECT * FROM NETFLIX n WHERE VIDEO_NAME = '���� ������';
SELECT * FROM NETFLIX n WHERE VIDEO_NAME <> '���� ������';
SELECT * FROM NETFLIX n WHERE VIEW_CNT = 50;
SELECT * FROM NETFLIX n WHERE VIEW_CNT <> 50;
SELECT * FROM NETFLIX n WHERE REG_DATE > SYSDATE-30; -- �ֱ� �Ѵ� ������ �����͸� ����ϰ�ʹ�
SELECT * FROM NETFLIX n WHERE REG_DATE < SYSDATE-30; -- �Ѵ� ���� ��ϵ� ������
SELECT CATEGORY FROM NETFLIX n;
SELECT DISTINCT CATEGORY FROM NETFLIX n; -- �ߺ��Ǵ°��� �ϳ��θ� ����ʹ� -> DISTINCT

-- ============ WHERE (1),(2) ============
-- �������� ������ �ο��Ѵ�.
SELECT * FROM NETFLIX;

--���̺� �� insert
INSERT INTO NETFLIX VALUES ('������ ����','�ִϸ��̼�', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('���󿡸�','�ִϸ��̼�', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('õ���� �� ��ǻŸ','�ִϸ��̼�', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�͸� ����̸�','�ִϸ��̼�', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('������ ����','�ִϸ��̼�', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('��Ʈ�ñ׳�','����', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('������ ����','����', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('ȿ���� �ι�','����', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�̽�Ʈ��','����', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�ƴ� ����','����', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('��Ʋ ������Ʈ','��ȭ', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�����а���','��ȭ', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('���ͽ��ڶ�','��ȭ', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('����','��ȭ', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('��ٿ�Ÿ��','��ȭ', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�츮�� ����','��ť', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�λ��̵� ��������','��ť', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�� ���� ������','��ť', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('�׾ ��������','��ť', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
INSERT INTO NETFLIX VALUES ('������ ������','��ť', ROUND(DBMS_RANDOM.VALUE(0, 100)), SYSDATE-ROUND(DBMS_RANDOM.VALUE(0, 100)));
COMMIT;

SELECT * FROM NETFLIX WHERE CATEGORY = '�ִϸ��̼�';
SELECT * FROM NETFLIX WHERE CATEGORY IN ('�ִϸ��̼�','��ȭ');
SELECT * FROM NETFLIX WHERE CATEGORY NOT IN ('�ִϸ��̼�','��ȭ');
SELECT * FROM NETFLIX WHERE VIEW_CNT < 70;
SELECT * FROM NETFLIX WHERE VIEW_CNT <= 70;
SELECT * FROM NETFLIX WHERE REG_DATE < TO_DATE('20210101','YYYYMMDD');

SELECT * FROM NETFLIX WHERE CATEGORY = '�ִϸ��̼�' AND VIEW_CNT < 70;
SELECT * FROM NETFLIX WHERE CATEGORY = '�ִϸ��̼�' AND REG_DATE < TO_DATE('20210101','YYYYMMDD');
SELECT * FROM NETFLIX WHERE CATEGORY = '�ִϸ��̼�' OR VIEW_CNT < 70;
SELECT * FROM NETFLIX WHERE CATEGORY = '�ִϸ��̼�' OR CATEGORY = '��ȭ'; --IN���� �ᵵ�ȴ�
SELECT * FROM NETFLIX WHERE VIDEO_NAME LIKE '��%'; -- ������ ������ '��'�� ���۵Ǵ� �����͸� ��ȸ���ض�!
SELECT * FROM NETFLIX WHERE VIDEO_NAME LIKE '%��'; -- ������ ������ '��'���� ������ �����͸� ��ȸ���ض�!
SELECT * FROM NETFLIX WHERE VIDEO_NAME LIKE '%��%'; -- �Ƕ�� ���ڰ� �տ��־ �ǰ� �����־ �ȴ�.('��'�� ���⸸ �ϸ� ��ȸ����)
SELECT * FROM NETFLIX WHERE VIEW_CNT >= 60 AND VIEW_CNT <= 70;
SELECT * FROM NETFLIX WHERE VIEW_CNT BETWEEN 60 AND 70;

-- ============ ORDER BY ============
-- �����͸� ���Ľ�Ų��. 
-- �������� : ū�ſ��� �����ŷ�(�ּڰ�����), �������� :�����ſ��� ū�ŷ�(�ִ밪����)
-- ���� 1 2 3 4 5 (��������) , 5 4 3 2 1 (��������)
-- ���ĺ� a b c d e (��������) , e d c b a (��������)
-- �ѱ� �� �� �� �� �� (��������) , �� �� �� �� �� (��������)
-- ��¥�� DESC �϶� �ֽż�!!
SELECT * FROM NETFLIX ORDER BY REG_DATE; --ASC�� DEFAULT��
SELECT * FROM NETFLIX ORDER BY REG_DATE DESC;
SELECT * FROM NETFLIX ORDER BY VIDEO_NAME;
SELECT * FROM NETFLIX ORDER BY VIEW_CNT DESC;
SELECT * FROM NETFLIX ORDER BY CATEGORY, VIEW_CNT DESC;
SELECT * FROM NETFLIX ORDER BY CATEGORY DESC, VIEW_CNT DESC;

-- ============ GROUP BY ============
-- �����͸� �׷����� ���´�.
SELECT CATEGORY, COUNT(*) FROM NETFLIX GROUP BY CATEGORY;
SELECT CATEGORY, SUM(VIEW_CNT) FROM NETFLIX GROUP BY CATEGORY;
SELECT CATEGORY, MAX(VIEW_CNT) FROM NETFLIX GROUP BY CATEGORY;
SELECT CATEGORY, MAX(VIEW_CNT) FROM NETFLIX GROUP BY CATEGORY ORDER BY MAX(VIEW_CNT) DESC;
SELECT CATEGORY, MIN(VIEW_CNT) FROM NETFLIX GROUP BY CATEGORY;
SELECT CATEGORY, MAX(VIEW_CNT), MIN(VIEW_CNT) FROM NETFLIX GROUP BY CATEGORY;
SELECT CATEGORY, AVG(VIEW_CNT) FROM NETFLIX GROUP BY CATEGORY;


-- ============ INNER JOIN ============
-- JOIN : �������� ���̺��� �����Ѵ�.
-- �������ִ� ��Ŀ����� INNER JOIN, OUTER JOIN ���� ����������.
-- INNER JOIN���� ���� �߿��ϰ� ����ؾ� �� �κ��� �� ���̺� ���������� �����ϴ� �����Ϳ����� ����̵ȴ�!
-- �׸��� JOIN�� ����� 1:1�� �� ���� �ְ� 1:N�� �� ���� �ְ� N:1�� �� ���� �ִ�.

CREATE TABLE NETFLIX_CAST (
	VIDEO_NAME		VARCHAR2(50),
	CAST_MEMBER		VARCHAR2(30),
	BIRTHDAY		DATE,
	GENDER			VARCHAR2(3)
);

INSERT INTO NETFLIX_CAST VALUES ('���� ������','������',TO_DATE('19930516','YYYYMMDD'),'��');
INSERT INTO NETFLIX_CAST VALUES ('�ñ׳�','������',TO_DATE('19760303','YYYYMMDD'),'��');
INSERT INTO NETFLIX_CAST VALUES ('ȿ���� �ι�','��ȿ��',TO_DATE('19790510','YYYYMMDD'),'��');
INSERT INTO NETFLIX_CAST VALUES ('���¿� Ŭ��','�ڼ���',TO_DATE('19881216','YYYYMMDD'),'��');
INSERT INTO NETFLIX_CAST VALUES ('�����','�۰�ȣ',TO_DATE('19670117','YYYYMMDD'),'��');
INSERT INTO NETFLIX_CAST VALUES ('�̻�','�ӽÿ�',TO_DATE('19881201','YYYYMMDD'),'��');
INSERT INTO NETFLIX_CAST VALUES ('�¸�ȣ','���¸�',TO_DATE('19900424','YYYYMMDD'),'��');

COMMIT;

SELECT * FROM NETFLIX_CAST;
-- JOIN�� �Ҷ��� �÷��տ� �� �÷��� ��� ���̺� ���� �÷������� ����� �ֱ� ���ؼ� ���̺��.�÷��� �̷������� �ۼ�! (alias)
SELECT A.VIDEO_NAME, A.CATEGORY , B.CAST_MEMBER , B.BIRTHDAY
FROM NETFLIX A, NETFLIX_CAST B
WHERE A.VIDEO_NAME = B.VIDEO_NAME;

INSERT INTO NETFLIX_CAST VALUES('ȿ���� �ι�', '�̻��', TO_DATE('19740825','YYYYMMDD'),'��');


-- ============ OUTER JOIN ============
-- LEFT OUTER JOIN , RIGHT OUTER JOIN, FULL OUTER JOIN
-- LEFT OUTER JOIN : LEFT TABLE�� ��� �����Ͱ� ����� �Ǵ� ���� ������ ������ �Ǵ� ���
-- RIGHT OUTER JOIN : RIGHT TABLE�� ��� �����Ͱ� ����� �Ǵ� ���� ������ ������ �Ǵ� ���
-- FULL OUTER JOIN: LEFT TABLE, RIGHT TABLE�� ��� �����Ͱ� ����� �Ǵ� ���� ������ JOIN�� �Ǵ� ��� (���⼭ ��� �����Ͱ� ����� 
-- �ȴٴ� ���� JOIN�Ǵ� TABLE�� ¦���� ��� ����� �ȴٴ� �̾߱��̴�.)

SELECT A.VIDEO_NAME, A.CATEGORY, B.CAST_MEMBER, B.BIRTHDAY
  FROM NETFLIX A
  LEFT OUTER JOIN NETFLIX_CAST B
  ON A.VIDEO_NAME = B.VIDEO_NAME
WHERE B.CAST_MEMBER IS NOT NULL; -- INNER JOIN�� ���������� �ϰ��Ҽ��ִ�.

SELECT A.VIDEO_NAME, A.CATEGORY, B.CAST_MEMBER, B.BIRTHDAY
  FROM NETFLIX A, NETFLIX_CAST B
  WHERE A.VIDEO_NAME = B.VIDEO_NAME;

-- ============ ��¥�Լ� ============
-- DAUL : �ý��ۿ��� �����ϴ� DUMMY ���̺�(���� ���̺��� �����͸� ���� ���� �ʰ� ������ ����� ���� ������ ���� SELECT���� ���� ��
-- ���� ����ϴ� �ý��� ���̺��̴�.)
SELECT SYSDATE FROM DUAL; 

-- ADD_MONTHS (init_date, add_months)
-- Ư�����ڿ��� ���� ���� ���� ��ȯ�ϴ� �Լ�
-- �Ű�����
-- init_date 
--  datetime Type �Ǵ� DATE�� ��ȯ�� �� �ִ� ���Դϴ�.
-- add_months 
--  �ʱ⳯¥(initdate)�� �߰��� ���� ���� �����մϴ�.
--  ������ ��� �ʱ� ��¥(init_date)�� ���� ������ ���˴ϴ�.
--  0�� ��� �ʱ⳯¥(init_date)�� ���������Դϴ�.
SELECT ADD_MONTHS(SYSDATE,3) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE,-3) FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') FROM DUAL; -- HH������ 24���°��� �ð��� 24������ ����ϰٴ�.
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') FROM DUAL;

-- ============ REPLACE ============
-- Ư�����ڸ� �ٸ� ���ڷ� ��ü�ϴ� �Լ�
SELECT REPLACE('�ڵ���̾�','�ڵ�','CODE') FROM DUAL; -- �ڵ���̾��̶�� �ܾ�� '�ڵ�'�� 'CODE'�� ��ü�ض�
SELECT REPLACE('�ڵ���̾�','�ڵ�') FROM DUAL; -- �ڿ� ��ü�� ���ڸ� �������������� '�ڵ�'��´ܾ NULL�� �Ǿ� ������Եȴ�!
SELECT REPLACE('010-1234-5678','-') FROM DUAL;

SELECT 
'�ȳ��ϼ��� 
�ڵ���̾��Դϴ�.'
FROM DUAL;

SELECT REPLACE('�ȳ��ϼ��� 
�ڵ���̾��Դϴ�.',CHR(10),' ') FROM DUAL;
SELECT * FROM NETFLIX_CAST;
SELECT REPLACE(CAST_MEMBER, '������', '������') FROM NETFLIX_CAST;


-- ============ SUBSTR ============
-- ���ڸ� ���ϴ� ��ŭ �ڸ��� �Լ�

-- '�ڵ���̾�'�̶�� ���ڿ��� ����° �ڸ����� '��'���ִ� �ڸ����� �α��ڸ� �������ڴٴ��ǹ��̴�.
SELECT SUBSTR('�ڵ���̾�',3,2) FROM DUAL; --����
-- ���������ڸ� �����ϸ� ����°�ڸ����� ������ ������ �������Եȴ�.
SELECT SUBSTR('�ڵ���̾�',3) FROM DUAL; -- ���̾�
SELECT SUBSTR('�ڵ���̾�',-4,3) FROM DUAL; -- �����
SELECT SUBSTR('�ڵ���̾�',-4) FROM DUAL; -- ����̾�

SELECT * FROM NETFLIX_CAST;
SELECT SUBSTR(CAST_MEMBER,1,1) || '*' || SUBSTR(CAST_MEMBER,3) FROM NETFLIX_CAST; -- EX)�̺�Ʈ��÷�� ��*�� �̷���..
SELECT SUBSTR('�̱� Ķ�����Ͼƿ� ���縦 �� ���ְ��� ȸ�� ����Ż ������� 2027�� ���� ���ʷ�
���� ȣ���� ������ ��ȹ�̶�� IT��ü BGR�� 8�� �����ߴ�.',1,20) || '.......' FROM DUAL;


-- ============ UPPER / LOWER �Լ� ============
-- UPPER / LOWER : ���ڸ� �빮�� / �ҹ��ڷ� �ٲ��ִ��Լ�
SELECT UPPER('CodeLion') FROM DUAL;
SELECT LOWER('CodeLion') FROM DUAL;
SELECT * FROM MEMBER WHERE ID = UPPER('CodeLion');

-- ============ �����Լ� ============
-- ���ڵ����͸� �����ϴ� �Լ�
-- ROUND : �ݿø�
SELECT ROUND(3.16) FROM DUAL;
SELECT ROUND(3.67) FROM DUAL;
SELECT ROUND(3.16, 1) FROM DUAL; --3.2 �ݿø��� �Ҽ��� ù°�ڸ�����

-- TRUNC : ����
SELECT TRUNC(3.16) FROM DUAL; 
SELECT TRUNC(3.67) FROM DUAL;
SELECT TRUNC(3.16,1) FROM DUAL;

-- CEIL : �ø�
SELECT CEIL(3.16) FROM DUAL;
SELECT CEIL(3.67) FROM DUAL;
SELECT CEIL(-3.16) FROM DUAL;







