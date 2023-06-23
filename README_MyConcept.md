# 개념정리
<br><br>
<h2>데이터베이스 : 데이터를 저장하는 공간</h2>
<h2>SQL : 중요하고도 방대한 데이터를 다루는데 사용되는 언어 데이터를 꺼내고 수정하고 삭제하기 위해서 SQL 사용</h2>

<h3><strong>[DB]DDL,DML,DCL - 데이터베이스 언어</strong></h3>
<p><strong>데이터베이스 언어란?</strong></p>
<br>
<p>데이터 베이스 언어는 데이터베이스를 구축하고 이용하기 위한 데이터베이스 시스템과의 통신 수단이다. DBMS를 통해 사용되며 기능과 사용 목적에 따라 DDL,DML,DCL로 구분된다.</p>

<h3>DDL(Data Definition Language) - 데이터 저장 언어</h3>
<p>DDL은 데이터베이스를 정의하는 언어이며 데이터를 생성, 수정 삭제하는 등의 데이터의 전체 골격을 결정하는 역할을 한다. 스키마, 도메인, 테이블, 뷰, 인덱스 등을 정의하거나 변경,삭제할 때 사용된다.</p>
<table>
  <tr>
    <th>종류</th>
    <th>역할</th>
      <tr>
        <td>CREATE</td>
        <td>데이터베이스,테이블생성</td>
      </tr>
      <tr>
        <td>ALTER</td>
        <td>테이블 수정</td>
      </tr>
      <tr>
        <td>DROP</td>
        <td>데이터베이스, 테이블삭제(테이블복구불가!)</td>
      </tr>
      <tr>
        <td>TRUNCATE</td>
        <td>테이블초기화(테이블복구불가!)</td>
      </tr>
  </tr>
</table>
<br><br>
<h3><strong>DML(Data Manipulation Language) - 데이터 조작 언어</strong></h3>
<p>DML은 **데이터베이스에 입력된 레코드**를 **조회**하거나 **수정,삭제** 등의 역할을 한다. 즉, 사용자로 하여금 데이터를 처리할 수 있게 하는 도구로서, 사용자와 DBMS간의 인터페이스를 제공한다.</p>
<table>
  <tr>
    <th>종류</th>
    <th>역할</th>
      <tr>
        <td>SELECT</td>
        <td>데이터 조회</td>
      </tr>
      <tr>
        <td>INSERT</td>
        <td>데이터 삽입</td>
      </tr>
      <tr>
        <td>UPDATE</td>
        <td>데이터 수정</td>
      </tr>
      <tr>
        <td>DELETE</td>
        <td>데이터 삭제</td>
      </tr>
  </tr>
</table>





<p>NOT NULL : 이 컬럼은 절대 빈 값일 수 없다라고 제한을 두는 것</p>
<p>PRIMARY KEY : 테이블내에서 중복 되어서는 안되는 데이터가 저장될 컬럼을 Primary Key로 정의한다.</p>