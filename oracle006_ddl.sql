DROP TABLE emp01;
--테이블 구조를 복사
CREATE TABLE emp01
AS
SELECT first_name, salary
FROM employees
WHERE 1=0;

--테이블의 구조
DESC emp01
SELECT * FROM emp01;

/*
테이블의 삽입
INSERT INTO table_name(column_name1, column_name2)
VALUES('valuel', value2);
*/
INSERT INTO emp01(first_name, salary)
VALUES('candy',5000);

SELECT * FROM emp01;
--테이블 모든 컬럼에 데이터를 삽입할떄는 컬렴명을 생략할수 있다.
INSERT INTO emp01
VALUES('Steven', 4000);

SELECT * FROM emp01;

--묵시적 NULL 삽입방법
INSERT INTO emp01(first_name)
VALUES('Lex');

SELECT * FROM emp01;

--명시적 NULL 삽입방법
INSERT INTO emp01
VALUES('Paran', null);

SELECT * FROM emp01;

/*
테이블 내용을 수정
UPDATE table_name
SET column_name=value, column_name=value
WHERE column_name = value;
*/
--emp01 테이블 first_name컬럼의 값이 'candy' 일때
--salary 컬럼의 값을 8000으로 수정

UPDATE emp01
SET salary = 8000
WHERE first_name='candy'; /* salary값이 5000에서 8000으로 수정 */

/* 
테이블의 내용을 삭제
DELETE FROM table_name
WHERE colum_name = value;
*/

--emp01 테이블에서 first_name 컬럼의 값이 'candy'일때 삭제하세요.
DELETE FROM emp01
WHERE first_name = 'candy';

SELECT * FROM emp01;

/*======================================
트랜잭션(Transaction)
1 트랜잭션 정의
  -한번에 수행되어야 할 데이터베이스의 일련의 Read와
   Write 연산을 수행하는 단위
  -하나의 논리적 기능을 수행하기 위한 작업의 단위로서
  데이터베이스의 일관된 상태를 또 다른 일관된 상태로
  변환시킴
  
  트랜잭션시작-> 수정->삭제->삽입 -> 트랜잭션종료
  하나의 작업이 시작해서 정상적으로 종료될때까지의 과정을 말한다.
  (논리적인 작업단위)
  
  은행(ATM)->기계 카드삽입-> 기계가 카드를 읽음->
  인출금액 입력-> 비밀번호 입력-> 기계에서 출금액 처리
  -> 출금금액 제공-> 카드제공
  
  <트랜잭션 시작>
  -데이터베이스에 처음 접속했을 때
  -하나 또는 여러 개의 DML문이 실행된후 commit 또는 rollback
   문이 실행된 직후
  
   <트랜잭션 종료>
  - commit 또는 rollback문이 실행될때
  - DDL 또는 DCL문이 실행될 때
  - 정상적으로 데이터베이스를 종료할때
  - 비정상적으로 데이터베이스를 종료할때
  
2 트랜잭션 안전성 확보를 위한 ACID
  1) ACID정의 
     -데이터베이스에서 논리적인 작업단위인 트랜잭션이
       안전하게 수행되는 것을 보장하는 특성집합
  2) ACID의 필요성
     -다중 사용자 환경 대응 :동일데이터-다중작업환경에서의
          데이터 처리 정확성 보장
     -안전한 트랜잭션 수행을 통한 데이터베이스 무결성 유지
  3) 트랜잭성 구성요소   
    Atomicity(원자성):
     -트랜잭션은 한 개 이상의 동작을 논리적으로 한 개의
      작업단위(single unit of work)로서 분해가
      불가능한 최소의 단위
     -연산 전체가 성공적으로 처리되거나 또는 한 가지라도
      실패할 경우 전체가 취소되어 무결성을 보장
      (All or Nothing)
    Consistency(일관성):
    -트랜잭션이 실행을 성공적으로 완료하면 언제나 모순 없이
     일관성 있는 데이터베이스 상태를 보존함
    - 테이블의 데이타는 갱신되고 그에 따른 인덱스는 갱신되지 않는 등의 부정합이 있어선 않된다.
    Isolation(고립성,독립성):
    -트랜잭션이 실행 중에 생성하는 연산의 중간 결과를
     다른 트랜잭션이 접근할 수 없음
   -커밋된 트랜잭션은 장애가 발생해도 데이타가 복구되여야 한다는 특성.
   Durability(영속성,지속성,내구성):
    -성공이 완료된 트랜잭션의 결과를 영구적으로 데이터베이스에
     저장됨
========================================================================================*/
/*자동커밋 설정 확인(SQL Developer)
도구>환경설정>데이터베이스>객체뷰어> 행변경시 사후편집, 자동커밋 설정 체크 해제 */

SELECT * FROM emp01;
SELECT * FROM hr.emp01;
SELECT * FROM user_tables;
SELECT table_name FROM user_tables
WHERE table_name = 'EMP01';

COMMIT;
--테이블에 컬럼을 추가한다.
ALTER TABLE student
ADD loc varchar2(50);

/*
describe                              descending
DESC table_nmae : 테이블 구조 확인, DESC column_name : 내림차순
*/

DESC student;
SELECT*FROM student;


-- 저장된 데이터의 크기로 줄일수는 있다.
ALTER TABLE student
MODIFY name varchar2(9);

--크기를 늘리는 것은 상관없다.
ALTER TABLE student
MODIFY name varchar2(30);
DESC student;

--테이블의 컬럼명을 수정한다.
ALTER TABLE student
RENAME COLUMN avg TO jumsu;
DESC student;

--테이블명을 변경한다.
ALTER TABLE student
RENAME TO members;
-- ORA-04043: stduent 객체가 존재하지 않습니다.
DESC stduent;

--정상수행
DESC members;
/*
DELETE : 테이블에 저장된 데이터 모두를 삭제한다.(AUTO COMMIT이 안댐)
TRUNCATE : 테이블에 저장된 데이터 모두를 삭제한다.
DROP : 테이블 자체를 삭제한다.
*/
COMMIT;

/*
무결성 제약조건
  무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면
  제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
  
  무결성 제약조건 5종류: not null, unique, primary key, foreign key, check
   not null : null을 허용하지 않는다.
   unique : 중복된 값을 허용하지 않는다. 항상 유일한 값이다.
   primary key : not null + unique
   foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
   check : 저장 가능한 데이터의 값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
   
   무결정 제약조건 2가지 레벨: 컬럼레벨, 테이블 레벨
   
   
   컬럼레벨 설정
   CREATE TABLE emp06(
       id varchar2(10)  constraint  emp06_id_pk  primary key,
       name varchar2(20) constraint emp06_name_nn not null,
       age number(3) constraint emp06_age_ck check(age between 20 and 50),
       gen char(1) constraint emp06_gen_ck check(gen in('m','w'))
   );
   
   테이블 레벨 설정
   CREATE TABLE emp07(
     id varchar2(10),
     name varchar2(20) constraint emp07_name_nn not null,
     age number(3),
     gen char(1),
     constraint  emp07_id_pk  primary key(id),
     constraint emp07_age_ck check(age between 20 and 50),
     constraint emp07_gen_ck check(gen in('m','w'))
   );
*/
SELECT * FROM user_constraints;

 CREATE TABLE emp06(
       id varchar2(10)  constraint  emp06_id_pk  primary key,
       name varchar2(20) constraint emp06_name_nn not null,
       age number(3) constraint emp06_age_ck check(age between 20 and 50),
       gen char(1) constraint emp06_gen_ck check(gen in('m','w'))
   );
   
   
   SELECT * FROM user_constraints
   WHERE constraint_name LIKE '%EMP06%';
   
   --ORA-02290: check constraint (HR.EMP06_AGE_CK) violated
   INSERT INTO emp06(id, name, age, gen)
   VALUES('kim','김고수', 15, 'm');
   
   --ORA-02290: check constraint (HR.EMP06_GEN_CK) violated
   INSERT INTO emp06(id, name, age, gen)
   VALUES('kim','김고수', 25, 'p');
   
   --정상 삽입
   INSERT INTO emp06(id, name, age, gen)
   VALUES('kim','김고수', 25, 'm');
   
   --ORA-00001: unique constraint (HR.EMP06_ID_PK) violated
    INSERT INTO emp06(id, name, age, gen)
   VALUES('kim','김고수', 25, 'm');
   
   --ORA-01400: cannot insert NULL into ("HR"."EMP06"."ID")
   INSERT INTO emp06(id, name, age, gen)
   VALUES(null,'김고수', 25, 'm');
      
   DROP TABLE emp06;
   
   SELECT * FROM user_constraints
   WHERE constraint_name LIKE '%EMP06%';


  --primary key 와 foreign key
  
  CREATE TABLE dept01(
    deptno number(2) constraint dept01_deptno_pk primary key,
    dname varchar2(20)
  );
  
  INSERT INTO dept01(deptno, dname)
  VALUES(10, 'accounting');
  
  SELECT * FROM dept01;
  
  INSERT INTO dept01(deptno, dname)
  VALUES(20, 'sales');
  
  SELECT  * FROM dept01;
  
  INSERT INTO dept01(deptno, dname)
  VALUES(30, 'research');
  
  SELECT * FROM dept01;
  
  CREATE TABLE loc01(
     locno number(2),
     locname varchar2(20),
     constraint loc01_locno_pk primary key(locno)
  );
  
  INSERT INTO loc01(locno, locname)
  VALUES(11, 'seoul');
  
  SELECT * FROM loc01;
  
  INSERT INTO loc01(locno, locname)
  VALUES(12, 'jeju');
  
  SELECT * FROM loc01;
  
  INSERT INTO loc01(locno, locname)
  VALUES(13, 'busan');
  
  SELECT * FROM loc01;
  
  CREATE TABLE emp08(
     empno number(2) constraint emp08_empno_pk primary key,
     deptno number(2) constraint emp08_deptno_fk references dept01(deptno),
     locno number(2),
     constraint emp08_locno_fk foreign key(locno) references loc01(locno)     
  );
  
  SELECT * FROM emp08;
  
  --정상 삽입
  INSERT INTO emp08(empno, deptno, locno)
  VALUES(1, 10, 11);
  
  SELECT * FROM emp08;
  
  
  INSERT INTO emp08(empno, deptno, locno)
  VALUES(2, 20, 12);

  SELECT * FROM emp08;
  
  
  INSERT INTO emp08(empno, deptno, locno)
  VALUES(3, null, null);
  
  SELECT * FROM emp08;
  
  --ORA-02291: integrity constraint (HR.EMP08_DEPTNO_FK) violated - parent key not found
  INSERT INTO emp08(empno, deptno, locno)
  VALUES(4, 40, 11);
  
  --ORA-02291: integrity constraint (HR.EMP08_LOCNO_FK) violated - parent key not found
 INSERT INTO emp08(empno, deptno, locno)
  VALUES(5, 30, 14);
  
  --emp08테이블의  deptno컬럼에서 30을 참조하지 않기 때문에 이상없이 삭제가 가능하다.
  DELETE FROM dept01
  WHERE deptno=30;
  
  SELECT * FROM dept01;
  
  SELECT * FROM emp08;
  
  --ORA-02292: integrity constraint (HR.EMP08_DEPTNO_FK) violated - child record found
  DELETE FROM dept01
  WHERE deptno=20;
  
  /*
    다른 테이블에서 현재 테이블을 참조해서 사용하고 있을 때는
    제약조건을 제거한 후 현재 테이블의 데이터를 삭제한다.
  */
  
  SELECT * FROM user_constraints
  WHERE constraint_name LIKE '%EMP08%';
  
  ALTER TABLE emp08
   DROP CONSTRAINT emp08_deptno_fk; 
   
   DELETE FROM dept01
   WHERE deptno=20;
   
   SELECT * FROM dept01;
   
   /*
   부모키가    
   */
   --삽입
   INSERT INTO dept01
   VALUES(20, 'sales');
   
   --cascade 설정
   ALTER TABLE emp08
   ADD constraint emp08_deptno_fk foreign key(deptno) references dept01(deptno) ON DELETE CASCADE;
   
   SELECT * FROM dept01;
   SELECT * FROM emp08;

DELETE FROM dept01
WHERE deptno=10;

SELECT * FROM dept01;
SELECT * FROM emp08;

