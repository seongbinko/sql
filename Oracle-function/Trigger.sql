/*
Ʈ����

-���̺� INSERT, UPDATE, DELETE �۾��� ����� �� �ڵ����� ����Ǵ� ���̴�.

-Ʈ���Ŵ� �����ͺ��̽� ��ü��. (CREATE�ؼ� ����� ��) 

-����

- �� Ʈ����

    ���̺��� �����Ͱ� ����� �� ����Ǵ� Ʈ����

- ���� Ʈ����

    ������ ���� ���� ���ٶ� ����Ǵ� Ʈ����

    *Ư�� �ð��� ����Ǵ� Ʈ����

-����

SQL

CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
{BEFORE | AFTER} --- � ���� (�ش��۾��� ����Ǳ�����, OR ����� �Ŀ� ������ �� )
{INSERT, UPDATE, DELETE} ON ���̺�� -- �̺�Ʈ ����
FOR EACH ROW 						<--  ������ ���� ��ȭ�� ���� ������
DECLARE (����)                        
BEGIN                               <---  ���๮ ����
			������ SQL
END;                                <--- ���๮ ��

- OLD NEW ���ξ�� �� Ʈ���ſ����� ��� �����ϴ�.
- Ʈ���� ���๮���� ������ �߻��� ���� ������, �����(�߰��� ��)�� ����� �� �ִ�.	
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
	DBMS_OUTPUT.PUT_LINE('Ʈ���� �׽�Ʈ �Դϴ�');
 	DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :old.LOC);
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :new.LOC);
END;
COMMIT;
UPDATE SCOTT.DEPT SET LOC = 'HONGDAE' WHERE DEPTNO = 60;

-----------------------------------------------------------
CREATE OR REPLACE TRIGGER sum_trigger
BEFORE
INSERT OR UPDATE ON emp
FOR EACH ROW
DECLARE
    -- ������ ������ ���� DECLARE���� ����ؾ� �Ѵ� 
    avg_sal VARCHAR2(10);
BEGIN
    SELECT TO_CHAR(ROUND(AVG(sal),3))
    INTO avg_sal
    FROM emp;

    DBMS_OUTPUT.PUT_LINE('�޿� ��� : ' || avg_sal);
END;

INSERT INTO EMP(EMPNO, ENAME, JOB, HIREDATE, SAL)
VALUES(4000, 'LION', 'SALES', SYSDATE, 5000);
-----------------------------------------------------
