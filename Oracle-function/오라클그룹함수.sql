--그룹함수
--사원테이블 모든 행의 갯수를 조회
select count(*)
from employees;

-- 사원테이블에서 80번 부서에 소속된 사원수fmf 조회
select count(*)
from employees
where department_id = 80;

--사원테이블에서 최고 최저, 평균급여를 조회하기
select max(salary),min(salary),trunc(avg(salary))
from employees;

--90번 부서에 소속된 사원들의 급여 합계를 조회하기
select sum(salary)
from employees
where department_id = 90;

--최고급여 찾기
--1.최고급여를 알아내자
select max(Salary)
from employees;
--2. 급여가 24000인 사원 알아내자
select first_name
from employees
where salary = 24000;
-- 최고급여를 받는 사람을 서브쿼리를 사용해서 한 번에 알아내기
select first_name
from employees
where salary = (select max(salary)
                from employees);
--부서별 사원수 조회하기
select department_id, count(*)
from employees
group by department_id;
--직종별 평균급여 조회하기, 최소급여, 최대급여 조회하기
select job_id,avg(salary), min(salary), max(salary)
from employees
group by job_id;

--입사년도별 사원수 조회하기
select to_char(hire_date,'yyyy'), count(*)
from employees
group by to_char(hire_date, 'yyyy');
-- 급여 등급별 사원수 조회하기
-- having절을 사용해서 그룹함수 적용결과를 필터링하기
select b.gra, count(*), round((count(*)/107)*100,1) rate
from employees A, job_grades B
where A.salary >= b.lowest_sal
      and A.salary<= b.highest_sal
group by b.gra
order by b.gra asc;

-- 전체조회/ 데이터필터링/ 그룹핑 및 그룹함수적용/ 그룹함수 적용결과 필터링
-- 없음 / where 절 / group by 절 / having절
-- 1. 전체조회 
select *
from employees;

-- 2. 데이터 필터링
select *
from employees
where department_id = 90;

-- 3. 그룹핑 및 그룹함수 적용
select department_id, count(*)
from employees
where salary >= 9000
group by department_id;


--4. 그룹함수 적용결과 필터링
select department_id, count(*), trunc(avg(salary))
from employees
where salary >= 9000
group by department_id
having avg(salary) >=10000;

--- 부서별 평균급여를 조회했을 때 평균 급여가 6000달러 미만인 부서만 표시하기
select department_id,count(*), round(avg(salary),1)
from employees
group by department_id
having avg(salary) < 6000;

-- 급여등급별 사원수를 조회했을 때, 사원수가 10명 이상인 등급을 조회하기
select B.gra , count(*)
from employees A, job_grades B
where A.salary >= b.lowest_sal
and A.salary <= b.highest_sal
group by B.gra
having count(*) > 10
order by B.gra desc;
-- 부서별 최고 급여 조회하기, 부서이름과 최고급여를 표시
select b.department_name, max(salary)
from employees A, departments B
where a.department_id = b.department_id
group by b.department_name
order by b.department_name;
