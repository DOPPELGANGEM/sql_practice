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













-- ============ ���� ============
-- ���̺� ����, Foreign Key, ���� ���Ἲ ��������
CREATE TABLE PARENT (
  P_ID VARCHAR2(2) NOT NULL
);

 ALTER TABLE PARENT ADD CONSTRAINT P_PK PRIMARY KEY(P_ID);
-- ALTER TABLE [pk ���� �������� ���̺��] ADD CONSTRAINT [PK �̸� ����] PRIMARY KEY [PK �����Ϸ��� �÷���]

CREATE TABLE CHILD(
  C_ID VARCHAR2(2) NOT NULL,
  P_ID VARCHAR2(2)
);
-- ALTER TABLE [pk ���� �������� ���̺��] ADD CONSTRAINT [PK �̸� ����] PRIMARY KEY [PK �����Ϸ��� �÷���]
ALTER TABLE CHILD ADD CONSTRAINT C_PK PRIMARY KEY(C_ID);
-- ALTER TABLE [FK ���� �������� ���̺��] ADD CONSTRAINT [ FK �̸� ����] FOREIGN KEY [ FK �����Ϸ��� �÷���] REFERENCES [�����ϴ� �θ� ���̺� ��] (�����Ϸ��� �θ� ���̺��� Į����)
ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID);

INSERT INTO PARENT VALUES('A');
INSERT INTO PARENT VALUES('B');
SELECT * FROM PARENT;
INSERT INTO CHILD VALUES('a','A');
SELECT * FROM CHILD;

INSERT INTO CHILD VALUES('b','B');
-- �θ𿡰� ���� ���� �ڽĿ��� �־��� �� �������Ἲ�� ����ȴ�.

DELETE FROM PARENT WHERE P_ID = 'A';
-- A�� �ڽ��� �ֱ� ������ �θ��� A�� ���������?

ALTER TABLE CHILD DROP CONSTRAINT C_FK;

ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID)
ON DELETE CASCADE;
-- ON DELETE CASCADE : PARENT ���� �� CHILD ���� ����
-- ON DELETE SET NULL: PARENT ���� �� CHILD�� �ش� �ʵ� NULL�� ������Ʈ
-- ON DELETE SET DEFAULT : PARENT ���� �� CHILD�� �ش� �ʵ� DEFAULT ������ UPDATE
-- ON DELETE RESTRICT : CHILD ���̺� PK ���� ���� ��츸 PARENT ����
-- ON DELETE NO ACTION : ���� ���Ἲ ���������� �����ϴ� �׼��� �Ұ�

SELECT * FROM CHILD;

DROP TABLE PARENT;
DROP TABLE CHILD;














