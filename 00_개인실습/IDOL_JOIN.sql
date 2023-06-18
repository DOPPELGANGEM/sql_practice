SELECT * FROM IDOL_GROUP;
SELECT * FROM IDOL_MEMBER;

-- �׷쿡�� 15���� IDOL_GROUP�� �ִµ� MEMBER���� 4���� �־���. 
-- �׷��� JOIN�� �� ��� 4���� GROUP�ۿ� ������ ����. �̷������ INNER JOIN
-- INNER JOIN�� A ���̺�� B���̺� ��� �����ϴ� �����͵鸸 ���´�.
-- �׷��� ���߿� �� ���̺��� �������� �ʴ´ٸ� ���������ʴ´�.
SELECT A.COMPANY, A.GROUP_NAME, B.MEMBER_NAME, B.REAL_NAME 
FROM IDOL_GROUP A, IDOL_MEMBER B WHERE A.GROUP_NAME = B.GROUP_NAME;

-- COUNT�� �� ���� GROUP BY�� ��ߵȴ�.
SELECT A.COMPANY, A.GROUP_NAME, COUNT(B.MEMBER_NAME) COUNT 
FROM IDOL_GROUP A, IDOL_MEMBER B WHERE A.GROUP_NAME = B.GROUP_NAME GROUP BY A.COMPANY, A.GROUP_NAME;












