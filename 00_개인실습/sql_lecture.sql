-- ============ 데이터베이스란? ============
-- 데이터베이스 : 데이터를 저장하는 공간
-- SQL : 중요하고도 방대한 데이터를 다루는데 사용되는 언어 데이터를 꺼내고 수정하고 삭제하기 위해서 SQL 사용

-- ============ 테이블이란? ============
-- 데이터베이스 안에 데이터를 저장을 할때는 테이블형태로 저장한다.
-- 그리고 그 테이블은 컬럼과 로우로 이루어진다.

-- ============ CREATE ============
-- 텍스트 유형의 데이터를 담을 계획이면 VARCHAR 타입으로 컬럼을 만듬
-- 숫자유형의 데이터를 담을 계획이면 NUMBER 타입
-- 날짜 유형의 데이터를 담을 계획이면 DATE 타입으로 컬럼을 만들어준다.
-- * 오라클에서는 VARCHAR 타입을 VARCHAR2로 정의를 해줌 *

CREATE TABLE NETFLIX(
  VIDEO_NAME VARCHAR2(50),
  CATEGORY VARCHAR2(30),
  VIEW_CNT NUMBER(7),
  REG_DATE DATE
);

SELECT * FROM NETFLIX;

-- ============ ALTER ============
-- 기존에 생성해 놓았던 테이블을 변경하고 싶을 때 사용하는 명령어
-- ADD COLUMN으로 컬럼을 추가할 수도 있고 DROP COLUMN으로 컬럼을 삭제할 수가 있고
-- MODIFY COLUMN으로 컬럼을 변경할수도있다.
SELECT * FROM NETFLIX n;

ALTER TABLE NETFLIX ADD (CAST_MEMBER VARCHAR2(20));
ALTER TABLE NETFLIX MODIFY (CAST_MEMBER VARCHAR2(50));
ALTER TABLE NETFLIX MODIFY (CAST_MEMBER NUMBER(2)); -- CAST_MEMBER를 NUMBER타입으로 변경
ALTER TABLE NETFLIX DROP (CAST_MEMBER);

-- ============ DROP / TRUNCATE ============
-- DROP TABLE : 테이블을 삭제한다.
-- TRUNCATE TABLE : 테이블을 초기화한다. (테이블은 그대로 남아 있지만 그 안에 저장되어 있던 데이터가 모두 삭제된다)
-- 참고로 DROP이나 TRUNCATE로 삭제된 테이블과 데이터는 다시 복구할수없다!
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
-- 테이블에 새로운 데이터를 삽입하는 쿼리이다.
-- INSERT query 수행시 데이터가 한 ROW씩 테이블에 입력이된다.
SELECT * FROM NETFLIX n;
INSERT INTO NETFLIX VALUES('나의 아저씨','드라마',50,SYSDATE);
COMMIT;
INSERT INTO NETFLIX (VIDEO_NAME, VIEW_CNT) VALUES ('시그널',42);
ROLLBACK; -- 내가 INSERT 햇던 작업을 취소하는 행위

INSERT INTO NETFLIX VALUES('응답하라 1988', '드라마', 35, SYSDATE-30);
INSERT INTO NETFLIX VALUES('이태원클라쓰','드라마',30, SYSDATE-40);
INSERT INTO NETFLIX VALUES('미스터션사인','드라마',22, SYSDATE-300);
DELETE FROM NETFLIX WHERE VIDEO_NAME = '응답하라 1988';


-- ============ UPDATE ============
-- 데이터를 변경한다.
-- UPDATE를 사용할 때 주의할점은 WHERE 조건절을 빼먹었을 때 모든 데이터가 변경이 돼 버리기때문에 주의 WHERE 조건 잘작성하기
SELECT * FROM NETFLIX n;

UPDATE NETFLIX SET VIEW_CNT = 70 WHERE VIDEO_NAME = '나의 아저씨';
COMMIT;
ROLLBACK;

UPDATE NETFLIX SET CATEGORY = '드라마',REG_DATE = TO_DATE('20210101','YYYYMMDD') WHERE VIDEO_NAME = '시그널';

-- ============ DELETE ============
-- 테이블에 존재하는 데이터를 삭제하는 query
-- TRUNCATE와 유사하지만 TRUNCATE가 테이블의 모든 데이터를 삭제하는 역할을 한다면 DELETE는 내가원하는 데이터만 골라서 삭제할 수가 있다.
-- TRUNCATE는 한번 실행하면 되돌릴 수 없지만 DELETE는 ROLLBACK을 이용하여 되돌릴 수가 있다.
-- 모든 데이터를 삭제하는 경우라면 DELETE보다 TRUNCATE가 빠르다.
SELECT * FROM NETFLIX n;

DELETE FROM NETFLIX n WHERE VIDEO_NAME = '미스터션사인';
COMMIT;

DELETE FROM NETFLIX n WHERE CATEGORY = '드라마' AND VIEW_CNT < 35;
ROLLBACK;
DELETE FROM NETFLIX WHERE VIDEO_NAME IN ('시그널','나의 아저씨');
DELETE FROM NETFLIX n;

-- ============ SELECT ============
SELECT * FROM NETFLIX n;

SELECT * FROM NETFLIX n WHERE VIDEO_NAME = '나의 아저씨';
SELECT * FROM NETFLIX n WHERE VIDEO_NAME <> '나의 아저씨';
SELECT * FROM NETFLIX n WHERE VIEW_CNT = 50;
SELECT * FROM NETFLIX n WHERE VIEW_CNT <> 50;
SELECT * FROM NETFLIX n WHERE REG_DATE > SYSDATE-30; -- 최근 한달 동안인 데이터를 출력하고싶다
SELECT * FROM NETFLIX n WHERE REG_DATE < SYSDATE-30; -- 한달 전에 등록된 데이터
SELECT CATEGORY FROM NETFLIX n;
SELECT DISTINCT CATEGORY FROM NETFLIX n; -- 중복되는것은 하나로만 보고싶다 -> DISTINCT




-- ============ 번외 ============
-- 테이블 참조, Foreign Key, 참조 무결성 제약조건
CREATE TABLE PARENT (
  P_ID VARCHAR2(2) NOT NULL
);

 ALTER TABLE PARENT ADD CONSTRAINT P_PK PRIMARY KEY(P_ID);
-- ALTER TABLE [pk 값을 넣으려는 테이블명] ADD CONSTRAINT [PK 이름 지정] PRIMARY KEY [PK 지정하려는 컬럼명]

CREATE TABLE CHILD(
  C_ID VARCHAR2(2) NOT NULL,
  P_ID VARCHAR2(2)
);
-- ALTER TABLE [pk 값을 넣으려는 테이블명] ADD CONSTRAINT [PK 이름 지정] PRIMARY KEY [PK 지정하려는 컬럼명]
ALTER TABLE CHILD ADD CONSTRAINT C_PK PRIMARY KEY(C_ID);
-- ALTER TABLE [FK 값을 넣으려는 테이블명] ADD CONSTRAINT [ FK 이름 지정] FOREIGN KEY [ FK 지정하려는 컬럼명] REFERENCES [참조하는 부모 테이블 명] (참조하려는 부모 테이블의 칼럼명)
ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID);

INSERT INTO PARENT VALUES('A');
INSERT INTO PARENT VALUES('B');
SELECT * FROM PARENT;
INSERT INTO CHILD VALUES('a','A');
SELECT * FROM CHILD;

INSERT INTO CHILD VALUES('b','B');
-- 부모에게 없는 값을 자식에게 넣었을 때 참조무결성에 위배된다.

DELETE FROM PARENT WHERE P_ID = 'A';
-- A의 자식이 있기 때문에 부모인 A를 지울수없다?

ALTER TABLE CHILD DROP CONSTRAINT C_FK;

ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID)
ON DELETE CASCADE;
-- ON DELETE CASCADE : PARENT 삭제 시 CHILD 같이 삭제
-- ON DELETE SET NULL: PARENT 삭제 시 CHILD의 해당 필드 NULL로 업데이트
-- ON DELETE SET DEFAULT : PARENT 삭제 시 CHILD의 해당 필드 DEFAULT 값으로 UPDATE
-- ON DELETE RESTRICT : CHILD 테이블에 PK 값이 없는 경우만 PARENT 삭제
-- ON DELETE NO ACTION : 참조 무결성 제약조건을 위배하는 액션은 불가

SELECT * FROM CHILD;

DROP TABLE PARENT;
DROP TABLE CHILD;














