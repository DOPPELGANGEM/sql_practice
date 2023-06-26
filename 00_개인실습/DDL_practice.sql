-- NOT NULL ��������
-- �����Ϳ� NULL�� ������� �ʰ� �ش� �÷��� �ݵ�� ���� ��ϵǾ�� �ϴ� ��쿡 ����ϰ� Ư�� �÷��� ���� �����ϰų� ������ ��
-- NULL���� ������� �ʵ��� �÷� �������� �����Ѵ�.
CREATE TABLE USER_NOTNULL(
  USER_NO NUMBER NOT NULL,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

-- UNIQUE �������� (�ߺ��� �� �����������)
-- UNIQUE�� �ߺ��� ���� ������� ����, �÷� �Է°��� ���� �ߺ��� �����ϴ� ������������ �÷� ������
-- ���̺� ������ ���� �����ϴ�.

-- �÷���������
CREATE TABLE USER_UNIQUE(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE, -- �÷�����
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

-- ���̺� �������� ����
CREATE TABLE USER_UNIQUE2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_ID) -- ���̺���
);

-- �ΰ��� �÷� ���� ���� ����
CREATE TABLE USER_UNIQUE3(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_NO, USER_ID)
);

-- PRIMARY KEY (���̺�� �ϳ� ���� ���� NOT NULL+UNIQUE ��ģ�Ӽ�)
-- PRIMARY KEY�� NULL�� �ߺ� ���� ������� ����(�÷��� ���� �ĺ��ڷ� ����ϱ� ���� ����Ѵ�.)
-- ���̺��� �� ���� ������ �����ϱ� ���� �����ĺ���(Identifier)�� ������ �Ѵ�.
-- NOT NULL�� �ǹ̿� UNIQUE�� �ǹ̸� �� �� ������ ������ �� ���̺� �� �ϳ��� ���� �����ϴ�. �÷������� ���̺� ���� �Ѵ� ������ �����ϴ�.

-- �÷���������
CREATE TABLE USER_PRIMARYKEY(
  USER_NO NUMBER PRIMARY KEY, --�÷���������
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMIAL VARCHAR2(50)
);

-- ���̺� �������� ����
CREATE TABLE USER_PRIMARYKEY2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  PRIMARY KEY(USER_NO) -- ���̺� ���� ����
);

-- �ΰ��� �÷��� ��� �ϳ��� PRIMARY KEY ����
CREATE TABLE USER_PRIMARYKEY3(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  PRIMARY KEY(USER_NO, USER_ID) -- �ΰ��� �÷��� ��� �ϳ��� PRIMARY KEY �������� ����
);

-- CHECK �������� (������ ���� ������ ������ ������ �����Ѱ� ���)
CREATE TABLE USER_CHECK (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30),
  USER_NAME VARCHAR2(30), 
  USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),
  USER_PHONE VARCHAR2(30),
  USER_EMAIL VARCHAR2(50)
);

-- DEFAULT �������� (�⺻������ ������ ���� �ڵ����� �Էµǵ��� �ϴ� ��������)
CREATE TABLE USER_DEFAULT2 (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) PRIMARY KEY, 
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30) NOT NULL,
  USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),
  USER_PHONE VARCHAR2(30),
  USER_EMAIL VARCHAR2(50),
  USER_DATE DATE DEFAULT SYSDATE
);

INSERT INTO USER_DEFAULT2 VALUES(1, 'khuser01', 'pass01','�Ͽ���','M','01082729383','khuser01@kh.com', DEFAULT);
SELECT * FROM USER_DEFAULT2;

-- FOREIGN KEY �������� (�����Ǵ� ���̺��� �÷��ǰ��� �����ϸ� ����Ѵ�. �������̺��� ����.)
-- ���̺� ����, Foreign Key, ���� ���Ἲ ��������
-- **-- FOREIGN KEY ��������**
-- FOREIGN KEY�� �����Ǵ� ���̺��� �÷��� ���� �����ϸ� ���
-- ���� ���Ἲ�� ���� ������������ ������ �ٸ����̺��� ������ ���� ����ϵ��� ������ �Ŵ� ���������̴�.
-- �����Ǵ� �÷��� ������ �÷��� ���� ���̺��� ���谡 �����Ǵµ� �����Ǵ� ���� �����Ǵ°� �ܿ� NULL��
-- ��밡���ϰ� ������ ���̺��� ������ �÷����� ������ ��� PRIMARY KEY�� ������ �÷��� �ڵ����� ������ �÷��̵ȴ�.
-- ������ �� �ִ� �÷��� �⺻Ű(PK)�� UNIQUE�� �����ϴ�.(���� PK�� ���´�.)

CREATE TABLE F_CLASS_TBL(
  STUDENT_SCORE NUMBER PRIMARY KEY,
  STUDENT_STATUS VARCHAR2(30)
);

INSERT INTO F_CLASS_TBL VALUES(10,'����');
INSERT INTO F_CLASS_TBL VALUES(30,'����');
INSERT INTO F_CLASS_TBL VALUES(60,'�ܿ����');
INSERT INTO F_CLASS_TBL VALUES(80,'�������');
INSERT INTO F_CLASS_TBL VALUES(100,'�������');

DELETE FROM F_CLASS_TBL WHERE STUDENT_SCORE = 100;


CREATE TABLE F_CLASS_TEST_TBL(
  STUDENT_NAME VARCHAR2(30) PRIMARY KEY,
  STUDENT_AGE NUMBER NOT NULL,
  STUDENT_ADDRESS VARCHAR2(50),
  STUDENT_PHONE VARCHAR2(50),
  STUDENT_GENDER VARCHAR2(10) CHECK(STUDENT_GENDER IN('M','F')),
  STUDENT_BIRTH DATE DEFAULT SYSDATE,
  STUDENT_SCORE NUMBER REFERENCES F_CLASS_TBL(STUDENT_SCORE) -- �÷�����
  -- FOREIGN KEY(STUDENT_SCORE) REFERENCES F_CLASS_TBL(STUDENT_SCORE) ON DELETE CASCADE -- ���̺���
);

INSERT INTO F_CLASS_TEST_TBL VALUES('�Ͽ���', 30, '������߱�', 010-9877-4090, 'M', DEFAULT, 10);
INSERT INTO F_CLASS_TEST_TBL VALUES('�̿���', 31, '����ð�����', 010-9877-4091, 'F', DEFAULT, 30);
INSERT INTO F_CLASS_TEST_TBL VALUES('�����', 32, '����ð�����', 010-9877-4092, 'M', DEFAULT, 60);
INSERT INTO F_CLASS_TEST_TBL VALUES('�����', 33, '����ü��빮��', 010-9877-4093, 'F', DEFAULT, 80);
INSERT INTO F_CLASS_TEST_TBL VALUES('������', 34, '����ÿ�걸', 010-9877-4094, 'M', DEFAULT, 100);

SELECT * FROM F_CLASS_TBL;
SELECT * FROM F_CLASS_TEST_TBL;

DROP TABLE F_CLASS_TBL;
DROP TABLE F_CLASS_TEST_TBL;

-- ON DELETE CASCADE : PARENT ���� �� CHILD ���� ����
-- ON DELETE SET NULL: PARENT ���� �� CHILD�� �ش� �ʵ� NULL�� ������Ʈ
-- ON DELETE SET DEFAULT : PARENT ���� �� CHILD�� �ش� �ʵ� DEFAULT ������ UPDATE
-- ON DELETE RESTRICT : CHILD ���̺� PK ���� ���� ��츸 PARENT ����
-- ON DELETE NO ACTION : ���� ���Ἲ ���������� �����ϴ� �׼��� �Ұ�












