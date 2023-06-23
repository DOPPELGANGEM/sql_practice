-- ====================== PL/SQL ======================
-- Oracle's Procedural Language Extensin to SQL�� ����
-- -> ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���ν�, SQL�� ������ �����Ͽ� SQL���� ������
-- ������ ����, ����ó��, �ݺ�ó�� ���� ������.


-- PL/SQL�� ����
-- 1.�͸��� (Anonymous Block)
-- 2.���ν��� (Procedure)
-- 3.�Լ� (Function)

-- PL/SQL�� ����(�͸���)
-- 1. ���� (���� : ������������)
-- 2. ����� (�ʼ�)
-- 3. ����ó���� (���� : ������������)
-- 4. END; (�ʼ�)
-- 5. / (�ʼ�)
    --DECLARE
    --BEGIN
    --EXCEPTION
    --END;
    --/
SET SERVEROUTPUT ON; 
-- SQLDEVELOPER ���� Ű�� �ٽ� ����!
SET TIMING ON;
SET TIMING OFF; -- �ð��ȳ������Ѵ�

BEGIN 
  DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

-- PL/SQL �����غ���
DECLARE
  vid NUMBER;
BEGIN
  SELECT EMP_ID
  INTO vid
  FROM EMPLOYEE
  WHERE EMP_NAME = '������'; -- ������ NO DATA~
  DBMS_OUTPUT.PUT_LINE('ID = '||vid);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA~');
END;
/

-- ========================== PL/SQL ���� ==========================
-- # ������ �ڷ���
-- 1. �⺻�ڷ���
-- VARCHAR2, NUMBER, DATE, BOOLEAN, ...
-- 2. �����ڷ���
-- Record, Cursor, Collection

-- 2.1 %TYPE ����
DESC EMPLOYEE;
DECLARE 
  VEMPNO EMPLOYEE.EMP_NO%TYPE;
  VENAME EMPLOYEE.EMP_NAME%TYPE;
  -- %TYPE �Ӽ��� ����Ͽ� ������ VEMPNO ������ �ش� ���̺��� �÷��� ���� �ڷ����� ũ�⸦ 
  -- �״�� �����ؼ� �������.
  -- �÷��� �ڷ����� ����Ǹ� �����ϴ� ���۷��� ������ �ڷ����� ũ�⵵ �ڵ����� �ݿ��ǹǷ�
  -- ������ ������ �ʿ䰡 ����.
BEGIN
  SELECT EMP_NO, EMP_NAME
  INTO VEMPNO, VENAME
  FROM EMPLOYEE
  WHERE EMP_ID = '200';
  DBMS_OUTPUT.PUT_LINE(VENAME||' : '||VEMPNO);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO Data!!');
END;
/

-- 2.2 %ROWTYPE
-- ��(ROW) ������ �����ϴ� %ROWTYPE �Ӽ��� ����.

DECLARE
  VEMP EMPLOYEE%ROWTYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME
  INTO VEMP.EMP_ID, VEMP.EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_NAME = '������';
  DBMS_OUTPUT.PUT_LINE(VEMP.EMP_ID || ' : ' || VEMP.EMP_NAME);
END;
/


DECLARE
  VEMP EMPLOYEE%ROWTYPE;
BEGIN
  -- * �� ROWTYPE ������ �̿��ؼ� �� ���ڵ带 ��°�� ���� �� ���� (���������� �Ȱ��� ����� ��Ÿ��!)
  SELECT *
  INTO VEMP
  FROM EMPLOYEE
  WHERE EMP_NAME = '������';
  DBMS_OUTPUT.PUT_LINE(VEMP.EMP_ID || ' : ' || VEMP.EMP_NAME);
END;
/


-- @�ǽ�����1
-- ���, �����, ���޸��� ���� �� �ִ� ���������� ���ؼ�
-- ������ ����� ���,����� ���޸��� �͸���� ���� ����ϼ���~

DECLARE
  VEMPID EMPLOYEE.EMP_ID%TYPE;
  VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
  VJOBNAME JOB.JOB_NAME%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, JOB_NAME
  INTO VEMPID, VEMPNAME, VJOBNAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  WHERE EMP_NAME = '������';
  DBMS_OUTPUT.PUT_LINE(' ������ ��� :  ' ||VEMPID||', �����: '||VEMPNAME||', ���޸� : '||VJOBNAME);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;
/


-- ======================= PL/SQL �Է� �ޱ� =======================
-- �����ȣ�� �Է¹޾Ƽ� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�.

DECLARE
  VINFO EMPLOYEE%ROWTYPE;
BEGIN
  SELECT * 
  INTO VINFO
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID'; -- �޽������� �����ϸ�ȵ�
  DBMS_OUTPUT.PUT_LINE('�����ȣ : '||VINFO.EMP_ID||', �̸� : '||VINFO.EMP_NAME||', �޿� : ' ||
  VINFO.SALARY||', �Ի��� : '||VINFO.HIRE_DATE);
END;
/

-- @�ǽ�����2
-- �����ȣ�� �Է¹޾Ƽ� �ش����� �����ȣ, �̸�, �μ��ڵ�, �μ����� ����ϼ���.
DECLARE
  VEMPID EMPLOYEE.EMP_ID%TYPE;
  VNAME EMPLOYEE.EMP_NAME%TYPE;
  VDCODE DEPARTMENT.DEPT_ID%TYPE;
  VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  INTO VEMPID, VNAME, VDCODE, VDTITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
  WHERE EMP_ID = '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('�����ȣ : '||VEMPID||', �̸� : '||VNAME||', �μ��ڵ� : '||VDCODE||', �μ��� : '||VDTITLE);
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �������� �ʽ��ϴ�.');
END;
/


BEGIN 
  INSERT INTO KH_SEQUENCE_TBL VALUES(SEQ_KH_SNO.NEXTVAL, 'ĥ����', 77);
  COMMIT;
END;
/

-- @�ǽ�����3
-- EMPLOYEE ���̺��� ����� ��������ȣ�� ���ѵ�, +1�� ����� ����ڷκ���
-- �Է¹��� �̸�, �ֹι�ȣ, ��ȭ��ȣ,�����ڵ�, �޿������ ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
DECLARE
  LAST_NUM EMPLOYEE.EMP_ID%TYPE;
BEGIN
  SELECT MAX(EMP_ID)
  INTO LAST_NUM
  FROM EMPLOYEE;
  
  INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
  VALUES(LAST_NUM+1, '&NAME', '&PERSON_NO', '&MOBILE', '&JCODE', '&SCODE');
  COMMIT;
END;
/

SELECT * FROM EMPLOYEE ORDER BY 1 DESC;

-- PL/SQL: ORA-00947: not enough values
-- ���ΰ� ��ġ���, �ذ����� �ۼ��Ͻÿ�.
-- �÷��� 14���ε� 6�� �ۿ� �ۼ����� �ʾ���. �÷��� ������ �����ؼ� �߻��ϴ� ������.
-- �ذ��� 1. 6�� -> 14���� �ø��� ��.
-- �ذ��� 2. 6���� �Էµǵ��� �ϴ� ��.


SELECT * FROM KH_SEQUENCE_TBL;
ROLLBACK;

SELECT * FROM USER_SEQUENCES;


-- ====================================== PL/SQL�� ���ǹ� ======================================
-- 1. IF (���ǽ�) THEN (���๮) END IF;
-- @�ǽ�����1
-- �����ȣ�� �Է¹޾Ƽ� ����� ���, �̸�, �޿�, ���ʽ����� ����Ͻÿ�
-- ��, �����ڵ尡 J1�� ��� '���� ȸ�� ��ǥ���Դϴ�.'�� ����Ͻÿ�.
DECLARE
    EMP_INFO EMPLOYEE%ROWTYPE;
BEGIN
    --SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    SELECT *
    INTO EMP_INFO
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('��� : '|| EMP_INFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| EMP_INFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| EMP_INFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : '|| EMP_INFO.BONUS*100||'%');
    
    IF (EMP_INFO.JOB_CODE = 'J1')
    THEN DBMS_OUTPUT.PUT_LINE('���� ȸ�� ��ǥ���Դϴ�.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �������� �ʽ��ϴ�.');
END;
/

-- 2. IF (���ǽ�) THEN (���๮) ELSE (���๮) END IF;
-- @�ǽ�����2
-- �����ȣ�� �Է´�Ƽ� ����� ���, �̸� �μ��� ���޸��� ����Ͻÿ�
-- �� ,�����ڵ尡 J1�� ��� '��ǥ', �� �ܿ��� '�Ϲ�����'���� ����Ͻÿ�.
-- ��� : 200
-- �̸� : ������
-- �μ��� : �ѹ���
-- ���޸� : �λ���
-- �Ҽ� : �Ϲ�����

-- ���� Type�� ��������� �ۼ����� �ʴ� ��� %TYPE
DECLARE
  EMPID EMPLOYEE.EMP_ID%TYPE; 
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
  JCODE JOB.JOB_CODE%TYPE;
  JNAME JOB.JOB_NAME%TYPE;
  EMPTEAM VARCHAR2(20);
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_CODE, JOB_NAME
  INTO EMPID, EMPNAME, DTITLE, JCODE, JNAME
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
  LEFT JOIN JOB USING(JOB_CODE)
  WHERE EMP_ID = '&EMP_ID';
  
  IF (JCODE = 'J1') THEN EMPTEAM := '��ǥ';
  ELSIF (JCODE = 'J2') THEN EMPTEAM := '�ӿ���';
  ELSE EMPTEAM := '�Ϲ�����';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('��� : '|| EMPID);
  DBMS_OUTPUT.PUT_LINE('�̸� : '|| EMPNAME);
  DBMS_OUTPUT.PUT_LINE('�μ��� : '|| DTITLE);
  DBMS_OUTPUT.PUT_LINE('���޸� : '|| JNAME);
  DBMS_OUTPUT.PUT_LINE('�Ҽ� : '|| EMPTEAM);
END;
/



-- 3. IF (���ǽ�) THEN (���๮) ELSEIF (���ǽ�) THEN (���๮) ELSE (���๮) END IF;
--@�ǽ����� 
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�
--500���� �̻�(�׿�) : A
--400���� ~ 499���� : B
--300���� ~ 399���� : C
--200���� ~ 299���� : D
--100���� ~ 199���� : E
--0���� ~ 99���� : F

/*
  -- ���� url : https://ldgeao99-developer.tistory.com/225
  [declare begin end �⺻���� ���� �� ��������]
  1. declare begin end - PL/SQL �⺻���� ����, ������ ������ �� �ֽ��ϴ�
  2. declare [�����] - ����, ����� ������ �� �ֽ��ϴ�
  3. begin [�����] - ����, �ݺ���, �Լ� �� �پ��� ���� ����� �����մϴ�
  4. end [�����] - ����� ������ ���Ḧ �����մϴ�
  5. ������ ����� DBMS_OUTPUT���� Ȯ���� �� �ֽ��ϴ�
*/

-- ���� Type�� ��������� �ۼ����� �ʴ� ��� %TYPE
DECLARE
  EMPID EMPLOYEE.EMP_ID%TYPE;
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  SALLEVEL EMPLOYEE.SAL_LEVEL%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY --���̺��� ��ȸ�� �÷� ����
  INTO EMPID, EMPNAME, SALARY -- ��ȸ�Ȱ���� �޾ƿú��� (INTO : �����͸� ����)
  FROM EMPLOYEE
  WHERE EMP_ID = '&���';
  SALARY := SALARY;
  IF (SALARY BETWEEN 0 AND 990000) THEN SALLEVEL := 'F';
  ELSIF (SALARY BETWEEN 1000000 AND 1990000) THEN SALLEVEL := 'E';
  ELSIF (SALARY BETWEEN 2000000 AND 2990000) THEN SALLEVEL := 'D';
  ELSIF (SALARY BETWEEN 3000000 AND 3990000) THEN SALLEVEL := 'C';
  ELSIF (SALARY BETWEEN 4000000 AND 4990000) THEN SALLEVEL := 'B';
  ELSE SALLEVEL := 'A';
  END IF;
  DBMS_OUTPUT.PUT_LINE('��� : '||EMPID);
  DBMS_OUTPUT.PUT_LINE('�̸� : '||EMPNAME);
  DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
  DBMS_OUTPUT.PUT_LINE('�޿���� : '||SALLEVEL);
END;
/

-- ======= �޿���� ��¹� CASE������ �ٲ㺸�� =======
DECLARE
  EMPID EMPLOYEE.EMP_ID%TYPE;
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  SALLEVEL EMPLOYEE.SAL_LEVEL%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMPID, EMPNAME, SALARY 
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    SALARY := TRUNC(SALARY / 1000000);
    CASE SALARY
      WHEN 0 THEN SALLEVEL := 'F'; -- 0~99 -> 0
      WHEN 1 THEN SALLEVEL := 'E'; -- 100 ~ 199 -> 1
      WHEN 2 THEN SALLEVEL := 'D'; -- 200 ~ 299 -> 2
      WHEN 3 THEN SALLEVEL := 'C'; -- 300 ~ 399 -> 3
      WHEN 4 THEN SALLEVEL := 'B'; -- 400 ~ 499 -> 4
      ELSE SALLEVEL := 'A';
    END CASE;
  DBMS_OUTPUT.PUT_LINE('��� : '||EMPID);
  DBMS_OUTPUT.PUT_LINE('�̸� : '||EMPNAME);
  DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
  DBMS_OUTPUT.PUT_LINE('�޿���� : '||SALLEVEL);
END;
/

-- 4.CASE��, 
-- CASE 
--    WHEN ��1 THEN ���๮1 
--    WHEN ��1 THEN ���๮1 
--    WHEN ��1 THEN ���๮1 
--    ELSE ���๮2
-- END CASE;
-- �Է¹��� ���� 10�̸� �������Դϴ�. 2�� ������Դϴ�. 3�̸� �ʷϻ��Դϴ�. �� ����ϼ���
DECLARE 
  INPUTVAL NUMBER;
BEGIN
  INPUTVAL := '&INPUTVAL';
  CASE INPUTVAL
    WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('�������Դϴ�.');
    WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('������Դϴ�.');
    WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('�ʷϻ��Դϴ�.');
    ELSE DBMS_OUTPUT.PUT_LINE('�߸��Է��ϼ̽��ϴ�.');
  END CASE;
END;
/

-- ====================================== PL/SQL�� �ݺ��� (8������ ����) ======================================









































































