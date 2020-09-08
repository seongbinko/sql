/*
트리거

-테이블에 INSERT, UPDATE, DELETE 작업이 수행될 때 자동으로 실행되는 것이다.

-트리거는 데이터베이스 객체다. (CREATE해서 만드는 것) 

-종류

- 행 트리거

    테이블의 데이터가 변경될 때 실행되는 트리거

- 문장 트리거

    영향을 받은 행이 없다라도 실행되는 트리거

    *특정 시간에 실행되는 트리거

-형식

SQL

CREATE OR REPLACE TRIGGER 트리거명
{BEFORE | AFTER} --- 어떤 시점 (해당작업이 시행되기전에, OR 시행된 후에 뭔가할 것 )
{INSERT, UPDATE, DELETE} ON 테이블명 -- 이벤트 종료
FOR EACH ROW 						<--  데이터 행의 변화가 생길 때마다
DECLARE (선언문)                        
BEGIN                               <---  수행문 시작
			실행할 SQL
END;                                <--- 수행문 끝

- OLD NEW 접두어는 행 트리거에서만 사용 가능하다.
- 트리거 수행문에서 변경이 발생한 행의 이전값, 변경된(추가된 갑)을 사용할 수 있다.	
*/


---------------------------------------------------------
SELECT * FROM bonus;
SELECT * FROM SCOTT.dept;
SELECT * FROM emp;
SELECT * FROM SALGRADE ;

------------------------------------------------------------
CREATE OR REPLACE TRIGGER scott_trigger_test
BEFORE 
update ON scott.dept
FOR EACH ROW
BEGIN 
	DBMS_OUTPUT.PUT_LINE('트리거 테스트 입니다');
 	DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값 : ' || :old.LOC);
    DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값 : ' || :new.LOC);
END;
COMMIT;
UPDATE SCOTT.DEPT SET LOC = 'HONGDAE' WHERE DEPTNO = 60;

-----------------------------------------------------------
CREATE OR REPLACE TRIGGER sum_trigger
BEFORE
INSERT OR UPDATE ON emp
FOR EACH ROW
DECLARE
    -- 변수를 선언할 때는 DECLARE문을 사용해야 한다 
    avg_sal VARCHAR2(10);
BEGIN
    SELECT TO_CHAR(ROUND(AVG(sal),3))
    INTO avg_sal
    FROM emp;

    DBMS_OUTPUT.PUT_LINE('급여 평균 : ' || avg_sal);
END;

INSERT INTO EMP(EMPNO, ENAME, JOB, HIREDATE, SAL)
VALUES(4000, 'LION', 'SALES', SYSDATE, 5000);
-----------------------------------------------------
