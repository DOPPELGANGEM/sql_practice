CREATE TABLE IDOL_GROUP 
   (	"COMPANY" VARCHAR2(300 BYTE) NOT NULL ENABLE, 
	"GROUP_NAME" VARCHAR2(300 BYTE) NOT NULL ENABLE, 
	"DEBUT_YEAR" VARCHAR2(4 BYTE), 
	"DEBUT_ALBUM" VARCHAR2(300 BYTE), 
	"GENDER" VARCHAR2(10 BYTE)
   ) ;
 

   COMMENT ON COLUMN IDOL_GROUP.GROUP_NAME IS '�׷��';
 
   COMMENT ON COLUMN IDOL_GROUP.DEBUT_YEAR IS '���߳⵵';
 
   COMMENT ON COLUMN IDOL_GROUP.DEBUT_ALBUM IS '���߾ٹ�';
 
   COMMENT ON COLUMN IDOL_GROUP.GENDER IS '����';


INSERT INTO IDOL_GROUP VALUES ('����Ʈ �������θ�Ʈ', 'BTS', '2013', '2 COOL 4 SCHOOL', 'boy');
INSERT INTO IDOL_GROUP VALUES ('JYP �������θ�Ʈ', 'Ʈ���̽�', '2015', 'THE STORY BEGINS', 'girl');
INSERT INTO IDOL_GROUP VALUES ('YG �������θ�Ʈ', '����ũ', '2016', 'SQUARE ONE', 'girl');
INSERT INTO IDOL_GROUP VALUES ('��Ÿ����', '�ƽ�Ʈ��', '2016', 'SPRING UP', 'boy');
INSERT INTO IDOL_GROUP VALUES ('�︲ �������θ�Ʈ', '������', '2014', 'Girls Invasion', 'girl');
INSERT INTO IDOL_GROUP VALUES ('��Ÿ�� �������θ�Ʈ', '���ּҳ�', '2016', 'Would You Like', 'girl');
INSERT INTO IDOL_GROUP VALUES ('���� �������θ�Ʈ', 'Wanna One', '2017', '1X1=1', 'boy');
INSERT INTO IDOL_GROUP VALUES ('ť�� �������θ�Ʈ', '(����)���̵�', '2018', 'I am', 'girl');
INSERT INTO IDOL_GROUP VALUES ('SM �������θ�Ʈ', '���座��', '2014', '�ູ', 'girl');
INSERT INTO IDOL_GROUP VALUES ('SM �������θ�Ʈ', 'EXO', '2012', '����', 'boy');
INSERT INTO IDOL_GROUP VALUES ('JYP �������θ�Ʈ', '������', '2014', 'Got it?', 'boy');
INSERT INTO IDOL_GROUP VALUES ('���������ڵ� �������θ�Ʈ', '�������', '2018', '�÷�������', 'girl');
INSERT INTO IDOL_GROUP VALUES ('�÷����� �������θ�Ʈ', '������ũ', '2011', 'Seven Springs of Apink', 'girl');
INSERT INTO IDOL_GROUP VALUES ('ť�� �������θ�Ʈ', '������', '2012', '���', 'boy');
INSERT INTO IDOL_GROUP VALUES ('�����', '����ģ��', '2015', 'Season of Glass', 'girl');
INSERT INTO IDOL_GROUP VALUES ('YG �������θ�Ʈ', '����', '2014', '2014 S/S', 'boy');
INSERT INTO IDOL_GROUP VALUES ('��Ÿ�� �������θ�Ʈ', '��Ÿ����', '2015', 'TRESPASS', 'boy');
INSERT INTO IDOL_GROUP VALUES ('WM �������θ�Ʈ', '�����̰�', '2015', 'OH MY GIRL', 'girl');
INSERT INTO IDOL_GROUP VALUES ('DSP�̵��', '��������', '2015', 'Dreaming', 'girl');
INSERT INTO IDOL_GROUP VALUES ('�����ǽ� �������θ�Ʈ', '������', '2016', 'The Little Mermaid', 'girl');