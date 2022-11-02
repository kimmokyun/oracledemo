/*
ROLLUP() 함수, CUBE()함수
*/
SELECT department_id, job_id, count(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

/*
ROLLUP(column1, column2)
ROLLUP(department_id, job_id)
20 MK_MAN 1 -- 그룹
20 MK_REP 1 -- 그룹
20        2 -- 그룹
        107 -- 총계
 */
 
 
 SELECT department_id, count(*)
FROM employees
GROUP BY rollup(department_id)
ORDER BY department_id;
/*
CUBE(department_id, job_id)
20 MK-MAN 1 --그룹
20 MK_REP 1 --그룹
20        2 -- 그룹
  MK_MAN 1  -- 소계
  MK_REP 1  -- 소계
        107 -- 총계
        */
        SELECT department_id, count(*)
        FROM employees
        GROUP BY CUBE(department_id)
        ORDER BY department_id;
       
        SELECT department_id, count(*)
        FROM employees
        GROUP BY CUBE(department_id,job_id)
        ORDER BY department_id, job_id;
  /*
  GROUPING SETS ()함수
  */
  SELECT department_id,job_id, count(*)
  FROM employees
  GROUP BY GROUPING SETS(department_id, job_id)
  ORDER BY department_id, job_id;
   
  SELECT CASE department_id
  WHEN 10 THEN 'A'
  WHEN 20 THEN 'B'
  ELSE 'C'
  END AS "alias"
  FROM employees;
    
  SELECT CASE GROUPING(d.department_name)
  WHEN 1 THEN 'ALL Departments'
  ELSE d.department_name
  END AS "DNAME",
  CASE GROUPING(e.job_id)
  WHEN 1 THEN 'ALL Jobs'
  ELSE e.job_id
  END AS "JOB",
  count(*) AS "Total sal",
  sum(e.salary) AS "Total sal"
  FROM employees e, departments d
  WHERE e.department_id=d.department_id
  GROUP BY d.department_name, rollup(job_id);
  
  /*
  그룹내 순위관련 함수
  RANK() OVER() : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다.
  DENSE() OVER() : 동일한 순위를 하나의 건수로 취급한다.
  ROW() OVER() : 동일한 값이라도 고유한 순위를 부여한다.
  */
  SELECT job_id, first_name, salary, rank() over(ORDER BY salary DESC)
  FROM employees; -- 1 2 2 4
  
  -- 그룹별로 순위를 부여할 때 사용 : PARTITION BY
  SELECT job_id, first_name, salary, rank() over(PARTITION BY  job_id ORDER BY salary DESC)
  FROM employees; -- 1 1 1 .... 1 2 3 4 5...
  
  SELECT job_id, first_name, salary, dense_rank() over(ORDER BY salary DESC)
  FROM employees; -- 1 2 2 3
  
  SELECT job_id, first_name, salary, row_number() over(ORDER BY salary DESC)
  FROM employees; -- 1 2 3 4
  
  /*
  계층형 질의
  */
  SELECT first_name, lpad(first_name, 10,)
  FROM employees;

  SELECT first_name, lpad(first_name, 10,'*')
  FROM employees;
  
  --매니저 -> 사원
  SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name
  FROM employees
  START WITH manager_id IS NULL
  CONNECT BY PRIOR employee_id = manager_id;
  
  SELECT employee_id, first_name, manager_id
  FROM employees;
  
  
  --사원 - > 매니저
   SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name
  FROM employees
  START WITH manager_id IS NOT NULL
  CONNECT BY PRIOR  manager_id = employee_id;
  
  --CONECT_BY_ROOT : 최상위 루트
     SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name, CONNECT_BY_ROOT employee_id
  FROM employees
  START WITH manager_id IS NOT NULL
  CONNECT BY PRIOR  manager_id = employee_id;
  
  
  
  
  
  
SELECT employee_id, manager_id, LEVEL, lpad(' ',3*(LEVEL-1)) || first_name, CONNECT_BY_ROOT employee_id
CONNECT_BY_ISLEAF
  FROM employees
  START WITH manager_id IS NOT NULL
  CONNECT BY PRIOR  manager_id = employee_id
  ORDER SIBLINGS BY first_name;