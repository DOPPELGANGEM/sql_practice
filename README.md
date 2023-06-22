# sql_practice 강의자료 실습 개념
<br><br>
<h1>[SQL] DDL, DML, DCL 이란?</h1>
<h2>DDL(Data Definition Language) - 데이터 정의어</h2>
<p>데이터베이스를 정의하는 언어이며, 데이터를 생성, 수정, 삭제하는 등의 데이터의 전체의 골격을 결정하는 역할을 하는 언어 이다.</p>
<table border="1">
  <th>종류</th>
  <th>역할</th>
    <tr>
      <td>CREATE</td>
      <td>데이터베이스, 테이블등을 생성하는 역할을 합니다.</td>
    </tr>
    <tr>
      <td>ALTER</td>
      <td>테이블을 수정하는 역할을 합니다.</td>
    </tr>
    <tr>
      <td>DROP</td>
      <td>데이터베이스, 테이블을 삭제하는 역할을 합니다.</td>
    </tr>
    <tr>
      <td>TRUNCATE</td>
      <td>테이블을 초기화 시키는 역할을 합니다.</td>
    </tr>
</table>

<h2>DML(Data Manipulation Language ) - 데이터 조작어</h2>
<p>데이터베이스에 등록된 레코드를 조회,수정,삭제하는 등의 역할을 하는 언어이다.</p>
<table border="1">
  <th>종류</th>
  <th>역할</th>
    <tr>
      <td>SELECT</td>
      <td>데이터를 조회하는 역할을합니다.</td>
    </tr>
    <tr>
      <td>INSERT</td>
      <td>데이터를 삽입하는 역할을 합니다.</td>
    </tr>
    <tr>
      <td>UPDATE</td>
      <td>데이터를 수정하는 역할을 합니다.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>데이터를 삭제하는 역할을 합니다.</td>
    </tr>
</table>


<h2>DCL(Data Control Language ) - 데이터 제어어</h2>
<p>데이버테이스에 접근하거나 객체에 권한을 주는 등의 역할을 하는 언어이다.</p>
<table border="1">
  <th>종류</th>
  <th>역할</th>
    <tr style="background-color:#fff;">
      <td>GRANT</td>
      <td>일반사용자(계정)에게 권한을 부여</td>
    </tr>
    <tr>
      <td>REVOKE</td>
      <td>부여된 권한을 취소</td>
    </tr>
    <tr>
      <td>COMMIT</td>
      <td>여러 명령어를 사용할 경우 중간 저장(완료)</td>
    </tr>
    <tr>
      <td>ROLLBACK</td>
      <td>잘못된 명령어 실행을 취소(복구)</td>
    </tr>
</table>