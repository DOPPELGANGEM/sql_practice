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

<strong>DDL(Data Definition Language) 제약조건</strong>
<p>제약 조건(CONSTRAINTS) : 제약 조건이란 테이블 작성 시 각 컬럼에 기록될 데이터에 대해 제약조건을 설정할 수 있는데 이는 데이터 무결성 보장을주 목적으로 한다. 입력 데이터에 문제가 없는지에 대한 검사와 데이터의 수정/삭제 가능 여부 검사 등을 위해 사용한다.</p>
<p>제약조건에는 NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK가 있다.</p>
<strong>제약조건 정리</strong>
<p>NOT NULL : NOT NULL이란 데이터에 NULL을 허용하지 않는다.  해당 컬럼에 반드시 값이 기록되어야 하는 경우에 사용하고 특정 컬럼에 값을 저장하거나 수정할 때 NULL 값을 허용하지 않도록 컬럼 레벨에서 제한한다</p>
<p>UNIQUE : UNIQUE란 중복된 값을 허용하지 않는다. <br>
  컬럼 입력 값에 대해 중복을 제한하는 제약조건으로 컬럼 레벨과 테이블 레벨에 설정이 가능하다.</p>
<p>PRIMARY KEY : PRIMARY KEY란 NULL과 중복 값을 허용하지 않음(컬럼의 고유 식별자로 사용하기 위해 사용한다.)<br> 테이블에서 한 행의 정보를 구분하기 위한 고유 식별자(Identifier)의 역할을 한다.<br> NOT NULL의 의미와 UNIQUE의 의미를 둘 다 가지고 있으며 한 테이블 당 하나만 설정 가능하다.<br> 컬럼 레벨과 테이블 레벨 둘 다 지정이 가능하다.</p>
<p>FOREIGN KEY : FOREIGN KEY란 참조되는 테이블의 컬럼의 값이 존재하면 허용한다. <br>
참조 무결성을 위한 제약조건으로 참조된 다른 테이블이 제공한 값만 사용하도록 제한을 거는 제약조건이다. <br>
참조되는 컬럼과 참조된 컬럼을 통해 테이블 간에 관계가 형성 되는데 참조되는 값은 제공되는 값 외에 NULL을 사용 가능하고 참조할 테이블의 참조할 컬럼명을 생략할 경우 PRIMARY KEY로 설정된 컬럼이 자동으로 참조할 컬럼이 된다.<br>
****** 주의할 점은 외래키가 설정되면, 자식 테이블 안의 부모 테이블 안에 언제나 존재해야함
</p>
<p>CHECK : CHECK란 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만 허용한다. <br> 해당 컬럼에 입력 되거나 수정되는 값을 체크하여 설정된 값 이외의 값이면 에러 발생시킨다. <br> 비교 연산자를 이용하여 조건을 설정하며 비교 값을 리터럴만 사용 가능하고 변하는 값이나 함수 사용은 불가능하다.</p>

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
    <tr>
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