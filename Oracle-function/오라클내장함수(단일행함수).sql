-- 문자함수 연습
-- 사원의 이름으로 소문자, 대문자로 바꾸기
-- lower(컬럼 혹은 표현식(연산)) upper(컬럼 혹은 표현식(연산))
select first_name , lower(first_name) , upper(first_name)
from employees
where department_id = 90;

-- 사원의 이름에서 부분문자데이터 추출하기
-- 첫번째 부터 3개 가져와라 1,3
-- substr(컬럼 혹은 표현식, 시작위치) : 지정된 시작위치부터 끝까지 추출
-- substr(컬럼 혹은 표현식, 시작위치, 갯수) : 지정된 시작위치부터 갯수만큼 추출
-- *시작위치는 1부터 시작한다
select first_name, substr(first_name, 1, 3),  substr(first_name, 2, 3), substr(first_name,3)
from employees
where department_id = 90;

-- 사원의 이름에서 first_name과 last_name을 연결하기
select first_name, last_name, concat(first_name, last_name) concat
from EMPLOYEES
where department_id = 90;

-- 사원의 이름과 특정문자가 등장하는 위치 조회하기
-- instr(컬럼 혹은 표현식, '검색할문자')
-- instr(컬럼 혹은 표현식, '검색할문자', 검색시작위치)
-- instr(컬럼 혹은 표현식, '검색할문자', 검색시작위치, 발생횟수)
-- 발생횟수는 두번째 e가 발생하는 곳의 위치를 표현해준다)
select first_name, instr(first_name, 'e'), instr(first_name, 'e', 3), instr(first_name, 'e', 1, 2)
from employees
where department_id = 90;

-- 사원의 이름과 글자수를 조회하기
-- length(컬럼 혹은 표현식) : 글자수를 반환한다.
select last_name, length(last_name)
from employees
where department_id = 90;

-- 사원의 이름을 조회하고, 지정된 길이보다 문자열이 짧으면 왼쪽 혹은 오른쪽은 부족한 만큼 문자 채우기
-- lpad(컬럼혹은 표현식, 길이,  '문자') : 지정된 길이보다 컬럼의 값이 짧으면 부족한 만큼 '문자'를 왼쪽에서 채운다
-- rpad (끝나는부분을 채우는것)
select first_name, lpad(first_name, 10, '#'), rpad(first_name, 10, '#')
from EMPLOYEES
where DEPARTMENT_ID = 90;

select lpad('1', 10, '0') 일련번호, lpad('1234', 10, '0') 제품번호
from dual;

-- 의미없는 공백 제거하기 
-- trim(컬럼 혹은 표현식) : 문자데이터 좌우의 의미없는 공백을 제거한다.
select trim('                안녕             하세요                         ') 
from dual;

-- dual 테이블 
-- 오라클이 제공하는 1행 1열짜리 더미(dummy)테이블이다.
-- 테이블의 데이터를 조회하는 작업이 아닌, 간단한 계산등을 수행할 때 주로 사용되는 테이블이다.
-- (계산 결과가 한 행만 조회된다.)
select *
from dual;

-- 문자열 바꾸기, 사원의 이름에서 'e'를 찾아서 'E'로 바꾸기
-- replace (컬럼 혹은 문자열, '검색할 문자', '변경할 문자') : 문자열을 찾아서 바꾼다.
select first_name, replace(first_name, 'e', 'E')
from employees
where department_id = 90;

--  전화번호에서 지역번호만 조회하기 (substr, instr 이용)
select '032)1234-8655',
	 substr('032)1234-5678', 1, INSTR('032)1234-5678', ')' ) -1 )
from dual;
-- 직원의 이름을 대문자로 바꾸고, 'E'를 '*'로 변경한다.
select replace(upper(first_name), 'E', '*')
from employees 
where DEPARTMENT_ID = 90;

-- 직원의 이름, 급여를 조회하고, 1달 21일 근무기준 1일 수당을 계산하기
select first_name , salary, salary/21 , round(salary/21) , round(salary/21, 1),
                                        trunc(salary/21), trunc(salary/21,1) 
from EMPLOYEES
where DEPARTMENT_ID = 90;

-- 숫자함수
-- round(컬럼 혹은 표현식)
-- round(컬럼 혹은 표현식, n) n번째 자리로 반올림한다.
--                                   n이 양수면 n번째 소수점 자리로 반올림,
--                                   n이 음수면 -1은 십의자리 밑을, -2는 백의 자리 밑을 반올림한다.
--trunc(컬럼 혹은 표현식)      동일하지만 내림
--trunc(컬럼 혹은 표현식, n)   n번째 자리까지 남기고 나머지는 버린다.
select round (1426.74), trunc(1426.74),                -- 1427, 1426
		round(1426.74, 1), trunc(1426.74, 1),           -- 1426.7 1426.7
		round(1426.74, 0), trunc(1426.74, 0),           -- 1427, 1426
		round(1426.74, -1), trunc(1426.74, -1)         -- 1430, 1420
from dual;

-- ceil(천장) (컬럼 혹은 표현식) : 현재 값보다 크거나 같은 정수중에서 가장 작은 정수를 반환한다.

select ceil(1.3), CEIL(1.6), ceil(-4.3), ceil(-4.6)
from dual;


--floor(바닥값)
select floor(1.3), floor(1.6), 
		floor(-4.3), floor(-4.6),  ceil(-4.3), ceil(-4.6), trunc(-4.3) ,trunc(-4.6), round(-4.6), round(-4.3)
from dual;

-- 날짜함수
-- sysdate : 현재 날짜와 시간을 반환한다.

 select sysdate
 from dual;

 -- 날짜 연산
 -- 날짜 + 숫자  --> 날짜 : 지정된 날짜에서 숫자만큼 일 수를 더한 날짜
 -- 날짜 - 숫자   --> 날짜 : 지정된 날짜에서 숫자만큼 일 수를 뺀 날짜
 -- 날짜 - 날짜   --> 숫자 : 두 날짜사이의 일 수
 -- 날짜 + 날짜 는 없다 
 -- MONTHS_BETWEEN(날짜, 날짜) : 두날짜 사이의 개월 수
 -- ADD_MONTHS(날짜, 숫자) : 날짜에서 숫자만큼의 개월수를 더한 날짜
 -- ROUND(날짜) : 날짜를 반올림한다. (정오를 지나면 내일, 정오를 지나지 않았으면 오늘)
 -- TRUNC(날짜) : 날짜에서 시간 부분을 버린다

-- 100일 후 날짜
 select trunc(sysdate +2)
 from dual;
 -- 7일전 날짜
 select sysdate - 7
 from dual;


-- 사원테이블에서 입사일을 기준으로 오늘까지 근무일수를 계산하기
select first_name, trunc(sysdate - hire_date)
from EMPLOYEES
where DEPARTMENT_ID = 90;

-- 나는 며칠 살았을까
select trunc(sysdate - to_date('19930331'))
from dual;

select round(sysdate), trunc(sysdate)
from dual;

-- 입사일을 기준으로 근무 개월수 조회하기
select first_name, hire_date, trunc(months_between(sysdate, hire_date), 1) working_months
from employees 
where department_id = 90;

-- 데이터 타입변환
-- 묵시적 변환
--- 문자 ---> 숫자로변환 (문자가 숫자로)
SELECT first_name, salary
from employees 
where salary >= 12000;

SELECT first_name, salary
from employees 
where salary >= '12000'; -- 문자데이터가 숫자로 자동으로 변환되었다.

-- 문자 ---> 날짜로변환 (문자가 날짜표기 형식일 때)
select first_name, hire_date
from EMPLOYEES
where department_id =60
and hire_date = '2006/01/03';

select first_name, hire_date
from EMPLOYEES
where department_id =60
and hire_date = '2006-01-03';

select first_name, hire_date
from EMPLOYEES
where department_id =60
and hire_date = '20060103';

-- ? ? 표에 넣을 때 스트링으로 넣으니까 java에서 그때 날짜도 스트링으로 넣으면되니까 편리

-- 명시적 날짜 변화
select SYSDATE , 
	to_char(sysdate, 'yyyy') 년,
	to_char(sysdate, 'mm') 월,
	to_char(sysdate, 'dd') 일,
	to_char(sysdate, 'am') 오전오후,
	to_char(sysdate, 'hh') "12시간제",
	to_char(sysdate, 'hh24') "24시간제",
	to_char(sysdate, 'mi') 분,
	to_char(sysdate, 'ss') 초
from dual;

select to_char(sysdate, 'YYYY-MM_DD'),
        to_char(sysdate, 'HH24:MI:SS'),
        to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS')
from dual;

-- 사원테이블에서 2006년에 입사한 사원 찾기
SELECT FIRST_NAME, HIRE_DATE
from  EMPLOYEES
where to_char(HIRE_DATE, 'yyyyMM') = '200603';


-- 입사일자가 오늘과 동일한 사원 찾기
select first_name, hire_date
from EMPLOYEES
where to_char(HIRE_DATE, 'mm-dd') = to_char(sysdate-1, 'mm-dd');

-- 특정 패턴의 날짜형식의 문자를 날짜로 변환하기.
select trunc(sysdate) - to_date('12/01/1981', 'mm/dd/yyyy')
from dual;
 
-- 2006년 1월 1일부터 ~ 2006년 6월 30일 사이에 입사한 사원 조회하기
-- 2006/01/01 00:00:00 <= hire_date <= 2006/06/30 23:59 59초
-- 2006/01/01 00:00:00 <= hire_date < 2006/07/01 00:00 00초
select first_name, hire_date
from EMPLOYEES
where hire_date >= to_date('20060101', 'yyyy/mm/dd')
and hire_date < to_date('20060630 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
order by hire_date;


-- 명시적 숫자 변화

-- 직원 테이블의 급여를 자릿수를 포함시켜서 조회하기
select first_name, salary, to_char(salary, '99,999'), to_char(salary, '999,999'),
                           to_char(salary, '00,000'), to_char(salary, '000,000') --숫자가 더 적으면 해당자리에 0을 넣는다.
from EMPLOYEES
where DEPARTMENT_ID = 90;

-- 숫자가 자리수를 초과하면 '######'으로 표시된다
select to_char(123456789, '99,99')
from dual;
-- 소수점이하는 표시된 자리로 반올림되고, 해당자리에 숫자가 없으면 0으로 표시된다.
select to_char(123.27, '999.9'),  to_char(123.27, '999.999'),
		to_char(123.27, '000.00'),   to_char(123.27, '000.000')
from dual;

-- 자릿수가 포함된 숫자형식의 문자를 숫자로 바꾸기
-- 자동으로 '123'이 123으로 변환됨
select '123' - 12                         
from dual;
-- 오류(숫자가 아닌 것이 문자에 포함되어 있다.)
select '123,456' - 10                    
from dual;
-- 명시적 변환
select to_number('123,456', '000,000') -10000
from dual;

-- 기타함수
-- nvl(컬럼 혹은 표현식, 대체할 값)
-- 직원의 이름, 급여, 커미션포인트를 조회하기
-- 커미션 포인트가 null이면 0으로 표시하기

--- nvl 활용 연봉계산하기
select first_name, salary, commission_pct, nvl(commission_pct, 0),
		(salary + salary*commission_pct)*12,
		(salary + salary*nvl(commission_pct, 0))*12  연봉조회
from EMPLOYEES;

-- CASE, DECODE 구하기
-- 50번 부서에 소속된 사원들 중에서 급여가 7000달러 이상인 고객은 보너스 4000 지급,
-- 급여가 3000달러 이상인 사원은 보너스 3000 지급 
-- 그 외 사원은 보너스 2000달러 지급하려고 한다.
-- 사원 아이디, 이름, 급여 , 보너스를 조회하기
select employee_id, first_name, salary,
        case
            when salary >= 7000 then 4000
            when salary >= 3000 then 3000
            else 2000
         end bonus
from employees
order by salary desc;
-- 50번 부서에 소속된 사원들 중에서 급여가 7000달러 이상인 사원은 급여 3%인상
-- 급여가 3000달러 이상인 사원은 급여 5%인상
-- 그 외 사원은 급여 7% 인상하려고 한다.
-- 사원 아이디, 이름, 급여, 인상된 급여를 조회하기
select employee_id, first_name, salary,
        case
            when salary >= 7000 then round(salary*1.03,1)
            when salary >= 4000 then round(salary*1.05,1)
            else round(salary*1.07,1)
        end newsalary
from employees
where department_id = 50
order by salary desc;

-- 소속부서 아이디가 30, 60, 90번이 사원의 급여를 각각 3%, 5%, 7% 인상하고, 그외 부서는 8% 인상
-- 사원아이디, 이름, 부서아이디, 급여, 인상된 급여를 조회하기 
-- department_id = 30 then salary + trunc(salary*0.03) 도 가능하고 이것이 더 가독성이 높아보인다.
select employee_id, first_name, department_id, salary, 
        case
            when department_id = 30 then salary*1.03
            when department_id = 60 then salary*1.05
            when department_id = 90 then salary*1.07
            else salary*1.08
        end newsalary
from employees;
-- 소속부서가 50번인 사원은 'A'팀, 80번인 사원은 'B'팀, 나머지는 'C'팀으로 나누려고 한다.
-- 사원아이디, 이름 , 소속부서아이디, 소속팀을 조회하고 , 소속팀으로 오름차순 정렬하기

select employee_id, first_name, department_id,
        decode (department_id, 50, 'A', 80, 'B', 'C') team
from employees
where department_id is not null
order by team asc;
