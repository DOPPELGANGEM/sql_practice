-- ====================== PL/SQL - Stored Procedure ======================
-- ���ν����� �Ϸ��� �۾� ������ �����ؼ� �����ص� ��.
-- �Լ��� �޸� ��ȯ���� ����.
-- ū ������ �����ؼ� ó���� �� �� ���, ���������� ���ν����� �����ؼ� ó����.
-- ���� SQL���� ��� �̸� �����صΰ� �ϳ��� ��û���� ������ �� ����
-- ���� ���ν����� ��������� ����� �� ����.
-- ����
-- CREATE OR REPLACE PROCEDURE ���ν�����(�Ű�����1, �Ű�����2, ...)
-- -> �Ű������� IN���(�����͸� ���޹��� ��), OUT���(����� ����� �޾ư� ��)�� ����.
-- IS
--    �������𰡴�(OUT���)
-- �͸���

-- ������
-- EXECUTE ���ν�����

-- ������ ���ν��� Ȯ��
SELECT * FROM USER_PROCEDURES; -- �츮���������ν���
SELECT * FROM ALL_PROCEDURES;


CREATE TABLE EMP_DUPLICATE
AS SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE PROC_DEL_ALL_EMP
IS
BEGIN
  DELETE FROM EMP_DUPLICATE;
END;
/
-- Procedure PROC_DEL_ALL_EMP��(��) �����ϵǾ����ϴ�.
-- ���ν��� ����
EXECUTE PROC_DEL_ALL_EMP; 
-- Ȯ��
SELECT * FROM EMP_DUPLICATE; 
 -- �ѹ��ϰ� �ٽ�Ȯ���ϸ� ���������� (ROLLBACK ����Ŀ�Խ������ε��ư�)
ROLLBACK;

-- Stored Procedure�� ������ (PROC_ADD_ALL_EMP)
CREATE OR REPLACE PROCEDURE PROC_ADD_ALL_EMP
IS
BEGIN
  INSERT INTO EMP_DUPLICATE (SELECT * FROM EMPLOYEE);
  COMMIT;
  DMBS_OUTPUT.PUT_LINE('�����Ͱ� ��� �߰��Ǿ����ϴ�.');
END;
/
EXEC PROC_ADD_ALL_EMP;
SELECT * FROM EMP_DUPLICATE;
ROLLBACK;

CREATE OR REPLACE PROCEDURE PROC_DEL_ONE_EMP(P_EMPID IN EMP_DUPLICATE.EMP_ID%TYPE) -- �Ű���������
IS
BEGIN
  DELETE FROM EMP_DUPLICATE WHERE EMP_ID = P_EMPID;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE(P_EMPID ||' ����� �����Ǿ����ϴ�.');
END;
/
EXEC PROC_DEL_ONE_EMP('&EMPID');
SELECT * FROM EMP_DUPLICATE;
EXECUTE PRO_DEL_ALL_EMP;
EXEC PROC_ADD_ALL_EMP;

-- ====================================== PROCEDURE �Ű����� IN, OUT��� ======================================
CREATE OR REPLACE PROCEDURE PROC_SELECT_EMP_INFO(
    P_EMPID IN EMPLOYEE.EMP_ID%TYPE,
    P_ENAME OUT EMPLOYEE.EMP_NAME%TYPE,
    P_SALARY OUT EMPLOYEE.SALARY%TYPE,
    P_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS,0)
    INTO P_ENAME, P_SALARY, P_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMPID;
END;
/
-- ���ε� ���� ����
VAR B_ENAME VARCHAR2(30);
VAR B_SALARY NUMBER;
VAR B_BONUS NUMBER;
-- ���ε� ���� ��� -> ������ �տ� : �ٿ� �ֱ�!
EXEC PROC_SELECT_EMP_INFO('&EMP_ID', :B_ENAME, :B_SALARY, :B_BONUS);

PRINT B_ENAME;
PRINT B_SALARY;
PRINT B_BONUS;

VAR RESULT VARCHAR2(200);
EXEC : RESULT := (:B_ENAME||', '||:B_SALARY||', '||:B_BONUS);
PRINT RESULT;


--@�ǽ�����
--�����μ����̺��� DEPT_ID, DEPT_TITLE�� ������ DEPT_COPY�� �����Ѵ�.
--DEPT_ID �÷� PK�߰�. DEPT_ID �÷� Ȯ�� CHAR(3)
--DEPT_COPY�� �����ϴ� ���ν��� PROC_MAN_DEPT_COPY�� �����Ѵ�.
-- ù��° ���ڷ� FLAG�� UPDATE/DELETE�� �޴´�.
-- UPDATE��, �����Ͱ� �������� ������ INSERT, �����Ͱ� �����ϸ�, UPDATE
-- DELETE��, �ش�μ��� ����� �����ϴ����� �˻��ؼ�, �����ϸ�, ���޼����� �Բ� ���������. �׷��� ������, ����.
-- �ϴ� ���ν����� �����Ͻÿ�.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
SELECT * FROM USER_CONSTRAINTS UC
WHERE UC.TABLE_NAME = 'DEPT_COPY';
-- PK �߰� (DEPARTMENT���� PK�� ������ �����ϸ� NOT NULL�� ���� �ǹǷ� PK�߰� �ʿ�)
ALTER TABLE DEPT_COPY
ADD CONSTRAINT PK_DEPT_ID PRIMARY KEY(DEPT_ID);
-- �÷� Ȯ��
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3);
DESC DEPT_COPY;
DESC DEPARTMENT;


CREATE OR REPLACE PROCEDURE PROC_MAN_DEPT_COPY(
    P_FLAG IN VARCHAR2,
    P_DEPTID IN DEPARTMENT.DEPT_ID%TYPE,
    P_DTITLE IN DEPARTMENT.DEPT_TITLE%TYPE
)
IS
    P_CNT NUMBER := 0;
BEGIN
    -- UPDATE��, �����Ͱ� �������� ������ INSERT, �����Ͱ� �����ϸ�, UPDATE
    IF P_FLAG = 'UPDATE'
    THEN
        -- P_CNT�� �̿��ؼ� �μ��� ���翩�θ� üũ
        SELECT COUNT(*)
        INTO P_CNT
        FROM DEPT_COPY
        WHERE DEPT_ID = P_DEPTID;
        IF P_CNT > 0
        THEN
            -- ������.
            UPDATE DEPT_COPY
            SET DEPT_TITLE = P_DTITLE
            WHERE DEPT_ID = P_DEPTID;
        ELSE
            -- �������� ����.
            INSERT INTO DEPT_COPY VALUES(P_DEPTID, P_DTITLE, 'L1');
        END IF;
-- DELETE��, �ش�μ��� ����� �����ϴ����� �˻��ؼ�, �����ϸ�, ���޼����� �Բ� ���������. �׷��� ������, ����.
    ELSIF P_FLAG = 'DELETE'
    THEN
        -- P_CNT�� �̿��ؼ� �μ����� ���翩�θ� üũ
        SELECT COUNT(*)
        INTO P_CNT
        FROM EMPLOYEE
        WHERE DEPT_CODE = P_DEPTID;
        IF P_CNT > 0
        THEN
            -- �μ����� ������.
            DBMS_OUTPUT.PUT_LINE('ERROR : �ش� �μ����� �����ϹǷ�, �μ��� ������ �� �����ϴ�.');
            RETURN;
        ELSE
            -- �μ����� �������� ����.
            DELETE FROM DEPT_COPY WHERE DEPT_ID = P_DEPTID;
            DBMS_OUTPUT.PUT_LINE('SUCCESS : �μ��� �����Ǿ����ϴ�.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR : �ش� �۾��� �������� �ʽ��ϴ�.');
        RETURN;
    END IF;
    COMMIT;
END;
/
EXEC PROC_MAN_DEPT_COPY('UPDATE', 'D10', '�渮��');
EXEC PROC_MAN_DEPT_COPY('DELETE', 'D10', '');
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY;
INSERT INTO DEPT_COPY (SELECT * FROM DEPARTMENT);
COMMIT;
ROLLBACK;
DROP TABLE DEPT_COPY;

-- ====================================== PL/SQL�� FUNCTION ======================================
-- -> ���� ���� �����ϴ� Stored Procedure
-- ����
-- CREATE OR REPLACE FUNCTION �Լ���(�Ű�����1, �Ű�����2, ..)
-- RETURN �ڷ���
-- IS
--     �������� ����
-- BEGIN
--     ���๮
-- END;
-- /
-- ������
-- EXEC ���ε� ���� := �Լ���(�Ű�����1, �Ű�����2, ...);

-- ����
-- ���ڿ��� �Է¹޾� �� ���� d��b�� �ٿ� ������� �����ּ���
-- ^_^ -> d^_^b
CREATE OR REPLACE FUNCTION GET_HEADPHONE
(
  P_STR VARCHAR2
)

RETURN VARCHAR2
IS
  RESULT VARCHAR2(100);
BEGIN
  RESULT := 'd'||P_STR||'b';
  RETURN RESULT;
END;
/
VAR vStr VARCHAR2;
EXEC :vStr := GET_HEADPHONE('&arg');
PRINT vStr;
  
  
-- @�ǽ�����1
-- ����� �Է¹޾� �ش� ����� ������ ����Ͽ� �����ϴ� �����Լ��� ����� ����Ͻÿ�.
-- �Լ��� : FN_SALARY_CALC, ���ε� ������ : VAR_CALC
CREATE OR REPLACE FUNCTION FN_SALARY_CALC
(
  V_EMPID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS
  -- SELECT�� SALARY�� ���� ����
  V_SALARY EMPLOYEE.SALARY%TYPE;
  -- ����� ����� ���� ����
  CALC_SAL NUMBER;
BEGIN
  SELECT SALARY
  INTO V_SALARY
  FROM EMPLOYEE
  WHERE EMP_ID = V_EMPID;
  CALC_SAL := V_SALARY * 12;
  RETURN CALC_SAL;
END;
/

VAR VAR_CALC NUMBER;
EXEC :VAR_CALC := FN_SALARY_CALC('&EMP_ID');
PRINT VAR_CALC;
-- SELECT������ �����غ���
SELECT FN_SALARY_CALC('&EMP_ID') FROM DUAL;
SELECT EMP_NAME "�����", FN_SALARY_CALC(EMP_ID) "����" FROM EMPLOYEE;


-- @�ǽ�����2
-- �����ȣ�� �Է¹޾Ƽ� ������ �����ϴ� �����Լ� FN_GET_GENDER�� �����ϰ�, �����ϼ���.
CREATE OR REPLACE FUNCTION FN_GET_GENDER
(
  V_EMPID VARCHAR2  
)
RETURN CHAR
IS
  -- �������� ����
  V_GENDER CHAR(3);
BEGIN
  SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��')
  INTO V_GENDER
  FROM EMPLOYEE
  WHERE EMP_ID = V_EMPID;
  -- ����� ��ȯ
  RETURN V_GENDER;
END;
/
-- SELECT������ ����ϱ� 
SELECT FN_GET_GENDER('207') FROM DUAL;
SELECT EMP_NAME, FN_GET_GENDER(EMP_ID) FROM EMPLOYEE;


-- @�ǽ�����3
-- ����ڷκ��� �Է¹��� ��������� �˻��Ͽ� �ش����� ���޸��� ��� ���� �����Լ�
-- FN_GET_JOB_NAME�� �ۼ��ϼ���. (�ش����� ���ٸ� '�ش�������' ���)

CREATE OR REPLACE FUNCTION FN_GET_JOB_NAME
(
  V_ENAME EMPLOYEE.EMP_NAME%TYPE
)
RETURN VARCHAR2
IS
  V_JNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT JOB_NAME
    INTO V_JNAME
    FROM EMPLOYEE
    LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_NAME = V_ENAME;
    RETURN V_JNAME;
EXCEPTION
  WHEN NO_DATA_FOUND THEN RETURN '�ش�������';
END;
/

-- SELECT�� ����غ���
SELECT FN_GET_JOB_NAME('������') FROM DUAL;







































