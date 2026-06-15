select * from v$version; --- 18c
select user from dual;
select * from employees;
select sysdate from dual;

--1. NVL Function
 --Əgər dəyər NULL-dursa, onu başqa dəyərlə əvəz edir.
select 
    first_name,
    last_name, 
    commission_pct,
    NVL(commission_pct,0) as commission_pct
from employees;

--Kommisiyasi null olan  dəyərlər  0-la əvəz ediləcək

--2. NULLIF Function

/* case when mentiqi ile eynidir
CASE
   WHEN expr1 = expr2 THEN NULL
   ELSE expr1
END*/

SELECT employee_id,
       salary,
       NULLIF(salary, 24000) AS result
FROM employees;

-------------------------
--3. COALESCE Function

--Soldan sağa ilk NULL olmayan dəyəri qaytarır.

SELECT employee_id,
       COALESCE(commission_pct, salary, 0) AS value
FROM employees;

--Sadə Nümunə
SELECT COALESCE(NULL,NULL,100,200)
FROM dual;
--Nəticə:
--100

--4. NVL2 Function
--NULL olub-olmamasına görə 2 fərqli nəticə qaytarmaq

SELECT NVL2(commission_pct, 'Has Commission', 'No Commission')
FROM employees;

--5. DECODE Function
--DECODE Oracle-un IF-ELSE / CASE WHEN alternatividir.
SELECT employee_id,
       job_id,
       DECODE(job_id,
              'IT_PROG', 'IT Department',
              'SA_REP', 'Sales Department',
              'Other Department') AS department_name
FROM employees;

---
SELECT employee_id,
       salary,
       DECODE(salary,
              24000, 'High',
              10000, 'Medium',
              'Low') AS salary_level
FROM employees;


