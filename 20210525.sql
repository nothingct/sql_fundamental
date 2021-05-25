kpcmembercreate table member(
	num int primary key,
	name varchar(50),
	addr varchar(50)
);


DESC member;
/*insert : 데이터 삽입 
구문 : insert into 테이블(칼럼리스트[생략시 모든 vqlue 입력]) values(값 리스트);
		칼럼 리스트와 값 리스트는 서로 매칭 해야 한다.
 */
INSERT INTO member(num,NAME,addr) VALUES(1,'오한승','서울');
INSERT INTO member(num,NAME) VALUES(2,'손정의');
INSERT INTO member VALUES(3,'스티브잡스','미국');

/*select : 데이터 조회/추출 
기본 구문 : select 칼럼리스트 from 테이블;
select from where groupby having orderby : select절은 이들 각각으로 개행해서 작성.
5      1    2      3       4      6      :실행 순서

*/
SELECT num,NAME,addr 
FROM member;

/*delete : 데이터 삭제 
기본 구문 : delete from member where 조건절; 
cf) 회원 탈퇴의 경우: 회사는 해당 정보를 삭제하는게 아니라 특정 칼럼에 1이면 회원, 0이면 비회원 이렇게 설정한다.
한 행을 지울 때는, 그 행의 유일한 값 인 primary key로 지정해주는 게 좋습니다.
*/

DELETE FROM member
WHERE num = 2;

SELECT num,NAME,addr FROM member;

/* update 
기본 구문 update 테이블 set 칼럼명 = 변경값,... 
			  where 조건절;
*/
UPDATE member 
SET NAME = '스티브잡수', addr='미쿡'
WHERE num=3; 

DESC emp;
SELECT * 
FROM emp;

SELECT *
FROM dept;
#정렬 공부.
#1.emp 테이블에서 사원번호, 사원이름 , 직업 출력
SELECT empno,ename,job
FROM emp;
#2 ""  사원번호 , 급여, 부서번호를 출력(단, 급여가 많은 순서대로 출력) 
SELECT empno, sal, deptno 
FROM emp 
ORDER BY sal DESC;
#3"" 사원번호 급여 입사일 출력( 급여 적은 순서대로 ) 
SELECT empno, sal, hiredate 
FROM emp 
ORDER BY sal;
#4"" 직업, 급여 ( 직업 오름차순,[단, 직업이 같으면 이 생략됨.]  급여 내림차순 ) 
SELECT job, sal 
FROM emp 
ORDER BY job, sal DESC;
#AS (별칭 ) : 별칭에 공백이 있는경우 " " 안에 넣어줘야함. 
#기본 구문 원래 칼럼멸 as "별칭" => 원래 칼럼명 "별칭"(as 생략 가능 ,공백 없을 경우 "" 생략가능)
SELECT empno 사원번호, ename 사원이름 
FROM emp;
#산술연산자
#emp 테이블에서 부서번호가 10번인 사람들의 급여와 10% 인상된 급여 같이 출력
SELECT sal, round(sal*1.1) increasedSal 
FROM emp
WHERE deptno = 10;
#비교연산자 
#급여 3000인 이상인 사원들의 모든 정보 출력[하되 어떠한 기준으로 정렬할지 를 항상 생각]
 SELECT * 
 FROM emp 
 WHERE sal>=3000;
 #order by sal;
 SELECT job 
 FROM emp;
 #부서번호 30번이 아닌 사람들의 이름과 부서번호를 출력 
 SELECT ename, deptno
 FROM emp 
 WHERE deptno <> 30;
#논리 연산자 . 
#부서번호 10 번이고 급여가 3000이상인 사람들의 이름과 급여를 출력 ( 기준은? ) 
SELECT ename, sal 
FROM emp
WHERE deptno = 10 AND sal >=3000;

#직업이 salesman이거나 manager 인 사원들의 사원번호 와 부서번호 출력(기준은?) 
SELECT empno , deptno
FROM emp 
WHERE job = 'SALESMAN' OR job = 'MANAGER'
ORDER BY deptno;

#OR => 성능 저하 하니까 AND 로 바꿔서 다시 
SELECT job 
FROM emp
ORDER BY job;

SELECT empno , deptno
FROM emp 
WHERE job <> 'ANALYST' and job <> 'CLERK' AND job <> 'PRESIDENT'
ORDER BY deptno;

#그럼 이건? 이것도 한번만 full scan?
SELECT empno , deptno
FROM emp 
WHERE NOT (job <> 'SALESMAN' AND job<>'MANAGER')
ORDER BY deptno;

#SQL 연산자 : in between like isnull isnotnull 

#부서번호 10번이거나 20번인 사원들의 이름과 부서번호 출력(기준은? )
SELECT ename , deptno
FROM emp
WHERE deptno IN (10,20)
ORDER BY deptno;

#IN 연산자도 OR 연산자랑 똑같음 => 성능 저하 => 되도록 바꿔 쓰는 걸 권고 =>and로 
SELECT ename, deptno 
FROM emp 
WHERE deptno <> 30 AND deptno <> 40 
order BY deptno;

#급여가 1000과 2000사이인 사원들의 사원번호 이름 급여 출력(기준은?)
SELECT empno,ename,sal 
FROM emp 
WHERE sal BETWEEN 1000 AND 2000
ORDER BY sal;
#and 연산자로도 가능하다.
SELECT empno,ename,sal 
FROM emp 
WHERE sal >= 1000 AND  sal <= 2000
ORDER BY sal;

#사람이름 'FORD' 와 'SCOTT'사이의 사원들의 사원번호 이름 출력 (기준은?)
SELECT empno, ename 
FROM emp 
WHERE ename BETWEEN 'FORD' AND 'SCOTT'
ORDER BY ename;

#사원이름이 'J'로 시작하는 사원들의 사원이름과 부서번호를 출력( 기준은 ? ) 
SELECT ename, deptno 
FROM emp 
WHERE ename LIKE 'J%'
ORDER BY ename;

#사원이름이 'J'를 포함하는  사원들의 사원이름과 부서번호를 출력( 기준은 ? ) 
SELECT ename, deptno 
FROM emp 
WHERE ename LIKE '%J%'
ORDER BY ename;

/*
SELECT ename 
FROM emp;
*/
# 사원 이름의 두번째 글자가 'A'인 사람의 이름 , 급여 , 입사일 을 출력
SELECT ename , sal , hiredate
FROM emp 
WHERE ename like '_A%'
ORDER BY ename;

# 사원 이름이 'ES'로 끝나는 사람의 이름 , 급여 , 입사일 을 출력
SELECT ename , sal , hiredate
FROM emp 
WHERE ename like '%ES'
ORDER BY ename;

SELECT hiredate
FROM emp 
ORDER BY hiredate;

#입사년도 81년인 사람들의 입사일 과 사원번호를 출력 
SELECT hiredate, empno 
FROM emp 
WHERE hiredate LIKE '1981%'
ORDER BY hiredate;

#커미션이 null인 사원의 사원이름과 커미션을 출력 
SELECT ename, comm 
FROM emp 
WHERE comm IS NULL
ORDER BY ename;

#커미션이 null이 아닌 사원의 사원이름과 커미션을 출력 
SELECT ename, comm 
FROM emp 
WHERE comm IS not NULL
ORDER BY ename;
	
#연결연산자concat
SELECT CONCAT(ename,'의 직업은 ',job,'입니다') 직원정보
FROM emp;

#단일행 함수 : 문자 함수
#chr(아스키 코드) : 해당 문자 반환  
SELECT chr(65);
#concat(칼럼명, 붙일 문자) : 문자열 연결함수 + concat(문자열,문자열,....): 문자열 합치기 
SELECT CONCAT(ename,'님') 존칭
FROM emp;

SELECT CONCAT('a','b','c','d','e','fghij');
#lower upper 는 잘 쓰진 않음 WHY? 자바에서 처리 가능.
#lower('문자열' ) : 모두 소문자로 
#upper('문자열' ) : 모두 대문자로 

#lpad 랑 rpad랑 쓸일이 꽤 있음. 주의할점 : 반환값이 문자열 (초록색) cf 숫자(파란색)
#lpad('문자열',전체 자리수 , '남는 자리를 채울 문자' ) : 왼쪽에 채운다. 
#rpad('문자열',전체 자리수 , '남는 자리를 채울 문자') : 오른쪽에 채운다.
SELECT empno 
FROM emp;
SELECT LPAD(empno,10,'0')
FROM emp;

SELECT RPAD('hi',10,'*');
#length():byte크기 기준 길이->한글 3byte, 영어 1byte
# 최대 한글 100자 들어가는 칼럼 은 varchar(300) 으로 해야 겠다.
# char_length(): 문자열 길이
SELECT CHAR_LENGTH('국어');
SELECT LENGTH('국어');

#left,right,substring <-- 애내도 굳이 sql에서 하기보다는 자바 단에서 처리하고 오는 경우가 많다. 
#left('문자열',num) :왼쪽에서 문자열 자르기 : 왼쪽에서부터 num번째 
SELECT LEFT('Catalog',3);
SELECT ename, LEFT(ename,3)
FROM emp;
#right('문자열',num) :오른쪽에서 문자열 자르기 : 오른쪽에서부터 num번째
SELECT RIGHT('hotdog',3);
SELECT ename, right(ename,3)
FROM emp;
#substring('문자열',from,len) : 문자열을 from번째 부터 len 개만큼 자르기 [자바는 0부터 애내는 1부터]
SELECT SUBSTRING('sister',1,3);
SELECT ename, SUBSTRING(ename,2,3)
from emp;

#format('처리할숫자', num ) :'처리할숫자'를 천(1000) 단위로 , 를 찍고, 소수 num번째 자리에서 반올림 반환값:문자열
SELECT FORMAT(134913894292432.124895989423,4);
#nvl(칼럼명, 값) : 해당 칼럼 null 이면 값으로 해당칼럼을 변환한다.
UPDATE emp SET comm=nvl(comm,0)
WHERE comm IS NULL;
SELECT * FROM emp;

#단일행 함수 : 숫자 함수 
#abs(num) : num의 절대값 
SELECT(ABS(-3.2));
#ceil(num) floor(num) :소수있는 num을 올림 /내림 정수로 변환
SELECT FLOOR(3.14);
SELECT ceil(3.14);
#round(실수 ,자릿수) : 자릿수+1 에서 반올림 
SELECT ROUND(3.141592, 2);
#mod(n1,n2) : n1%n2 나머지 
SELECT MOD(5,2);
#truncate(실수, 자릿수 ) : 숫자를 지정한 자릿수까지만 잘라서 보여줌 
SELECT TRUNCATE(3.141592,2);

#단일행 함수 : 날짜 함수 
#자료형 date : 날짜 datetime : 날짜시간
#curdate(), curtime(), now() : 현재 날짜| 현재 시간 | 현재 날짜와 시간
#그래서 now를 제일 많이 씀 why? insert 하실 때 현재 시스템 날짜 넣을 때 now를 넣으면 회원가입날짜 칼럼만들수 있음 
SELECT CURDATE(), CURTIME(), NOW();
#date_add,adddate(date,INTERVAL expr TYPE ):date를 INTERVEAL expr 만큼 더한다 (TYPE 기준) 
#date_sub,subdate(date,INTERVAL expr TYPE ):date를 INTERVAL expr만큼 뺀다 ( TYPE 기준)
SELECT ADDDATE(now(), INTERVAL 4 DAY);
#180일 동안 적용되는 서비스를 할 떄, 이 회원이 해당 서비스 적용기간인지 확인하고자 할 때 사용. 
SELECT NOW(), DATE_ADD(NOW() ,INTERVAL 180 DAY);
SELECT SUBDATE(NOW(), INTERVAL 30 DAY);
#DATEDIFF(날짜1,날짜2) , TIMESTAMP(단위,날짜1,날짜2)  : 날짜 1-날짜 2의 차이를 단위로 변환해줌
SELECT DATEDIFF('2021-05-29',CURDATE());
SELECT TIMESTAMPDIFF(DAY,'2021-04-29',CURDATE());
SELECT TIMESTAMPDIFF(HOUR,'2021-04-29',CURDATE());
SELECT TIMESTAMPDIFF(MINUTE,'2021-04-29',CURDATE());
SELECT TIMESTAMPDIFF(SECOND,'2021-04-29',CURDATE());
#==> 날짜 관련해서는 curdate() now() adddate() 이 정도 기억하시면 될 거 같습니다.
#단일행 함수 : 변환함수 : 날짜 -> 문자열
# month 의 m이랑 겹치니까 분은 minute 에서 i ,m은 못써 월에써서
# now()하고 date_format() 이 둘은 엄청 많이 쓴다. 
SELECT DATE_FORMAT(now(),'%Y-%m-%d %p %h:%i:%s %W');
SELECT hiredate, DATE_FORMAT(hiredate,'%Y/%m/%d %H:%i:%s')
FROM emp;
#단일행 함수 : 변환함수 : 숫자 문자열 -> 날짜
#CONVERT(COL_1, SIGNED) :문자열 COL_1 을 (음수 이면) SIGNED를 2번째 인자로 아니면 UNSIGNED로 해서 숫자로 변경
#==> WHEN USED??? : 다음과 같이 숫자랑 문자를 비교하면 => 문자를 숫자로 바꿔준다  
SELECT CONVERT('-1234', SIGNED) + 1234;
SELECT empno, ename 
FROM emp
WHERE empno < '7566'; #내부적으로 이 문자를 convert()를 통해 숫자로 바꿔줌.

#STR_TO_DATE('날짜에 대응되는 문자’,’날짜 포맷’) :문자열=>날짜 포맷으로
SELECT STR_TO_DATE('2021-05-25', '%Y-%m-%d');#date type인 밤색으로 나오는 것을 확인할 수 있다.  
#쓸일은 거의 없음 근데 말씀드리는 이유가 뭐냐면 내부적으로 문자열 = > DATE 로 바꿔줌 .
#where절 등에서 조건으로 문자로 날짜를 비교할 때, 삽입할 때 알아서 날짜로 바꿔서 비교를 해준다.
DESC emp;
INSERT INTO emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES ('9000','OH','SALESMAN','7698','2021-05-25','3000','0','10');#이따구로 놔도 다 변환해줌 알아서

#복수행(그룹) 함수 
#count
SELECT COUNT(MGR)
FROM emp;

SELECT COUNT(*)  
FROM emp;

SELECT COUNT(*), COUNT(empno), COUNT(ename), COUNT(comm)
FROM emp;
#sum
SELECT SUM(sal)
FROM emp;

SELECT SUM(comm)
FROM emp;
#avg : null이 들어가 있을 경우 평균을 구할 때는 조심해야 한다. 테이블을 조사하지 않았다면 
#안전빵으로 avg(nlv(칼럼명,0))으로 구해줘야 한다.
SELECT round(AVG(comm),1),round(AVG(sal),1) ,ROUND(SUM(sal)/COUNT(*),1)
FROM emp;
#위와 밑이 동일해야 제대로 된 평균을 구한 것이다.
SELECT SUM(comm)/COUNT(*) , AVG(comm)
FROM emp;
#max
SELECT MAX(sal)
FROM emp;

#min
SELECT MIN(sal)
FROM emp;
#GROUP BY
#부서번호 와 부서별 급여 총합 
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
ORDER BY SUM(sal);
#ename 을 select에 넣는 순간 말이 안되는 sql문 : 그룹핑이 안됨
SELECT ename,deptno, SUM(sal)
FROM emp
GROUP BY deptno
ORDER BY SUM(sal);
#다만 각 부서에 몇명이 있는지는 그루핑으로 표현할 수 있음.
SELECT deptno, SUM(sal) ,COUNT(ename), nvl(SUM(comm),0)
FROM emp
GROUP BY deptno
ORDER BY deptno;

#부서번호 와 부서별 평균 급여 
SELECT deptno, avg(nvl(sal,0))
FROM emp
GROUP BY deptno
ORDER BY avg(sal);
#부서번호 와 부서별 평균 급여 (반올림해서 소수첫째자리까지만)
SELECT deptno, round(avg(nvl(sal,0)),1)
FROM emp
GROUP BY deptno
ORDER BY avg(sal);

#직업과 직업별 최대 급여 
SELECT job, MAX(nvl(sal,0))
FROM emp 
GROUP BY job
ORDER BY job;
# 급여가 1000 이상인 사원들의 부서번호와 부서별 평균 급여의 반올림 값을 부서번호로 내림차순 정렬해서 출력.
SELECT deptno , ROUND(AVG(nvl(sal,0))) 
FROM emp 
WHERE sal >= 1000
GROUP BY deptno
order BY deptno DESC;

#HAVING 































