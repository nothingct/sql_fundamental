SELECT * FROM emp;
DESC emp;
#jdbc -empDAO,DTO용 insert
INSERT INTO emp(empno,ename,job,mgr,hiredate,sal,comm)
VALUES(9010,'KIM','MANAGER','7839',CURDATE(),50000,40000);
#jdbc -empDAO,DTO용 update
UPDATE emp
SET ename='KOM',job='MANAGER1',mgr=1212, hiredate=CURDATE(),sal =50001 , comm= 40001, deptno = 40
WHERE empno = 9003; 
#jdbc -empDAO,DTO용 delete
DELETE FROM emp 
WHERE empno = 9003;
#jdbc -empDAO,DTO용 select
Desc dept;
SELECT empno,ename,dname
FROM emp E,dept D
WHERE D.DEPTNO = E.DEPTNO;

SELECT ename, empno , E.deptno, dname 
FROM emp E inner join dept D
USING(deptno);

SELECT ename, dname
FROM emp E , dept D 
WHERE D.DEPTNO = E.DEPTNO 
	AND E.sal BETWEEN 3000 AND 5000;

SELECT ename, hiredate, E.deptno, dname
FROM emp as E , dept as D 
WHERE D.deptno= E.deptno AND
      dname ='ACCOUNTING';

/*커미션이 null 이 아닌 사원의 이름, 입사일, 부서명을 출력. 
*/
SELECT ename ,hiredate,dname
FROM emp E, dept D
WHERE D.DEPTNO = E.DEPTNO AND E.COMM IS NOT NULL;

/*부서명이 'ACCOUNTNG' 인 사원의 이름, 입사일, 부서번호, 부서명을 출력.*/
SELECT ename, hiredate,E.deptno,dname 
FROM emp E , dept D
WHERE D.DEPTNO = E.DEPTNO AND dname ='ACCOUNTING';

SELECT * FROM emp;

/*사원번호,부서번호,부서명을 출력하세요 단, 사원이 근무하지 않는 부서명도 같이 출력해보세요.*/
SELECT empno,E.DEPTNO,dname,loc
FROM emp E LEFT JOIN dept D
ON D.DEPTNO = E.DEPTNO;

#1. emp 테이블과 dept 테이블을 조인하여 부서번호, 부서명, 이름, 급여를 출력. 
SELECT E.DEPTNO , DNAME, ENAME, SAL
FROM emp E ,dept D
WHERE D.DEPTNO=E.DEPTNO;
#2. 사원의 이름이 'ALLEN' 인 사원의 이름과 부서명을 출력.  
SELECT ENAME , DNAME
FROM emp E , dept D
WHERE D.DEPTNO=E.DEPTNO AND ENAME='ALLEN';

#3. 모든 사원의 이름, 부서번호, 부서명, 급여를 출력.단, emp 테이블에 없는 부서도 출력해보세요.
SELECT ENAME, E.DEPTNO, DNAME, SAL
FROM emp E LEFT JOIN dept D
ON D.DEPTNO = E.DEPTNO;
#등급이 여기 있음
#급여 등급 정보는 salgrade 테이블에 저장되어 있다. 
#회사정책에 따라 등급이 바뀔 수 있기 때문에 등급테이블은 회사마다 가지고있다.
#정책에 따라 lowsal highsal 바꾼 후 조인 하는데 거의 5와 비슷한방식으로 SQL문을 실행한다.
#근데 그러면 엄청난 FULL SCAN을 해야 한다..
DESC salgrade;
SELECT * from salgrade;
#5. 사원의 이름과 급여, 급여의 등급을 출력.
# ==> 두 테이블 간의 조인컬럼이 없어도 조인을 하는 경우. (효율적이지는 않음 )
SELECT ename, sal, grade
FROM emp E, salgrade S
WHERE sal BETWEEN losal AND hisal
ORDER BY grade;

#6.사원의 이름과, 부서명, 급여의 등급을 출력.
SELECT ename, dname, grade
FROM emp E, dept D,salgrade S
WHERE D.deptno = E.deptno and
	sal BETWEEN losal AND hisal
ORDER BY grade;

create table member2(
	num int primary key,
	name varchar(50),
	addr varchar(50)
);

INSERT INTO member2(num) VALUES(1);
INSERT INTO member2(num) VALUES(2);
INSERT INTO member2(num) VALUES(3);
INSERT INTO member2(num) VALUES(4);
SELECT SUM(nvl(NAME,0)) FROM member2;

SELECT D.DEPTNO, E.DEPTNO, COUNT(empno)
FROM dept D LEFT JOIN emp E
on D.DEPTNO = E.DEPTNO
GROUP BY D.DEPTNO
ORDER BY D.DEPTNO;

SELECT empno , ename 
FROM emp 
WHERE empno IN (SELECT empno FROM emp WHERE  empno BETWEEN 8000 AND 10000)
ORDER BY empno;
#'ALLEN' 과 같은 부서에서 근무하는 사원의 이름과 부서의 번호를 출력. 
SELECT ename, deptno
FROM emp 
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN');
DESC emp;
#'ALLEN' 과 동일한 직책(job) 을 가진 사원의 사번과 이름, 직책을 출력
SELECT empno , ename, job 
FROM emp 
WHERE job = (SELECT job FROM emp WHERE eNAME ='ALLEN');

#'ALLEN' 의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 출력. 
SELECT ename,sal 
FROM emp 
WHERE sal >= ( SELECT sal FROM emp WHERE ename = 'ALLEN');

#'DALLAS' 에서 근무하는 사원의 이름, 부서번호를 출력. 
SELECT ename, deptno
FROM emp 
WHERE deptno = (SELECT deptno FROM dept WHERE loc='DALLAS');

#'SALES' 부서에서 근무하는 모든 사원의 이름과 급여를 출력. 
SELECT ename, sal
FROM emp 
WHERE deptno = (SELECT deptno FROM dept WHERE dname='SALES');

#자신의 직속 상관이 'KING' 인 사원의 이름과 급여를 출력
SELECT ename , sal 
FROM emp 
WHERE mgr=(SELECT empno FROM emp WHERE ename = 'KING');

#급여를 3000 이상받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의 
#이름과 급여, 부서번호를 출력. 

SELECT ename,sal,deptno 
FROM emp 
WHERE deptno IN (SELECT deptno FROM emp WHERE sal >= 3000)
ORDER BY deptno;

#IN 연산자를 이용하여 부서별로 가장 급여를 많이 받는 사원의 사원번호, 급여, 부서번호를 출력
SELECT empno, max(sal) ,deptno 
FROM emp
WHERE deptno IN(SELECT deptno FROM emp)
GROUP BY deptno;

#직책이 MANAGER 인 사원이 속한 부서의 부서번호와 부서명과 부서의 위치를 출력
SELECT deptno , dname, loc 
FROM dept 
WHERE deptno IN (SELECT deptno FROM emp WHERE job ='MANAGER');

#직책이 'SALESMAN' 보다 급여를 많이 받는 사원들의 이름과 급여를 출력 (ANY 연산자 이용) 
SELECT ename , sal 
FROM emp 
WHERE sal > ANY(SELECT sal from emp WHERE job = 'SALESMAN')
ORDER BY sal;

SELECT ename,dname
FROM emp INNER JOIN dept
ON dept.DEPTNO = emp.DEPTNO
UNION 
SELECT ename,dname 
FROM emp LEFT JOIN dept
ON dept.DEPTNO = emp.DEPTNO
UNION 
SELECT ename,dname
FROM emp NATURAL JOIN dept;

CREATE TABLE TAB1(COL1 VARCHAR(100), COL2 INT);
CREATE TABLE TAB2(COL1 VARCHAR(100), COL2 INT);


INSERT INTo TAB2 VALUES('A02',20);
INSERT INTo TAB2 VALUES('A03',30);
INSERT INTo TAB2(COL2) VALUES(40);
INSERT INTo TAB2(COL2) VALUES(40);

SELECT col1,col2
FROM tab1
WHERE nvl(col1,'x')<>'A01';
#기출 30회 11번
SELECT * FROM tab1;
SELECT col1, col2
FROM tab1 
WHERE col1 > 0;
#start transaction ~commit | rollback
#start transaction : Console 에서 치고 입력한 후 
SELECT * FROM member;
#치면 안들어가 있음 ( console에는 들어가 있음) 



