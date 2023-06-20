CREATE VIEW V_COFFEE
AS SELECT * FROM COFFEE;
-- ORA-01031: insufficient privileges (권한이없다) 
-- CREATE VIEW 권한은 RESOURCE에 포함되어 있지않고 권한부여가 안되었기 때문에 권한이 없는것!
-- 해결방안 : GRANT CREATE VIEW TO KHUSER01 <모범답안 ㅋ>
-- 권한이없어서 권한을부여 ㅇㅈㄹ ㄴㄴ




