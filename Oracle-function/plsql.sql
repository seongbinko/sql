-- 간단한 INSERT 작업을 수행하는 PL/SQL문 작성하기
create or replace procedure add_contact(
	 i_name varchar2,
	 i_tel varchar2,
	 i_address varchar2,
	 i_email varchar2, 
	 i_fax varchar2)
is 
	 -- 변수선언
begin 
	 -- sql 실행문
	 insert into contacts(name, tel, address, email, fax, create_date)
	 values(i_name, i_tel, i_address, i_email, i_fax, sysdate);
	 
	 commit;
end;

create table contacts (
	name varchar2(40),
	tel varchar2(20),
	address varchar2(100),
	email varchar2(200),
	fax varchar2(20),
	create_date date
);12


-- 새로운 연락처 저장
execute add_contact('김수영', '010-1234-5678', '서울특별시 서대문구', 'itsuyoung@naver.com', '02-2222-2222');

-- 사원의 아이디를 입력받아서 그 사원의 급여를 그 사원이 소속된 부서의 평균급여의 5%만큼 증가시키기
create or replace procedure update_emp_salary(
	i_emp_id in number --사원아이디를 전달받는 변수

)
IS
	v_avg_salary number(8,2); -- 실행부에서 사용할 변수 선언
BEGIN
	-- 사원이 소속된 부서의 평균급여를 조회해서 변수에 저장하기
	select trunc(avg(salary))
	into v_avg_salary --사원이 소속된 부서의 급여평균이 v_avg_salary 변수에 저장됨
	from employees 
	where department_id = (select department_id 
							from employees 
							where employee_id = i_emp_id);
	--- 사원의 급여를 변경하기 
	update employees 
	set 
		salary = salary + trunc(v_avg_salary*0.05)
	where
		employee_id = i_emp_id;
	--- 커밋
	commit;
	
end;

--  사원의 아이디를 입력받아서 그 사원의 급여등급을 반환하는 함수 작성하기
create or replace function fc_emp_grade 
	(i_emp_id number) -- 급여등급을 확인할 사원의 아이디를 전달받는 변수
return char 
is 
	v_emp_grade char(1); --계산된 급여등급을 저장하는 변수 
begin
	-- 급여등급 계산하기
	select B.gra
	into v_emp_grade
	from employees A, job_grades B
	where A.salary >= B.lowest_sal
	and A.salary <= B.highest_sal 
	and A.employee_id = i_emp_id;
	
	return v_emp_grade;
end;

--60번 부서에 소속된 사원의 아이디, 이름 , 급여, 급여등급을 조회하기
select employee_id, first_name, salary, fc_emp_grade(employee_id)
from employees 
where department_id = 60;

-- 계층형검색 
-- employees테이블에서 101번 직원의 부하직원들 조회하기 
select level, employee_id, lpad(first_name,length(first_name)+ (level*5), '_'), manager_id
from EMPLOYEES
start with employee_id = 101
connect by prior employee_id = manager_id; 

-- 206번 사원의 상사들 조회하기 
select level, employee_id, first_name, manager_id 
from employees 
start with employee_id = 206
connect by prior manager_id = employee_id; 

--2006년에 월별 입사자수 조회하기 
select to_char(hire_date, 'mm'), count(*)
from employees 
where to_char(hire_date, 'yyyy')='2004'
group by to_char(hire_date, 'mm')
order by 1;


-- 1~12까지 숫자 출력하기 
select lpad(level, 2, '0') month 
     from dual
     connect by  level <=12;
     
select '0'+level
from dual
connect by level <=12;


-- 2004년
select A.month, nvl(B.cnt, 0)
from(select lpad(level, 2, '0') month 
     from dual
     connect by  level <=12) A,
     
     (select to_char(hire_date, 'mm') month, count(*) cnt 
		from employees 
		where to_char(hire_date, 'yyyy')='2004'
		group by to_char(hire_date, 'mm')) B
where A.month = B.month(+)  -- B가 모자라니까 B쪽에 +를 붙인다.
order by 1;


select to_date('2006/01/01', 'yyyy/mm/dd') +level -1
from dual 
connect by level <=365;

-- 2019/08/26 ~ 2019/10/28 사이의 날짜를 생성하기
select to_date('2019/08/26' , 'yyyy/mm/dd') + level -1 as D_day
from dual 
connect by level <= to_date('2019/10/28') - to_date('2019/08/26') +1;

-- 각년도별 사원수 조회하기 
-- 년도 	사원수
-- 2001 	10
-- 2002 	5
-- 2003 	15
select A.year, nvl(B.cnt, 0) count
from
        (select 2000+ level as year
        from dual
        connect by 2000+ level <= to_char(sysdate,'yyyy')) A
        ,
        (select to_char(hire_date, 'yyyy') year, count(*) cnt
        from employees 
        group by to_char(hire_date, 'yyyy')) B
where A.year = B.year(+)
order by A.year;

-- 각 년도별 사원수 조회하기
-- 2001 2002 2003 2004 2005 
-- 1 	4	 10		6	20 
-- 가로순으로 나오고 싶다

-- 부서별 년도별 사원수 조회
select 
	department_id,
	sum(decode(to_char(hire_date, 'yyyy'), '2001' , 1,0) )"2001",
	sum(decode(to_char(hire_date, 'yyyy'), '2002' , 1, 0)) "2002",
	sum(decode(to_char(hire_date, 'yyyy'), '2003' , 1, 0)) "2003",
	sum(decode(to_char(hire_date, 'yyyy'), '2004' , 1, 0)) "2004",
	sum(decode(to_char(hire_date, 'yyyy'), '2005' , 1, 0) )"2005",
	sum(decode(to_char(hire_date, 'yyyy'), '2006' , 1, 0) )"2006",
	sum(decode(to_char(hire_date, 'yyyy'), '2007' , 1, 0) )"2007",
	sum(decode(to_char(hire_date, 'yyyy'), '2008' , 1, 0) )"2008"
from employees 
where department_id is not null 
group by department_id
order by 1;


select 
	sum(decode(to_char(hire_date, 'yyyy'), '2001' , 1,0) )"2001",
	sum(decode(to_char(hire_date, 'yyyy'), '2002' , 1, 0)) "2002",
	sum(decode(to_char(hire_date, 'yyyy'), '2003' , 1, 0)) "2003",
	sum(decode(to_char(hire_date, 'yyyy'), '2004' , 1, 0)) "2004",
	sum(decode(to_char(hire_date, 'yyyy'), '2005' , 1, 0) )"2005",
	sum(decode(to_char(hire_date, 'yyyy'), '2006' , 1, 0) )"2006",
	sum(decode(to_char(hire_date, 'yyyy'), '2007' , 1, 0) )"2007",
	sum(decode(to_char(hire_date, 'yyyy'), '2008' , 1, 0) )"2008"
from employees ;


-- 프로시저 
-- 사원아이디를 전달받아서 그 사원이 소속된 부서의 평균급여를 계산하고,
-- 평균급여보다 그 사원의 평균급여가 적으면 평균급여의 5%를 인상하고, 
-- 평균급여와 같으면 3%를 인상하고 .
-- 평균급여보다 많으면 1%을 인상하는 프로시저를 작성하기

create or replace procedure update_emp_salary2 (
	i_emp_id in number -- 매개변수
	
)
is 
     v_dept_id       departments.department_id%type;  -- 부서아이디를 저장할 변수 선언 
     v_avg_salary number(8);                          -- 평균급여를 저장할 변수 선언
	 v_salary       employees.salary%type;            -- 직원의 급여를 저장할 변수
	 v_new_salary   employees.salary%type;            -- 증가시킬 급여
begin 
	-- 소속부서 아이디 조회해서 저장하기 
	select department_id , salary 
	into v_dept_id, v_salary 
	from employees 
	where employee_id = i_emp_id;
	
	-- 평균급여 계산해서 변수에 저장하기
	select trunc(avg(salary),-2)
	into v_avg_salary 
	from employees 
	where department_id = v_dept_id;
	
	
	-- 증가시킬 급여 계산하기
	if v_salary > v_avg_salary then 
		
		v_new_salary := trunc(v_avg_salary * 0.01);   -- := 대입연산자
	
	elsif v_salary = v_avg_salary then 
		
		v_new_salary := trunc(v_avg_salary * 0.03);
	else 
		v_new_salary := trunc(v_avg_salary * 0.05);
		
    end if;
    
    -- 급여변경하기 
    update employees 
    set 
	    salary = salary + v_new_salary 
	where 
		employee_id = i_emp_id;
	commit;
end;

-- 지정된 부서아이디에 소속된 사원수를 반환하는 함수 
create or replace function fc_emp_cnt (
	i_dept_id in departments.department_id%type -- 사원수를 조회할 부서아이디
)
	return number 
is 
	v_emp_cnt number(3); -- 해당 부서에 소속된 사원수를 담을 변수
begin 
	select count(*) 
	into v_emp_cnt 
	from employees 
	where department_id = i_dept_id;
	
	return v_emp_cnt; 
end;

select department_id, department_name, fc_emp_cnt(department_id) cnt
from departments ;
)