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














