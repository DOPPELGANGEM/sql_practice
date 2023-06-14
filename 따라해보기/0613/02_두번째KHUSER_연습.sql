SHOW USER;
SELECT * FROM USER_ROLE_PRIVS;

-- ============================= KHUSER02 세션으로 실행  =============================

SELECT * FROM KHUSER01.COFFEE;
INSERT INTO KHUSER01.COFFEE VALUES('카누커피', 1500, '카누');
INSERT INTO KHUSER01.COFFEE VALUES('매머드커피', 1800, '매머드');
COMMIT;