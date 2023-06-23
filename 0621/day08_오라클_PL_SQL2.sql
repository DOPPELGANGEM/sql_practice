-- ====================================== PL/SQL�� �ݺ��� (8������ ���� / 230621) ======================================
SET SERVEROUTPUT ON; -- ���ٰ� Ű�� �����ǽ����ؾߵ�!!!!!

-- 1.LOOP
-- ����. 1 ~ 5���� �ݺ� ����ϱ�
DECLARE
  N NUMBER := 1;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N + 1;
--    IF (N > 5)
--      THEN EXIT;
--    END IF;
  EXIT WHEN N > 5;
  END LOOP;
END;
/

-- @�ǽ�����1
-- 1 ~ 10������ ������ 5�� ����غ��ÿ�.
-- DBMS_RANDOM.VALUE(low,high); -- ���� �߻��Լ�, low���� ũ�ų� ����, high���� ���� ������ ���� �߻�. 
DECLARE
  N NUMBER := 0;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(TRUNC(DBMS_RANDOM.VALUE(1,11)));
    N := N + 1;
    EXIT WHEN N > 9;
  END LOOP;
END;
/

-- 2.WHILE LOOP
-- ���������� TRUE�� ���ȸ� ������ �ݺ������
-- LOOP�� ������ �� ������ ó������ FALSE�̸� �ѹ��� ������� ���� �� ����.
-- EXIT�� ���̵� �������� �ݺ��� ���� ������ ����� �� ����.
-- WHITE (���ǽ�) LOOP (���๮) END LOOP;
-- 1 ~ 5 ���� ���
DECLARE
  N NUMBER := 1;
BEGIN
  WHILE (N <= 5) LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N + 1;
  END LOOP;
END;
/

-- @�ǽ�����2
-- ����ڷκ��� 2~9������ ���� �Է¹޾� �������� ����Ͻÿ�.
DECLARE
  N NUMBER := 1;
  DAN NUMBER;
BEGIN
  DAN := &��;
  IF (DAN BETWEEN 2 AND 9)
  THEN
      WHILE (N <= 9)
      LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || ' = ' ||DAN * N);
        N := N + 1;
        --EXIT WHEN N > 9 -- > EXIT�� �Ƚ������� WHILE ��
      END LOOP;
  ELSE DBMS_OUTPUT.PUT_LINE('2~9������ ���� �Է��ϼ���.');
  END IF;
END;
/

-- ����, 1 ~ 30������ �� �߿��� Ȧ���� ����Ͻÿ�.
DECLARE
  N NUMBER := 1;
BEGIN
  WHILE (N <= 30)
  LOOP
    IF (MOD(N,2) != 0)
    THEN DBMS_OUTPUT.PUT_LINE(N);
    END IF;
    N := N + 1;
  END LOOP;
END;
/

DECLARE
  N NUMBER := 0; -- 1���� ����ؾ��ؼ� 0
BEGIN
  WHILE (N <= 30)
  LOOP
    N := N + 1;
    CONTINUE WHEN MOD(N,2) = 0; --continue���� �ش� '���ǹ���' �������� �ʰ�, �ݺ����� �̾ �����ϴ� ����̴�.
    DBMS_OUTPUT.PUT_LINE(N); 
  END LOOP;
END;
/

-- 3.FOR LOOP
-- FOR LOOP������ ī��Ʈ�� ������ �ڵ� ����ǹǷ�, ���� ���� ������ �ʿ䰡 ����.
-- ī��Ʈ ���� �ڵ����� 1�� ������.
-- REVERSE�� 1�� ������.
-- 1 ~ 5���� ����Ͻÿ�.
BEGIN
  FOR N IN REVERSE 1..5
  LOOP
    DBMS_OUTPUT.PUT_LINE(N);
  END LOOP;
END;
/

-- @�ǽ�����1
-- EMPLOYEE ���̺��� ����� 200 ~ 210������ ��� ������ �����ȣ, �����, �̸����� ����Ͻÿ�.
DECLARE
  EINFO EMPLOYEE%ROWTYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('ID      NAME     EMAIL');
  DBMS_OUTPUT.PUT_LINE('-----------------------');
  FOR I IN 0..10
  LOOP
    SELECT * 
    INTO EINFO
    FROM EMPLOYEE
    WHERE EMP_ID = 200+I;
    DBMS_OUTPUT.PUT_LINE(EINFO.EMP_ID || '      ' || EINFO.EMP_NAME|| '           '||EINFO.EMAIL);
  END LOOP;
END;
/


-- @�ǽ�����1
-- KH_NUMBER_TBL�� ����Ÿ���� �÷� NO�� ��¥Ÿ���� �÷� INPUT_DATE�� ������ �ִ�.
-- �ش� ���̺� 0 ~ 99 ������ ������ 10�� �����Ͻÿ�.
CREATE TABLE KH_NUMBER_TBL(
  NO NUMBER(3),
  INPUT_DATE DATE DEFAULT SYSDATE
);
BEGIN
  FOR N IN 1..10
  LOOP
    INSERT INTO KH_NUMBER_TBL VALUES(TRUNC(DBMS_RANDOM.VALUE(0,99)), DEFAULT);
  END LOOP;
  COMMIT;
END;
/

ROLLBACK;
SELECT * FROM KH_NUMBER_TBL;


-- ====================================== PL/SQL ����ó�� ======================================
-- �ý��� ����(�޸��ʰ�, �ε��� �ߺ� Ű ��)�� ����Ŭ�� �����ϴ� ������
-- ���� PL/SQL ���� ������ ���� ������ Ž���Ͽ� �߻���Ű�� ������
-- 1. �̸� ���ǵ� ����ó��
-- 2. ����� ���� ����ó��
-- 3. �̸� ���ǵ��� ���� ����ó��(��ȭ)
--NO_DATA_FOUND
--SELECT INTO ������ ����� ���õ� ���� �ϳ��� ���� ���
--DUP_VAL_ON_INDEX
--UNIQUE �ε����� ������ �÷��� �ߺ� �����͸� �Է��� ���
--CASE_NOT_FOUND
--CASE���忡�� ELSE������ ���� WHEN���� ��õ� ������ �����ϴ� ���� ���� ���
--ACCESS_INTO_NULL
--�ʱ�ȭ���� ���� ������Ʈ�� ���� �Ҵ��Ϸ��� �� ��
--COLLECTION_IS_NULL
--�ʱ�ȭ���� ���� ��ø ���̺��̳� VARRAY���� �÷����� EXISTS���� �ٸ� �޼ҵ�� ������ �õ��� ���
--CURSOR_ALREADY_OPEN
--�̹� ���µ� Ŀ���� �ٽ� �����Ϸ��� �õ��ϴ� ���
--INVALID_CURSOR
--������ ���� Ŀ���� ������ ��� (OPEN���� ���� Ŀ���� �������� �� ���)
--INVALID_NUMBER
--SQL���忡�� ������ �����͸� ���������� ��ȯ�� �� ����� �� ���ڷ� ��ȯ���� ���� ���
--LOGIN_DENIED
--�߸��� ����ڸ��̳� ��й�ȣ�� ������ �õ��� ��

-- ����
-- �̹� �����ϴ� ������� �����͸� �Է��Ϸ��� �Ҷ� ����ó�� �ϱ�!
-- EXCEPTION������ �̹� �����ϴ� ����Դϴ�. �� �ƴ� �����޽����� �� 
BEGIN
  INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
  VALUES(200, '�̹����', '990621-1104323', '01033378383', 'J5', 'S5');
EXCEPTION 
--  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �������� �ʽ��ϴ�!.');
  WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/

-- ��ũ ����
-- https://docs.oracle.com/cd/E11882_01/timesten.112/e21639/exceptions.htm#TTPLS210














































