-- �������� �ǽ�
-- ���̺� ���� (DDL - CREATE, ALTER, DROP)
CREATE TABLE USER_NO_CONSTRAINT (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30),
  USER_NAME VARCHAR2(30),
  USER_GENDER VARCHAR2(10),
  USER_PHONE VARCHAR2(30),
  USER_EMAIL VARCHAR2(50)
);

-- ������ �߰�
INSERT INTO USER_NO_CONSTRAINT VALUES(1, 'khuser01', 'pass01', '�Ͽ���', '��', '01098774090', 'khuser01@iei.or.kr');
-- ������ ��ȸ
SELECT * FROM USER_NO_CONSTRAINT;
COMMIT;
INSERT INTO USER_NO_CONSTRAINT VALUES(2, 'khuser02', 'pass02','�̿���','��','01098774090','khuser01@iei.or.kr');
INSERT INTO USER_NO_CONSTRAINT VALUES(3, null, null, null,'��','01098774090','khuser01@iei.or.kr');


























