SELECT first_name
FROM employees;

-- 주석처리
/*
컬럼명, 테이블명에 별칭(alias)을 지정할 수 있다.
별칭(alias)에 공백이 있을때는 ""(쌍따움표)를 지정한다.
*/


SELECT * FROM employees;
SELECT * FROM tab;

SELECT salary, salary*10 AS bonus
FROM employees;
-- King님의 급여는 24000입니다.
SELECT last_name ||'님의 급여는' || salary || '입니다' AS name
FROM employees;

-- 중복 제거 = DISTINCT
SELECT DISTINCT first_name
FROM employees;

--SELECT 입력순서
SELECT column_name1, column_name2
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
ORDER BY column_name ASC, column_name DESC;

--select 해석 순서

FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
SELECT column_name1, column_name2
ORDER BY column_name ASC, column_name DESC;

--employees테이블에서 salary이 3000미만 일떄의
--first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE salary < 3000;
--employees테이블에서 first_name컬럼의 값이 'david'일때의
--first_name, salary을 출력하라. =
SELECT first_name, salary
FROM employees
WHERE first_name = 'David';

--employees 테이블에서 first_name컬럼의 값이 'David' 아닐떄의
--first_name, salary를 출력하라  !=,<>
SELECT first_name, salary
FROM employees
WHERE first_name != 'David';

--&&(and), ||(or)
--employees테이블에서 salary이 3000, 9000, 17000일때
--first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date,salary
FROM employees
WHERE salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date,salary
FROM employees
WHERE salary IN(3000,9000,17000);

--employees 테이블에서 salary이 3000부터 5000까지 일떄의
--first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date,salary
FROM employees
WHERE salary >= 3000 AND salary <= 5000;

--employees 테이블에서 job_id가 'it_prog'이 아닐때
--first_name, email, job_id을 출력하라
SELECT first_name, hire_date,salary, job_id
FROM employees
WHERE job_id != 'IT_PROG';

--employees테이블에서 salary이 3000, 9000, 17000아닐때
--first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date,salary
FROM employees
WHERE NOT(salary=3000 OR salary=9000 OR salary=17000);

--employees테이블에서 commission_pct이 null일때
--first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS  NULL;


--employees테이블에서 commission_pct이 null아니면
--first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS not NULL;

--employees테이블에서 first_name에 'der'이 포함된
--first_name, salary, email을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE first_name LIKE '%der%';

--employees테이블에서 first_name의 값중 'A'로 시작하고
--두번째 문자는 임의 문자이면 'exander'로 끝나는
--first_name, salary, email을 출력하라.
SELECT first_name, salary, email
FROM employees
WHERE first_name LIKE 'A_exander';


/*
WHERE절에서 사용된 연산자 3가지 종류
1. 비교연산자 : => >= <= != <> ^=
2. SQL연산자 : BETWEEN a AND b, IN, LIKE, IS NULL
3.논리 연산자 : AND,OR,NOT
우선순위
1 괄호 ()
2 NOT 연산자
3 비교연산자, SQL연산자
4 AND
5 OR
*/

--employees 테이블에서 job_id을 오름차순으로
--first_name, email, job_id을 출력하시오.
SELECT first_name, email, job_id
FROM employees
ORDER BY job_id ASC;

--employees테이블에서 department_id를 오름차순하고
--first_name을 내림차순으로
--department_id, first_name, salary를 출력하시오.
SELECT department_id, first_name, salary
FROM employees
ORDER BY department_id ASC, first_name DESC;

--employees테이블에서 가장 최근 입사 순으로
--사원의 first_name, salary, hire_data을 추력하시오.
SELECT first_name, salary, hire_date
FROM employees
ORDER BY hire_date DESC;

--employees테이블에서 업무(job_id)이 'FI_ACCOUNT'인 사원들의
--급여(salary)가 높은순으로 first_name,job_id,salary을 출력하시오.
SELECT first_name, job_id, salary
FROM employees
WHERE job_id='FI_ACCOUNT'
ORDER BY salary DESC;







