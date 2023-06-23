-- ====================================== 8. TRIGGER ======================================
-- Ʈ���� : ��Ƽ�, �������, ...
-- Ư���̺�Ʈ�� DDL, DML������ ����Ǿ��� ��
-- �ڵ������� � �Ϸ��� ����(Operation), ó���� ����ǵ��� �ϴ� �����ͺ��̽� ��ü�� �ϳ���.
-- ���� ) ȸ�� Ż�� �̷���� ��� ȸ�� Ż�� ���̺� ���� ���� ȸ�������� �ڵ����� �Էµǵ��� ����
-- or ������ ������ ���� ��, ������ �����Ϳ� ���� �α��̷��� ����� ���
-- �����
-- CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
-- BEFORE (OR AFTER)
-- DELETE (OR UPDATE OR INSERT) ON ���̺��
-- [FOR EACH ROW]
-- BEGIN
--      (���๮)
-- END;
-- /
-- ����. ��� ���̺� ���ο� �����Ͱ� ������ ���Ի�� �Ի��Ͽ����ϴ�. �� ����ϱ�
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE PROC_ADD_ONE_EMP
(
  V_ENAME IN EMPLOYEE.EMP_NAME%TYPE,
  V_PERSONNO IN EMPLOYEE.EMP_NO%TYPE,
  V_MOBILE IN EMPLOYEE.PHONE%TYPE,
  V_JCODE IN EMPLOYEE.JOB_CODE%TYPE,
  V_SALLEVEL IN EMPLOYEE.SAL_LEVEL%TYPE
)
IS
  LAST_NUM VARCHAR2(10);
BEGIN
    SELECT MAX(EMP_ID)
    INTO LAST_NUM
    FROM EMPLOYEE;
    
    INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
    VALUES(LAST_NUM+1, V_ENAME, V_PERSONNO, V_MOBILE, V_JCODE, V_SALLEVEL);
    COMMIT;
END;
/
EXEC PROC_ADD_ONE_EMP('���Ͽ���','990621-1160423','01088373332','J5','S5');
SELECT * FROM EMPLOYEE;


CREATE OR REPLACE TRIGGER TRG_EMP_NEW
AFTER
INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
 DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/

SELECT * FROM USER_TRIGGERS;

-- ����2. EMPLOYEE ���̺� �޿� ������ ����Ǹ� ���� ������ ȭ�鿡 ����ϴ� Ʈ���Ÿ� �����Ͻÿ�.
SELECT * FROM EMP_DUPLICATE;
DELETE FROM EMP_DUPLICATE WHERE EMP_NAME LIKE '%����%';
COMMIT;
ROLLBACK;
-- Ʈ���� Ȯ���ϱ� (Ŀ����Ȯ�ΰ���)
UPDATE EMP_DUPLICATE
SET SALARY = SALARY*2
WHERE EMP_ID = '205';
-- COMMIT �� Ȯ�ΰ���
COMMIT;

CREATE OR REPLACE TRIGGER TRG_EMP_SALINFO
AFTER
UPDATE ON EMP_DUPLICATE
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('���� ��: '||:OLD.SALARY);
  DBMS_OUTPUT.PUT_LINE('���� ��: '||:NEW.SALARY);
END;
/

DROP TABLE EMP_DUPLICATE;
CREATE TABLE EMP_DUPLICATE
AS SELECT * FROM EMPLOYEE;

-- ======================================== �ǻ緹�ڵ� OLD, NEW ========================================
-- FOR EACH ROW�� ���
-- 1. INSERT : OLD -> NULL, NEW -> ���� ���� ���ڵ�
-- 2. UPDATE : OLD -> ���� ���� ���ڵ�, NEW -> ���� ���� ���ڵ�
-- 3. DELETE : OLD -> ���� ���� ���ڵ�, NEW -> NULL

-- @�ǽ�����1
-- 1. ��ǰ PRODUCT ���̺��� ���ڷ� �� PCODE�÷��� �ְ� PRIMARY KEY�� ����, ���ڿ� ũ�� 30��
-- PNAME�� �÷�, ���ڿ� ũ�� 30�� BRAND�÷�, ���ڷ� �� PRICE �÷�, ���ڷ� �Ǿ� �ְ� �⺻���� 0�� STOCK�÷���
-- ����.
CREATE TABLE PRODUCT -- �θ����̺�
(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30),
    BRAND VARCHAR2(30),
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);
-- 2. ��ǰ ����� PRODUCT_IO ���̺��� ���ڷ� �� IOCODE �÷��� �ְ� PRIMARY KEY�� ����,
-- ���ڷ� �� PCODE�÷�, ��¥�� �� PDATE �÷�, ���ڷε� AMOUNT�÷�, ���ڿ� ũ�Ⱑ 10��
-- STATUS�÷��� ����. STATUS�÷��� �԰� �Ǵ� ��� �Է°�����.
-- PCODE�� PRODUCT ���̺��� PCODE�� �����Ͽ� �ܷ�Ű�� �����Ǿ� ����.
CREATE TABLE PRODUCT_IO --�ڽ����̺�
(
    IOCODE NUMBER PRIMARY KEY,
    PCODE NUMBER CONSTRAINT FK_PRODUCT_IO REFERENCES PRODUCT(PCODE),
    PDATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(10) CHECK(STATUS IN('�԰�','���'))
);
-- 3. �������� SEQ_PRODUCT_PCODE, SEQ_PRODUCTIO_IOCODE��� �̸����� �⺻������ �����Ǿ�����.
CREATE SEQUENCE SEQ_PRODUCT_PCODE
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;
CREATE SEQUENCE SEQ_PRODUCTIO_IOCODE;
SELECT * FROM USER_SEQUENCES;
-- 4. Ʈ������ �̸��� TRG_PRODUCT �̰� PRODUCT_IO ���̺� �԰� �ϸ� PRODUCT ���̺�
-- STOCK �÷��� ���� �߰��ϰ� PRODUCT_IO ���̺� ��� �ϸ� STOCK �÷��� ���� ���ִ� ������ ��.
CREATE OR REPLACE TRIGGER TRG_PRODUCT
AFTER
INSERT ON PRODUCT_IO
FOR EACH ROW
BEGIN
-- INSERT INTO PRODUCT_IO 
-- VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL,1,SYSDATE, 10, '�԰�');
    IF :NEW.STATUS = '�԰�'
    THEN
        UPDATE PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
        --DBMS_OUTPUT.PUT_LINE('��ǰ�� �԰� �Ǿ����ϴ�. ���� : '||:NEW.AMOUNT);
    ELSIF :NEW.STATUS = '���'
    THEN
        UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
        --DBMS_OUTPUT.PUT_LINE('��ǰ�� ��� �Ǿ����ϴ�. ���� : '||:NEW.AMOUNT);
    END IF;
END;
/

-- TEST�غ���
-- ��ǰ ���̺� ���� �Է�
DESC PRODUCT;
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_PCODE.NEXTVAL, '��������', '�Ｚ', 1000000, DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_PCODE.NEXTVAL, '������', '����', 1200000, DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_PCODE.NEXTVAL, '�����', '������', 200000, DEFAULT);
SELECT * FROM PRODUCT;
COMMIT;
-- ��ǰ ��� ���̺� INSERT
INSERT INTO PRODUCT_IO 
VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL,1,SYSDATE, 10, '�԰�');
INSERT INTO PRODUCT_IO 
VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL,1,SYSDATE, 5, '���');
DESC PRODUCT_IO;
CREATE OR REPLACE PROCEDURE PROC_PRODUCT_IO
(
    V_PCODE IN PRODUCT_IO.PCODE%TYPE,
    V_AMOUT IN PRODUCT_IO.AMOUNT%TYPE,
    V_STATUS IN PRODUCT_IO.STATUS%TYPE
)
IS
    V_STOCK PRODUCT.STOCK%TYPE;
    V_PNAME PRODUCT.PNAME%TYPE;
    V_BRAND PRODUCT.BRAND%TYPE;
BEGIN
    INSERT INTO PRODUCT_IO 
    VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL,V_PCODE,SYSDATE, V_AMOUT, V_STATUS);
    COMMIT;
    SELECT PNAME, BRAND, STOCK
    INTO V_PNAME, V_BRAND, V_STOCK
    FROM PRODUCT
    WHERE PCODE = V_PCODE;
    DBMS_OUTPUT.PUT_LINE('��ǰ�� '||V_STATUS||' �Ǿ����ϴ�. ���� : '||V_AMOUT);
    DBMS_OUTPUT.PUT_LINE('�귣��� : '||V_BRAND||', ��ǰ�� : '||V_PNAME);
    DBMS_OUTPUT.PUT_LINE('���� ����� '||V_STOCK||'�Դϴ�.');    
END;
/
EXECUTE PROC_PRODUCT_IO(1, 10,'�԰�');
EXECUTE PROC_PRODUCT_IO(1, 7,'���');
COMMIT;
SELECT * FROM PRODUCT;
-- �������� ��Ȱ��ȭ
-- PCODE�� �ܷ�Ű�̱� ������ PRODUCT ���̺��� PCODE�� ���� �����͸� �� �� ����.
-- PRODUCT���̺��� �ƹ� �����͵� ���� ������ ���� �߻�
-- parent key not found : �θ𿡴� 1�̶�� �ϴ� �����Ͱ� ��� INSERT �Ұ���
ALTER TABLE PRODUCT_IO DISABLE CONSTRAINT FK_PRODUCT_IO;
ALTER TABLE PRODUCT_IO ENABLE CONSTRAINT FK_PRODUCT_IO;

SELECT * FROM PRODUCT_IO;
DELETE FROM PRODUCT_IO;
COMMIT;

-- ������� �ƹ��͵� ���������� Ȯ�μ���
-- 1. PRODUCT ���̺� ����
-- 2. PRODUCT_TO ���̺� ����
-- 3. ������ ������ ����
-- 4. TRG_PRODUCT Ʈ���� ����
-- 5. PRODUCT ���̺� ������ ����(��������, ������, �����) �� COMMIT
-- 6. PROC_PRODUCT_IO ���ν��� ������ ���ν��� �����ؼ� �޽��� Ȯ��


--DROP TABLE PRODUCT;
--DROP TABLE PRODUCT_IO;
--DROP SEQEUENCE SEQ_PRODUCTIO_IOCODE;

