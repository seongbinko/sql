-- 뷰 작성하기
-- 사원아이디, 사원의 이름(FIRST_NAME과 LAST_NAME이 포함되어 있는), 전화번호, 입사일
-- 직종아이디, 직종제목, 급여, 소속부서명을 포함하는 뷰 만들기

create or replace view employees_sample1_view
as 
	SELECT A.EMPLOYEE_ID, A.first_name || ', ' || A.LAST_NAME full_name, A.phone_number,
		   A.HIRE_DATE, A.JOB_ID, B.JOB_TITLE, A.SALARY, A.DEPARTMENT_ID,C.DEPARTMENT_NAME
	from employees A, jobs B, departments C
	where A.job_id = B.job_id
	and A.DEPARTMENT_ID = C.DEPARTMENT_ID;
	
select * from employees_sample1_view;

--80번 부서에 근무하는 사원들의 사원아이디, 사원의 이름(first_name과 last_name 이 포함되어있는),
--전화번호 입사일 직종아이디, 직종제목, 급여, 소속부서명을 조회하기
SELECT A.EMPLOYEE_ID, A.first_name || ', ' || A.LAST_NAME full_name, A.phone_number,
	      A.HIRE_DATE, A.JOB_ID, B.JOB_TITLE, A.SALARY, A.DEPARTMENT_ID,C.DEPARTMENT_NAME
from employees A, jobs B, departments C
where A.job_id = B.job_id
and A.DEPARTMENT_ID = C.DEPARTMENT_ID
and A.DEPARTMENT_ID = 80;


--90번 부서에 근무하는 사원들의 사원아이디, 사원의 이름(first_name과 last_name 이 포함되어있는),
--전화번호 입사일 직종아이디, 직종제목, 급여, 소속부서명을 조회하기

select *
from employees_sample1_view
where department_id = 90;

-- 인라인 뷰 

-- 80번 부서에 소속된 사원 중 연봉이 10달러 이하인 사원 조회하기
select A.id, A.name, A.salary, A.annual_salary
from(select employee_id as id , first_name as name, salary, salary*12 annual_salary
     from EMPLOYEES
     where department_id = 80) A
where A.annual_salary < 100000;

-- 각 부서별 평균급여를 계산했을 때 평균급여보다 급여를 적게 받는 사원의 이름, 급여,
-- 부서아이디, 부서평균급여를 조회하기

select A.first_name, A.salary, B.dept_id, B.avg_sal
from employees A, 	(select department_id as dept_id, trunc(avg(salary)) as avg_sal
					from employees 
					where department_id is not NULL
					group by department_id) B
where A.department_id = B.dept_id
and A.salary < B.avg_sal;

-- TOP-N 분석하기
-- 급여를 가장많이 받는 사원 3명의 아이디, 이름 직종 , 급여를 조회하기
select rownum, employee_id, first_name, job_id, salary
from (select employee_id, first_name, job_id, salary
	  from employees 
	  order by salary desc)
where rownum <= 3;

-- 커미션 포인트를 가장 적게 받는 사원 3명의 아이디, 이름, 직종, 급여, 커미션 포인트를 조회하기
select rownum, employee_id, first_name, job_id, salary, commission_pct 
from (select employee_id, first_name, job_id, salary, commission_pct
	 from employees 
	 where commission_pct is not null
	 order by commission_pct )
where rownum <=3;

-- 입사년도별 입사한 사원수를 계산했을 때 가장 많은 사원이 입사한 년도 3개를 조회하기 (입사년도, 사원수)
select rownum, hire_year, cnt
from (select to_char(hire_date, 'yyyy') hire_year, count(*) cnt
      from employees 
      group by to_char(hire_date, 'yyyy')
      order by cnt desc)
where rownum <= 3;

-- 부서별 사원수를 계산했을 때 사원수가 가장많은 부서 3곳의 부서의 아이디, 부서명, 사원수를 조회하기

select rownum, A.department_id, B.department_name , A.cnt
from (select department_id ,count(*) cnt
	  from employees 
	  where department_id is not null
	  group by department_id
	  order by department_id desc) A, departments B
where A.DEPARTMENT_ID = B.DEPARTMENT_ID
and rownum <=3;

-- 사원급여별 등급을 계산했을 때 등급별 사원수가 가장 많은 등급 2곳의 등급명, 사원수를 조회하기

select rownum, X.gra, X.cnt, Y.LOWEST_SAL, Y.HIGHEST_SAL
from (select gra, count(*) cnt
	  from employees A, job_grades B
	  where A.salary >= B.LOWEST_SAL and A.salary <= HIGHEST_SAL
	  group by gra
	  order by cnt desc) X, job_grades Y
where X.gra = Y.gra
and rownum <= 3;


-- 분석함수 사용하기 
-- ROW_NUMBER()
select row_number() over (order by salary desc), first_name, salary 
from employees;


-- RANK 1 22 4 55 7 
select rank() over (order by salary desc) as x , first_name, salary 
from employees;
-- DENSE_RANK() - 1 22 3 44 5
select dense_rank() over (order by salary desc) as x , first_name, salary 
from employees;

-- 부서별 최고 급여를 받는 사람의 이름, 부서아이디, 급여를 조회하기
select first_name, department_id, salary
from (select dense_rank() over (partition by department_id  order by salary desc) as x,
	   first_name, department_id, salary 
	   from employees
	   where department_id is not null)
where x = 1;

-- 분석함수 없을 경우 
select first_name, department_id, salary
from employees
where(department_id, salary) in	(select department_id, max(salary)
								 from employees 
							     group by department_id)
order by department_id;
-- 
-- 급여 순위 1~10까지 구하기
select * 
from (select row_number() over (order by salary desc) x, first_name, salary 
	  from employees) 
where x >= 1 and x<= 10; 
-- 급여 순위 11~20 까지 구하기 
select * 
from (select row_number() over (order by salary desc) x, first_name, salary 
	  from employees) 
where x >= 11 and x<= 20; 
-- 급여 순위 21~30 까지 구하기
select * 
from (select row_number() over (order by salary desc) x, first_name, salary 
	  from employees) 
where x >= 21 and x<= 30; 


-- 그룹함수와 분석함수
-- 그룹함수 : 전체 테이블당 혹은 그룹당 결과가 하나 반환된다.
select DEPARTMENT_ID, sum(salary)
from employees 
group by department_id
order by department_id;
-- 분석함수 : 각 행마다 분석함수의 결과가 반환된다.
select employee_id, first_name, department_id, salary,
		sum(salary) over (partition by department_id) department_total_salary
from employees;

-- 사원아이디, 이름, 부서아이디, 급여, 부서평균과 급여사이의 차이 조회하기
select employee_id, first_name, department_id,salary, (avg(salary) over (partition by department_id) - salary) as salary_gap
from employees;

select EMPLOYEE_ID, FIRST_NAME DEPARTMENT_ID, salary - trunc(avg(salary) over (PARTITION by DEPARTMENT_ID)) salary_gap
from employees;
