-- 합계 소계를 알때 안성맞춤이다.
		select nvl(to_char(A.hire_date, 'yyyy'),'날짜'),--nvl(B.department_name, '합계') department,
		    count(*) incumbent,
		    sum(
		        case
		            when A.grade_no <> 7 then 1
		            else 0
		        end
		    ) fullTimer,
		    sum(decode(A.grade_no, 7, 1, 0)) partTimer
		from employees A, departments B 
		where A.retired = 'N'
		--and to_char(A.hire_date, 'yyyy') <= '2019'
		and A.department_no = B.department_no
		group by rollup(to_char(A.hire_date, 'yyyy'));--,B.department_name);	