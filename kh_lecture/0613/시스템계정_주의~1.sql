-- ============================= 시스템 세션으로 실행  =============================
GRANT SELECT ON KHUSER01.COFFEE TO KHUSER02;
GRANT INSERT ON KHUSER01.COFFEE TO KHUSER02;
-- Grant을(를) 성공했습니다.

-- ============================= 시스템 세션으로 실행  =============================
REVOKE SELECT ON KHUSER01.COFFEE FROM KHUSER02;
REVOKE INSERT ON KHUSER01.COFFEE FROM KHUSER02;
--Revoke을(를) 성공했습니다.