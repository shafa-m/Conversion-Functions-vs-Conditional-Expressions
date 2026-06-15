#Conversion Functions və Conditional Expressions

Conversion və conditional funksiyalar olan NVL, NULLIF və COALESCE mövzularının izahi.
Bu funksiyalar SQL-də NULL dəyərlərlə işləmək və sorğularda məntiq qurmaq üçün istifadə olunur.

NVL → NULL dəyəri verilən başqa bir dəyərlə əvəz edir.
NULLIF → iki dəyər eynidirsə NULL qaytarır.
COALESCE → soldan sağa ilk NULL olmayan dəyəri qaytarır.

Bu funksiyalar data analiz, hesabatların hazırlanması və çatışmayan məlumatların idarə olunması üçün çox vacibdir.
Oracle SQL-də NVL, NULLIF və COALESCE funksiyaları NULL dəyərlərlə işləmək üçün istifadə olunur.

1. NVL Function
 Əgər dəyər NULL-dursa, onu başqa dəyərlə əvəz edir.

Sintaksizi aşağıdaki kimi olacaq:
NVL(expression, replacement_value)
NVL-in istifadə məqsədi əgər dəyər NULL-dursa, onu başqa dəyərlə əvəz edir.
HR Schema Nümunəsi

employees cədvəlində bəzi işçilərin komissiyası yoxdur (commission_pct NULL-dur).

SELECT employee_id,
       first_name,
       commission_pct,
       NVL(commission_pct, 0) AS commission
FROM employees;
--Kommisiyasi null olan  dəyərlər  0-la əvəz ediləcək


ommission_pct	commission
NULL	           0
0.2	              0.2

Note;NVL() funksiyasında hər iki parametr eyni tipdə olmalıdır və ya Oracle onları uyğun tipə çevirə bilməlidir.


NVL(commission_pct, 0) AS commission
Burada:
commission_pct → NUMBER tipidir.
0 → NUMBER tipidir.

Əgər belə yazilsa:
NVL(commission_pct, 'No Commission') AS commission

Oracle commission_pct sütununu NUMBER kimi gözləyir, 'No Commission' isə VARCHAR2-dir. Oracle mətni rəqəmə çevirməyə çalışır və xəta verir

Əgər  mətn tipində "No Commission" göstərmək istəyiriksə, əvvəlcə rəqəmi mətnə çevirməlisən:

NVL(TO_CHAR(commission_pct), 'No Commission') AS commission

2. NULLIF Function

 İki ifadə eynidirsə NULL qaytarır, fərqlidirsə birinci ifadəni qaytarır.

Sintaksis
NULLIF(expr1, expr2)

Bu:

CASE
   WHEN expr1 = expr2 THEN NULL
   ELSE expr1
END

ilə eynidir.

HR Schema Nümunəsi
SELECT employee_id,
       salary,
       NULLIF(salary, 24000) AS result
FROM employees;
Nəticə

salary	result
24000	NULL
17000	17000
-------------------------
3. COALESCE Function

Soldan sağa ilk NULL olmayan dəyəri qaytarır.

Sintaksis
COALESCE(expr1, expr2, expr3, ...)

HR Schema Nümunəsi
SELECT employee_id,
       COALESCE(commission_pct, salary, 0) AS value
FROM employees;

Əgər:

commission_pct NULL deyilsə → onu qaytarır
commission_pct NULL-dursa → salary-ni qaytarır
salary də NULL olsa → 0 qaytarır


Sadə Nümunə
SELECT COALESCE(NULL,NULL,100,200)
FROM dual;

Nəticə:

100

2. NVL2 Function
NULL olub-olmamasına görə 2 fərqli nəticə qaytarmaq

Sintaksisaşağıdaki kimi olacaq:
NVL2(expr, value_if_not_null, value_if_null)
Məntiq:
expr NOT NULL → value_if_not_null
expr NULL → value_if_null
Nümunə:
SELECT NVL2(commission_pct, 'Has Commission', 'No Commission')
FROM employees;

Nəticə:
commission_pct	  nəticə
NULL	          No Commission
0.2	              Has Commission
Əsas fərqlər

Xüsusiyyət	     NVL         	             NVL2
Parametr sayı	 2	                         3
Məqsəd	         NULL-u əvəz edir	         NULL / NOT NULL logic
NOT NULL halda	 orijinal dəyər	             ikinci parametr
NULL halda	     default dəyər	             üçüncü parametr
İstifadə	     sadə replacement	         branching logic

2. DECODE Function
DECODE Oracle-un IF-ELSE / CASE WHEN alternatividir.

Sintaksis

Məntiq
expression = value1 → result1
expression = value2 → result2
heç biri uyğun gəlməzsə → default
HR Schema Nümunə

employees cədvəlində job_id üzrə status:

SELECT employee_id,
       job_id,
       DECODE(job_id,
              'IT_PROG', 'IT Department',
              'SA_REP', 'Sales Department',
              'Other Department') AS department_name
FROM employees;

Nəticə

job_id	    department_name
IT_PROG	    IT Department
SA_REP	    Sales Department
ST_CLERK	Other Department
---
SELECT employee_id,
       salary,
       DECODE(salary,
              24000, 'High',
              10000, 'Medium',
              'Low') AS salary_level
FROM employees;

