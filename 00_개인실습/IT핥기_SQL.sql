CREATE TABLE INFO(
  ID NUMBER,
  NAME VARCHAR2(100),
  BIRTH DATE,
  BTYPE CHAR(2)
);

DESC INFO; --테이블의정보를 보는 것도가능
SELECT * FROM INFO;

INSERT INTO "INFO" VALUES (1, '홍길동', SYSDATE, 'B');
INSERT INTO "INFO" VALUES (2, '이순신', '2020-12-23', 'B');
INSERT INTO "INFO" ("ID", "NAME") VALUES (3, '임꺽정');
INSERT INTO "INFO" ("BTYPE", "NAME") VALUES ('AB', '강감찬');
INSERT INTO "INFO" ("ID", "NAME", "BIRTH", "BTYPE") VALUES (5, '장영실', '2011-01-26', 'O');
INSERT INTO "INFO" VALUES (2, '이순신', '2020-12-23', 'B');

-- 값 수정하기 (SELECT에서 사용하는 WHERE 조건 형태 활용)
UPDATE "INFO" SET "ID"=10 WHERE "ID"=1;
UPDATE "INFO" SET "NAME"='이길동' WHERE "ID"=1;
UPDATE "INFO" SET "NAME"='이길동' WHERE "ID"=10;
UPDATE "INFO" SET "NAME"='홍길동',"BTYPE"='C' WHERE "ID"=10;
UPDATE "INFO" SET "BIRTH"=SYSDATE WHERE "NAME"='강감찬';
UPDATE "INFO" SET "BIRTH"='1988-09-21', "NAME"='김꺽정' WHERE "ID"=3;
UPDATE "INFO" SET "BTYPE"='A' WHERE "ID"=3;
UPDATE "INFO" SET "ID"=100 WHERE "NAME"='강감찬';
COMMIT;
UPDATE "INFO" SET "BTYPE"='O'; /* WHERE절이 없는 경우 모든 행 수정 */
ROLLBACK;

-- 값 삭제하기(SELECT에서 사용하는 WHERE 조건 형태 활용)
DELETE FROM "INFO"; /* WHERE절이 없는 경우 모든 행 삭제 */
ROLLBACK;
SELECT * FROM INFO WHERE ID = 100;
DELETE FROM "INFO" WHERE "ID"=100;
SELECT * FROM "INFO" WHERE "ID"=3 AND "NAME"='홍길동';
DELETE FROM "INFO" WHERE "ID"=3 AND "NAME"='홍길동';
SELECT * FROM "INFO" WHERE "ID"=3 OR "NAME"='%길동';
DELETE FROM "INFO" WHERE "ID"=3 OR "NAME"='%길동';




