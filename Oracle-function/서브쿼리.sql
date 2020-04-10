-- 단일행 서브쿼리

-- having 절에서 서브쿼리 사용하기
-- 직종별로 평균급여를 계산했을 때, 
-- 직종이 IT_PROG의 평균급여보다 평균급여가 적은 직종의 평균급여 조회하기
select job_id , avg(salary)
from employees
group by job_id
having avg(salary) < (select avg(salary)
                      from employees 
                      where job_id = 'IT_PROG')
order by avg(salary);
-- 직종별로 평균급여를 계산했을 때,
-- 전체사원들의 평균급여보다 평균급여가 적은 직종의 급여를 조회하기
select job_id , avg(salary)
from employees
group by job_id
having avg(salary) < (select avg(salary)
                      from employees)
order by avg(salary);

-- 직종별로 평균급여를 계산했을 때, 평균급여가 가장 높은 직종의 평균급여를 조회하기
select job_id, avg(salary)
from employees 
group by job_id
having avg(salary) = (select max(avg(salary))
                      from employees 
                      group by job_id);
-- 부서아이디별 평균급여를 계산했을 때, 평균급여가 가장 적은 부서의 평균급여를 조회하기
select department_id, round(avg(salary))
from employees
where department_id is not null 
group by department_id
having avg(salary) = (select min(avg(salary))
                      from EMPLOYEES
                      group by department_id);
                      
-- 부서아이디별 평균급여를 계산했을때, 평균급여가 가장적은 부서에 근무하고 있는 사원의 아이디,
-- 이름, 급여, 부서아이디를 조회하기
select employee_id, first_name, salary, department_id
from employees
where department_id = (select department_id
                        from employees
                        where department_id is not null
                        group by department_id
                        having avg(salary) = (select min(avg(salary))
                                                from employees
                                                group by department_id))
order by employee_id;
 
-- 부서별 평균급여를 조회했을 때// 그 부서의 평균급여보다// 적은 급여를 받은 사원의 이름, 급여, 부서명을 조회하기 (부서명순으로 정렬하기)
select first_name, salary, department_name
from employees A,
    
    (select department_id, avg(salary) avg_salary
    from employees
    group by department_id) B, 
    
    departments C
where 
    A.department_id = B.department_id
    and A.department_id = C.department_id
    and A.salary < B.avg_salary;
                            

--Multiple-Row Subquery란?
-- 하나 이상의 행을 반환하는 Subquery이다
-- 단일 행 연산자를 사용하지 못하며, 다중 행 연산자(IN, NOT IN, ANY, ALL, EXISTS)만 사용이 가능하다.


--- 부서별로 가장 급여를 많이 받는 사원의 정보를 출력하는 예제
-- in 예제
select employee_id, first_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)
order by department_id;

-- any 예제 ANY 연산자는 Subquery의 여러 결과값 중 어느 하나의 값만 만족이 되면 행을 반환 한다.

-- 직업의 급여보다 많이 받는 사원의 사원명과 급여 정보를 출력하는 예제 (min값 보다 클때)
select first_name, salary
from employees
where salary > any (select salary
                            from employees
                            where job_id = 'IT_PROG')
order by salary;

--- ALL 연산자는 Subquery의 여러 결과값 중 모든 결과 값을 만족해야 행을 반환 한다.
-- 여기선 max(salary)보다 클때가 나올것이다.
select first_name, salary
from employees
where salary > all (select salary
                            from employees
                            where job_id = 'IT_PROG')
order by salary;

-- EXIST 연산자
select distinct A.department_id, A.department_name
from departments A, employees B
where A.department_id = B.department_id;

-- EXist 잘모르겠다 
select A.department_id, A.department_name
from departments A
where EXISTS
    (select 1
        from employees B
        where A.department_id = B.department_id);



 -- 시퀀스
 CREATE SEQUENCE customer_seq
 				INCREMENT by 1    -- 1씩 증가
 				START WITH 10000  -- 시작값을 10000
 				NOCACHE;           -- 캐시사용하지 않음
 select customer_seq.nextval
 from dual;
 
 select customer_seq.currval
 from dual;


 

 			
