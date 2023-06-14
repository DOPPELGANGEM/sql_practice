-- TCL (Transaction Control Language) COMMIT, ROLLBACK, SAVEPOINT
-- 트랜잭션 처리 언어,
-- Transaction(트랜잭션)이란?
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말함.
-- ATM 출금, 계좌이체
-- 1.계좌번호 입력, 은행 선택 - 처음부터 다시
-- 2.금액 입력 - 처음부터 다시
-- 3.비밀번호 입력 - 처음부터 다시
-- 4.이체 완료 - 완료
-- oracle DBMS 트랙잭션>
-- INSERT 수행시 DMBS 트랜잭션 처리함. -> 그 뒤에 또 다른 작업이 있을 것이라고 생각함.
-- INSERT - INSERT - INSERT - ... - COMMIT; (최종저장)
-- INSERT - DELETE - UPDATE - INSERT - ... - COMMIT; (트랜잭션 종료)
INSERT INTO COFFEE VALUES('커피우유', 1800, '서울우유');
COMMIT;
INSERT INTO COFFEE VALUES('카페라떼', 3700, 'TWOSOME PLACE');
ROLLBACK;
--1. COMMIT : 트랜잭션 작업이 정상 완료 되어 변경 내용을 영구히 저장 (모든 savepoint 삭제)
--2. ROLLBACK : 트랜잭션 작업을 모두 취소하고 가장 최근 commit 시점으로 이동
--3. SAVEPOINT : <savepoint>명 : 현재 트랜잭션 작업 시점에 이름을 지정함. 하나의 트랜잭션 안에서 구역을 나눌 수 있음 (임시저장)

CREATE TABLE USER_TCL(
  USER_NO NUMBER UNIQUE,
  USER_NAME VARCHAR(20) NOT NULL,
  USER_ID VARCHAR(30) PRIMARY KEY
);

INSERT INTO USER_TCL VALUES(1, '일용자', 'khuser01');
COMMIT;
INSERT INTO USER_TCL VALUES(2, '이용자', 'khuser02');
COMMIT;
INSERT INTO USER_TCL VALUES(3, '삼용자', 'khuser03');
SAVEPOINT until3;
INSERT INTO USER_TCL VALUES(4, '사용자', 'khuser04');
COMMIT;
SELECT * FROM USER_TCL;
ROLLBACK TO until3;
ROLLBACK;

DROP TABLE USER_TCL;





