-- NOT NULL �������� AGE�̰� NOT NULL�̶� ���ԺҰ�

-- UNIQUE �������� (�ߺ��� �� �����������)
-- PRIMARY KEY (���̺�� �ϳ� ���� ���� NOT NULL+UNIQUE ��ģ�Ӽ�)
-- CHECK �������� (������ ���� ������ ������ ������ �����Ѱ� ���)
-- DEFAULT �������� (�⺻������ ������ ���� �ڵ����� �Էµǵ��� �ϴ� ��������)


-- FOREIGN KEY �������� (�����Ǵ� ���̺��� �÷��ǰ��� �����ϸ� ����Ѵ�. �������̺��� ����.)
-- ���̺� ����, Foreign Key, ���� ���Ἲ ��������
CREATE TABLE PARENT(
  P_ID VARCHAR2(2) NOT NULL
);

-- ALTER TABLE [pk ���� �������� ���̺��] ADD CONSTRAINT [PK �̸� ����] PRIMARY KEY [PK �����Ϸ��� �÷���]
ALTER TABLE PARENT ADD CONSTRAINT P_PK PRIMARY KEY(P_ID);

CREATE TABLE CHILD(
  C_ID VARCHAR(2) NOT NULL,
  P_ID VARCHAR(2)
);

-- ALTER TABLE [pk ���� �������� ���̺��] ADD CONSTRAINT [PK �̸� ����] PRIMARY KEY [PK �����Ϸ��� �÷���]
ALTER TABLE CHILD ADD CONSTRAINT C_PK PRIMARY KEY(C_ID);
-- ALTER TABLE [FK ���� �������� ���̺��] ADD CONSTRAINT [ FK �̸� ����] FOREIGN KEY [ FK �����Ϸ��� �÷���] REFERENCES [�����ϴ� �θ� ���̺� ��] (�����Ϸ��� �θ� ���̺��� Į����)
ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID);

INSERT INTO PARENT VALUES('A');
INSERT INTO PARENT VALUES('B');

INSERT INTO CHILD VALUES('a','A');


-- �θ𿡰� ���� ���� �ڽĿ��� �־��� �� �������Ἲ�� ����ȴ�.
INSERT INTO CHILD VALUES('b','B');

-- A�� �ڽ��� �ֱ� ������ �θ��� A�� ���������?
DELETE FROM PARENT WHERE P_ID = 'A';

ALTER TABLE CHILD DROP CONSTRAINT C_FK;
ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID) ON DELETE CASCADE;
-- ON DELETE CASCADE : PARENT ���� �� CHILD ���� ����
-- ON DELETE SET NULL: PARENT ���� �� CHILD�� �ش� �ʵ� NULL�� ������Ʈ
-- ON DELETE SET DEFAULT : PARENT ���� �� CHILD�� �ش� �ʵ� DEFAULT ������ UPDATE
-- ON DELETE RESTRICT : CHILD ���̺� PK ���� ���� ��츸 PARENT ����
-- ON DELETE NO ACTION : ���� ���Ἲ ���������� �����ϴ� �׼��� �Ұ�


SELECT * FROM PARENT;
SELECT * FROM CHILD;

DROP TABLE CHILD;
DROP TABLE PARENT;























