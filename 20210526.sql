
#부서번호 와 부서별 평균 급여 (반올림해서 소수첫째자리까지만)
SELECT deptno, round(avg(nvl(sal,0)),1)
FROM emp
GROUP BY deptno
ORDER BY deptno desc;

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

/*emp 테이블에서 부서번호와 급여가 2000 이상인 사원들의 부서별 평균 급여의 반올림 값을
평균 급여의 반올림 값으로 오름차순 정렬해서 출력*/
#이렇게 칼럼이 길어졌을 때 Alias 를 사용하면 깔끔.
SELECT deptno, ROUND(AVG(nvl(sal,0))) salavg
FROM emp 
WHERE sal >= 2000
GROUP BY deptno
ORDER BY salavg;

/*emp 테이블에서 각 부서별 같은 업무(job)를 하는 사람의 인원수를 구해서 부서번호, 업무(job), 인원
수를 부서번호에 대해서 오름차순 정렬해서 출력*/
SELECT deptno, job, COUNT(job)
FROM emp 
GROUP BY deptno,job
ORDER BY deptno;
#HAVING 
/*emp 테이블에서 부서번호와 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력. 단, 부서별 평균
급여가 2000 이상인 부서만 출력하세요. */
SELECT deptno, ROUND(AVG(nvl(sal,0))) salavg 
FROM emp 
WHERE sal >= 1000
GROUP BY deptno
HAVING salavg >= 2000;
#굳이 HAVING 을 안했어도 자바에서 처리가 가능하긴 하나. 이는 꼼수다.

#limit start=0, len : start인덱스 에서부터 len개
SELECT empno,ename 
FROM emp
ORDER BY empno DESC
LIMIT 150,5;
#JDBC에 복붙할 용도로 미리 여기서 시험해본다.
#구조 확인.
DESC member;
SELECT * FROM member;

INSERT INTO member(num,NAME,addr) 
	VALUES(5,'goku','용신네집');

UPDATE member SET NAME='트럼프' , addr = '중국'
WHERE num = 10;

DELETE FROM member
WHERE NAME = 'ohs';

DELETE FROM member 
WHERE addr= '용신네집';












