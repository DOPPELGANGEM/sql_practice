-- NOT NULL 제약조건 AGE이가 NOT NULL이라 삽입불가

-- UNIQUE 제약조건 (중복된 값 허용하지않음)
-- PRIMARY KEY (테이블당 하나 설정 가능 NOT NULL+UNIQUE 합친속성)
-- CHECK 제약조건 (데이터 값의 범위나 조건을 지정해 설정한값 허용)
-- DEFAULT 제약조건 (기본값으로 설정한 값이 자동으로 입력되도록 하는 제약조건)


-- FOREIGN KEY 제약조건 (참조되는 테이블의 컬럼의값이 존재하면 허용한다. 따로테이블만들어서 본다.)
-- 테이블 참조, Foreign Key, 참조 무결성 제약조건
CREATE TABLE PARENT(
  P_ID VARCHAR2(2) NOT NULL
);

-- ALTER TABLE [pk 값을 넣으려는 테이블명] ADD CONSTRAINT [PK 이름 지정] PRIMARY KEY [PK 지정하려는 컬럼명]
ALTER TABLE PARENT ADD CONSTRAINT P_PK PRIMARY KEY(P_ID);

CREATE TABLE CHILD(
  C_ID VARCHAR(2) NOT NULL,
  P_ID VARCHAR(2)
);

-- ALTER TABLE [pk 값을 넣으려는 테이블명] ADD CONSTRAINT [PK 이름 지정] PRIMARY KEY [PK 지정하려는 컬럼명]
ALTER TABLE CHILD ADD CONSTRAINT C_PK PRIMARY KEY(C_ID);
-- ALTER TABLE [FK 값을 넣으려는 테이블명] ADD CONSTRAINT [ FK 이름 지정] FOREIGN KEY [ FK 지정하려는 컬럼명] REFERENCES [참조하는 부모 테이블 명] (참조하려는 부모 테이블의 칼럼명)
ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID);

INSERT INTO PARENT VALUES('A');
INSERT INTO PARENT VALUES('B');

INSERT INTO CHILD VALUES('a','A');


-- 부모에게 없는 값을 자식에게 넣었을 때 참조무결성에 위배된다.
INSERT INTO CHILD VALUES('b','B');

-- A의 자식이 있기 때문에 부모인 A를 지울수없다?
DELETE FROM PARENT WHERE P_ID = 'A';

ALTER TABLE CHILD DROP CONSTRAINT C_FK;
ALTER TABLE CHILD ADD CONSTRAINT C_FK FOREIGN KEY(P_ID) REFERENCES PARENT(P_ID) ON DELETE CASCADE;
-- ON DELETE CASCADE : PARENT 삭제 시 CHILD 같이 삭제
-- ON DELETE SET NULL: PARENT 삭제 시 CHILD의 해당 필드 NULL로 업데이트
-- ON DELETE SET DEFAULT : PARENT 삭제 시 CHILD의 해당 필드 DEFAULT 값으로 UPDATE
-- ON DELETE RESTRICT : CHILD 테이블에 PK 값이 없는 경우만 PARENT 삭제
-- ON DELETE NO ACTION : 참조 무결성 제약조건을 위배하는 액션은 불가


SELECT * FROM PARENT;
SELECT * FROM CHILD;

DROP TABLE CHILD;
DROP TABLE PARENT;























