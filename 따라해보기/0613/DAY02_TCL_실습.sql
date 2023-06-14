-- TCL (Transaction Control Language) COMMIT, ROLLBACK, SAVEPOINT
-- Ʈ����� ó�� ���,
-- Transaction(Ʈ�����)�̶�?
-- �Ѳ����� ����Ǿ�� �� �ּ��� �۾� ������ ����.
-- ATM ���, ������ü
-- 1.���¹�ȣ �Է�, ���� ���� - ó������ �ٽ�
-- 2.�ݾ� �Է� - ó������ �ٽ�
-- 3.��й�ȣ �Է� - ó������ �ٽ�
-- 4.��ü �Ϸ� - �Ϸ�
-- oracle DBMS Ʈ�����>
-- INSERT ����� DMBS Ʈ����� ó����. -> �� �ڿ� �� �ٸ� �۾��� ���� ���̶�� ������.
-- INSERT - INSERT - INSERT - ... - COMMIT; (��������)
-- INSERT - DELETE - UPDATE - INSERT - ... - COMMIT; (Ʈ����� ����)
INSERT INTO COFFEE VALUES('Ŀ�ǿ���', 1800, '�������');
COMMIT;
INSERT INTO COFFEE VALUES('ī���', 3700, 'TWOSOME PLACE');
ROLLBACK;
--1. COMMIT : Ʈ����� �۾��� ���� �Ϸ� �Ǿ� ���� ������ ������ ���� (��� savepoint ����)
--2. ROLLBACK : Ʈ����� �۾��� ��� ����ϰ� ���� �ֱ� commit �������� �̵�
--3. SAVEPOINT : <savepoint>�� : ���� Ʈ����� �۾� ������ �̸��� ������. �ϳ��� Ʈ����� �ȿ��� ������ ���� �� ���� (�ӽ�����)

CREATE TABLE USER_TCL(
  USER_NO NUMBER UNIQUE,
  USER_NAME VARCHAR(20) NOT NULL,
  USER_ID VARCHAR(30) PRIMARY KEY
);

INSERT INTO USER_TCL VALUES(1, '�Ͽ���', 'khuser01');
COMMIT;
INSERT INTO USER_TCL VALUES(2, '�̿���', 'khuser02');
COMMIT;
INSERT INTO USER_TCL VALUES(3, '�����', 'khuser03');
SAVEPOINT until3;
INSERT INTO USER_TCL VALUES(4, '�����', 'khuser04');
COMMIT;
SELECT * FROM USER_TCL;
ROLLBACK TO until3;
ROLLBACK;

DROP TABLE USER_TCL;





