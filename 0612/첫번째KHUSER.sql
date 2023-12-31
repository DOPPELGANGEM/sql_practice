-- 테이블을 생성하기 위해서는 관리자 계정에서 권한을 부여해줬어야 했음.
-- 권한부여 완료 후 생성 완료
CREATE TABLE STUDENT_TBL (
  STUDENT_NAME VARCHAR2(20),
  STUDENT_AGE NUMBER,
  STUDENT_GRADE NUMBER,
  STUDENT_ADDR VARCHAR2(100)
); -- 컨트롤 + 엔터
-- CRUD
-- 정의된 테이블에 데이터 추가
INSERT INTO STUDENT_TBL VALUES('오용자', 55, 5, '경기도 부천시'); -- 컨트롤엔터(임시저장 상태)
COMMIT; -- 컨트롤 S와 같은 역할, 최종 저장
SELECT STUDENT_NAME, STUDENT_AGE, STUDENT_GRADE, STUDENT_ADDR FROM STUDENT_TBL;
--추가된 데이터 수정
UPDATE STUDENT_TBL SET STUDENT_AGE = 56 WHERE STUDENT_NAME = '오용자';
-- SET 뒤에는 수정하고 싶은 테이블 헤더에 값을 대입하고 WHERE 뒤에는 수정하고 싶은 데이터를 특정함.
-- 데이터 수정 후 최종 저장 필요!

DELETE FROM STUDENT_TBL WHERE STUDENT_NAME = '일용자';
-- WHERE 뒤에는 수정하고 싶은 데이터를 특정함.
-- 데이터 삭제 후 최종 저장 필요
-- 이렇게 쓰면 안된다!! (의도하지 않는 WHERE 절 누락 조심해야함!)
-- DELETE FROM STUDENT_TBL;
-- UPDATE STUDENT_TBL SET STUDENT_AGE = 56;
-- 임시 상태에서 원상복구 하는 방법(원복 ROLLBACK)
ROLLBACK;

------------------------------------------------------------------------------------------------------------------------------------------------
-- ================================================= DDL =================================================
-- 데이터 정의어 (Data Defintion Language)
-- 테이블 생성, 수정, 삭제함
-- CREATE TABLE~ , ALTER TABLE ~, DROP TABLE~
-- STUDENT_TBL 삭제해주세요.
-- DROP TABLE STUDENT_TBL; (원복없음 날리면끝)
DROP TABLE STUDENT_TBL;
-- STUDNET_TBL 생성해주세요.
CREATE TABLE STUDENT_TBL (
    STUDENT_NAME VARCHAR2(20),
    STUDENT_AGE NUMBER,
    STUDENT_GRADE NUMBER,
    STUDENT_ADDR VARCHAR2(100)
);
SELECT STUDENT_NAME, STUDENT_AGE, STUDENT_GRADE, STUDENT_ADDR FROM STUDENT_TBL;
-- 데이터 추가
INSERT INTO STUDENT_TBL VALUES('일용자', 11, 1, '서울시 중구');
COMMIT;
SELECT * FROM STUDENT_TBL;
SELECT STUDENT_NAME, STUDENT_AGE FROM STUDENT_TBL;
-- 데이터 수정
UPDATE STUDENT_TBL SET STUDENT_AGE = 22 WHERE STUDENT_NAME = '일용자';
SELECT * FROM STUDENT_TBL;
-- 데이터 삭제
DELETE FROM STUDENT_TBL WHERE STUDENT_GRADE = 1;
COMMIT;

--테이블 생성
CREATE TABLE LESSON_TBL (
    LESSON_NO NUMBER,
    MEMBER_ID VARCHAR2(15),
    APPLY_PRICE VARCHAR2(60),
    APPLY_PLAN VARCHAR2(60),
    APPLY_CONTENT VARCHAR2(600),
    APPLY_DATE TIMESTAMP(6)
);

SELECT * FROM LESSON_TBL;
-- 데이터타입과 크기를 확인(스키마확인)
DESC LESSON_TBL;
DESC STUDENT_TBL;
--테이블삭제
DROP TABLE LESSON_TBL;

COMMENT ON COLUMN LESSON_TBL.LESSON_NO IS '레슨글 번호';
COMMENT ON COLUMN LESSON_TBL.MEMBER_ID IS '신청인 ID';
COMMENT ON COLUMN LESSON_TBL.APPLY_PRICE IS '신청가격';
COMMENT ON COLUMN LESSON_TBL.APPLY_PLAN IS '신청일정';
COMMENT ON COLUMN LESSON_TBL.APPLY_CONTENT IS '신청내용';
COMMENT ON COLUMN LESSON_TBL.APPLY_DATE IS '신청일';








