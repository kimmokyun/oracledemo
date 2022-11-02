/*
서뷰쿼리
1. 스칼라 쿼리 :SELECT
2. 인라인 뷰 : FROM
3. 서뷰쿼리 : WHERE
*/



--90번 부서에 근무하는 LEX사원의 근무하는 부서명 출력하시오.
SELECT department_name
FROM departments
WHERE department_id=90;

--'Lex'가 근무하는 부서명을 출력하시오.
SELECT department_id
FROM employees
WHERE first_name='Lex';

SELECT department_name
FROM departments
WHERE department_id=90;

SELECT d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.first_name='Lex';

--'Lex'와 동일한 업무를 가진 사원의 이름,
-- 엄무명, 입사일을 출력하시오
SELECT e.first_name, j.job_title, e.hire_date
FROM employees e, jobs j
WHERE e.job_id=j.job_id
AND e.job_id = ( SELECT job_id
                 FROM employees
                 WHERE first_name='Lex');

SELECT job_id
FROM employees
WHERE first_name='Lex';

--'IT'에 근무하는 사원이름(first_name), 부서번호를 출력하시오.
SELECT first_name, department_id
FROM employees
WHERE department_id = (
SELECT department_id
FROM departments
WHERE department_name='IT');

--'Bruce'보다 급여를 많이 받은 사원이름(first_name), 부서명, 급여를 출력하시오.
SELECT department_id, first_name, salary,
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary > (
SELECT salary
FROM employees
WHERE first_name = 'Bruce')
ORDER BY e.salary;
--Steven와 같은 부서에서 근무하는 사원의 이름, 급여, 입사일을 출력하시오
SELECT e.first_name, e.salary, e.hire_date
FROM employees e
WHERE department_id IN (
SELECT department_id
FROM employees
WHERE first_name='Steven');


--부서별로 가장 급여를 많이 받는 사원이름, 부서번호, 급여를 출력하시오(in)
SELECT e.first_name, e.department_id, e.salary
FROM employees e
WHERE (e.department_id, e.salary) IN (
                        SELECT department_id, max(salary)
                        FROM employees
                        GROUP BY department_id);

--30부서의 모든 사원들의 급여보다 더많은 급여를 받는
-- 사원이름, 급여, 입사일을 출력하시오.
--(서브쿼리에서 max()함수를 사용하지 않는다);
SELECT salary
FROM employees
WHERE department_id=30; -- 11000

SELECT first_name, salary, hire_date
FROM employees
WHERE salary > ALL (
                   SELECT salary
                FROM employees
                WHERE department_id=30
                   );
--30부서 사원들이 받은 최저급여보다 높은 급여를 받는
-- 사원이름, 급여, 입사일을 출력하시오. (ANY)
--(서브쿼리에서 max()함수를 사용하지 않는다);
SELECT salary
FROM employees
WHERE department_id=30
SELECT first_name, salary, hire_date
FROM employees
WHERE salary > ANY (
                   SELECT salary
                FROM employees
                WHERE department_id=30
                   );

--20부서에 사원이 있으면 사원들의 사원명, 입사일, 급여, 부서번호를 출력하시오.
SELECT first_name, hire_date, salary, department_id
FROM employees
WHERE EXISTS ( 
                SELECT department_id
                FROM employees
                WHERE department_id=1150

 );
--사원이 있는 부서만 출력하시오.

--사원이 있는 부서만 출력하시오. (사원이 없는 부서는 NOT EXISTS)
SELECT count(*)
FROM departments; /* 총 부서 : 72개 */

SELECT department_id, department_name
FROM departments
WHERE department_id IN (
                    SELECT distinct department_id
                    FROM employees
                    WHERE department_id IS NOT NULL
                    --GROUP BY department_id
                     );
SELECT department_id, department_name
FROM departments d
WHERE EXISTS (
SELECT 1
FROM employees e
WHERE e.department_id = d.department_id);

--부서가 있는 사원을 정보를 출력하시오
SELECT e.employee_id, e.first_name, e.department_id
FROM employees e
WHERE EXISTS (
                 SELECT 1
                 FROM departments d
                 WHERE e.department_id = d.department_id
);
-- 월별 입사자 수를 조회하되 입사자수가 가장 많은 상위 3개만 출력되도록 하시오.
-- <출력 : 월 입사자수 >
SELECT*
FROM(

SELECT to_char(hire_date, 'mm'), count(*)
FROM employees
GROUP BY to_char(hire_date, 'mm')




