# 데이터베이스구현_서술형문제_정리
<br><br>
<h2>1.DBMS(Data Base Management System)에 대해 서술하시오.</h2>
<p>데이터베이스를 '데이터의 집합'이라고 정의한다면 이런 <strong>데이터베이스를 관리하고 운영하는 소프트웨어를 <br>DBMS(Database Management System)</strong>라고 합니다. 다양한 데이터가 저장되어 있는 데이터베이스는 여러 명의 사용자나 응용 프로그램과 공유 <br>하고 동시에 접근이 가능해야 합니다.</p>
<img src="images/database_01.png" alt="">
<br><br>
<h2>2.데이터베이스 관리자 계정과 사용자 계정에 대해 서술하시오.</h2>
<h3>데이터 베이스 사용자 계정</h3>
<p>데이터 베이스의 생성 및 관리, 데이터의 삽입,수정,변경 및 삭제를 수행하는 데이터베이스 계정을 의미한다. DBMS 소프트웨어의 설치 및 관리에 사용할 계정을 의미하며 보통 설치 계정과 일반적인 운영 계정을 분리할 궛을 권장한다.</p>
<ul>
  <li><strong>관리자 계정(Administrator)</strong></li>
  <li><strong>DBMS 설치 계정(Administrator)</strong></li>
  <li><strong>일반 계정(End user)</strong></li>
</ul>
<br>
<h3>관리자 계정(Administrator)</h3>
<ul>
  <li>데이터베이스의 생성과 관리를 담당하는 슈퍼 유저(Super User)계정이며, 정의, 생성, 삭제 등의 작업이 가능합니다.</li>
  <li>오라클 데이터베이스 관리자 계정인 SYS와 SYSTEM 계정이 자동으로 생성되어 있다. MySQL 데이터베이스인 경우에는 관리자 계정인 root가 기본적으로 생성된다.</li>
  <li>오브젝트(Object)의 생성, 변경, 삭제 등의 작업이 가능하다.</li>
  <li>데이터베이스에 대한 모든 권한과 책임을 가지는 계정입니다.</li>
</ul>
<h3>DBMS 설치 계정(Administrator)</h3>
<ul>
  <li>DBMS 소프트웨어의 소유자가 되며, 사용자 계정과 그룹을 가집니다</li>
  <li>DBMS 제품군에 따라 계정을 분리합니다.</li>
  <li>설치된 DBMS 백업은 이 계정으로 작업해야 합니다.</li>
</ul>
<h3>일반 계정(End user)</h3>
<ul>
  <li>데이터베이스에 대하여 질의(Query), 갱신, 보고서 작성 등의 작업을 수행할 수 있는 계정</li>
  <li>일반 계정은 업무에 필요한 최소한의 권한만 가지는 것을 원칙으로 합니다.</li>
</ul>
<br>
<h4>SYS 계정</h4>
<p>데이터베이스내의 모든 권한을 갖는 <u>최상위 레벨의 사용자</u></p>
<h4>SYSTEM 계정</h4>
<p><u>1) SYS 사용자로부터 "DBA권한"을 받은 사용자</u></p>
<p>2) 새로운 사용자를 추가, 변경 삭제할 수 있다.</p>
<p>3) 사용자별 공간할당, 패스워드관리, 세션관리 등을 할 수 있다.</p>
<p>4) 데이터베이스 오브젝트(테이블,뷰,트리거)는 "사용자별로" 생성된다.</p>
<p>5) 데이터베이스 오브젝트를 생성한 사용자를 그 오브젝트의 소유자(owner)라 한다.</p>
<h4>[사용자 생성]</h4>
<p>dba권한을 가진 사용자만 가능하다.</p>
<p>형식 ) CREATE USER 사용자ID IDENTIFIED BY 패스워드</p>
<h4>[사용자 변경]</h4>
<p><strong>패스워드 변경</strong></p>
<p>ALTER USER 사용자명 IDENTIFIED BY 바꿀비밀번호</p>
<h2>3.제약조건 중 NOT NULL, UNIQUE 제약조건에 대해 서술하시오.</h2>
<h2>4.제약조건 중 PRIMARY KEY, FOREIGN KEY, CHECK 에 대하여 서술하시오.</h2>
<h2>5.데이터 오브젝트를 정의하기 위한 DDL(Data Definition Language)에 대해 서술하시오.</h2>
<h2>6.외래키 제약조건 설정 시 사용하는 ON DELETE CASCADE, ON DELETE SET NULL 옵션에 대해 서술하시오.</h2>
<h2>7.오라클 계정의 권한 설정 ROLE중 CONNECT, RESOURCE에 대해 서술하시오.</h2>















