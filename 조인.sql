-- 등가조인
-- 부서테이블과 위치테이블 조인하기
-- 부서아이디, 부서명, 소재도시, 주소
select DEPARTMENT_ID, DEPARTMENT_NAME
from DEPARTMENTS, LOCATIONS
where departments.location_id = locations.location_id 
order by departments.department_id;

--90번 부서에 소속된 사원들의 사원아이디, 사원명, 직종아이디, 직종제목
-- 최소급여, 최대급여, 현재급여

select A.employee_id, A.first_name, B.job_title, A.job_id, B.job_title, B.MIN_SALARY, B.MAX_SALARY, A.salary  --별칭붙이면 이제 원래 이름은 못쓰는 것 같다.. 
from employees A, jobs B
where A.job_id = B.job_id
and A.department_id = 90;

-- 부서테이블에서 부서관리자가 지정된 부서의 부서아이디, 부서명,
-- 관리자 사원아이디, 관리자 사원명, 관리자 조회하기

select a.department_id, a.department_name, a.manager_id, b.first_name
from departments A , employees B
where A.manager_id = b.employee_id
and A.manager_id is not null;


--- 30, 60 , 90 부서에 근무하는 사원의 아이디, 사원이름, 사원의 급여 < --- employees
-- 직종아이디, 직종제목, 최소급여 , 최대급여,						 <---- jobs
--소속부서 아이디, 부서명을 조회하기								 <---- departments

select a.employee_id, a.first_name, a.salary, 
	   c.job_id, c.job_title, c.min_salary, c.max_salary,
	   b.department_id , b.department_name
from employees A, departments B, jobs C
where A.department_Id in (30,60,90)
and a.job_id =c.job_id
and a.department_id = b.department_id;

-- 관리자있는 부서의 부서아이디, 부서명,
-- 관리자의 사원아이디, 관리자의 이름, 관리자의 전화번호
-- 부서의 소재도시, 우편번호, 주소 조회가기
select a.department_id, a.department_name, b.employee_id, b.first_name,  b.phone_number, c.city, c.street_address, c.postal_code 
from departments A, employees B, LOCATIONS C
where A.MANAGER_ID is not null
and a.department_id = b.employee_id
and a.location_id = c.location_id; 

-- 100 사원의 이름과 급여, 부서명, 근무지역을 조회하기
select a.first_name , a.salary , b.department_id, c.city
from employees A, departments B, locations C
where employee_id = 100
and a.department_id = b.department_id
and b.location_id = c.location_id;

--- Toronto 지역에 근무하는 //사원의 아이디와 사원이름, 급여를 조회하기
select C.employee_id, C.first_name, C.salary
from locations A, departments B, employees C
where A.city = 'Toronto'
and A.location_id = B.location_id
and B.department_id = C.department_id;

-- 최소급여가 3000이상 4000이하인 직종에 종사하는 사원의 아이디, 이름, 급여, 직종아이디, 최소급여
-- 직종아이디, 최소급여를 조회하기
select B.employee_id, B.first_name, B.salary, A.job_id, A.min_salary 
from jobs A, employees B
where min_salary >= 3000
and min_salary <= 4000
and A.job_id = B.job_id;



--비등가조인 30,60,90 부서에 근무하는 사원의 이름, 사원의 급여, 사원의 급여등급
select A.first_name, A.salary, B.GRA
from employees A, job_grades B
where department_id in (30,60,90)
and A.salary >= B.lowest_sal and A.salary <= B.highest_sal;

-- 100사원에게 보고하는 사원들의 이름, 사원급여, 급여등급, 소속부서아이디, 부서명을 조회하기
select A.first_name, A.salary, B.gra, C.department_id, C.department_name
from employees A, job_grades B, departments C
where A.manager_id = 100
and A.salary >= B.lowest_sal 
and A.salary <= B.highest_sal
and A.department_id = C.department_id;


-- 114번 사원의 이름, 급여, 급여등급을 조회하기
select emp.FIRST_NAME, emp.SALARY, emp_g.GRA
from employees emp, job_grades emp_g
where  emp.employee_id = 114
and emp.salary >= emp_g.LOWEST_SAL
and emp.salary <= emp_g.HIGHEST_SAL;

-- 셀프조인
-- 101번 사원의 이름, 급여, 직종과, 101번 사원의 상사의 이름, 직종을 조회하기
select A.first_name, A.salary, A.job_id, B.first_name manager_name, B.job_id manager_job
from employees A, employees B
where A.employee_id = 101
and A.manager_id = B.employee_id;

-- 114번 사원의 이름, 급여, 급여등급과 상사의 이름, 상사의 급여, 상사의 급여등급을 조회하기
select 
    emp.first_name,emp.salary,graa.gra, mag.employee_id magid, mag.salary magsalary, graB.gra maggrade
from
    employees emp, employees mag, job_grades graA, job_grades graB
where
    emp.manager_id = mag.employee_id
    and emp.employee_id = 114
    and emp.salary >= graA.lowest_sal
    and emp.salary <= graA.highest_sal
    and mag.salary >= graB.lowest_sal
    and mag.salary <= graB.highest_sal;
-- 포괄조인
-- 정보가 부족한 쪽에 null행을 생성한다.
select
    A.employee_id, A.department_id, B.department_id
from employees A, departments B
where A.department_id = b.department_id(+);


--포괄조인(아웃터 조인)
-- 부서아이디, 부서명, 부서관리자 아이디, 부서관리자 이름, 직종아이디 조회하기
-- 매니저가 할당되지 않은 부서도 알고 싶다. 정보가 부족한 B에 (+)
    
select a.department_id, a.department_name, B.first_name,B.job_id,a.manager_id, B.employee_id
from departments A, employees B
where A.manager_id = B.employee_id(+);
--직종아이디가 SA_REP인 사원의 아이디, 이름, 급여, 소속부서아이디, 소속부서명을 조회하기
select A.employee_id, A.first_name,A.job_id, A.salary, B.department_id, B.department_name, B.manager_id
from employees A, departments B
where A.job_id = 'SA_REP'
      and A.department_id = B.department_id(+);

SELECT A.DEPARTMENT_ID, A.DEPARTMENT_NAME, B.EMPLOYEE_ID, B.FIRST_NAME, B.JOB_ID
FROM DEPARTMENTS A, EMPLOYEES B
where A.manager_id = B.employee_id(+)
order by A.DEPARTMENT_ID asc;

--직종아이디가 SA_REP인 사원의 아이디, 이름, 급여, 소속부서아이디, 소속부서명을 조회하기
select *
from EMPLOYEES A, DEPARTMENTS B
where JOB_ID = 'SA_REP'
and A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
order by A.EMPLOYEE_ID asc;
