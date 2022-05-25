set hidden param parseThreshold = 150000;   
-- 용량을 늘리는 line

SHOW USER;
-- USER이(가) "HR"입니다.

SELECT * FROM dba_users;
-- ORA-00942: table or view does not exist
-- dba_users 는 관리자만 조회할 수 있는 것이지, 일반 사용자인 hr 은 조회가 불가하다는 말이다.


-- //////////////////////////////////////////////////////////////////////// --

/*
    ORACLE 은 관계형 데이터베이스(Relation DataBase) 관리 시스템(Management System) 이다.
    
    RDBMS (Relation DataBase Management System) 란?
    ==> 데이터를 열(Column, Field)과 행(Row, Record, Tuple) 으로 이루어진 테이블(Table, Entity(개체), Relation) 형태로 
        저장해서 관리하는 시스템을 말한다.    
*/

-- ** 현재 오라클 서버에 접속된 사용자(지금은 hr)가 만든(소유의) 테이블(Table) 목록을 조회하겠다. **--
SELECT * 
FROM TAB;
/*
-----------------------------
TNAME               TABTYPE 
-----------------------------
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	(VIEW 는 TABLE 은 아니지만, select 조회된 결과물을 마치 TABLE 처럼 보는 것이다.)
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS         	TABLE	
*/

-- sql 명령어는 대,소문자를 구분하지 않는다. 
-- 테이블명과 컬럼명도 대,소문자를 구분하지 않습니다.

SELECT *
FROM departments;

SELECT *
FROM departments;

SELECT *
FROM departments;

SELECT department_id, department_name
FROM departments;

SELECT department_id, department_name
FROM departments;

SELECT department_id, department_name
FROM departments;

--- !!! 저장된 ★★데이터 값★★ 만큼은 반드시 대,소문자를 구분한다. !!! ---
SELECT *
FROM departments
WHERE department_name = 'IT'; -- 조회되어서 나온다.

SELECT *
FROM departments
WHERE department_name = 'it'; -- 아무것도 안나온다.

SELECT *
FROM departments
WHERE department_name = 'It'; -- 아무것도 안나온다.

SELECT *
FROM departments
WHERE department_name = 'Sales';

SELECT *
FROM departments
WHERE department_name = 'sales'; -- 아무것도 안나온다.

--------------------------------------------------------------------------------

--- 어떤 테이블의 Column의 구성을 알고자 한다면 아래와 같이 하면 됩니다. ---

DESCRIBE departments; -- departments 테이블의 컬럼(column)의 정보를 알려주는 것이다.
-- 또는 
DESC departments;     -- "부서" 테이블 // 굳이 DESCRIBE 다 쓸 필요 없이 DESC 만 써도 결과는 똑같다.

/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)    
*/

SELECT *
FROM employees; -- "사원" 테이블

DESC employees;
/*
이름                              널?               유형           
--------------                  --------        ------------ 
EMPLOYEE_ID     (사원번호)       NOT NULL          NUMBER(6)         -999999 ~ 999999 이내의 값만 들어온다.
FIRST_NAME      (이름)                            VARCHAR2(20)      문자열 최대 20 byte 까지만 들어온다.
LAST_NAME       (성)            NOT NULL          VARCHAR2(25)      문자열 최대 25 byte 까지만 들어온다.
EMAIL           (이메일)         NOT NULL          VARCHAR2(25) 
PHONE_NUMBER    (연락처)                           VARCHAR2(20) 
HIRE_DATE       (입사일자)       NOT NULL          DATE              날짜만 들어온다.
JOB_ID          (직종)          NOT NULL          VARCHAR2(10)      
SALARY          (기본급여)                         NUMBER(8,2)       -999999.99 ~ 999999.99 이내의 값만 들어온다. (8,소수부)
COMMISSION_PCT  (커미션[수당]퍼센티지)               NUMBER(2,2)       -0.99 ~ 0.99      
MANAGER_ID      (직속상관[사수]의 사원번호)           NUMBER(6)    
DEPARTMENT_ID   (해당사원이 근무하는 부서번호)         NUMBER(4)   
*/

SELECT *
FROM locations; -- 부서의 위치정보를 알려주는 테이블.

SELECT *
FROM countries; -- 국가정보를 알려주는 테이블

SELECT *
FROM regions;   -- 대륙정보를 알려주는 테이블

--------------------------------------------------------------------------------

/*
    === ★★★★★★★★★★★ 매우 중요 ★★★★★★★★★★★ !!! ===
    === ★★★★★★★★★★★ 필수 암기 ★★★★★★★★★★★ !!! ===
    
    == 어떠한 테이블(또는 뷰)에서 데이터 정보를 꺼내와 보는 명령어인 select 의 처리 순서 ==
    
    select 컬럼명, 컬럼명, ... -- ⑤ 컬럼명 대신에 *(아스테리크)을 쓰면 모든 컬럼을 뜻하는 것이다. (보고싶은 컬럼 기입)
    from 테이블명(또는 뷰명)    -- ①
    where 조건절              -- ② where 조건절이 뜻하는 것은 해당 테이블명 (또는 뷰명)에서 조건에 만족하는 행(row)을 메모리(RAM)에 로딩(올리는 것)을 해주는 것이다.
    group by 절              -- ③
    having 그룹함수조건절      -- ④
    order by 절              -- ⑥ (정렬)
    
   ▶ 항상 from 부터 쓴다. (select 부터 쓰지 말 것.!!!)     
*/

------------------------------------------------------------------------------

----- *** NULL 을 처리해주는 함수 *** -----
----- NULL 은 존재하지 않는 것이므로 사칙연산(+,-,*,/)에 NULL이 포함되면 그 결과는 무조건 NULL 이 된다.

--1. NVL

    SELECT '안녕하세요'
    FROM dual;  -- dual 은 select 다음에 나오는 값들을 화면에 보여주기 위한 용도로 쓰이는 가상테이블이다.(여기서는 '안녕하세요')

    SELECT 1+2, 2-1, 3*2, 5/2, 
           1+NULL, 2-NULL, 0*NULL, 5/NULL
    FROM dual;

    SELECT nvl(7,3), nvl(NULL,3),       -- 첫번째 값이 null 인가? 아니라면 그대로 그 값 출력. 그 값이 null 이면, 그 다음 값 출력.
           nvl('이순신','거북선'), nvl(NULL,'거북선')
    FROM dual;

-- 2. NVL2

    SELECT nvl2(7,3,2), nvl2(NULL,3,2),       -- 첫번째 값이 null 인가? 아니라면 다음 값 출력. 그 값이 null 이면, 그 다음다음 값 출력.
           nvl2('이순신','거북선','구국영웅'), nvl2(NULL,'거북선','구국영웅')
    FROM dual;


    -- employees(직원) 테이블에서 부서번호(department_id)가 60번에 근무하는 사원들만 
    -- 사원번호, 사원명, 기본급여, 커미션퍼센티지, 부서번호를 나타내세요.
    
    SELECT employee_id, first_name, last_name, salary, commission_pct, department_id
    FROM employees     -- employees 테이블에서 전체 행(직원이 107명)을 메모리에 다 퍼올리세요! ▶ where 절을 쓰지 않는 것임.
    WHERE department_id = 60;   -- where 절이 있으므로 department_id 컬럼의 값이 60인 행들만 메모리(RAM)에 올라간다.
      
    -- employees(직원) 테이블에서 모든 사원들에 대해
    -- 사원번호, 사원명, 기본급여, 커미션퍼센티지, 부서번호를 나타내세요.    
    SELECT employee_id, first_name, last_name, salary, commission_pct, department_id
    FROM employees;  -- 메모리에 전부다 올라가는 거면 where 절 안쓰고, 골라와야함.
    -- where 절이 없으므로 employees 테이블에 있는 모든 행들이 메모리(RAM)에 올라간다.

    -- COMMISSION_PCT 컬럼이 뜻하는 바는 다음과 같다.
    -- COMMISSION_PCT 컬럼의 값이 null 이라면 수당(commission)이 존재하지 않는다는 뜻이고,
    -- COMMISSION_PCT 컬럼의 값이 0.3 이라면 salary(기본급여)의 30% 가 수당이 된다는 뜻이다.
    -- SALARY   COMMISSION_PCT  SALARY*COMMISSION_PCT
    -- 1000      0.3            300
    -- 2000      0.3            600
    -- 4000      0.3            1200
    -- 5000      null           null
    
    
    -- employees(직원) 테이블에서 모든 사원들에 대해
    -- 사원번호, 사원명, 기본급여, 커미션퍼센티지, 월급, 부서번호를 나타내세요.
    --> "월급"은 기본급여 + 수당액을 합친것을 말한다. 
    
    SELECT employee_id, first_name, last_name, salary, commission_pct, 
           salary + (salary * commission_pct), department_id
    FROM employees; -- 잘못구한것

    SELECT employee_id, first_name, last_name, salary, commission_pct, 
           nvl(salary + (salary * commission_pct), salary) ,department_id   -- ▶ 앞의 값이 null 이면, 그 다음값으로 나와라. (수당이 없는 사람한테는 salary가 null로 나오면 안되므로 적용)
    FROM employees; -- 올바르게 구한것

    SELECT employee_id, first_name, last_name, salary, commission_pct,  
           nvl(salary + (salary * commission_pct), salary) ,                -- ▶ 앞의 값이 null 이면, 그 다음값으로 나와라.
           nvl2(commission_pct, salary + (salary * commission_pct), salary) -- ▶ 앞의 값이 null 이 아니면, 그 다음값으로 나와라. // null 이면 그 다음다음값으로 나와라.
           , department_id   
    FROM employees; -- 올바르게 구한것


    --- *** 컬럼에 대해 별칭(Alias) 부여하기 *** ---
    SELECT employee_id AS "사원번호"
        , first_name "이름"   -- 별칭(Alias) 에서 AS 는 생략가능함.
        , last_name  성       -- 별칭(Alias) 에서 "" 는 생략가능함.
        , salary  "기본 급여"  -- 별칭(Alias) 에서 글자 사이에 공백을 주고자 한다면 반드시 "" 로 해주어야 한다.
        , commission_pct 커미션퍼센티지
        , nvl(salary + (salary * commission_pct), salary) 월급1
        , nvl2(commission_pct, salary + (salary * commission_pct), salary) 월급2
        , department_id 부서번호
    FROM employees; -- 올바르게 구한것


    -------------------- **** 비교연산자 **** --------------------
/*
   1. 같다                    = 
   2. 같지않다                !=  <>  ^= 
   3. 크다. 작다              >   <
   4. 같거나크다. 같거나작다    >=       <= 
   5. NULL 은 존재하지 않는 것이므로 비교대상이 될 수가 없다.
      그러므로 비교연산( =  != <> ^= >  <  >=  <= )을 할수가 없다.
      그래서 비교연산을 하려면 nvl()함수, nvl2()함수를 사용하여 처리한다. 
      (★눈에 보여야 같느냐 같지않냐를 판단할 수 있기 때문!!)
*/   
    -- 오라클에서 컬럼들을 붙일때(연결할때)는 문자 타입이든 숫자 타입이든 날짜 타입이든 관계없이 ||(수직바,파이프,버티컬라인) 를 쓰면 된다. 
    --(숫자는 오른쪽 맞춤, 문자''&날짜 는 왼쪽맞춤)
    SELECT sysdate  --현재날짜시각을 알려주는 것
    FROM dual;
    
    SELECT '서울시'||' '||'마포구 쌍용강북교육센터' || 1234  || sysdate  
    FROM dual;
       
    -- employees(직원) 테이블에서 부서번호(department_id)가 60번에 근무하는 사원들만 
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요.
    SELECT  department_id AS "사원번호"
            , first_name || ' ' || last_name AS "사원명"
            , nvl( salary + (salary*commission_pct), salary ) AS "월급"
            , department_id AS 부서번호
    FROM employees
    WHERE department_id = 60

    DESC employees;
    
    SELECT first_name, department_id
    FROM employees;

    SELECT first_name, department_id, nvl(department_id, -9999)
    FROM employees;
    
    SELECT department_id
    FROM departments;   -- "부서" 테이블
    
    -- employees(직원) 테이블에서 부서번호(department_id)가 NULL 인 사원들만 
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요.
    --  5. NULL 은 존재하지 않는 것이므로 비교대상이 될 수가 없다.
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS 부서번호
    FROM employees
    WHERE nvl(department_id, -9999) = -9999;
 
    -- 또는
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS 부서번호
    FROM employees
    WHERE department_id IS NULL;    -- NULL 은 is 를 사용하여 구한다.
                                    -- department_id 컬럼의 값이 null 인 행들만 메모리(RAM)에 퍼올리는 것이다.
 
    -- employees(직원) 테이블에서 부서번호(department_id) 60번에 근무하지 않는 사원들만 
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요.
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE nvl(department_id, -9999) != 60;
 -- where nvl(department_id, -9999) <> 60;
 -- where nvl(department_id, -9999) ^= 60;
    
    -- employees(직원) 테이블에서 부서번호(department_id) NULL 이 아닌 사원들만 
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요.   
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS 부서번호
    FROM employees
    WHERE nvl(department_id, -9999) = -9999;
 
   -- 또는
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE department_id IS NOT NULL; 
    
   -- 또는
   -- (부정은 컬럼명 앞에 쓴다.)
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE NOT department_id IS NULL; 
    
   -- 또는
   -- (부정은 컬럼명 앞에 쓴다.)
   SELECT  employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , nvl( salary + (salary*commission_pct), salary ) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE NOT (department_id IS NULL); 
        
   ----------------------------------------------------------------------------- 
   ----- ** select 되어져 나온 데이터를 정렬(오름차순정렬, 내림차순정렬)하여 보여주기 ** ----- 
    SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    ORDER BY salary ASC;    -- salary 컬럼의 값을 오름차순정렬하여 보여라.(ascending)

    SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    ORDER BY salary DESC;    -- salary 컬럼의 값을 내림차순정렬하여 보여라.(descending)

    SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    ORDER BY salary ;        -- asc 는 생략가능하다. (생략 시, 자동으로 오름차순 정렬임. 그러나 dsc는 꼭 적어야함.)

    -- employees(직원) 테이블에서 부서번호(department_id) NULL 이 아닌 사원들만 
    -- 사원번호, 사원명, 월급, 부서번호를 나타내는데 월급의 내림차순으로 보여주세요.
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , nvl(salary+(salary*commission_pct), salary) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE department_id IS NOT NULL
    ORDER BY nvl(salary+(salary*commission_pct), salary) DESC;

-- 또는
-- order by 란에 nvl~~~ 대신 "월급" 으로 대체해서 쓸 수 있다. (AS 는 = 으로 해석된다.)
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , nvl(salary+(salary*commission_pct), salary) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE department_id IS NOT NULL
    ORDER BY "월급" DESC;

-- 또는
-- order by 란에 보이는 컬럼의 순서(3)를 보인다. (nvl~~~, "월급" 대신에 컬럼순서 3을 씀)
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , nvl(salary+(salary*commission_pct), salary) AS "월급"
        , department_id AS "부서번호"
    FROM employees
    WHERE department_id IS NOT NULL
    ORDER BY 3 DESC;

-- employees(직원) 테이블에서 부서번호(department_id) NULL 이 아닌 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내는데 
-- 먼저 부서번호의 오름차순으로 정렬한 후, 
-- 동일한 부서번호 내에서는 월급의 내림차순으로 보여주세요.        
SELECT employee_id AS "사원번호"
    , first_name ||' '|| last_name AS "사원명"
    , nvl(salary+(salary*commission_pct), salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
WHERE department_id IS NOT NULL
ORDER BY 4 ASC, 3 DESC;
-- ▲ order by 란에서는 숫자 대신 "부서번호", "월급"을 각각 사용할 수 있다.     

-- 또는
SELECT employee_id AS "사원번호"
    , first_name ||' '|| last_name AS "사원명"
    , nvl(salary+(salary*commission_pct), salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
WHERE department_id IS NOT NULL
ORDER BY "부서번호", "월급" DESC;
-- ▲ "부서번호" 까지 모두 뒤에 있는 decs 로 묶여있는 것이 아니라, 부서번호 뒤에 asc가 생략되어있는 것이기 때문에 부서번호는 asc / 월급은 desc 이다.

SELECT employee_id AS "사원번호"
    , first_name ||' '|| last_name AS "사원명"
    , nvl(salary+(salary*commission_pct), salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
WHERE department_id IS NOT NULL
ORDER BY 4, 3 DESC;
-- ▲ 4는 오름차순, 3은 내림차순이다. (4까지 desc로 묶여있는 것이 아니다.!!!)    


-- employees(직원) 테이블에서 모든 사원들에 대해
-- 사원번호, 사원명, 월급, 부서번호를 나타내는데 
-- 먼저 부서번호의 오름차순으로 정렬한 후, 
-- 동일한 부서번호 내에서는 월급의 내림차순으로 보여주세요.    
SELECT employee_id AS "사원번호"
    , first_name ||' '|| last_name AS "사원명"
    , nvl(salary+(salary*commission_pct), salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
ORDER BY "부서번호" ASC, "월급" DESC;  

-- 어떤 컬럼의 값이 null 이면, 비교를 할 수 없기 때문에 제일 큰 것으로 간주한다. (ex. 부서번호 정렬시 맨 밑에 위치해있음.)
-- ▶ 오라클에서 null 은 존재하지 않는 것이므로 정렬시 가장 큰것으로 간주한다.
-- 그러므로 오름차순 정렬시, null 은 맨 뒤에 나오고,
-- 내림차순 정렬시, null 은 맨 처음에 나온다.
/*
    참고로 Microsoft 사에서 만든 MS-SQL 서버에서는 null 은 정렬시 가장 작은 것으로 간주하기에
    오라클과 반대로 나온다. 
    즉, 오름차순 정렬시 null 은 맨 처음에 나오고, 내림차순 정렬시 null 은 맨 뒤에 나온다.
*/

/*
    employees 테이블에서 수당퍼센티지가 null 인 사원들만 
    사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되
    먼저 부서번호의 오름차순으로 정렬한 후, 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요.
*/
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , nvl(salary + (salary*commission_pct),salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
WHERE commission_pct IS NULL
ORDER BY 4, 3 DESC;

/*
    employees 테이블에서 부서번호가 50번 부서에 근무하지 않는 사원들만 
    사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되
    먼저 부서번호의 오름차순으로 정렬한 후, 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요.
*/
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , nvl(salary + (salary*commission_pct),salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
WHERE nvl(department_id,-9999) != 50
ORDER BY 4, 3 DESC;
-- ▶ kimberly 가 나오게 하기 위해서 where 절에 nvl을 사용한다.
/*
    employees 테이블에서 월급(기본급여+수당금액)이 10000보다 큰 사원들만 
    사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되
    먼저 부서번호의 오름차순으로 정렬한 후, 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요.
*/
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , nvl(salary + (salary*commission_pct),salary) AS "월급"
    , department_id AS "부서번호"
FROM employees
WHERE nvl(salary + (salary*commission_pct),salary) > 10000
ORDER BY 4 ASC, 3 DESC;
-- 위에 where 에서 "월급"을 대신 넣으면 안됨. 해석순서가 where 다음에 select 이므로, where에서 "월급"을 사용하면 테이블에서 별명인 "월급"을 인식할 수 없으므로 오류가 발생한다.


------------ *** AND OR IN() NOT 연산자 *** ------------
-- or는 in의 역할도 한다.
/*
    employees 테이블에서 80번 부서에 근무하는 사원들 중에 기본급여가 10000 이상인 
    사원들만 사원번호, 사원명, 기본급여, 부서번호를 나타내세요.
*/
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , salary AS "기본급여"
    , department_id AS "부서번호"
FROM employees
WHERE department_id = 80 AND 
      salary >= 10000;

/*
    employees 테이블에서 30번, 60번, 80번 부서에 근무하는 
    사원들만 사원번호, 사원명, 기본급여, 부서번호를 나타내세요.
*/
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , salary AS "기본급여"
    , department_id AS "부서번호"
FROM employees
WHERE department_id = 30 OR 
      department_id = 60 OR 
      department_id = 80
ORDER BY "부서번호" ASC;

-- 또는 ▼ 아래처럼 where 라인에 or or를 일일이 쓰는 대신 in( , , ) 이런식으로 한번에 묶어서 쓸 수 있다.
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , salary AS "기본급여"
    , department_id AS "부서번호"
FROM employees
WHERE department_id IN(30, 60, 80)
ORDER BY "부서번호" ASC;

/*
    employees 테이블에서 30번, 60번, 80번 부서에 근무하지 않는 
    사원들만 사원번호, 사원명, 기본급여, 부서번호를 나타내세요.
*/
-- null 은 비교연산자를 사용할 수 없기 때문에 nvl을 붙임으로써 null 인 값이 나오게 한다. (null 은 제일 큰 값이므로 오름차순 시 맨 밑에 오게 된다.)
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , salary AS "기본급여"
    , department_id AS "부서번호"
FROM employees
WHERE nvl(department_id, -9999) != 30 AND 
      nvl(department_id, -9999) != 60 AND
      nvl(department_id, -9999) != 80
ORDER BY "부서번호" ASC;

-- 또는
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , salary AS "기본급여"
    , department_id AS "부서번호"
FROM employees
WHERE nvl(department_id,-9999) NOT IN(30, 60, 80)
ORDER BY "부서번호" ASC;

-- 또는 ▼ not을 where 뒤에 붙여도 되고, in 앞에 붙여도 된다.
SELECT employee_id AS "사원번호"
    , first_name || '' || last_name AS "사원명"
    , salary AS "기본급여"
    , department_id AS "부서번호"
FROM employees
WHERE NOT nvl(department_id,-9999) IN(30, 60, 80)
ORDER BY "부서번호" ASC;

/*
    [퀴즈]
   -- employees 테이블에서 부서번호가 30, 50, 60번 부서에 근무하는 사원들중에 
   -- 연봉(월급*12)이 20000 이상 60000 이하인 사원들만 
   -- 사원번호, 사원명, 연봉(월급*12), 부서번호를 나타내되 
   -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 연봉의 내림차순으로 나타내세요.
*/ -- ▼ 내풀이 ▼ (맞게 나오긴 함..)
SELECT employee_id AS "사원번호"
      , first_name ||''|| last_name AS "사원명"
      , salary*12 AS "연봉"
      , department_id AS "부서번호"
FROM employees
WHERE department_id IN(30, 50, 60) AND
      salary*12 >=20000 AND salary*12 <= 60000
ORDER BY "부서번호" ASC, "연봉" DESC;  

-- ▼ 틀린 아래풀이 ▼ : 아래에서 where 절에서 and 먼저 실행되고 그 다음에 or가 실행되므로 값이 잘못 나오게 된다.
-- ① 부서번호 60번만 적용(and 먼저 실행) ② 30,50번은 연봉에 제약을 받지 않게됨(or가 and 다음에 실행되기 때문에) → 그러므로 60000 이상, 20000이하의 연봉인 사원도 결과가 나옴. (부서번호만 맞으면 값이 나옴)
SELECT employee_id AS "사원번호"
      , first_name ||''|| last_name AS "사원명"
      , salary*12 AS "연봉"
      , department_id AS "부서번호"
FROM employees
WHERE department_id = 30 OR department_id = 50 OR department_id = 60 AND
      nvl(salary+(salary*commission_pct),salary)*12 >=20000 AND 
      nvl(salary+(salary*commission_pct),salary)*12 <= 60000
ORDER BY "부서번호" ASC, "연봉" DESC;  --> 풀이는 틀린것이다.!!

/*
    !!! AND 와 OR 가 혼용되어지면 우선순위는 AND 가 먼저 실행된다. !!!
    그러므로 연산자에 있어서 가장 최우선은 ★괄호( )★ 가 제일 우선한다.
*/
-- ▼ 정답풀이 ▼ : where 맨 처음 라인에 ( ) 를 해줌으로써 제일 먼저 계산되게끔 설정한다.
-- IN 은 괄호가 있는 OR 이다.
SELECT employee_id AS "사원번호"
      , first_name ||''|| last_name AS "사원명"
      , salary*12 AS "연봉"
      , department_id AS "부서번호"
FROM employees
WHERE (department_id = 30 OR department_id = 50 OR department_id = 60) AND
      nvl(salary+(salary*commission_pct),salary)*12 >=20000 AND 
      nvl(salary+(salary*commission_pct),salary)*12 <= 60000
ORDER BY "부서번호" ASC, "연봉" DESC;  

-- 또는
SELECT employee_id AS "사원번호"
      , first_name ||''|| last_name AS "사원명"
      , salary*12 AS "연봉"
      , department_id AS "부서번호"
FROM employees
WHERE department_id IN(30, 50, 60) AND
      nvl(salary+(salary*commission_pct),salary)*12 >=20000 AND 
      nvl(salary+(salary*commission_pct),salary)*12 <= 60000
ORDER BY "부서번호" ASC, "연봉" DESC;--> 올바른 풀이.  

-- 그러나, ★대용량★ DATABASE 에서는, IN 대신에 ★OR★ 를 사용함. (ex. 100만개 이상(대용량) 속도가 더 빠르다!!)
-- IN 은 괄호가 있는 OR 이다.



---- *** 범위 연산자 *** ----
/*
    범위 연산자의 데이터는 숫자, 문자, 날짜 모두가 사용된다.
    >  <  >=  <=
    between A and B --> A 부터 B 까지
*/

---- *** == 현재 시각을 알려주는 것 == *** ----
SELECT sysdate, current_date
       , localtimestamp, current_timestamp
       systimestamp -- 왜 current_timestamp 가 안나오지??
FROM dual;
-- 22/01/05  22/01/05      
-- 22/01/05 12:07:36.0000000
-- 22/01/05 12:07:36.000000000 ASIA/SEOUL
-- 
/*
   날짜타입은 date 이다.
   date 타입의 기본적인 표현방식은 'RR/MM/DD' 으로 나타내어진다.
   RR 은 년도의 2자리만 나타내어주는데 50 ~ 99 는  1950 ~ 1999 을 말하는 것이다.
   RR 은 년도의 2자리만 나타내어주는데 00 ~ 49 는  2000 ~ 2049 을 말하는 것이다.
   MM 은 월이고, DD 는 일이다.
*/

SELECT sysdate
    , to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss')
    , to_char(sysdate, 'yyyy-mm-dd pm hh:mi:ss')
    , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')    
    , to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')        
FROM dual;

DESC employees;
-- HIRE_DATE 컬럼의 타입은 DATE(날짜)이다.

SELECT employee_id AS "사원번호"
    , first_name ||''|| last_name AS "사원명"
    , hire_date AS "입사일자1"   -- 'RR/MM/DD'
    , to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') AS "입사일자2" -- 원래의 hire_date 포맷을 오른쪽의 문자로 바꿔서 보여라!
FROM employees;

-- employees 테이블에서 employee_id 컬럼의 값이 154 인 사원의 hire_date(입사일자) 컬럼의 값을 '2006-12-09 00:00:00' 에서
-- '2006-12-31 09:00:00' 으로 변경하겠다.
UPDATE employees SET hire_date = '2006-12-31 09:00:00'  --set hire_date = '2006-12-09 00:00:00'에서 = 은 대입한다는 말이다. and -- 문자열'' 은 date에 들어갈 수 없다.
WHERE employee_id = 154;    -- where 절 다음에 '=' 는 '같다'라는 말이다.
/*
오류보고 -
ORA-01861: literal does not match format string
*/

UPDATE employees SET hire_date = TO_DATE('2006-12-31 09:00:00' , 'yyyy-mm-dd hh24:mi:ss') 
WHERE employee_id = 154;
-- 1 행 이(가) 업데이트되었습니다.

COMMIT;
-- 커밋 완료.

-- employees 테이블에서 입사일자가 2005년 1월 1일 부터 2006년 12월 31일 까지 입사한 사원들만 
-- 사원번호, 사원명, 입사일자를 나타내세요.
-- >=,<= 같은 부등호는 숫자 뿐만 아니라 ★날짜, 문자★ 에도 쓰인다.!!!
-- 범위를 구할 때에는 숫자,날짜,문자 모두 가능하다.!!
SELECT employee_id AS "사원번호"
    , first_name ||''|| last_name AS "사원명"
    , hire_date AS "입사일자1"   -- 'RR/MM/DD'
    , to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') AS "입사일자2"
FROM employees
WHERE '05/01/01' <= hire_date AND hire_date <= '06/12/31'   -- 시,분,초를 빼면 무조건 0시 0분 0초이다.
ORDER BY "입사일자1" ASC;   -- 틀린풀이 이다.

--- !!!!! 중요 !!!!  날짜를 나타낼때 시,분,초 가 없는 년,월,일만 나타내어주면 자동적으로 0시0분0초가 된다.
--- 즉, 자정(그날의 시작)을 뜻한다.
-- (입사를 12월 31일 자정에 했습니다. 라고 하지않음. 그냥 입사가 그 날이면 날짜만 말함)

-- ▼ hire_date <= '06/12/31' 를 hire_date < '07/01/01'로 수정한다.!! (그렇게 되면 시간에 구애받지 않고 12월 31일에 입사하는 사람이면 결과가 모두 나옴.)
SELECT employee_id AS "사원번호"
    , first_name ||''|| last_name AS "사원명"
    , hire_date AS "입사일자1"   -- 'RR/MM/DD'
    , to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') AS "입사일자2"
FROM employees
WHERE '05/01/01' <= hire_date AND hire_date < '07/01/01'   -- 시,분,초를 빼면 무조건 0시 0분 0초이다.
ORDER BY "입사일자1" ASC;   -- 올바른 풀이★ 이다.

-- 범위를 구할 때에는 숫자,날짜,문자 모두 가능하다.!!
-- ASCII 코드 ▼
'A' --> 65
'a' --> 97
'0' --> 48
' ' --> 32
SELECT ASCII('A'), ASCII('a'), ASCII('0'), ASCII(' ')
FROM dual;
--          65           97	        48	        32


SELECT CHR(65), CHR(97), CHR(48), CHR(32)
FROM dual;
--          A	    a	    0	     

-- employees 테이블에서 first_name 컬럼의 값이 'Elj' 부터 'I' 까지인 데이터를 가지는 
-- 사원들만 first_name 을 출력하세요.
SELECT first_name
FROM employees
WHERE 'Elj' <= first_name AND first_name <= 'I'
ORDER BY 1;
--'Elj' 'Elja' 'EljaSt' 'Eljxafdsff' ~~~~~~ 'HAsdfsgf' 'I' / 'IA' 'IAsdfsgf'

SELECT first_name
FROM employees
WHERE first_name BETWEEN 'Elj' AND 'I'
ORDER BY 1;

/*
       대용량 데이터베이스인 경우 IN 연산자 보다는 ★ OR 를 사용하기를 권장★하고,
       대용량 데이터베이스인 경우 between A and B 보다는 ★ >= and <= 을 사용할 것을 권장 ★한다.
       왜냐하면 IN 연산자는 내부적으로 OR 로 변경된 후 실행되고, 
       between A and B 도 내부적으로 >= and <= 으로 변경된 후 실행되기 때문이다. 
       
      -- 대용량 데이터베이스의 기준은 어떤 테이블의 행의 개수가 100만건을 넘을 경우를 말한다.
      -- 소규모 데이터베이스의 기준은 어떤 테이블의 행의 개수가 1만건 미만인 경우를 말한다.
*/

    ------ *** employees 테이블에 jubun(주민번호) 이라는 컬럼을 추가해봅니다. *** --------
    /*
           jubun(주민번호) 컬럼의 값을 입력할때는 '-' 는 빼고 숫자로만 입력할 것입니다.
           jubun(주민번호) 컬럼의 값을 입력할 때 맨 처음 첫자리에 0 이 들어올 수 있다라면 
           number 타입이 아니라 varchar2 타입으로 해야 한다.
           왜냐하면 number 타입으로 해주면 맨 앞에 입력한 값이 0 일때는 0이 생략 되어지기 때문이다. (ex. select 0105053234567 ▶ 105053234567 으로 나옴)
           맨 앞의 0 도 나오게 하려면 컬럼의 데이터 타입은 varchar2 가 되어야 한다.
    */
    SELECT 0105053234567, '0105054234567'
    FROM dual;    
    --     105053234567    0105053234567

    ALTER TABLE employees
    ADD jubun VARCHAR2(13); -- employees 테이블에 jubun 이라는 컬럼을 추가해주는 것.
    -- Table EMPLOYEES이(가) 변경되었습니다.

    DESC employees;
    
    SELECT *
    FROM employees;
        
    UPDATE employees SET jubun = '6010151234567'
    WHERE employee_id = 100;
    -- 1 행 이(가) 업데이트되었습니다.
        
    ROLLBACK;   
    -- 롤백 완료.
    -- commit; 한 이후에 DML(Data Manipulation Language[데이터조작어] ==> insert, update, delete, merge) 명령어로
    -- 변경된 것을 이전 상태로 되돌리는 것.

    UPDATE employees SET jubun = '6010151234567'
    WHERE employee_id = 100;
    -- 1 행 이(가) 업데이트되었습니다.

    COMMIT;  
    -- 커밋 완료.
    -- DML(Data Manipulation Language[데이터조작어] ==> insert, update, delete, merge) 명령어로
    -- 변경된 것을 디스크에 적용시키는 것이다.
    -- commit; 한 이후로 rollback; 해도 이전 상태로 되돌아 가지 않는다. ▶ 취소가 안된다.!!
    
    UPDATE employees SET jubun = '8510151234567'
    WHERE employee_id = 101;
    -- 1 행 이(가) 업데이트되었습니다.
   
    UPDATE employees SET jubun = '6510151234567'
    WHERE employee_id = 102;
    -- 1 행 이(가) 업데이트되었습니다.
    
    SELECT *
    FROM employees;
         
    ROLLBACK;
    
    ----------------------------------------------------------------------------
    -- ▼ Employee_id 100번 ~206번까지 jubun 입력
    
    UPDATE employees SET jubun = '6010151234567'  
    WHERE employee_id = 100;

    UPDATE employees SET jubun = '8510151234567'
    WHERE employee_id = 101;
    
    UPDATE employees SET jubun = '6510152234567'
    WHERE employee_id = 102;
    
    UPDATE employees SET jubun = '7510151234567'
    WHERE employee_id = 103;
    
    UPDATE employees SET jubun = '6110152234567'
    WHERE employee_id = 104;
    
    UPDATE employees SET jubun = '6510151234567'
    WHERE employee_id = 105;
    
    UPDATE employees SET jubun = '6009201234567'
    WHERE employee_id = 106;
    
    UPDATE employees SET jubun = '0803153234567'
    WHERE employee_id = 107;
    
    UPDATE employees SET jubun = '0712154234567'
    WHERE employee_id = 108;
    
    UPDATE employees SET jubun = '8810151234567'
    WHERE employee_id = 109;
    
    UPDATE employees SET jubun = '8908152234567'
    WHERE employee_id = 110;
    
    UPDATE employees SET jubun = '9005052234567'
    WHERE employee_id = 111;
    
    UPDATE employees SET jubun = '6610151234567'
    WHERE employee_id = 112;
    
    UPDATE employees SET jubun = '6710151234567'
    WHERE employee_id = 113;
    
    UPDATE employees SET jubun = '6709152234567'
    WHERE employee_id = 114;
    
    UPDATE employees SET jubun = '6110151234567'
    WHERE employee_id = 115;
    
    UPDATE employees SET jubun = '6009301234567'
    WHERE employee_id = 116;
    
    UPDATE employees SET jubun = '6110152234567'
    WHERE employee_id = 117;
    
    UPDATE employees SET jubun = '7810151234567'
    WHERE employee_id = 118;
    
    UPDATE employees SET jubun = '7909151234567'
    WHERE employee_id = 119;
    
    UPDATE employees SET jubun = '7702152234567'
    WHERE employee_id = 120;
    
    UPDATE employees SET jubun = '7009151234567'
    WHERE employee_id = 121;
    
    UPDATE employees SET jubun = '7111011234567'
    WHERE employee_id = 122;
    
    UPDATE employees SET jubun = '8010131234567'
    WHERE employee_id = 123;
    
    UPDATE employees SET jubun = '8110191234567'
    WHERE employee_id = 124;
    
    UPDATE employees SET jubun = '9012132234567'
    WHERE employee_id = 125;
    
    UPDATE employees SET jubun = '9406251234567'
    WHERE employee_id = 126;
    
    UPDATE employees SET jubun = '9408252234567'
    WHERE employee_id = 127;
    
    UPDATE employees SET jubun = '9204152234567'
    WHERE employee_id = 128;
    
    UPDATE employees SET jubun = '8507251234567'
    WHERE employee_id = 129;
    
    UPDATE employees SET jubun = '6511111234567'
    WHERE employee_id = 130;
    
    UPDATE employees SET jubun = '0010153234567'
    WHERE employee_id = 131;
    
    UPDATE employees SET jubun = '0005254234567'
    WHERE employee_id = 132;
    
    UPDATE employees SET jubun = '0110194234567'
    WHERE employee_id = 133;
    
    UPDATE employees SET jubun = '0412154234567'
    WHERE employee_id = 134;
    
    UPDATE employees SET jubun = '0503253234567'
    WHERE employee_id = 135;
    
    UPDATE employees SET jubun = '9510012234567'
    WHERE employee_id = 136;
    
    UPDATE employees SET jubun = '9510021234567'
    WHERE employee_id = 137;
    
    UPDATE employees SET jubun = '9610041234567'
    WHERE employee_id = 138;
    
    UPDATE employees SET jubun = '9610052234567'
    WHERE employee_id = 139;
    
    UPDATE employees SET jubun = '7310011234567'
    WHERE employee_id = 140;
    
    UPDATE employees SET jubun = '7310092234567'
    WHERE employee_id = 141;
    
    UPDATE employees SET jubun = '7510121234567'
    WHERE employee_id = 142;
    
    UPDATE employees SET jubun = '7612012234567'
    WHERE employee_id = 143;
    
    UPDATE employees SET jubun = '7710061234567'
    WHERE employee_id = 144;
    
    UPDATE employees SET jubun = '7810052234567'
    WHERE employee_id = 145;
    
    UPDATE employees SET jubun = '6810251234567'
    WHERE employee_id = 146;
    
    UPDATE employees SET jubun = '6811062234567'
    WHERE employee_id = 147;
    
    UPDATE employees SET jubun = '6712052234567'
    WHERE employee_id = 148;
    
    UPDATE employees SET jubun = '6011251234567'
    WHERE employee_id = 149;
    
    UPDATE employees SET jubun = '6210062234567'
    WHERE employee_id = 150;
    
    UPDATE employees SET jubun = '6110191234567'
    WHERE employee_id = 151;
    
    UPDATE employees SET jubun = '5712062234567'
    WHERE employee_id = 152;
    
    UPDATE employees SET jubun = '5810231234567'
    WHERE employee_id = 153;
    
    UPDATE employees SET jubun = '6311051234567'
    WHERE employee_id = 154;
    
    UPDATE employees SET jubun = '6010182234567'
    WHERE employee_id = 155;
    
    UPDATE employees SET jubun = '6110191234567'
    WHERE employee_id = 156;
    
    UPDATE employees SET jubun = '6210112234567'
    WHERE employee_id = 157;
    
    UPDATE employees SET jubun = '6311132234567'
    WHERE employee_id = 158;
    
    UPDATE employees SET jubun = '8511112234567'
    WHERE employee_id = 159;
    
    UPDATE employees SET jubun = '8710131234567'
    WHERE employee_id = 160;
    
    UPDATE employees SET jubun = '8710072234567'
    WHERE employee_id = 161;
    
    UPDATE employees SET jubun = '9010171234567'
    WHERE employee_id = 162;
    
    UPDATE employees SET jubun = '9112072234567'
    WHERE employee_id = 163;
    
    UPDATE employees SET jubun = '9110241234567'
    WHERE employee_id = 164;
    
    UPDATE employees SET jubun = '9212251234567'
    WHERE employee_id = 165;
    
    UPDATE employees SET jubun = '9310232234567'
    WHERE employee_id = 166;
    
    UPDATE employees SET jubun = '9811151234567'
    WHERE employee_id = 167;
    
    UPDATE employees SET jubun = '9810252234567'
    WHERE employee_id = 168;
    
    UPDATE employees SET jubun = '9910301234567'
    WHERE employee_id = 169;
    
    UPDATE employees SET jubun = '0910153234567'
    WHERE employee_id = 170;
    
    UPDATE employees SET jubun = '1011153234567'
    WHERE employee_id = 171;
    
    UPDATE employees SET jubun = '1006153234567'
    WHERE employee_id = 172;
    
    UPDATE employees SET jubun = '1111154234567'
    WHERE employee_id = 173;
    
    UPDATE employees SET jubun = '1209103234567'
    WHERE employee_id = 174;
    
    UPDATE employees SET jubun = '1207154234567'
    WHERE employee_id = 175;
    
    UPDATE employees SET jubun = '0906153234567'
    WHERE employee_id = 176;
    
    UPDATE employees SET jubun = '0812113234567'
    WHERE employee_id = 177;
    
    UPDATE employees SET jubun = '9810132234567'
    WHERE employee_id = 178;
    
    UPDATE employees SET jubun = '8712111234567'
    WHERE employee_id = 179;
    
    UPDATE employees SET jubun = '8310012234567'
    WHERE employee_id = 180;
    
    UPDATE employees SET jubun = '6510191234567'
    WHERE employee_id = 181;
    
    UPDATE employees SET jubun = '6510221234567'
    WHERE employee_id = 182;
    
    UPDATE employees SET jubun = '6510232234567'
    WHERE employee_id = 183;
    
    UPDATE employees SET jubun = '8512131234567'
    WHERE employee_id = 184;
    
    UPDATE employees SET jubun = '8510182234567'
    WHERE employee_id = 185;
    
    UPDATE employees SET jubun = '7510192234567'
    WHERE employee_id = 186;
    
    UPDATE employees SET jubun = '8512192234567'
    WHERE employee_id = 187;
    
    UPDATE employees SET jubun = '9511151234567'
    WHERE employee_id = 188;
    
    UPDATE employees SET jubun = '7509302234567'
    WHERE employee_id = 189;
    
    UPDATE employees SET jubun = '8510161234567'
    WHERE employee_id = 190;
    
    UPDATE employees SET jubun = '9510192234567'
    WHERE employee_id = 191;
    
    UPDATE employees SET jubun = '0510133234567'
    WHERE employee_id = 192;
    
    UPDATE employees SET jubun = '0810194234567'
    WHERE employee_id = 193;
    
    UPDATE employees SET jubun = '0910183234567'
    WHERE employee_id = 194;
    
    UPDATE employees SET jubun = '1010134234567'
    WHERE employee_id = 195;
    
    UPDATE employees SET jubun = '9510032234567'
    WHERE employee_id = 196;
    
    UPDATE employees SET jubun = '9710181234567'
    WHERE employee_id = 197;
    
    UPDATE employees SET jubun = '9810162234567'
    WHERE employee_id = 198;
    
    UPDATE employees SET jubun = '7511171234567'
    WHERE employee_id = 199;
    
    UPDATE employees SET jubun = '7810172234567'
    WHERE employee_id = 200;
    
    UPDATE employees SET jubun = '7912172234567'
    WHERE employee_id = 201;
    
    UPDATE employees SET jubun = '8611192234567'
    WHERE employee_id = 202;
    
    UPDATE employees SET jubun = '7810252234567'
    WHERE employee_id = 203;
    
    UPDATE employees SET jubun = '7803251234567'
    WHERE employee_id = 204;
    
    UPDATE employees SET jubun = '7910232234567'
    WHERE employee_id = 205;
    
    UPDATE employees SET jubun = '8010172234567'
    WHERE employee_id = 206;
    
    COMMIT;
        
    SELECT *
    FROM employees;
     
    -----------------------------------------------------------------------------
   
    ---------- ***** like 연산자 ***** ----------
    SELECT *
    FROM employees
    WHERE department_id = 30;
    
    SELECT *
    FROM employees
    WHERE department_id LIKE 30;      -- like(부사) : ~와 같은 (equal 의 의미로 사용한다. ▶ 그러나 이는 column 내에서 뭘 찾을때 사용한다.)
    
    /*
        like 연산자와 함께 사용되어지는 % 와 _ 를 wild character 라고 부른다.
        like 연산자와 함께 사용되어지는 % 의 뜻은 글자수와는 관계없이 글자가 있든지 없든지 관계없다라는 말이고,
        like 연산자와 함께 사용되어지는 _ 의 뜻은 반드시 아무글자 1개만을 뜻하는 것이다.
    */
    
    -- employees 테이블에서 여자 1990년생과 남자 1991년생의 사원들만
    -- 사원번호, 사원명, 주민번호를 나타내세요.
    SELECT employee_id AS "사원번호"
          , first_name || ' ' || last_name AS "사원명"
          , jubun AS "주민번호"
    FROM employees
    WHERE jubun LIKE '90____2%' OR
          jubun LIKE '91____1%' ;
              
    -- employees 테이블에서 first_name 컬럼의 값이 'J'로 시작하는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요.
    SELECT employee_id AS "사원번호"
          , first_name AS "성"
          , last_name AS "이름"
          , salary AS "기본급여"
    FROM employees
    WHERE first_name LIKE 'J%';          
    
    -- employees 테이블에서 first_name 컬럼의 값이 's'로 끝나는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요.    
    SELECT employee_id, first_name, last_name, salary 
    FROM employees
    WHERE first_name LIKE '%s';     
    
    -- employees 테이블에서 first_name 컬럼의 값중에서 'ee'가 포함된 사원들만
    -- 사원번호, 이름, 성, 기본급여를 나타내세요.    
    SELECT employee_id, first_name, last_name, salary 
    FROM employees
    WHERE first_name LIKE '%ee%';     
    
    -- employees 테이블에서 first_name 컬럼의 값중에서 'ee'가 2개 이상 사원들만
    -- 사원번호, 이름, 성, 기본급여를 나타내세요.    
    SELECT employee_id, first_name, last_name, salary 
    FROM employees
    WHERE first_name LIKE '%e%e%';     -- 최소한 e가 두개. 이름 안에 e가 2개 이상만 있으면 됨. (위치 상관X)
    
    -- employees 테이블에서 last_name 컬럼의 값이 첫글자는 'F' 이고 두번째 글자는 아무거나 이고
    -- 세번째 글자는 소문자 'e' 이며 4번째 부터는 글자가 있든지 없든지 상관없는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
    SELECT employee_id, first_name, last_name, salary 
    FROM employees
    WHERE last_name LIKE 'F_e%';
    
    ----- *** like 연산자와 함께 사용되는 % 와 _ 인 wild character 의 기능을 escape(탈출) 시키기 *** -----
    SELECT * FROM TAB;
     
    CREATE TABLE tbl_watch
    (watch_name VARCHAR2(10)   -- watch_name 컬럼에 들어올 수 있는 데이터는 문자열 최대 10byte 까지만 허용한다.          -- database 에서도 이름을 줄때 스네이크 or 카멜 기법을 사용한다.!!
    ,bigo       NVARCHAR2(10)  -- bigo 컬럼에 들어올 수 있는 데이터는 문자열 최대 10글자 까지만 허용한다.
    );
    -- Table TBL_WATCH이(가) 생성되었습니다.

    -- ▼▼▼ tbl_watch 테이블 속에 데이터를 입력해주는 것이다. ▼▼▼
    INSERT INTO tbl_watch(watch_name, bigo) VALUES('금시계', '순금고급시계');    
    -- 1 행 이(가) 삽입되었습니다.
    SELECT *
    FROM tbl_watch
    
--  rollback;       -- 디스크에 적용시키지 마라.!!    
    COMMIT;
    
    INSERT INTO tbl_watch(watch_name, bigo) VALUES('고급순은시계', '아주좋은시계');    
/*
    (UTF-8임. 글자 1개에 2byte)
    오류 보고 -
    ORA-12899: value too large for column "HR"."TBL_WATCH"."WATCH_NAME" (actual: 18, maximum: 10)
*/
    
    INSERT INTO tbl_watch(watch_name, bigo) VALUES('은시계', '아주좋은시계');        
    -- 1 행 이(가) 삽입되었습니다.

    COMMIT;
    
    DELETE FROM tbl_watch;      -- tbl_watch 테이블에 저장된 모든 행들을 삭제시키는 것이다.(DML 명령문, 4가지, 데이터 조작어 IDDM(Insert,Update,Delete,Merge)
    -- 2개 행 이(가) 삭제되었습니다.

    SELECT *
    FROM tbl_watch
 
    ROLLBACK;       -- 이전에 하던거 다시 되돌림. 
    
    DELETE FROM tbl_watch
    WHERE watch_name = '금시계';
    -- tbl_watch 테이블에 저장된 행들 중에서 watch_name 컬럼의 값이 '금시계' 인 것을 삭제하는 것이다.
    
    DELETE FROM tbl_watch;
    -- 2개 행 이(가) 삭제되었습니다.

    COMMIT;
           
    DROP TABLE tbl_watch PURGE;     -- 행만 지움.
    -- Table TBL_WATCH이(가) 삭제되었습니다.

    CREATE TABLE tbl_watch
    (watch_name VARCHAR2(10)    -- watch_name 컬럼에 들어올 수 있는 데이터는 문자열 최대 10byte 까지만 허용한다.          -- database 에서도 이름을 줄때 스네이크 or 카멜 기법을 사용한다.!!
    ,bigo       NVARCHAR2(100)  -- bigo 컬럼에 들어올 수 있는 데이터는 문자열 최대 100글자 까지만 허용한다.
    );
    -- Table TBL_WATCH이(가) 생성되었습니다.
   
    INSERT INTO tbl_watch(watch_name, bigo) VALUES('금시계', '순금 99.99% 함유 고급시계');
    INSERT INTO tbl_watch(watch_name, bigo) VALUES('은시계', '고객만족도 99.99점 획득한 고급시계');

    COMMIT;

    -- tbl_watch 테이블에서 bigo 컬럼에 99.99% 라는 글자가 들어있는 행만 추출하세요.
    SELECT *
    FROM tbl_watch
    WHERE bigo LIKE '%99.99%%'; -- 글자가 아니라 % 를 wild_character 로 봄. ▶ 그러므로 순수한 %로 추출해야함.

    SELECT *
    FROM tbl_watch
    WHERE bigo LIKE '%99.99\%%' ESCAPE '\'; -- '' 안에 글자를 탈출시킨다. ▶ 순수하게 %인지를 물어봄. (wild character 가 아니라)
    --  escape 문자로 '\' 을 주었으므로 '\' 다음에 나오는 % 1개만 wild character 기능에서 탈출시켜 버리므로 % 는 진짜 글자 퍼센트(%) 로 된다.
  
    SELECT *
    FROM tbl_watch
    WHERE bigo LIKE '%99.991%%' ESCAPE '1'; -- '' 안에 글자를 탈출시킨다. ▶ 순수하게 %인지를 물어봄. (wild character 가 아니라)
  
  ------------------------------------------------------------------------------
  ------ >> 단일행 함수 << ------
    /*
    ※ 단일행 함수의 종류  
    1. 문자 함수
    2. 숫자 함수
    3. 날짜 함수
    4. 변환 함수
    5. 기타 함수
    */

    ------ >> 1. 문자 함수 << ------ 
    
    -- 1.1 upper('문자열') ==> '문자열' 을 모두 대문자로 변환시켜주는 것.
    SELECT 'kOreA sEouL', UPPER('kOreA sEouL')
    FROM dual;  
    --      kOreA sEouL	      KOREA SEOUL 
    
    -- 1.2 lower('문자열') ==> '문자열' 을 모두 소문자로 변환시켜주는 것.
    SELECT 'kOreA sEouL', LOWER('kOreA sEouL')
    FROM dual;  
    --      kOreA sEouL	       korea seoul
    
    -- 1.3 initial capital('문자열') ==> '문자열'을 단어별(구분자 공백)로 첫글자만 대문자, 나머지는 모두 소문자로 변환시켜주는 것.
    SELECT 'kOreA sEouL', initcap('kOreA sEouL')
    FROM dual;  
    --      kOreA sEouL	         Korea Seoul
    
    SELECT last_name, UPPER(last_name), LOWER(last_name)
    FROM employees;
    
    SELECT *
    FROM employees
    WHERE LOWER(last_name) = LOWER('KING') -- lower면 lower 대로 보이게 해라! (그래서 = 양옆에 lower를 붙임)
    
    SELECT *
    FROM employees
    WHERE UPPER(last_name) = UPPER('king'); -- 화면에 보일때는 원래 컬럼대로 보여라!
    
    SELECT *
    FROM employees
    WHERE UPPER(last_name) = UPPER('KiNg'); -- 화면에 보일때는 원래 컬럼대로 보여라!
    
    SELECT *
    FROM employees
    WHERE initcap(last_name) = initcap('KiNg'); -- 화면에 보일때는 원래 컬럼대로 보여라!
    
    -- 1.4 substr('문자열', 시작글자번호, 뽑아야할글자수) -- 글자수이지 index가 아니다.!!
    --     ==> '문자열' 중에 문자열의 일부분을 선택해올 때 사용한다.
    SELECT '쌍용교육센터'
        , substr('쌍용교육센터', 2, 3) -- '쌍용교육센터' 에서 2번째 글자인 '용'부터 3글자만 뽑아온다.
        , substr('쌍용교육센터', 2)    -- '쌍용교육센터' 에서 2번째 글자인 '용'부터 끝까지 뽑아온다.    
    FROM dual;
    -- 쌍용교육센터	용교육	용교육센터
    
    --- *** substr()함수를 사용하여 employees 테이블에서 성별이 '여자'인 사원들만 
    --      사원번호, 사원명, 주민번호를 나타내세요. ***
    
    -- ▼내답안▼ -- (맞음)
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , jubun AS "주민번호"
    FROM employees       
    WHERE substr(jubun, 7, 1) = '2' OR
          substr(jubun, 7, 1) = '4' ;

    -- ▼답안▼ --
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , jubun AS "주민번호"
    FROM employees       
    WHERE substr(jubun, 7, 1) IN ('2','4') ;
    
    
    --- *** substr()함수를 사용하여 employees 테이블에서 1990년 ~ 1995년에 태어난 사원들중 
    --      성별이 '남자'인 사원들만 사원번호, 사원명, 주민번호를 나타내세요. ***
    -- ▼내답안▼ -- (틀림 :( ) ▶ 원래대로 수정 완
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , jubun AS "주민번호"
    FROM employees       
    WHERE substr(jubun, 1, 2) >= '90' AND  -- 이부분에서 or로 써서 결과가 안나옴 ,,
           substr(jubun, 1, 2) <= '95' AND
           substr(jubun, 7, 1) = '1'        -- 90년대생은 3으로 시작하는 주민번호가 없다.!! 그러므로 쓰지 않아도 됨.
          
    -- ▼답안▼ --
    SELECT employee_id AS "사원번호"
        , first_name ||' '|| last_name AS "사원명"
        , jubun AS "주민번호"
    FROM employees       
    WHERE substr(jubun, 1, 2) BETWEEN '90' AND '95' AND
          substr(jubun, 7, 1) = '1';   
        
    -- 1.5  instr : 어떤 문자열에서 명명된 문자열의 위치를 알려주는 것 **** ---
    SELECT '쌍용교육센터 서울교육대학교 교육문화원'
         
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 1)    -- 3
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 2)    -- 10
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 1 번째 부터 2 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4, 1)    -- 10
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 4 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4, 3)    -- 0
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 4 번째 부터 3 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     --   그러한 값이 없다면 0 이 나온다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1)    -- 3
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     --   출발점만 나오면 뒤에 , 1 이 생략된 것이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4)    -- 10
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 4 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     --   출발점만 나오면 뒤에 , 1 이 생략된 것이다.
         
    FROM dual;   
    
    -- 1.6  reverse : 어떤 문자열을 거꾸로 보여주는 것이다. **** ---
    SELECT 'ORACLE', REVERSE('ORACLE')
         , '대한민국', REVERSE('대한민국'),  REVERSE( REVERSE('대한민국') )
    FROM dual;
    
    ------ [퀴즈] -------
    CREATE TABLE tbl_files
    (fileno      NUMBER(3)
    ,filepath    VARCHAR2(200)
    );
    
    INSERT INTO tbl_files(fileno, filepath) VALUES(1, 'c:\myDocuments\resume.hwp');
    INSERT INTO tbl_files(fileno, filepath) VALUES(2, 'd:\mymusic.mp3');
    INSERT INTO tbl_files(fileno, filepath) VALUES(3, 'c:\myphoto\2021\07\face.jpg');
    
    COMMIT;
    
    SELECT fileno, filepath
    FROM tbl_files;
    
    ---- 아래와 같이 나오도록 select 문을 완성하세요. ----
    /*
        ------------------------------------------------------
        파일번호          파일명
        ------------------------------------------------------
           1             resume.hwp
           2             mymusic.mp3
           3             face.jpg
    */
    -- ▼내답변▼ (틀림!!!!!!!)
    SELECT filepath, REVERSE (filepath)
    FROM tbl_files;
    WHERE substr(pwh.emuser\stnemucodym\:C, 1,5) AND
    substr(m3p.cisumym\:D, 1,5) AND
    substr(gpj.ecaf\70\1202\otohpym\:C, 1,5) ;

    -- ▼답안▼ ①거꾸로 뒤집고, ② substr ③instr ④ (reverse(reverse)) ▶ 거꾸로 뒤집은 것을 원상복구함
    -- substr : '문자열' 중에 문자열의 일부분을 선택해올 때 사용한다.
    -- instr : 어떤 문자열에서 명명된 문자열의 위치를 알려주는 것
    -- 전체를 다 가져와야하기 때문에 where은 안쓴다.
    SELECT fileno, filepath, REVERSE (filepath),
        -- substr(reverse (filepath), 1, ? ) 
        -- ==> ? 는 뽑아야할 글자길이인데, reverse(filepath) 에서 최초로 '\'가 나오는 위치값 -1 이다. (첫번째 자리를 -1 해주는 것임. n'번째' 부터니까)
        -- ? ==> instr(reverse(filepath),'\', 1) : '\'가 첫번째로 나오는 것
        substr(REVERSE (filepath), 1, instr(REVERSE(filepath),'\', 1) -1 ),     -- 위치값 -1        
        REVERSE(substr(REVERSE (filepath), 1, instr(REVERSE(filepath),'\', 1) -1 ))
    FROM tbl_files; 
    
    SELECT fileno AS "파일번호"
        , REVERSE(substr(REVERSE (filepath), 1, instr(REVERSE(filepath),'\', 1) -1 ))AS "파일명"
    FROM tbl_files; 
        
     SELECT '쌍용교육센터 서울교육대학교 교육문화원'
         
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 1)    -- 3
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -1, 1)    -- 16
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 ★역순으로★ 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 1)    -- 10
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 ★역순으로★ 6 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 2)    -- 3
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 ★역순으로★ 6 번째 부터 2 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     --   그러한 값이 없다면 0 이 나온다.
       
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 3)    -- 0
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 ★역순으로★ 6 번째 부터 3 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     --   그러한 값이 없다면 0 이 나온다.
     
     , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6)    -- 10
     --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
     --   출발점이 ★역순으로★ -6 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
     --   출발점만 나오면 뒤에 , 1 이 생략된 것이다.

     FROM dual;
    
    SELECT fileno, filepath
      --  substr(filepath, filepath에서 마지막으로 나오는 \의 위치값+1
      --  filepath 에서 마지막으로 나오는 \의 위치값은 instr(filepath, '\', -1)
        , substr(filepath, instr(filepath, '\', -1)+1)
    FROM tbl_files;
    
    SELECT fileno AS "파일번호"
        , substr(filepath, instr(filepath, '\', -1)+1) AS "파일명"
    FROM tbl_files;
    
    
    --- 1.7  lpad : 왼쪽부터 문자를 자리채움 **** ---
    --- 1.8  rpad : 오른쪽부터 문자를 자리채움 **** ---
    SELECT lpad('교육센터',10, '*')  
        -- 10byte를 확보해서 ''안에 교육센터를 넣는다. 넣은 후 빈공간(2byte)이 있으면 왼쪽부터 *로 채워라.(Leftpad)
          , rpad('교육센터',10, '*')  
        -- 10byte를 확보해서 ''안에 교육센터를 넣는다. 넣은 후 빈공간(2byte)이 있으면 오른쪽부터 *로 채워라.(Leftpad)
    FROM dual;
    
    
    --- 1.9  ltrim : 왼쪽부터 문자를 제거한다 **** ---    
    --- 1.10 rtrim : 오른쪽부터 문자를 제거한다 **** ---
    --- 1.11 trim  : 왼쪽,오른쪽부터 *공백*을 제거한다 **** ---
    SELECT LTRIM('aabbbcccccddddddTaabbccddSSSSSS','abcd')  -- a b c d 중에 하나가 있으면 왼쪽부터 제거해라.
         , RTRIM('aabbbcccccddddddTaabbccdd','abcd')
         , RTRIM( LTRIM('aabbbcccccddddddTaabbccdd','abcd'), 'abcd' )        
    FROM dual;    
        
    SELECT '쌍용' || '                 교육            센터'
         , '쌍용' || LTRIM('                 교육            센터')
    FROM dual;    
    
    SELECT '쌍용              ' || '교육            센터'
         , RTRIM('쌍용              ') || '교육            센터'
    FROM dual;    
       
    SELECT '쌍용' || '         교육    '  ||'센터'
         , '쌍용' || TRIM('         교육    ')  ||'센터'
    FROM dual;    
    
    --- 1.12 translate  --- (1:1 매핑 (숫자-한글 matching))
    SELECT TRANSLATE('010-2345-6789'
                    ,'0123456789'
                    ,'영일이삼사오육칠팔구')
    FROM dual;        
    
    --- 1.13 replace ---
    SELECT REPLACE('쌍용교육센터 서울교육대학교 교육문화원'
                 , '교육' 
                 , 'education' )
    FROM dual;
    
    --- 1.14 length : 문자열의 길이를 알려주는 것 --- (길이이지 byte가 아니다.)
    SELECT LENGTH('쌍용center')   --8
    FROM dual;
        
    --- 1.15 lengthb : 문자열의 byte 수를 알려주는 것 ---
    SELECT lengthb('쌍용center')   --12(byte)
    FROM dual;
    
    
    ------------------ >> 2. 숫자 함수 << ------------------
    
    -- 2.1 mod : 나머지를 구해주는 것
    SELECT 5/2, MOD(5,2), TRUNC(5/2)
    FROM dual;
    -- 2.5 / 1 (5를 2로 나누었을 때의 나머지) / 2 (정수부만 취하는것 (trunc, 몫))
    
    
    -- 2.2 round : 반올림을 해주는 것
    SELECT 94.547
         , round(94.547)        -- 95
         , round(94.547, 0)     -- 95     0 은 정수 1자리 까지만 나타내어준다.
         , round(94.547, 1)     -- 94.5   1 은 소수 첫째자리까지만 나타내어준다.
         , round(94.547, 2)     -- 94.55  2 는 소수 둘째자리까지만 나타내어준다.             
         , round(94.547, -1)    -- 90    -1 은 정수 10자리까지만 나타내어준다.             
         , round(94.547, -2)    -- 100   -2 는 정수 100자리까지만 나타내어준다.             
    FROM dual;
    
    -- 2.3 trunc : 절삭을 해주는 것 (무조건 잘라버림.)
    SELECT 94.547
         , TRUNC(94.547)        -- 94
         , TRUNC(94.547, 0)     -- 94       0 은 정수 1자리 까지만 나타내어준다.
         , TRUNC(94.547, 1)     -- 94.5     1 은 소수 첫째자리까지만 나타내어준다.
         , TRUNC(94.547, 2)     -- 94.54    2 는 소수 둘째자리까지만 나타내어준다.  (반올림 안하고 그냥 자름)           
         , TRUNC(94.547, -1)    -- 90       -1 은 정수 10자리까지만 나타내어준다.             
         , TRUNC(94.547, -2)    -- 0        -2 는 정수 100자리까지만 나타내어준다.             
    FROM dual;
     
    -- *** [성적처리] *** --
    CREATE TABLE tbl_sungjuk
    (hakbun      VARCHAR2(20)
    ,NAME        VARCHAR2(20)
    ,kor         NUMBER(3)
    ,eng         NUMBER(3)
    ,math        NUMBER(3)
    );
    
    SELECT *
    FROM tbl_sungjuk;
    
    --- *** 데이터 입력하기 *** ---
    INSERT INTO tbl_sungjuk(hakbun, NAME, kor, eng, math) VALUES('sist001','한석규',90,92,93);
    INSERT INTO tbl_sungjuk(hakbun, NAME, kor, eng, math) VALUES('sist002','두석규',100,100,100);
    INSERT INTO tbl_sungjuk(hakbun, NAME, kor, eng, math) VALUES('sist003','세석규',71,72,73);
    INSERT INTO tbl_sungjuk(hakbun, NAME, kor, eng, math) VALUES('sist004','네석규',89,87,81);
    INSERT INTO tbl_sungjuk(hakbun, NAME, kor, eng, math) VALUES('sist005','오석규',60,50,40);
    INSERT INTO tbl_sungjuk(hakbun, NAME, kor, eng, math) VALUES('sist006','육석규',80,81,87);     
     
    COMMIT; 
    -- 커밋 완료.
    
    ------------------------------------------------------------------------------------------------------------------------------------
    학번  성명  국어  영어  수학  총점  평균(소수부 첫째자리까지 나타내되 반올림) 학점(평균이 90 이상이면 'A' 90미만 80이상이면 'B'.... 60 미만이면 'F')
    ------------------------------------------------------------------------------------------------------------------------------------    
    
    SELECT hakbun AS "학번"
         , NAME   AS "성명"
         , kor    AS "국어"
         , eng    AS "영어"
         , math   AS "수학"
         , kor+eng+math     AS "총점"
         , round((kor+eng+math)/3, 1)   AS "평균"
   --    , trunc(round((kor+eng+math)/3, 1))
         , CASE TRUNC(round((kor+eng+math)/3, 1), -1)
          WHEN 100 THEN 'A'
          WHEN 90 THEN 'A'
          WHEN 80 THEN 'B'
          WHEN 70 THEN 'C'
          WHEN 60 THEN 'D'
          ELSE         'F'
          END AS 학점1
        
         , decode(TRUNC(round((kor+eng+math)/3, 1), -1), 100, 'A'
                                                       ,  90, 'A'
                                                       ,  80, 'B'
                                                       ,  70, 'C'
                                                       ,  60, 'D'
                                                            , 'F'
                 ) AS 학점2                 
         , CASE
           WHEN TRUNC(round((kor+eng+math)/3, 1), -1) IN(100,90) THEN 'A'
           WHEN TRUNC(round((kor+eng+math)/3, 1), -1) = 80       THEN 'B'
           WHEN TRUNC(round((kor+eng+math)/3, 1), -1) = 70       THEN 'C'
           WHEN TRUNC(round((kor+eng+math)/3, 1), -1) = 60       THEN 'D'
           ELSE 'F'
           END AS 학점3
           
    FROM tbl_sungjuk;
    
    -- 2.4 power : 거듭제곱
    SELECT 2*2*2*2*2, POWER(2,5)    -- 2의 5승
    FROM dual;
    
    -- 2.5 sqrt : 제곱근
    SELECT sqrt(16), sqrt(3), sqrt(2)       -- () 안은 루트16, 루트3, 루트2
    FROM dual; 

    -- 2.6 sin, cos, tan, asin, acos, atan
    SELECT sin(90), cos(90), tan(90), asin(0.3), acos(0.3), atan(0.3)
    FROM dual;
    
    -- 2.7 log
    SELECT LOG(10, 100) -- 밑이 10 인 log 100?
    FROM dual;
    
    -- 2.8 sign ==> 결과값이 양수라면 1, 결과값이 0 이면 0, 결과값이 음수라면 -1
    SELECT sign(5-2), sign(5-5), sign(2-5)
    FROM dual;
    
    -- ★★2.9 ceil(실수)   ==> 입력된 실수(10.1)보다 큰 최소의 정수(11)를 나타내어준다.
    --        ceil(정수)   ==> 입력된 정수를 그대로 나타내어준다.
    SELECT ceil(10.1), ceil(-10.1), ceil(-10), ceil(10)
    FROM dual;
    
    -- ★★2.10 floor(실수)   ==> 입력된 실수(10.1)보다 작은 최대의 정수(10)를 나타내어준다.
    --         floor(정수)   ==> 입력된 정수를 그대로 나타내어준다.    
    SELECT floor(10.1), floor(-10.1), floor(-10), floor(10)
    FROM dual;
    
    
    
    
    ------------------ >>★★★ 3. 날짜 함수 ★★★ << ------------------
    
    /*
        날짜1 + 숫자 = 날짜2  ==> 날짜1 에서 숫자(단위가 일수)만큼 더한 값이 날짜2 가 된다.
        날짜1 - 숫자 = 날짜2  ==> 날짜1 에서 숫자(단위가 일수)만큼 뺀 값이 날짜2 가 된다.
    
        여기서 중요한 것은 숫자의 단위는 *일수* 이다.
        
        날짜1 - 날짜2 = 숫자  ==> 결과값인 숫자의 단위는 일수이다. (몇일 차이인지?)
    */
    
    SELECT 
            sysdate-1, to_char(sysdate-1, 'yyyy-mm-dd hh24:mi:ss') AS 어제시각
          , sysdate, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각
          , sysdate+1, to_char(sysdate+1, 'yyyy-mm-dd hh24:mi:ss') AS 내일시각    
    FROM dual;
    
    -- 단위환산 --
    /*
        1 kg = 1000 g
        1 g = 1/1000 kg
        
        1 일 = 24 시간
        1 시간 = 60 분
        1분 = 1/60 시간
        1분 = 60초
        1초 = 1/60분
    */
    
    --- *** [퀴즈] 현재시각으로부터 1일 2시간 3분 4초 뒤를 나타내세요. *** ---
    SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각 ,
           to_char(sysdate + 1 + (2/24)+ 3/(24*60) + 4/(24*60*60), 'yyyy-mm-dd hh24:mi:ss') AS "1일 2시간 3분 4초 뒤" -- as 뒤 별칭(alias)은 30글자 이상이 안됨.
    FROM dual;
    
    
    -- 3.1 to_yminterval('년-월') , to_dsinterval('일 시:분:초') // ym:year month , ds : day second
    /*
        to_yminterval 은 년 과 (개)월을 나타내어 
        연산자가 + 이면 날짜에서 더해주는 것이고, 연산자가 - 이면 날짜에서 빼주는 것이다.
        
        to_dsinterval 은 일 시간 분 초 를 나타내어 
        연산자가 + 이면 날짜에서 더해주는 것이고, 연산자가 - 이면 날짜에서 빼주는 것이다.                
    */
    
    -- 현재시각으로 부터 1년 2개월 3일 4시간 5분 6초 뒤를 나타내세요.
    SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각 ,
           sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'),
           to_char(sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'), 'yyyy-mm-dd hh24:mi:ss') AS "1년2개월3일4시간5분6초"
    FROM dual;
    
    
    -- 3.2 add_months(날짜, 숫자)
    /*
        ==> 숫자가 양수이면 날짜에서 숫자 개월수 만큼 더해준 날짜를 나타내는 것이고,
            숫자가 음수이면 날짜에서 숫자 개월수 만큼    뺀 날짜를 나타내는 것이다.
        
        여기서 숫자의 단위는 ★개월수★ 이다.
    */
    
    SELECT  to_char(add_months(sysdate,-2), 'yyyy-mm-dd hh24:mi:ss') AS "2개월전",
            to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각,
            to_char(add_months(sysdate,+2), 'yyyy-mm-dd hh24:mi:ss') AS "2개월후"
    FROM dual;
    
    --- *** 내일 홍길동이 군대 입대를 한다. 복무기간이 18개월 이라면 제대일자(년-월-일)를 구하세요. *** ---
    SELECT to_char(add_months(sysdate+1,18), 'yyyy-mm-dd') AS "제대일자"
    FROM dual;
    
    
    -- 3.3 months_between(날짜1, 날짜2)
    /*
          *날짜1 에서 날짜2 를 뺀 값*으로 그 결과는 숫자가 나오는데 결과물 숫자의 단위는 개월수 이다.
          즉, 두 날짜의 개월차이를 구할 때 사용한다.
    */
    SELECT sysdate+3 - sysdate
    FROM dual;
    -- 날짜1 - 날짜2 = 숫자  ==> 결과값인 숫자의 단위는 일수이다. (몇일 차이인지?)
    
    SELECT months_between(add_months(sysdate,3), sysdate),  --  3 
           months_between(sysdate, add_months(sysdate,3))   -- -3
    FROM dual;
    
    -- 3.4 last_day(특정날짜)
    --     ==> 특정날짜가 포함된 달력에서 맨 마지막날짜를 알려주는 것이다.
    SELECT sysdate, last_day(sysdate)
    FROM dual;

    SELECT last_day('2020-02-01'),   -- 해당 월의 마지막날짜가 존재해야 결과값이 나옴. (2020-02-29는 있지만, 2021-02-29는 없음)
           last_day(TO_DATE('2022-02-01', 'yyyy-mm-dd')),    -- 자동형변환
           last_day('2020-02-01'), 
           last_day('2023-02-01'), last_day('2024-02-01')
    FROM dual;
        
        
    -- 3.5  next_day(특정날짜, '일') '일'~'토'
    --      ==> 특정날짜로 부터 다음번에 돌아오는 가장 빠른 '일'~'토'의 날짜를 알려주는 것이다. 
    SELECT sysdate
         , next_day(sysdate, '금')
         , next_day(sysdate, '월')
         , next_day(sysdate, '목')
    FROM dual;
    --- 22/01/06    22/01/07    22/01/10    22/01/13
    
        
    -- 3.6 extract ==> 날짜에서 *년, 월, 일*을 숫자형태로 추출해주는 것이다.
    --     참고로 to_char() ==> 날짜에서 년, 월, 일을 문자형태로 추출해주는 것이다.
    SELECT sysdate
         , to_char(sysdate, 'yyyy')     -- 2022 (문자열이므로 왼쪽맞춤)
         , EXTRACT(YEAR FROM sysdate)   -- 2022 (숫자이므로 오른쪽맞춤)
         , to_char(sysdate, 'mm')       -- 01 (문자열이므로 왼쪽맞춤)
         , EXTRACT(MONTH FROM sysdate)  -- 1 (숫자이므로 오른쪽맞춤)
         , to_char(sysdate, 'dd')       -- 06 (문자열이므로 왼쪽맞춤)
         , EXTRACT(DAY FROM sysdate)    -- 6 (숫자이므로 오른쪽맞춤)
         
         , to_char(sysdate, 'hh24')     
         , to_char(sysdate, 'mi')
         , to_char(sysdate, 'ss')        
    FROM dual;
    
    ------------------ >> 4. 변환 함수 << ------------------

    -- 4.1 to_char(날짜, '형태') ==> 날짜를 '형태' 모양으로 문자형태로 변환시켜주는 것이다.    
    --     to_char(숫자, '형태') ==> 숫자를 '형태' 모양으로 문자형태로 변환시켜주는 것이다.
    
    --- 날짜를 문자형태로 변환하기 ---
     SELECT to_char(sysdate, 'yyyy') AS 년도
          , to_char(sysdate, 'mm')   AS 월
          , to_char(sysdate, 'dd')   AS 일
          , to_char(sysdate, 'hh24') AS "24시간"
          , to_char(sysdate, 'am hh') AS "12시간"
          , to_char(sysdate, 'pm hh') AS "12시간"
          , to_char(sysdate, 'mi')   AS 분
          , to_char(sysdate, 'ss')   AS 초
          , to_char(sysdate, 'q')    AS 분기       -- 1월~3월 => 1,   4월~6월 => 2,   7월~9월 => 3,    10월~12월 => 4 
          , to_char(sysdate, 'day')  AS 요일명     -- 월요일(Windows) , Monday(Linux) 
          , to_char(sysdate, 'dy')   AS 줄인요일명  -- 월(Windows) , Mon(Linux)
     FROM dual;
     
     SELECT to_char(sysdate, 'd')  -- sysdate 의 주의 일요일 부터(지금은 2022년 1월 2일)  sysdate(지금은 2022년 1월 6일) 까지 며칠째 인지를 알려주는 것이다.
                                   --  1(일요일)  2(월요일) 3(화요일) 4(수요일) 5(목요일) 6(금요일) 7(토요일) 
     FROM dual;
     
     SELECT CASE to_char(sysdate, 'd') 
            WHEN '1' THEN '일'
            WHEN '2' THEN '월'
            WHEN '3' THEN '화'
            WHEN '4' THEN '수'
            WHEN '5' THEN '목'
            WHEN '6' THEN '금'
            WHEN '7' THEN '토'
            END AS "오늘의 요일명1"
     
         , decode (to_char(sysdate, 'd'), '1','일'
                                        , '2','월'
                                        , '3','화'
                                        , '4','수'
                                        , '5','목'
                                        , '6','금'
                                        , '7','토'
                  ) AS "오늘의요일명2"
     FROM dual; 
    
    
     
     SELECT to_char(sysdate, 'dd'),     -- sysdate 의 월 1일 부터(지금은 2022년 1월 1일) sysdate 까지 며칠째 인지를 알려주는 것이다.
            to_char(sysdate, 'ddd')     -- sysdate 의 년도 1월 1일 부터(지금은 2022년 1월 1일) sysdate 까지 며칠째 인지를 알려주는 것이다.
     FROM dual;
     
     SELECT to_char(add_months(sysdate,1), 'dd'),     --add_months(sysdate,1) 은 2022년 2월 6일 이다. --06   ( 해당 월의 6일째 )
            to_char(add_months(sysdate,1), 'ddd')     --add_months(sysdate,1) 은 2022년 2월 6일 이다. -- 037 ( 해당 년도의 37일째 )
     FROM dual;
    
    
    --- *** 숫자를 문자형태로 변환하기 *** ---
    SELECT 1234567890
         , to_char(1234567890, '9,999,999,999')    
         , to_char(1234567890, '$9,999,999,999')             
         , to_char(1234567890, 'L9,999,999,999')    -- L(Local)은 그나라의 화폐기호가 나온다.
    FROM dual;
    --  1,234,567,890	 $1,234,567,890	        ￦1,234,567,890
    
    
    SELECT 100
        , to_char(100, '999.0')     -- 100.0
        , 95.7
        , to_char(95.7, '999.0')    -- 95.7
        , to_char(95.7, '999.0')    -- 95.70
        , to_char(95.78, '999.0')   -- 95.80    
    FROM dual;
    
    -- 4.2 to_date(문자, '형태') ==> 문자를 '형태' 모양으로 날짜 형태로 변환시켜주는 것이다.
    SELECT '2022-01-06' + 1
    FROM dual;
    -- ORA-01722: invalid number        
        
    SELECT TO_DATE('2022-01-06', 'yyyy-mm-dd') + 1
         , TO_DATE('2022/01/06', 'yyyy-mm-dd') + 1    
         , TO_DATE('20220106', 'yyyymmdd') + 1    
    FROM dual;    
   -- 22/01/07	22/01/07	22/01/07     

    SELECT TO_DATE('2022-02-28', 'yyyy-mm-dd') + 1
    FROM dual;    
    -- 22/03/01
    SELECT TO_DATE('2022-02-29', 'yyyy-mm-dd') + 1  -- 2022-02-29 는 달력에 없으므로 변경이 불가하다.
    FROM dual;    
    -- 오류!! (ORA-01839: date not valid for month specified)
    SELECT TO_DATE('2020-02-29', 'yyyy-mm-dd') + 1
    FROM dual;    
    -- 20/03/01
    
    -- 4.3 to_number(문자) ==> 숫자모양을 가지는 문자를 숫자형태로 변환시켜주는 것이다.
    SELECT '12345', to_number('12345')  -- 문자는 왼쪽맞춤, 숫자는 오른쪽 맞춤!! (문자를 숫자로 바꿈으로써 to_number 에서 오른쪽정렬을 확인할 수 있음.)
    FROM dual;
    
    SELECT '50'+10  -- 자동형변환이 되어짐. (원래 문자열+ 숫자가 되지 않는데 자동형변환이 되어 결과값이 나오는 것임.)
         , to_number('50')+10
    FROM dual;

    SELECT to_number('홍길동') -- 숫자가 아니기 때문에 오류.
    FROM dual;
    -- ORA-01722: invalid number

    
    
    ------------------ >>★★ 5. 기타 함수 ★★<< ------------------ !! 암기 !!
    
    -- 5.1 case when then else end ==> !!! 암기 !!! (참거짓에 쓰임)
    SELECT CASE 5-2
           WHEN 4 THEN '5-2=4 입니다.'
           WHEN 1 THEN '5-2=1 입니다.'
           WHEN 0 THEN '5-2=3 입니다.'
           ELSE '나는 수학을 몰라요ㅜㅜ'
           END AS "결과"
    FROM dual;
    
    
    -- 5.2 decode ==> !!! 암기 !!!
    
    SELECT decode(5-2, 4, '5-2=4 입니다.'
                     , 1, '5-2=1 입니다.'
                     , 3, '5-2=3 입니다.'
                        , '나는 수학을 몰라요') AS "결과"
    FROM dual;
    
        
    SELECT CASE
           WHEN 4 > 5 THEN '4는 5보다 큽니다.'
           WHEN 5 > 7 THEN '5는 7보다 큽니다.'
           WHEN 3 > 2 THEN '3은 2보다 큽니다.'
           ELSE '나는 수학을 몰라요'
           END AS "결과"            
    FROM dual;
    
    
    -- 5.3 greatest, least
    SELECT greatest(10, 90, 100, 80) -- 나열된 값들 중에 제일 큰값을 알려주는 것
         , least(10, 90, 100, 80)    -- 나열된 값들 중에 제일 작은값을 알려주는 것        
    FROM dual;
    --      100     10 
    
    SELECT greatest('김유신','허준','고수','엄정화')
         , least('김유신', '허준', '고수', '엄정화')
    FROM dual;
    --     허준       고수
    
    -- ★★5.4 rank ==> 등수(석차)  , dense_rank ==> 서열구하기
    SELECT employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , nvl(salary + (salary*commission_pct), salary) AS 월급
         , RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS 월급등수
         , DENSE_RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS 월급서열   -- 월급 등수는 6번이지만, 서열로는 5번째로 많이 번다.!! (사원번호 147번 기준)
    FROM employees;
    
    -- 부서내에서 등수 구하기.!!
    SELECT employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , nvl(salary + (salary*commission_pct), salary) AS 월급
         , department_id AS 부서번호
         , RANK() OVER(PARTITION BY department_id
                       ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS 부서내월급등수
         , RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS 전체월급등수
         , DENSE_RANK() OVER(PARTITION BY department_id
                             ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS 부서내월급서열   
         , DENSE_RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS 전체월급서열      
    FROM employees
    ORDER BY 부서번호;
    
    -- employees 테이블에서 월급을 가장 많이 버는 등수로 1등부터 10등까지인 사원들만 
    -- 사원번호, 사원명, 월급, 등수를 나타내세요.
    SELECT AS 사원번호, AS 사원명, AS 월급, AS 등수
    FROM employees
    WHERE RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) BETWEEN 1 AND 10;
    -- 오류★★
    -- ** rank() 및 dense_rank() 함수는 where 절에 바로 쓸 수 없다.!! ▶ Inline view를 써서 구해준다.
    
    -- rank() 및 dense_rank() 함수는 where 절에 바로 쓸 수 없기 때문에 
    -- inline view 를 통해서 해야한다. *** ---
    
    -- ▼ 아래와 같이 사용▼    
    SELECT V. *
    FROM
    (
    SELECT employee_id, first_name || ' ' || last_name AS full_name,
           nvl(salary+(salary*commission_pct),salary) AS salary,
           RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS rank_month_salary           
    FROM employees
    ) V
    WHERE V.rank_month_salary BETWEEN 1 AND 10;

    -- ▼ V. 는 생략 가능.
    SELECT *        -- 여기서 v.는 생략할 수 있다.
    FROM
    (
        SELECT employee_id, first_name || ' ' || last_name AS full_name,
               nvl(salary+(salary*commission_pct),salary) AS salary,
               RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS rank_month_salary           
        FROM employees                              
    ) V
    WHERE V.rank_month_salary BETWEEN 1 AND 10;

/*
        --- [퀴즈] -------
        employees 테이블에서 모든 사원들에 대해
        사원번호, 사원명, 주민번호, 성별, 현재나이, 월급, 입사일자, 정년퇴직일, 정년까지근무개월수, 퇴직금 을 나타내세요.
        
        여기서 정년퇴직일이라 함은 
        해당 사원의 생월이 3월에서 8월에 태어난 사람은 
        해당사원의 나이(한국나이)가 63세가 되는 년도의 8월 31일로 하고,
        해당사원의 생월이 9월에서 2월에 태어난 사람은 
        해당사원의 나이(한국나이)가 63세가 되는 년도의 2월말일(2월28일 또는 2월29일)로 한다.
   
        정년까지근무개월수 ==> 입사일자로 부터 정년퇴직일 까지 개월차이 
        months_between(정년퇴직일, 입사일자)
        
        퇴직금 ==> 근무년수 * 월급       26개월근무 ==> 2년2개월 ==> 2년*월급
        
    */ 

       
    SELECT employee_id AS 사원번호
    , first_name || '' || last_name AS 사원명
    , jubun AS 주민번호 
    , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END AS 성별        
    -- , 현재년도 - 태어난년도( 주민번호앞의 2자리 + 1900 OR 주민번호앞의2자리 + 2000) + 1 as 현재나이   
    , EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 AS 현재나이  -- 2000년대에 태어난 사람은 7번째 자리가 3,4로 시작
    , nvl(salary + (salary*commission_pct), salary) AS "월급"
    , hire_date AS "입사일자"
    -- ★★★★ 정년퇴직 매우 어렵 ..★★★★
    -- ▼쌤 답안 --
    -- 정년퇴직일은 해당사원의 나이(한국나이)가 63세가 되는 년도
    -- 어떤 사원의 현재 나이가 62세 => 63세가 되는 년도 add_months(sysdate, (63-62)*12)
    -- 어떤 사원의 현재 나이가 37세 => 63세가 되는 년도 add_months(sysdate, (63-37)*12)
    -- 어떤 사원의 현재 나이가 57세 => 63세가 되는 년도 add_months(sysdate, (63-57)*12)  
    -- to_char( add_months(sysdate, (63-현재나이)*12), 'yyyy') || '-08-31' '-02-28' '-02-29'
    , last_day (to_char( add_months(sysdate, (63-( EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 ))*12), 'yyyy')  || 
            CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END ) -- 앞에 01,02 가 아니라 1,2,3,4 이렇게 바뀜(to_number)           
            AS 정년퇴직일                    
    --        , months_between(정년퇴직일, hire_date) as 정년까지근무개월수
         , TRUNC(months_between(last_day (to_char( add_months(sysdate, (63-( EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 ))*12), 'yyyy')  || 
                                         CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END 
                                         ), hire_date) 
           ) AS 정년까지근무개월수
           
    --        , trunc(정년까지근무개월수/12) * 월급 as 퇴직금
    
          , TRUNC (TRUNC(months_between(last_day (to_char( add_months(sysdate, (63-( EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 ))*12), 'yyyy')  || 
                                                   CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END 
                                                   ), hire_date) 
           ) /12) * nvl(salary + (salary*commission_pct), salary) AS 퇴직금
    FROM employees;
    
    -- ▼주석문 뺀 답안▼ --
    SELECT employee_id AS 사원번호
    , first_name || '' || last_name AS 사원명
    , jubun AS 주민번호 
    , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END AS 성별        
    , EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 AS 현재나이  -- 2000년대에 태어난 사람은 7번째 자리가 3,4로 시작
    , nvl(salary + (salary*commission_pct), salary) AS "월급"
    , hire_date AS "입사일자"
    , last_day (to_char( add_months(sysdate, (63-( EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 ))*12), 'yyyy')  || 
            CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END ) -- 앞에 01,02 가 아니라 1,2,3,4 이렇게 바뀜(to_number)           
            AS 정년퇴직일                    
          , TRUNC(months_between(last_day (to_char( add_months(sysdate, (63-( EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 ))*12), 'yyyy')  || 
                                         CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END 
                                         ), hire_date) 
           )AS 정년까지근무개월수
          , TRUNC (TRUNC(months_between(last_day (to_char( add_months(sysdate, (63-( EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 ))*12), 'yyyy')  || 
                                                   CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END 
                                                   ), hire_date) 
                        ) /12) * nvl(salary + (salary*commission_pct), salary) AS 퇴직금
    FROM employees;

    -------------------------!! 중요 !!------------------------- : VIEW 라는 테이블로 보겠다.
    -- "Inline View" 를 사용하여 구해봅니다. --
    
    SELECT V.employee_id, full_name, jubun, gender, age, month_salary, hire_date  -- V. 는 생략 가능하다.     
           
           , last_day( 
                     to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                     CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
            ) AS 정년퇴직일
            
       --  ,  months_between(정년퇴직일, hire_date) AS 정년까지근무개월수
           ,  TRUNC(
                    months_between(last_day( 
                                            to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                                            CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
                                            ), hire_date) 
                   )AS 정년까지근무개월수
    --  , trunc(정년까지근무개월수/12) * 월급 as 퇴직금           
        , TRUNC(
                TRUNC(
                        months_between(last_day( 
                                                to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                                                CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
                                                ), hire_date) 
                 ) /12 
             ) * month_salary AS 퇴직금                    
    FROM 
    (
    SELECT employee_id
         , first_name ||' '|| last_name AS full_name
         , jubun
         , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END AS gender
         , EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 AS age
         , nvl(salary + (salary*commission_pct), salary) AS month_salary
         , hire_date
    FROM employees
    ) V; -- V 를 "inline view" 라고 부른다.
    
    
    -------------------- ***** !!!!! 아주 중요중요중요중요중요중요중요중요중요중요 !!!!! ***** -------------------- 
    -- VIEW(뷰)란? 테이블은 아니지만 select 되어진 결과물을 마치 테이블 처럼 보는것(간주하는 것)이다.
    
    -- VIEW(뷰) 는 2가지 종류가 있다.
    -- 첫번째로 ① inline view 가 있고, 두번째로 ② stored view 가 있다. 
    -- ① inline view 는 바로 위의 예제에 보이는 V 인 것이다. 즉, select 구문을 괄호( )를 쳐서 별칭(예 : V)을 부여한 것을 말한다.
    -- ② stored view 는 복잡한 SQL(Structured Query Language == 정형화된 질의어)을 저장하여 select 문을 간단하게 사용하고자 할 때 쓰인다.
    -- 그래서 inline view 는 1회성이고, stored view는 언제든지 불러내서 재사용이 가능하다.
    
    --- *** Stored View(저장된 뷰) 생성하기 *** ---
    /*
        create or replace view 뷰명 --> 만약에 저장된 뷰로 뷰명이 없으면 새롭게 생성해주고(create), 뷰명이 이미 존재한다면 그 이전의 select 문을 없애고 지금의 select 문으로 바꿔라(replace)는 말이다.
        as
        select 문;
    */
    -- 위의 create or replace view 와 아래의 select 문은 as(같다.)
    CREATE OR REPLACE VIEW view_employee_retire
    AS 
    SELECT employee_id
        , first_name || ' ' || last_name AS full_name
        , salary
        , department_id
    FROM employees
    WHERE department_id IN (20,30)
    -- View VIEW_EMPLOYEE_RETIRE이(가) 생성되었습니다.

    SELECT *
    FROM view_employee_retire;       -- view가 table 처럼 보임 (위의 select 문이 구동된 것이다.) ▶ table은 아니지만 table 처럼 보이도록,!!
    
    ---- 위에서 복사해옴 ▼▼▼▼▼
    --- *** Stored View(저장된 뷰) 생성하기 *** ---
    /*
        create or replace view 뷰명 --> 만약에 저장된 뷰로 뷰명이 없으면 새롭게 생성해주고(create), 뷰명이 이미 존재한다면 ★그 이전의 select 문을 없애고 지금의 select 문으로 바꿔라(replace)★는 말이다.
        as
        select 문;
    */
    CREATE OR REPLACE VIEW view_employee_retire
    AS     
    SELECT V.employee_id, full_name, jubun, gender, age, month_salary, hire_date  -- V. 는 생략 가능하다.     
           
           , last_day( 
                     to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                     CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
            ) AS retirement_date
           
           ,  TRUNC(
                    months_between(last_day( 
                                            to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                                            CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
                                            ), hire_date) 
                )AS retire_working_months_num
           , TRUNC(
                TRUNC(
                        months_between(last_day( 
                                                to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                                                CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
                                                ), hire_date) 
                 ) /12 
             ) * month_salary AS severance_pay
    FROM 
    (
    SELECT employee_id
         , first_name ||' '|| last_name AS full_name
         , jubun
         , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END AS gender
         , EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 AS age
         , nvl(salary + (salary*commission_pct), salary) AS month_salary
         , hire_date
    FROM employees
    ) V; 
    -- View VIEW_EMPLOYEE_RETIRE이(가) 생성되었습니다.

    SELECT * FROM TAB;

    DESC view_employee_retire;      

    SELECT *
    FROM view_employee_retire;       -- view가 table 처럼 보임 (위의 select 문이 구동된 것이다.) ▶ table은 아니지만 table 처럼 보이도록,!!
    
    ---- 40,50대 여자만 추출해보아라!
    SELECT *
    FROM view_employee_retire
    WHERE gender = '여' AND TRUNC(age, -1) IN (40,50);
    
    
    ---- 40,50대 남자만 추출해보아라!
    SELECT *
    FROM view_employee_retire
    WHERE gender = '남' AND retire_working_months_num >= 500;
    
    --- *** Stored View(저장된 뷰) 가 무엇이 있는지 알아봅니다. ---    
    SELECT *
    FROM user_views;
    
    --- *** Stored View(저장된 뷰) VIEW_EMPLOYEE_RETIRE 의 원본 소스를 알아봅니다. ---    VIEW_EMPLOYEE_RETIRE 는 view 인데 원본 소스는 아래이다.
    SELECT text 
    FROM user_views
    WHERE view_name = 'VIEW_EMPLOYEE_RETIRE';
    /*
    "SELECT V.employee_id, full_name, jubun, gender, age, month_salary, hire_date  -- V. 는 생략 가능하다.     
           
           , last_day( 
                     to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                     CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
            ) AS RETIREMENT_DATE
           
           ,  TRUNC(
                    months_between(last_day( 
                                            to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                                            CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
                                            ), hire_date) 
                )AS RETIRE_WORKING_MONTHS_NUM
           , TRUNC(
                TRUNC(
                        months_between(last_day( 
                                                to_char( add_months(sysdate, (63-age)*12), 'yyyy') || 
                                                CASE WHEN to_number( substr(jubun, 3, 2) ) BETWEEN 3 AND 8 THEN '-08-01' ELSE '-02-01' END
                                                ), hire_date) 
                 ) /12 
             ) * month_salary AS SEVERANCE_PAY
    FROM 
    (
    SELECT employee_id
         , first_name ||' '|| last_name AS FULL_NAME
         , jubun
         , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END AS GENDER
         , EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 AS AGE
         , nvl(salary + (salary*commission_pct), salary) AS MONTH_SALARY
         , HIRE_DATE
    FROM employees
    ) V"
    */
     
     
    -- ★★★ 5.5 lag 함수, lead 함수 
    --      ==> 게시판에서 특정 글을 조회할 때 많이 사용합니다. !!!
    
    CREATE TABLE tbl_board
    (boardno       NUMBER                -- 글번호 
    ,subject       VARCHAR2(4000)        -- 글제목   varchar2 의 최대크기는 4000 이다. 4000 보다 크면 오류!!!
    ,CONTENT       NVARCHAR2(2000)       -- 글내용   Nvarchar2 의 최대크기는 2000 이다. 2000 보다 크면 오류!!!
    ,userid        VARCHAR2(40)          -- 글쓴이의 ID
    ,registerday   DATE DEFAULT sysdate  -- 작성일자   default sysdate 은 데이터 입력시 registerday 컬럼의 값을 생략하면 기본적으로 sysdate 가 입력된다는 말이다. 
    ,readcount     NUMBER(10)            -- 조회수
    );
    
    INSERT INTO tbl_board(boardno, subject, CONTENT, userid, registerday, readcount)
    VALUES(1, '안녕하세요', '글쓰기 연습입니다', 'leess',  sysdate, 0);  
    -- 1 행 이(가) 삽입되었습니다.
    
    INSERT INTO tbl_board
    VALUES(2, '반갑습니다', '모두 취업대박 나십시오', 'eomjh',  sysdate, 0);  
    -- 1 행 이(가) 삽입되었습니다.
    
    INSERT INTO tbl_board(subject, boardno, CONTENT, userid, registerday, readcount)    -- 테이블 네임 다음에 column을 빼면 순서가 1:1 되어야 하지만, 그렇지 않으면 1:1로 다시 매핑하면 된다.
    VALUES('건강하세요', 3, '로또 1등을 기원합니다', 'youks',  sysdate, 0); 
    -- 1 행 이(가) 삽입되었습니다.
    
    INSERT INTO tbl_board(boardno, subject, CONTENT, userid, registerday, readcount)
    VALUES(4, '기쁘고 감사함이 넘치는 좋은 하루되세요', '늘 행복하세요', 'leess',  DEFAULT, 0);    -- 해당 컬럼에 date defalut sysdate라고 해놨기 때문에 defalut 라고 써도 된다.
    -- 1 행 이(가) 삽입되었습니다.
    
    INSERT INTO tbl_board(boardno, subject, CONTENT, userid, readcount)
    VALUES(5, '오늘도 좋은 하루되세요', '늘 감사합니다', 'hongkd', 0);  -- defalut sysdate 값을 생략해도 (registerday) 자동적으로 sysdate가 들어온다. (위에서 date defalut sysdate) 라고 설정.
    -- 1 행 이(가) 삽입되었습니다.
    
    COMMIT;
    -- 커밋 완료.
    
    SELECT *
    FROM tbl_board;
    
    SELECT boardno
         , CASE WHEN LENGTH(subject) > 7 THEN substr(subject, 1, 5) || '..' ELSE subject END AS subject
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')
    FROM tbl_board
    ORDER BY boardno DESC;

    /*
    -----------------------------------------------------------------------------------------------------------------------
    이전글번호   이전글제목   이전글작성일자           글번호     글제목       글작성일자            다음글번호   다음글제목   다음글작성일자
    -----------------------------------------------------------------------------------------------------------------------
    4	    기쁘고 감..	2022-01-07 10:24:46       5	    오늘도 좋..	2022-01-07 10:26:03   null      null        null
    3	    건강하세요	2022-01-07 10:23:59       4	    기쁘고 감..	2022-01-07 10:24:46   5	        오늘도 좋..	2022-01-07 10:26:03
    2	    반갑습니다	2022-01-07 10:23:07       3	    건강하세요	2022-01-07 10:23:59   4	        기쁘고 감..	2022-01-07 10:24:46
    1	    안녕하세요	2022-01-07 10:21:49       2	    반갑습니다	2022-01-07 10:23:07   3	        건강하세요	2022-01-07 10:23:59
    null    null        null                      1	    안녕하세요	2022-01-07 10:21:49   2	        반갑습니다	2022-01-07 10:23:07
    
    */    
    -- ()를 v라는 테이블로 보는 것임.
    -- board no를 내림차순 했을때 *고정*!!
    -- 이전글(글번호를 내림차순 했을 때 아래의 것) 
    -- lag : 나를 기준으로 n칸 위, lead : 나를 기준으로 n칸 아래
    SELECT LEAD(boardno,1) OVER(ORDER BY boardno DESC) AS 이전글번호        
           -- boardno(글번호) 컬럼의 값을 내림차순으로 정렬했을 때 아래쪽으로 1칸 내려간 행의 boardno 값을 가져오는 것이다.
         , LEAD(subject,1) OVER(ORDER BY boardno DESC) AS 이전글제목        
           -- boardno(글번호) 컬럼의 값을 내림차순으로 정렬했을 때 아래쪽으로 1칸 내려간 행의 subject 값을 가져오는 것이다.
         , LEAD(registerday,1) OVER(ORDER BY boardno DESC) AS 이전글작성일자
           -- boardno(글번호) 컬럼의 값을 내림차순으로 정렬했을 때 아래쪽으로 1칸 내려간 행의 registerday 값을 가져오는 것이다.
           
         , boardno AS 글번호
         , subject AS 글제목
         , registerday AS 작성일자

         , LAG(boardno,1) OVER(ORDER BY boardno DESC) AS 다음글번호        
           -- boardno(글번호) 컬럼의 값을 내림차순으로 정렬했을 때 윗쪽으로 1칸 올라간 행의 boardno 값을 가져오는 것이다.         
         , LAG(subject,1) OVER(ORDER BY boardno DESC) AS 다음글제목        
           -- boardno(글번호) 컬럼의 값을 내림차순으로 정렬했을 때 윗쪽으로 1칸 올라간 행의 subject 값을 가져오는 것이다.         
         , LAG(registerday,1) OVER(ORDER BY boardno DESC) AS 다음글작성일자
           -- boardno(글번호) 컬럼의 값을 내림차순으로 정렬했을 때 윗쪽으로 1칸 올라간 행의 registerday 값을 가져오는 것이다.    

    FROM  
       (
        SELECT boardno
             , CASE WHEN LENGTH(subject) > 7 THEN substr(subject, 1, 5)||'..' ELSE subject END AS subject
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday
        FROM tbl_board
       ) V;
        
      SELECT LEAD(boardno) OVER(ORDER BY boardno DESC)    AS 이전글번호
              -- 숫자가 없으면 1 이 생략된 것이다. 
              
            , LEAD(subject) OVER(ORDER BY boardno DESC)    AS 이전글제목
            , LEAD(registerday) OVER(ORDER BY boardno DESC) AS 이전글작성일자
    
            , boardno      AS 글번호
            , subject      AS 글제목
            , registerday  AS 글작성일자
            
            , LAG(boardno) OVER(ORDER BY boardno DESC)    AS 다음글번호
              -- 숫자가 없으면 1 이 생략된 것이다.
            
            , LAG(subject) OVER(ORDER BY boardno DESC)    AS 다음글제목
            , LAG(registerday) OVER(ORDER BY boardno DESC) AS 다음글작성일자
        FROM
        (
        SELECT  boardno              
              , CASE WHEN LENGTH(subject) > 7 THEN substr(subject, 1, 5) || '..' ELSE subject END AS subject
              , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday
        FROM tbl_board
        )V;
      
     SELECT T.*
      FROM   
      ( 
       SELECT LEAD(boardno) OVER(ORDER BY boardno DESC)    AS 이전글번호
            , LEAD(subject) OVER(ORDER BY boardno DESC)    AS 이전글제목
            , LEAD(registerday) OVER(ORDER BY boardno DESC) AS 이전글작성일자
       
            , boardno      AS 글번호
            , subject      AS 글제목
            , registerday  AS 글작성일자
            
            , LAG(boardno) OVER(ORDER BY boardno DESC)    AS 다음글번호
            , LAG(subject) OVER(ORDER BY boardno DESC)    AS 다음글제목
            , LAG(registerday) OVER(ORDER BY boardno DESC) AS 다음글작성일자
       FROM  
       (
        SELECT boardno
             , CASE WHEN LENGTH(subject) > 7 THEN substr(subject, 1, 5)||'..' ELSE subject END AS subject
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday
        FROM tbl_board
       ) V
      ) T  
      WHERE T.글번호 = 3;    -- 컬럼네임이 한글로 바뀐 것.
 
 
 
 
    ------------------------------------------------------------------------------------------------------------      
    -- *** case when then else end 구문을 사용하여 로그인 메시지 보여주기 *** --    
    
    CREATE TABLE tbl_members
    (userid    VARCHAR2(20)
    ,passwd    VARCHAR2(20)
    ,NAME      VARCHAR2(20)
    ,addr      VARCHAR2(100)
    );
    
    INSERT INTO tbl_members(userid, passwd, NAME, addr)
    VALUES('kimys','abcd','김유신','서울');
    
    INSERT INTO tbl_members(userid, passwd, NAME, addr)
    VALUES('young2','abcd','이영이','서울');
    
    INSERT INTO tbl_members(userid, passwd, NAME, addr)
    VALUES('leesa','abcd','이에리사','서울');
    
    INSERT INTO tbl_members(userid, passwd, NAME, addr)
    VALUES('park','abcd','박이남','서울');
    
    INSERT INTO tbl_members(userid, passwd, NAME, addr)
    VALUES('leebon','abcd','이본','서울');
    
    COMMIT;  
    
    SELECT *
    FROM tbl_members;
    
    SELECT COUNT(*) -- select 되어 나온 결과물의 행의 개수 ==> 5
    FROM tbl_members;    
    
    SELECT *
    FROM tbl_members    
    WHERE userid = 'kimys' AND passwd = 'abcd';
    
    SELECT COUNT(*)  -- select 되어 나온 결과물의 행의 개수 ==> 1   (아이디는 고유하다라고 보는 가정)
    FROM tbl_members    
    WHERE userid = 'kimys' AND passwd = 'abcd';
    
    SELECT *
    FROM tbl_members    
    WHERE userid = 'kimys' AND passwd = 'asfdsgsfgsdf';
    
    SELECT COUNT(*)  -- select 되어 나온 결과물의 행의 개수 ==> 0 
    FROM tbl_members    
    WHERE userid = 'kimys' AND passwd = 'asfdsgsfgsdf'; 
    
    SELECT *
    FROM tbl_members    
    WHERE userid = 'kimyssdfsdfsd' AND passwd = 'abcd';
    
    SELECT COUNT(*)  -- select 되어 나온 결과물의 행의 개수 ==> 0 
    FROM tbl_members    
    WHERE userid = 'kimyssdfsdfsd' AND passwd = 'abcd';
    
    /*
       -- [퀴즈] --
       tbl_members 테이블에서
       userid 및 passwd 가 모두 올바르면 '로그인성공' 을 보여주고,
       userid 는 올바르지만 passwd 가 틀리면 '암호가 틀립니다' 을 보여주고,
       userid 가 존재하지 않으면 '아이디가 존재하지 않습니다' 을 보여주려고 한다.
    */
    
    SELECT CASE ( SELECT COUNT(*)
                  FROM tbl_members
                  WHERE userid='kimys' AND passwd ='abcd') 
           WHEN 1 THEN '로그인성공'
           ELSE ( 
                  CASE (SELECT COUNT(*)
                        FROM tbl_members
                        WHERE userid='kimys')
                  WHEN 1 THEN '암호가 틀립니다'
                  ELSE '아이디가 존재하지 않습니다'
                  END
                 )
           END AS 로그인결과      
    FROM dual;
  
  
  
  -- ======================================================================== --  
  ------------------------------------------------------------------------------
 
  ------------------ >> ★★★그룹함수(집계함수)★★★ << ------------------
/* (주로 1~5번 자주사용)
    1. sum      -- 합계
    2. avg      -- 평균
    3. max      -- 최대값
    4. min      -- 최소값
    5. count    -- select 되어서 나온 결과물의 행의 개수
    6. variance -- 분산
    7. stddev   -- 표준편차
    
    분산    : 분산의 제곱근이 표준편차   (평균에서 떨어진 정도)
    표준편차 : 표준편차의 제곱승이 분산   (평균과의 차액)
    
    >> 주식투자 <<
  A -  50 60 40 50 55 45 52 48     평균 50 A는 B보다 상대적으로 편차가 적음.   -- 안정투자                  // 적게 따던지 적게 잃던지!!
  B -  10 90 20 80 30 70 90 10     평균 50 B는 A보다 상대적으로 편차가 큼.     -- 투기성투자(위험을 안고 투자) // 많이 따던지 많이 잃던지!
    
  분산과 표준편차는 어떤 의사결정시 도움이 되는 지표이다.  
    
*/ 

    SELECT salary, to_char(salary,'$99,999')
    FROM employees; -- 107개 행   107개 행
    
    SELECT SUM(salary)  -- 그룹함수는 결과물이 1개행만 나온다.
    FROM employees;
        
    SELECT salary, SUM(salary)  -- salary는 107개 행, 그룹함수는 결과물이 1개행만 나온다. ▶ 그러므로 두가지를 한꺼번에 썼을 때 오류가 나옴.
    FROM employees; -- 테이블은 다각형이 아니므로 이것은 오류이다.!!! // * 오류> ORA-00937: not a single-group group function
    
    --- !!! 중요중요중요중요 !!! ---
    -- 그룹함수(집계함수) 에서는 null 이 있으면 무조건 null 은 제외시킨 후 연산을 한다.!!
    -- 그룹함수(집계함수) 를 사용하면 1개의 결과물을 가진다.
    -- 사칙연산에 null 을 더하면 결과값은 null 이다. ▶ 그러므로 nvl을 사용하는 것.
    SELECT 1+100+5000+NULL  -- null
    FROM dual;    
    
    SELECT SUM(salary * commission_pct) -- 73690 (그룹함수(집계함수) 에서는 null 이 있으면 무조건 null 은 제외시킨 후 연산 ▶ 그러므로 sum(그룹함수) 후 아래와 같은 결과값이 나오는 것)
    FROM employees;
    
    SELECT SUM(salary * commission_pct) -- 73690
    FROM employees
    WHERE commission_pct IS NOT NULL;
    
    SELECT SUM(salary * commission_pct)
         , COUNT(salary)            -- 107 (전체 107행)
         , COUNT(commission_pct)    -- 35 (null 이 아닌것이 35개) :count는 그룹함수이므로 null 값 제외하고 35가 나옴.
    FROM employees;
    
    DESC employees; -- table에서 NOT NULL 인 것은 그룹함수 시 제외되지 않음. *을 사용해서 전체 조회한다.
    
    SELECT COUNT(*)             -- *: 모든 column (전체사원수)
         , COUNT(department_id) -- 106 (kimberly 가 null 이므로 107-1=106) : department_id 컬럼의 값이 null 이 아닌 개수
         , COUNT(commission_pct)-- 35 : commission_pct 컬럼의 값이 null 이 아닌 개수
         , COUNT(employee_id)   -- 107
         , COUNT(email)         -- 107
    FROM employees;
    
    
    SELECT SUM(salary * commission_pct)     -- 합계
        ,  AVG(salary * commission_pct)     -- 평균
        ,  MAX(salary * commission_pct)     -- 최대값
        ,  MIN(salary * commission_pct)     -- 최소값
        ,  COUNT(salary * commission_pct)   -- null 을 제외한 개수 (35)
        ,  VARIANCE(salary * commission_pct)-- 분산
        ,  STDDEV(salary * commission_pct)  -- 표준편차      
    FROM employees;
    
    
    --------- **** avg() 평균을 구할때는 주의를 요한다. **** ---------
    -- 요구한 사람의 의도가 맞는지 꼭.!! 확인한다.
    -- 수당을 받는 사람'들'만의 평균치인지, 수당을 받지 않는 사람들의 값을 0으로 간주해서(바꿔서) 총 합계로 산출하여 계산할 것인지.
    
    -- employees 테이블에서 수당액(salary * commission_pct)의 평균을 나타내세요.
    SELECT SUM(salary*commission_pct)/COUNT(salary*commission_pct)
        -- 2105.428571428571428571428571428571428571
        -- 73690 / 35
        
          , AVG(salary*commission_pct)
        -- 2105.428571428571428571428571428571428571
         
          , SUM(salary*commission_pct)/COUNT(*)        
        -- 73690 / 107
        -- 688.691588785046728971962616822429906542
        
         , SUM( nvl (salary*commission_pct, 0)) / COUNT(nvl(salary*commission_pct, 0))
        -- 73690 / 107
        -- 688.691588785046728971962616822429906542
        
         , AVG( nvl (salary*commission_pct, 0))
        -- 688.691588785046728971962616822429906542                    
    FROM employees;
    
    SELECT salary * commission_pct
         , nvl(salary*commission_pct, 0)
    FROM employees;
    
    SELECT COUNT(salary * commission_pct)       -- 35
         , COUNT(nvl(salary*commission_pct, 0)) -- 107 (nvl 사용함으로써 null을 0으로 만들면서 그룹함수인 count가 전체 행을 셀 수 있도록 함)
    FROM employees;
    -- sum(10+20+null+30) ==> 60    (그룹함수는 null 제외하고 계산)
    -- sum(10+20+0+30)    ==> 60    
    
    SELECT AVG(salary * commission_pct)       
         -- 2105.428571428571428571428571428571428571
         -- 수당액을 받는 사람들 그들만의 수당액 평균
    
         , AVG(nvl(salary*commission_pct, 0)) 
         -- 688.691588785046728971962616822429906542                             
         -- 수당이 null 인 사람은 0 으로 간주한 *모든 사원들*의 수당액 평균
    FROM employees; 
    
    
    ---- **** 그룹함수(집계함수) 와 함께 사용되는 group by 절에 대해서 알아봅니다. **** ----
    
    --- employees 테이블에서 부서번호별로 인원수를 나타내세요. ---
    
    /*
    -----------------
    부서번호    인원수
    -----------------
      10        1
      20        2
      30        6
      40        1
      ...       ...
    */
    SELECT department_id AS 부서번호
           , COUNT(*) AS 인원수       
    FROM employees
    GROUP BY department_id           -- department_id 컬럼의 값이 같은 것 끼리 group을 짓는다.
    ORDER BY 1 ;
    
    --- employees 테이블에서 성별로 인원수를 나타내세요. ---
    /*
        --------------
        성별      인원수
        --------------
        여	    51
        남	    56
    */
    SELECT gender AS 성별, COUNT(*) AS 인원수
    FROM    -- GENDER 라는 column 을 가진 테이블.!!!
    (
    SELECT CASE WHEN substr(jubun,7,1) IN ('1','3') THEN '남' ELSE '여' END AS gender -- GENDER 가 원래 테이블에 없어서 만들었다!! 없으면, 만들어라.
    FROM employees
    ) V
    GROUP BY gender
    ORDER BY 2
    
    ---- [퀴즈] employees 테이블에서 연령대별로 인원수를 나타내세요. ----
   /*
      -------------------
       연령대       인원수
      -------------------
        10
        20
        30
        40
        50
        60
   */
   
   /*
    ---- -------   
    나이   연령대 trunc(나이, -1)
    ---- -------
    10	    16
    20	    18
    30	    21
    40	    20
    50	    16
    60	    16
    
    trunc(25, -1) * 20으로 산출됨.
   
   나이 ==>  현재년도 - 태어난년도 + 1
            extract(year from sysdate) - case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end +1 AS birth_date
   
   */
    
    SELECT V.age_line AS 연령대
           , COUNT(*) AS 인원수
    FROM    
   (
    SELECT TRUNC(EXTRACT(YEAR FROM sysdate) - (substr(jubun,1,2) + CASE WHEN substr(jubun,7,1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 , -1) AS age_line 
    FROM employees
   ) V
   GROUP BY V. age_line -- V.는 생략가능
   ORDER BY 1;

   
   
   ----- **** 1차 그룹, 2차 그룹 짓기 **** -----
   
   -- employees 테이블에서 부서번호별, 성별 인원수를 나타내세요 .. --
   /*
   ----------------------------
   부서번호    성별      인원수
   ----------------------------
   ......   ......     .....
   50       남           23
   50       여           22
   60       남           4   
   60       여           1
   
   */
   SELECT V.department_id AS 부서번호
        , V.gender AS 성별
        , COUNT(*)
   FROM
   (
   SELECT department_id
        , CASE WHEN substr(jubun,7,1) IN ('1','3') THEN '남' ELSE '여' END AS gender
   FROM employees
   )V
   GROUP BY V.department_id, V.gender   -- 1차(department_id), 2차그룹(GENDER)
   ORDER BY 1;
   
   ---- [퀴즈] employees 테이블에서 연령대별, 성별 인원수를 나타내세요. ----
   /*
      -------------------------
       연령대     성별    인원수
      -------------------------
        10        남     10
        10        여     6   
        20        남     8
        20        여     10
        30        남     10
        30        여     11
        ...       ...
   */
   SELECT age_line AS 연령대
        , gender   AS 성별
        , COUNT(*) AS 인원수
   FROM
   (
    SELECT TRUNC(EXTRACT(YEAR FROM sysdate) - (substr(jubun,1,2) + CASE WHEN substr(jubun,7,1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 , -1) AS age_line 
         , CASE WHEN substr(jubun,7,1) IN ('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
   )V
   GROUP BY V.age_line, V.gender
   ORDER BY 1;
   
   -----------------------------------------------------------------------------
   
   -- *** 요약값을 보여주는 rollup, cube, grouping sets, grouping 에 대해서 알아봅니다. *** --
   
       ----- >>>>> 요약값(rollup, cube, grouping sets) <<<<< ------
  /*
      1. rollup(a,b,c) 은 grouping sets( (a,b,c),(a,b),(a),() ) 와 같다.
    
         group by rollup(department_id, gender) 은
         group by grouping sets( (department_id, gender), (department_id), () ) 와 같다.
                                  --> 동일부서내에서 성별
  
      2. cube(a,b,c) 은 grouping sets( (a,b,c),(a,b),(b,c),(a,c),(a),(b),(c),() ) 와 같다.
 
         group by cube(department_id, gender) 은
         group by grouping sets( (department_id, gender), (department_id), (gender), () ) 와 같다.
         
         Grouping sets : 내가 보고싶은 것만 볼 수 있다.
         Cube : 결과가 모두 다 나옴.
  */
   
   
   -- employees 테이블에서 부서번호별로 인원수를 나타내면서 동시에 전체인원수도 나타내세요.
   
   SELECT department_id AS 부서번호
        , COUNT(*) AS 인원수
   FROM employees
   GROUP BY ROLLUP (department_id);

   -- rollup 없이 grouping 을 넣는 것은 의미가 없다. (맨밑에 요약값이 나오지 않기 때문.!!)
   -- grouping 은 0 아니면 1만 나옴. 
   -- 0: department_id 컬럼의 실제 값을 가지고 있는 것. 
   -- 1: 그룹을 안지었다는 말. (합계값은 값을 합산한 것이지 컬럼의 실제 값을 가진것이 아님( 메모리에 107개가 다 올라가 있는 것이다. = 메모리에 전체가 올라가 있다))
   SELECT department_id AS 부서번호
        , GROUPING(department_id)   -- grouping(department_id) 은 결과값이 오로지 2개만 나온다. 0 또는 1인데, 0이라 함은 department_id 컬럼의 값으로 그룹을 지었다는 말이고, 1이라 함은 그룹을 안 지었다는 말이다.
        , COUNT(*) AS 인원수
   FROM employees
   GROUP BY ROLLUP (department_id);

    -- 퍼센티지 보이기
    
   SELECT decode( GROUPING(department_id), 0, nvl(to_char(department_id),'인턴')    -- 이 값이 그룹을 지었는지(0) 안지었는지(1) 판단하는 기준. // to_char를 쓰는 이유는 숫자 타입을 문자타입(왼쪽정렬)으로 맞춰줘야 하기 때문.
                                            , '전체') AS 부서번호 
        , COUNT(*) AS 인원수
        , round(COUNT(*) / (SELECT COUNT(*) FROM employees) * 100, 1) AS 퍼센티지   -- round( , 1) 소수부 첫째자리까지 보인다.
   FROM employees
   GROUP BY ROLLUP (department_id);
    
    
    -- employees 테이블에서 성별로 인원수를 나타내면서 동시에 전체인원수도 나타내세요.
    /*
    --------------------
    성별   인원수   퍼센티지
    --------------------
    남     50        49
    여     57        51
    전체   107       100   
   */
   SELECT decode(GROUPING(V.gender), 0, V.gender, '전체') AS 성별 
          , COUNT(*) AS 인원수
          , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
   FROM
   (
   SELECT CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender 
   FROM employees
   )V
   GROUP BY ROLLUP (V.gender);
   
       
    -- employees 테이블에서 부서번호별, 성별로 인원수를 나타내면서 동시에 전체인원수도 나타내세요.
    /*
    ------------------------------
    부서번호  성별   인원수   퍼센티지
    ------------------------------
    ...     ...     ...     .....
    50      남       20      
    50      여       35      
    50      전체     45
    60      남       3
    60      여       2
    60      전체     5
    ...     ...     ...     .....    
    전체    전체      107
    */
    --- group by roll up 사용시 ---
    SELECT  decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')    -- varchar 타입과 숫자가 동시에 쓰일 수 없다. ▶ to_char 로 바꾼다( 숫자 -> 문자 )
                                             , ' ') AS 부서번호                         -- 넘버타입을 -9999로 하겠다. (그룹을 안지을 경우 -9999로 도출된다.)
            , decode(GROUPING(V.gender), 0, V.gender                                  -- 여기는 GENDER 와 '전체' 모두 문자열이므로 GENDER의 타입을 바꿀 필요가 없다.
                                          , ' ') AS 성별                               -- ' ' = 공백 , '' = null로 출력된다.
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    )V
    GROUP BY ROLLUP (V.department_id, V.gender); -- 부서번호, 성별 그룹지음 // rollup(유효값 도출)
    
    -- roll up 2 (group 순서가 중요하다)
    
    SELECT  decode(GROUPING(V.gender), 0, V.gender                         -- 여기는 GENDER 와 '전체' 모두 문자열이므로 GENDER의 타입을 바꿀 필요가 없다.
                                          , ' ') AS 성별
            , decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      -- varchar 타입과 숫자가 동시에 쓰일 수 없다. ▶ to_char 로 바꾼다( 숫자 -> 문자 )
                                             , ' ') AS 부서번호                                           -- ' ' = 공백 , '' = null로 출력된다.
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    )V
    GROUP BY ROLLUP (V.gender, V.department_id); -- 부서번호, 성별 그룹지음 // rollup(유효값 도출)
    

    -- grouping sets 사용( == roll up과 같음)
    
    SELECT  decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      -- varchar 타입과 숫자가 동시에 쓰일 수 없다. ▶ to_char 로 바꾼다( 숫자 -> 문자 )
                                             , ' ') AS 부서번호             -- 넘버타입을 -9999로 하겠다. (그룹을 안지을 경우 -9999로 도출된다.)
            , decode(GROUPING(V.gender), 0, V.gender                         -- 여기는 GENDER 와 '전체' 모두 문자열이므로 GENDER의 타입을 바꿀 필요가 없다.
                                          , ' ') AS 성별                      -- ' ' = 공백 , '' = null로 출력된다.
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    )V
    GROUP BY GROUPING SETS ((V.department_id, V.gender), V.department_id,());    
    
   ---- grouping sets 2  (grouping sets 순서 변환)   
    SELECT  decode(GROUPING(V.gender), 0, V.gender                         -- 여기는 GENDER 와 '전체' 모두 문자열이므로 GENDER의 타입을 바꿀 필요가 없다.
                                          , ' ') AS 성별
            , decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      -- varchar 타입과 숫자가 동시에 쓰일 수 없다. ▶ to_char 로 바꾼다( 숫자 -> 문자 )
                                             , ' ') AS 부서번호                                           -- ' ' = 공백 , '' = null로 출력된다.
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    )V
    GROUP BY GROUPING SETS ((V.gender, V.department_id), (V.gender), ()) ; -- 부서번호, 성별 그룹지음 // rollup(유효값 도출)

    
    --- cube 사용시 ---        
    SELECT  decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      
                                             , ' ') AS 부서번호             
            , decode(GROUPING(V.gender), 0, V.gender                         
                                          , ' ') AS 성별                     
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    )V
    GROUP BY CUBE (V.department_id, V.gender)
--  order by 1;
    ORDER BY V.department_id;
    
    
    --- grouping sets 3       
    SELECT  decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      
                                             , ' ') AS 부서번호             
            , decode(GROUPING(V.gender), 0, V.gender                         
                                          , ' ') AS 성별                     
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    )V
    GROUP BY GROUPING SETS ((V.department_id, V.gender), (V.department_id), (V.gender), ())
--  order by 1;
    ORDER BY V.department_id;

    -- grouping sets 4
    SELECT  decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      
                                             , ' ') AS 부서번호             
            , decode(GROUPING(V.gender), 0, V.gender                         
                                          , ' ') AS 성별                     
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    ) V
    GROUP BY GROUPING SETS ((V.department_id, V.gender), ())
--  order by 1;
    ORDER BY V.department_id;

    -- grouping sets 5
    SELECT  decode(GROUPING(department_id), 0, nvl(to_char(V.department_id),'인턴')      
                                             , ' ') AS 부서번호             
            , decode(GROUPING(V.gender), 0, V.gender                         
                                          , ' ') AS 성별                     
            , COUNT(*) AS 인원수
            , round(COUNT(*) / (SELECT COUNT(*) FROM employees) *100, 1) AS 퍼센티지
    FROM
    (
    SELECT department_id
           , CASE WHEN substr(jubun,7,1) IN('1','3') THEN '남' ELSE '여' END AS gender
    FROM employees
    ) V
    GROUP BY GROUPING SETS ((V.department_id), (V.gender), ())  -- 보고싶은 것만 도출 ▶ 그룹 짓고싶은것만 group 화
--  order by 1;
    ORDER BY V.department_id;       
    
    
    ---------- ======= ****   having 그룹함수조건절   **** ======= ----------
   /*
       group by 절을 사용하여 그룹함수의 값을 나타내었을때
       그룹함수의 값이 ★특정 조건에 해당하는 것만 추출★하고자 할때는 where 절을 사용하는 것이 아니라
       having 그룹함수조건절 을 사용해야 한다.
   */
   
   -- employees 테이블에서 사원이 10명 이상 근무하는 부서번호와 그 인원수를 나타내세요. --
   
   SELECT department_id AS 부서번호, COUNT(*) AS 인원수
   FROM employees
   WHERE COUNT(*) >= 10         -- where 는 어떤 행만 메모리에 올리라는 뜻. select 부터가 아니라 from 부터라는 것을 잊지 말자.
   GROUP BY department_id;      -- 오류!!
   
   
   SELECT department_id AS 부서번호
        , COUNT(*) AS 인원수
   FROM employees
   GROUP BY department_id           -- 그룹을 짓고, 내가 보고싶은 count(인원수) 결과 출력
   HAVING COUNT(*) >= 10
   order by 인원수 desc;
   
   --- [퀴즈] employees 테이블에서 부서번호별로 월급의 합계를 나타내었을 때
   --        부서번호별 월급의 합계가 50000 이상인 부서에 대해서만
   --        부서번호, 월급의 합계를 나타내세요.
   select department_id AS 부서번호
          , to_char(sum( nvl(salary + (salary*commission_pct), salary) )
                    , '9,999,999') AS 월급의합계
   from employees
   group by department_id
   having sum( nvl(salary + (salary*commission_pct), salary) ) >= 50000      -- 그룹함수(sum)에 대한 조건절
   order by 2 desc;   
   
   ------- **** !!! 누적(누계)에 대해서 알아봅니다. !!! **** ---------
   /*
        sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
        
        sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
                                  order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
   */
    create table tbl_panmae
    (panmaedate  date
    ,jepumname   varchar2(20)
    ,panmaesu    number
    );
   
   -- Table TBL_PANMAE이(가) 생성되었습니다.
   
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-2), '새우깡', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-2)+1, '새우깡', 15); 
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-2)+2, '감자깡', 20);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-2)+3, '새우깡', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-2)+3, '새우깡', 3);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-1), '고구마깡', 7);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-1)+1, '새우깡', 8); 
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-1)+2, '감자깡', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( add_months(sysdate,-1)+3, '감자깡', 5);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate - 4, '허니버터칩', 30);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate - 3, '고구마깡', 15);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate - 2, '고구마깡', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate - 1, '허니버터칩', 20);
        
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '새우깡', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '새우깡', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '감자깡', 5);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '허니버터칩', 15);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '고구마깡', 20);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '감자깡', 10); 
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( sysdate, '새우깡', 10);
    
    commit;
    
    select * 
    from tbl_panmae;
    
    -- *** tbl_panmae 테이블에서 '새우깡'에 대한 일별판매량과 일별누적판매량을 나타내세요. *** --
    /*
    sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
    
    sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
                               order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
    */
    select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') as PANMAEDATE
          , panmaesu
    from tbl_panmae
    where jepumname = '새우깡';
    
    ----------------------------------
    판매일자    일별판매량   일별누적판매량
    ----------------------------------
    2021-11-10 	    10      10
    2021-11-11 	    15      25
    2021-11-13 	    13      38
    2021-12-11 	    8       46
    2022-01-10 	    30      76
    ----------------------------------
    
    select to_char(PANMAEDATE, 'yyyy-mm-dd') as 판매일자
          , sum(panmaesu) as 일별판매량
--        , sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
          , sum(sum(panmaesu)) over(order by to_char(PANMAEDATE, 'yyyy-mm-dd') asc ) as 일별누적판매량 -- panmaedate(판매일자) 의 오름차순으로 정렬 했을 때, 일별판매량을 누적해라.
    from tbl_panmae
    where jepumname = '새우깡'
    group by to_char(panmaedate, 'yyyy-mm-dd');     -- panmaedate(판매일자)만 같으면 누적.   // 그룹함수는 없기 때문에 having 쓸 필요가 없다.

    -- *** tbl_panmae 테이블에서 모든 제품에 대한 일별판매량과 일별누적판매량을 나타내세요. *** --

    select-- jepumname as 제품명  
          to_char(PANMAEDATE, 'yyyy-mm-dd') as 판매일자
          , sum(panmaesu) as 일별판매량
--        , sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
          , sum(sum(panmaesu)) over(order by to_char(PANMAEDATE, 'yyyy-mm-dd') asc ) as 일별누적판매량 -- panmaedate(판매일자) 의 오름차순으로 정렬 했을 때, 일별판매량을 누적해라.
    from tbl_panmae
    where jepumname = '감자깡'    
    group by to_char(panmaedate, 'yyyy-mm-dd');     -- panmaedate(판매일자)만 같으면 누적.   // 그룹함수는 없기 때문에 having 쓸 필요가 없다.
    
    -----------------------------------------
    제품명    판매일자    일별판매량   일별누적판매량
    -----------------------------------------
    감자깡   2021-11-12  20	    20
    감자깡   2021-12-12	10	    30
    감자깡   2021-12-13  	5	    35
    감자깡   2022-01-10	15	    50
    ...
    ...
    새우깡   2021-11-10  10      10
    새우깡   2021-11-11 	15      25
    새우깡   2021-11-13 	13      38
    새우깡   2021-12-11 	8       46
    새우깡   2022-01-10 	30      76
    ----------------------------------                               
    select jepumname as 제품명
         , to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
         , sum(panmaesu) as 일별판매량 
--       , sum(누적되어야할 컬럼명) over(★ partition by 그룹화 되어질 컬럼명 ★            -- ★제품별★로 분류하여 누적판매량을 산출한다.
--                              order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
         , sum(sum(panmaesu)) over(partition by jepumname 
                                   order by to_char(PANMAEDATE, 'yyyy-mm-dd') desc ) as 일별누적판매량      
    from tbl_panmae   
    group by jepumname, to_char(panmaedate, 'yyyy-mm-dd');    

-- Stored view 생성하기 ▶ 복잡한 것은 stored view 를 생성해서 불러온다.!!

    create or replace view view_NujukPanmae
    as
    select JEPUMNAME 
         , to_char(panmaedate, 'yyyy-mm-dd') as PANMAEDATE
         , sum(panmaesu) as DAILY_SALES 
         , sum(sum(panmaesu)) over(partition by JEPUMNAME 
                                   order by to_char(PANMAEDATE, 'yyyy-mm-dd') desc ) as DAILY_NUJUK_SALES      
    from tbl_panmae      
    group by jepumname, to_char(panmaedate, 'yyyy-mm-dd');    
-- View VIEW_NUJUKPANMAE이(가) 생성되었습니다.
    
    select *
    from VIEW_NUJUKPANMAE    
    where jepumname in('감자깡','고구마깡')
    
    
    --- *** [퀴즈] tbl_panmae 테이블에서 판매일자가 1개월전 '01'일(즉, 현재가 2022년 1월 10일 이므로 2021년 12월 1일) 부터 판매된 
    --            모든 제품에 대해 일별판매량과 일별누적판매량을 나타내세요.
    
-- 한달 전의 1일로 바꾸는 방법 2가지   
    select sysdate
         , add_months(sysdate,-1)
         , to_date( to_char(add_months(sysdate, -1),'yyyy-mm-') || '01', 'yyyy-mm-dd') -- ①'yyyy-mm-'를 다시 날짜로(to_date) 바꾼 것임.    
         , last_day(add_months(sysdate, -2)) + 1                                        -- ② 2달전 월을 뽑은 후, 그 달의 마지막 날(last_day) +1 (그다음 하루)를 더하면 한달전의 1일이 나옴.
    from dual;

-- 정답 도출 ① ▼    
    select jepumname as JEPUMNAME
         , to_char(PANMAEDATE, 'yyyy-mm-dd') as PANMAEDATE
         , sum(panmaesu) as DAILY_SALES 
         , sum(sum(panmaesu)) over(partition by jepumname 
                                   order by to_char(PANMAEDATE, 'yyyy-mm-dd') desc ) as DAILY_NUJUK_SALES      
    from tbl_panmae   
    where panmaedate >= to_date( to_char(add_months(sysdate, -1),'yyyy-mm-') || '01', 'yyyy-mm-dd')        -- ||: '01'을 더해준다.
    group by jepumname, to_char(PANMAEDATE, 'yyyy-mm-dd');        

-- 정답 도출 ② ▼    
    select jepumname as JEPUMNAME
         , to_char(PANMAEDATE, 'yyyy-mm-dd') as PANMAEDATE
         , sum(panmaesu) as DAILY_SALES 
         , sum(sum(panmaesu)) over(partition by jepumname 
                                   order by to_char(PANMAEDATE, 'yyyy-mm-dd') desc ) as DAILY_NUJUK_SALES      
    from tbl_panmae   
    where panmaedate >= last_day(add_months(sysdate, -2)) + 1         
    group by jepumname, to_char(PANMAEDATE, 'yyyy-mm-dd');            
    
    
    ------ ==== *** 아래처럼 나오도록 하세요 *** ==== ------
    
    ----------------------------------------------------------------------
    전체사원수   10대   20대   30대   40대   50대   60대   
    ----------------------------------------------------------------------
    107        
    ----------------------------------------------------------------------
    
    /*
    select trunc( SELECT TRUNC(EXTRACT(YEAR FROM sysdate) - (태어난년도) + 1 , -1) AS AGELINE 
    from employees;

    태어난년도 ==> to_number(substr(jubun,1,2)) + 1900 OR 2000
                                   + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end as AGELINE

    */

    -- ver1.
    select V.ageline
          ,decode(V.ageline, 10, 1) -- 10대라면 1값을 준다.
          ,decode(V.ageline, 20, 1)
          ,decode(V.ageline, 30, 1)
          ,decode(V.ageline, 40, 1)
          ,decode(V.ageline, 50, 1)
          ,decode(V.ageline, 60, 1)
    from
    (
    SELECT trunc((EXTRACT(YEAR FROM sysdate) - (to_number(substr(jubun,1,2)) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end) + 1) , -1) 
           AS AGELINE
    from employees
    ) V;
    
    -- ver 2. ▼ 올바른 정답. (count를 통해서 각 연령별 사원수를 구한다.)
    select count(V.ageline) as 전체사원수
          , sum(decode(V.ageline, 10, 1)) as "10대"  -- 별칭에 있어 첫글자가 숫자면 반드시 ""로 처리해야 한다.
          , sum(decode(V.ageline, 20, 1)) as "20대"
          , sum(decode(V.ageline, 30, 1)) as "30대"
          , sum(decode(V.ageline, 40, 1)) as "40대"
          , sum(decode(V.ageline, 50, 1)) as "50대"
          , sum(decode(V.ageline, 60, 1)) as "60대"
    from
    (
    SELECT trunc((EXTRACT(YEAR FROM sysdate) - (to_number(substr(jubun,1,2)) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end) + 1) , -1) 
           AS AGELINE
    from employees
    ) V;
    
    ---------- ===== *** [퀴즈] 아래처럼 나오도록 하세요 *** ===== ----------
   
   select employee_id, first_name, job_id
   from employees;
   
   --------------------------------------------------------------------------------------------------------------------------------------
     직종ID          남자기본급여평균    여자기본급여평균     기본급여평균    (남자기본급여평균 - 기본급여평균)       (여자기본급여평균 - 기본급여평균)
   --------------------------------------------------------------------------------------------------------------------------------------
     ........           ....              ....             ....                   ...                                 ...     
     FI_ACCOUNT         7900              7950             7920                   -20                                  30 
     IT_PROG            5700              6000             5760                   -60                                 240 
     ........           ....              ....             ....                   ...                                 ...   
   --------------------------------------------------------------------------------------------------------------------------------------

    
-- ▼ 쌤 답안 ▼ --    
   select V.job_id AS 직종ID
         , trunc(avg(V.MAN_SALARY)) AS 남자기본급여평균
         , trunc(avg(V.WOMAN_SALARY)) AS 여자기본급여평균
         , trunc(avg(V.salary)) AS 기본급여평균
         , trunc(avg(V.MAN_SALARY)) - trunc(avg(V.salary)) as "남자평균차액"
         , trunc(avg(V.WOMAN_SALARY)) - trunc(avg(V.salary)) as "여자평균차액"
   from 
   (
       select job_id
            , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END as GENDER
            , salary        -- 남녀불문 salary
            , CASE WHEN substr(jubun, 7, 1) IN('1','3') then salary end as MAN_SALARY       -- 1 또는 3이면 salary를 보여라.
            , CASE WHEN substr(jubun, 7, 1) IN('2','4') then salary end as WOMAN_SALARY     -- 2 또는 4이면 salary를 보여라.
       from employees
   ) V
   group by V.job_id;    --▶ job_id로 그룹을 짓자.
   
   ------------------------------------------------------------------------
   
   ----- ===== **** Sub Query(서브쿼리) **** ==== -----
   /*
       -- Sub Query (서브쿼리)란?
       select 문속에 또 다른 select 문이 포함되어져 있을 때 포함되어진 select 문을 Sub Query (서브쿼리)라고 부른다.
       
       
       select ...
       from .....  ==> Main Query(메인쿼리 == 외부쿼리)
       where ... in (select ... 
                     from .....) ==> Sub Query (서브쿼리 == 내부쿼리)
   */
   
   /*
       employees 테이블에서
       기본급여가 제일 많은 사원과 기본급여가 제일 적은 사원의 정보를
       사원번호, 사원명, 기본급여로 나타내세요...
   */
   
   
   from employees
   where salary = (employees 테이블에서 salary 의 최댓값) OR 
         salary = (employees 테이블에서 salary 의 최솟값);
         
   employees 테이블에서 salary 의 최댓값 ==> select max(salary) from employees => 24000      
                                         select min(salary) from employees => 2100      
   
   select employee_id as 사원번호
        , first_name || ' ' || last_name as 사원명
        , salary as 기본급여
   from employees
   where salary = (select max(salary) from employees) OR 
         salary = (select min(salary) from employees);
    ------------------------
    사원번호   사원명   기본급여
    ------------------------
    100	 Steven King 24000
    132	 TJ Olson	 2100
    -----------------------
    
    /*
      [퀴즈]
      employees 테이블에서 부서번호가 60, 80번 부서에 근무하는 사원들중에
      월급이 50번 부서 직원들의 '평균월급' 보다 많은 사원들만 
      부서번호, 사원번호, 사원명, 월급을 나타내세요....
   */
   select department_id as 부서번호
        , employee_id as 사원번호
        , first_name || ' ' || last_name 사원명
        , salary as 월급
   from employees
   where dapartment_id in(60, 80) AND
         nvl(salary + (salary*commission_pct),salary) > 월급이 50번 부서 직원들의 '평균월급';
   
   월급이 50번 부서 직원들의 '평균월급'
   select AVG(nvl(salary + (salary*commission_pct),salary))
   from employees
   where department_id=50;
   -- 3475.555555555555555555555555555555555556

   -- ▼ 위의것 취합 후 정답 ▼
   select department_id as 부서번호
        , employee_id as 사원번호
        , first_name || ' ' || last_name AS 사원명
        , nvl(salary + (salary*commission_pct),salary) as 월급
   from employees
   where department_id in(60, 80) AND
         nvl(salary + (salary*commission_pct),salary) >( select AVG( nvl(salary + (salary*commission_pct),salary) )
                                                         from  employees
                                                         where department_id = 50)
    order by 1, 4 desc;                              


create table tbl_authorbook
   (bookname       varchar2(100)
   ,authorname     varchar2(20)
   ,loyalty        number(5)
   );
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('자바프로그래밍','이순신',1000);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','한석규',800);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','이순신',500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('조선왕조실록','엄정화',2500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','유관순',1200);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','이혜리',1300);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','서강준',1700);

   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('어린왕자','김유신',1800);
   
   commit;
   
   
   select * 
   from tbl_authorbook;
   
   ---  tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명이 다른 도서)로 지어진 도서정보를 나타내세요... ---
   
   /*
       ---------------------------------
         도서명         작가명    로얄티
       ---------------------------------  
         로빈슨크루소    한석규    800
         로빈슨크루소    이순신    500
         그리스로마신화  유관순   1200
         그리스로마신화  이혜리   1300
         그리스로마신화  서강준   1700
       ---------------------------------  
   */
   select BOOKNAME, count(*)
   from tbl_authorbook
   group by BOOKNAME

/*
    ---------------------
    bookname    count(*)
    로빈슨크루소	 2
    그리스로마신화	 3
    자바프로그래밍	 1
    조선왕조실록	 1
    어린왕자	     1
    ---------------------
*/

   select BOOKNAME, count(*)
   from tbl_authorbook
   group by BOOKNAME
   having count(*) > 1; -- 조건절
   
   -- 책 이름만 나오도록 결과 출력
   select BOOKNAME
   from tbl_authorbook
   group by BOOKNAME
   having count(*) > 1; -- 조건절
   
   -- in 안에 책이름이 나오도록 select 문 기입 ▶ Sub Query
   select *
   from tbl_authorbook
   where bookname in( select BOOKNAME
                      from tbl_authorbook
                      group by BOOKNAME
                      having count(*) > 1);
   
    ------- **** Sub Query (서브쿼리)에서 사용되어지는 ANY , ALL 에 대해서 알아봅니다. **** --------
    /*
       Sub Query (서브쿼리) 에서 사용되어지는 ANY 는 OR 와 흡사하고, 
       Sub Query (서브쿼리) 에서 사용되어지는 ALL 은 AND 와 흡사하다.
    */
    
    -- employees 테이블에서 salary 가 30번 부서에 근무하는 사원들의 salary 와 동일한 사원들만 추출하세요..
    -- 단, 출력시 30번 부서에 근무하는 사원은 제외합니다.
    --  salary = 30 번 부서에 근무하는 사원들
    
    select salary
    from employees
    where department_id = 30;
    /*
    11000
    3100
    2900
    2800
    2600
    2500
    */
    select employee_id, first_name, salary, department_id
    from employees
    where department_id != 30 and 
          salary in( select salary
                     from employees
                     where department_id = 30)
    order by 4,3 desc;               
                   
    select employee_id, first_name, salary, department_id
    from employees
    where department_id != 30 and       -- =(equal)의 경우 결과물이 1개가 나와야 함. (복수의 개수 x) = 01427. 00000 -  "single-row subquery returns more than one row"
          salary = any (select salary     -- in() == =ANY, 이때 복수개의 결과물을 나타내기 위해서 =ANY 를 사용함. OR을 뜻을 가진다.
                        from employees
                        where department_id = 30)
    order by 4,3 desc;               
    
    /*
    기본급여(salary)가 제일 많은 사원만
    사원번호, 사원명, 기본급여(salary)를 나타내세요.   
    */
    
    from employees
    where salary = max(사원들 중에 salary가 가장 큰 값);
    
    select employee_id, first_name, salary, department_id
    from employees
    where salary = (select max(salary) from employees);
        
    select employee_id, first_name, salary, department_id
    from employees
    where salary >= ALL(select salary from employees);
    -- 모든것과 비교했을 때 salary가 같거나 크다. == 1등만 나온다는 뜻. (24000)
    -- AND 는 모든 조건이 참일때만 참이다. 
                      
    /*
    기본급여(salary)가 제일 많은 사원을 제외한 나머지 사원들만
    사원번호, 사원명, 기본급여(salary)를 나타내세요.   
    */
    select employee_id, first_name, salary, department_id
    from employees
    where salary != (select max(salary) from employees);
    
    select employee_id, first_name, salary, department_id
    from employees
    where salary < (select max(salary) from employees);
    
   -- OR 는 참이 1개라도 포함되면 참이다. 
    select employee_id, first_name, salary, department_id
    from employees
    where salary < ANY(select salary from employees);   
    --> 월급이 제일 많은 24000 KING 은 나오지 않게 됨. (24000을 뺀 나머지 결과가 출력된다.)
    --> 자동으로 salary 컬럼에 대해 오름차순으로 정렬되어 나온다.
    --> ALL 은 모든것이 참일때만 보여진다.
    /*
        salary < (24000
                  17000 -- 17000은 24000보단 작음. (1개라도 참!!) ▶ ANY는 OR의 뜻을 가지고 있기 때문에 17000이 들어가도 참이 된다.
                  9000
                  ....
                  2100)
    */
    
    /*
        수당(commission_pct) 이 제일 많은 사원을 제외한 나머지 사원들만
        사원번호, 사원명, 기본급여(salary)를 나타내세요.   
    */
    
    from employees
    where commssion_pct = (commssion_pct 가 제일큰 값);
    
    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct = (select max(commission_pct) from employees);
    -- max 는 그룹함수 이므로 수당에서 null 값을 다 뺀다.                    
    -- 145	John	0.4	80
    
    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct >= ALL (select commission_pct from employees);    
    -- 위처럼 했을 때, 결과물은 아무것도 나오지 않는다.
    -- commission_pct에 null 값이 있기 때문에 all을 썼을 때, 비교할 수 없으므로 값이 산출이 안됨.
    -- *** Sub Query 절에서 사용하는 ALL 은 사용시 주의를 요한다.
    -- *** Sub Query 절에서 select 되는 결과물에 NULL 이 존재하지 않도록 만들어야 한다. !!!
    
    -- ▼▼▼ 아래와 같이 commission_pct is not null 라인을 추가함으로써 null 값이 안나오도록 설정한다.
    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct >= ALL (select commission_pct from employees
                                 where commission_pct is not null); -- null 이 아닌것만 올려라.    
    -- 위처럼 Sub Query 절에서 select 되는 절에 null 이 존재하지 않도록 만들어야 한다.
    -- 그러나 all 보다는 max를 사용해도 무방하다.
    -- 145	John   0.4	80
    
    
    /*
        수당(commission_pct) 이 제일 많은 사원을 제외한 나머지 사원들만
        사원번호, 사원명, 기본급여(salary)를 나타내세요.   
    */
    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct != (select max(commission_pct) from employees);    
    -- commission_pct가 null 인 값들은 나오지 않는다. (John을 뺀 나머지가 나옴)
    
    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct != (select max(commission_pct) from employees);    
    -- 34명 출력됨.    
    
    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct < (select max(commission_pct) from employees);    
    -- 34명 출력됨.    

    select employee_id, first_name, commission_pct, department_id
    from employees
    where commission_pct < ANY (select commission_pct from employees);        
    -- NULL 은 존재하지 않기 때문에 비교를 할 수 없음 (연산할 수 없음): null 값만 빼고 출력됨
    -- 34명 출력됨.    (0.4(max값)을 뺀 나머지가 출력됨)
    -- ANY를 씀으로서 sort까지 되어 나옴 ( 위에서 any를 쓰지 않았을 때는 sort가 되어있지 않아 order by를 해야하지만, any는 그럴 필요가 없다.)
    --> 자동으로 salary 컬럼에 대해 오름차순으로 정렬되어 나온다.
    
    
    
    -------------- ===== *** Pairwise(쌍) Sub Query *** ===== --------------
    /*
        employees 테이블에서
        부서번호별로 salary 가 최대인 사원과
        부서번호별로 salary 가 최소인 사원의 정보를 
        부서번호, 사원번호, 사원명, 기본급여를 나타내세요.
    */
    select department_id, salary
    from employees;
    
    /*
        원하는 값
        -----------------------------------
        department_id   salary  
        -----------------------------------
        10              4400
        20              6000  (20번에서 min)
        20              13000 (20번에서 max)
        30              2500  (30번에서 min)
        30              11000 (30번에서 max)
        .....           .....
    */
    select department_id as 부서번호
        , employee_id as 사원번호
        , first_name || ' ' || last_name as 사원명
        , salary as 기본급여
    from employees
    where (department_id, salary) in ( select department_id , min(salary)
                                       from employees
                                       group by department_id)
           OR
          (department_id, salary) in ( select department_id, max(salary)
                                       from employees
                                       group by department_id)
    order by 부서번호, 기본급여;                                  
                                       
 /*   
    select department_id, min(salary)
    from employees
    group by department_id
    
    select department_id, max(salary)
    from employees
    group by department_id
*/
    -- Kimberly 값(deparment_id == null)을 화면에 출력하기 위해서 nvl 사용
    -- 조건에 만족하는 행만 메모리에 올려서 화면에 올릴때는 기본값만 보이게 해라.
    select department_id as 부서번호
        , employee_id as 사원번호
        , first_name || ' ' || last_name as 사원명
        , salary as 기본급여
    from employees
    where (nvl(department_id, -9999), salary) in ( select nvl(department_id, -9999) , min(salary)
                                       from employees
                                       group by department_id )
           OR
          (nvl(department_id, -9999), salary) in ( select nvl(department_id, -9999), max(salary)
                                       from employees
                                       group by department_id )
    order by 부서번호, 기본급여;    
    
    
    
    --------- ===== **** 상관서브쿼리(== 서브상관쿼리) ****  ===== ---------    
   /*
      상관서브쿼리 이라함은 Main Query(== 외부쿼리)에서 사용된 테이블(뷰)에 존재하는 컬럼이
      Sub Query(== 내부쿼리)의 조건절(where절, having절)에 사용되어질때를 
      상관서브쿼리(== 서브상관쿼리)라고 부른다.
   */
    
    -- employees 테이블에서 기본급여에 대해 전체등수 및 부서내등수를 구하세요.
    -- ① 첫번째 방법은 rank() 함수를 사용하여 구해본다.
    select department_id as 부서번호              
         , employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , salary as 기본급여
         , rank() over(order by salary desc) AS 전체등수
         , rank() over(partition by department_id
                       order by salary desc ) AS 부서내등수
    from employees
    order by 부서번호, 기본급여 desc;
    
    -- employees 테이블에서 기본급여에 대해 전체등수 및 부서내등수를 구하세요.
    -- ② 두번째 방법은 count(*) 를 이용하여 상관서브쿼리를 사용하여 구해본다.
    select salary 
    from employees
    order by salary desc;
    
    -- 자신의 급여가 14000 라면 몇등일까?
    select count(*)+1           -- select count(*) 는 자신의 숫자 바로위 숫자들의 개수 ▶ 거기에 +1을 하면 내 자리로 오므로, 내 등수를 알 수 있음.
    from employees
    where salary > 14000;
    
    update employees set department_id = null
    where employee_id = 100;
    
    --- E. 는 메인쿼리
    -- NVL(,): , 앞에 값이 NULL 이라면 회사에 존재하지 않는 번호로 바꾼다.(-9999)
    -- Where 절에서 NVL을 달아야 하는 이유는, Null 값이 여러개 존재할 때 등수의 구분을 위해서 이다.
    -- nvl 을 달지 않으면 추후에 null 값이 2개 이상 나올 때, 부서내등수가 둘다 1로 뜨는 오류가 발생할 수 있기 때문에 이를 방지하고자함.
    select department_id as 부서번호              
         , employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , salary as 기본급여
         
         , (select count(*)+1           
            from employees
            where salary > E.salary) AS 전체등수    -- *상관서브쿼리 : 서브쿼리조건절에 외부커리(메인커리)에 쓰였던 컬럼이 쓰이는 것.
            
         , (select count(*)+1 
            from employees
            where NVL(department_id, -9999) = NVL(E.department_id, -9999) AND   -- 내가 속한 부서내에서 내 salary 보다 큰것이 뭐가 있느냐.
                  salary > E.salary) AS 부서내등수            
    from employees E    
    order by 부서번호, 기본급여 desc;
        
    rollback;   -- 부서번호 100을 null 로 해놨던 것을 다시 원상복구 하기 위함

    select employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         
         , (select count(*)+1           
            from employees
            where salary > E.salary) AS 전체등수    -- *상관서브쿼리 : 서브쿼리조건절에 외부커리(메인커리)에 쓰였던 컬럼이 쓰이는 것.
            
         , (select count(*)+1 
            from employees
            where NVL(department_id, -9999) = NVL(E.department_id, -9999) AND   -- 내가 속한 부서내에서 내 salary 보다 큰것이 뭐가 있느냐.
                  salary > E.salary) AS 부서내등수            
    from employees E
    order by 전체등수 asc;
    
 
    ----- === *** Sub Query 를 사용하여 테이블을 생성할 수 있습니다. *** === -----
    create table tbl_employees_3060
    as 
    select department_id
        , employee_id
        , first_name || ' ' || last_name AS ENAME
        , nvl(salary + (salary * commission_pct), salary) AS MONTHSAL
        , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
        , jubun
    from employees
    where department_id in (30, 60);
    -- Table TBL_EMPLOYEES_3060이(가) 생성되었습니다.
    
    select * from tab;
    
    select *
    from tbl_employees_3060;

    
    ----- === *** Employees 테이블을 가지고 데이터 없이 
    --            employees 테이블의 구조만 동일한 tbl_employees_sub 이라는 
    --            테이블을 생성하겠습니다. *** === -----
    select *
    from employees
    where 1=1;
    
    select *
    from employees
    where 2=2;
    
    create table tbl_employees_sub
    as 
    select *
    from employees
    where 1=2;
    -- Table TBL_EMPLOYEES_SUB이(가) 생성되었습니다.
    
    select * from tab;
    
    select *     
    from TBL_EMPLOYEES_SUB;
    
    desc TBL_EMPLOYEES_SUB;
    
    ---- **** !!!! 필수로 꼭 알아두시길 바랍니다. !!!! **** ----
    -- === 상관서브쿼리(=서브상관커리)를 사용한 UPDATE 처리하기 === --
    /*
        회사에 입사하여 delete 또는 update 를 할 때 먼저 반드시 해당 테이블을 백업 한 후,
        작업을 해야한다. 백업본이 있으면 실수를 하더라도 복구가 가능하기 때문이다.    
    */
    create table tbl_employees_backup_220111
    as
    select *
    from employees
    -- Table TBL_EMPLOYEES_BACKUP_220111이(가) 생성되었습니다.

    select *
    from tbl_employees_backup_220111
    
    update employees set first_name = '순신', last_name = '이';
    -- 107개 행 이(가) 업데이트되었습니다.

    commit;
    -- 커밋 완료.
    
    select *
    from employees;
    
    -- update 뒤에 employees 는 메인쿼리에 있는 테이블의 컬럼이기 때문에 E를 붙여준다.
    update employees E set first_name = ( select first_name
                                        from tbl_employees_backup_220111
                                        where employee_id = E.employee_id )
                          , last_name = (select last_name
                                        from tbl_employees_backup_220111
                                        where employee_id = E.employee_id );
    -- 107개 행 이(가) 업데이트되었습니다.
    -- 위와같이 올바르게 복구되기 위해서는 Sub Query 절의 where 에서 사용된
    -- employee_id 컬럼은 고유한 값만 가지는 컬럼이어야 한다.
    
    select *
    from employees;
    
    commit;
    -- 커밋 완료.
    
    
    ----- === *** Sub Query 절을 사용하여 데이터를 입력(insert) 할 수 있습니다. *** === -----
    select *
    from TBL_EMPLOYEES_3060;
    
    desc TBL_EMPLOYEES_3060;
    
    insert into TBL_EMPLOYEES_3060
    select department_id
        , employee_id
        , first_name || ' ' || last_name AS ENAME                
        , nvl(salary + (salary * commission_pct), salary) AS MONTHSAL
        , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
        , jubun
    from employees
    where department_id in (40, 50)
    order by 1;    
    -- 46개 행 이(가) 삽입되었습니다.
    
    select *
    from TBL_EMPLOYEES_3060;
        
--    rollback;
      commit;
      
    ----- === *** Sub Query 절을 사용하여 데이터를 수정(update) 할 수 있습니다. *** === -----
    
    UPDATE TBL_EMPLOYEES_3060 set monthsal = ( select TRUNC(AVG(nvl (salary + (salary * commission_pct), salary )))
                                               from employees
                                               where department_id = 50
                                               )
    where department_id = 30;
    -- 6개 행 이(가) 업데이트되었습니다.
    
    COMMIT;
    
    ----- === *** Sub Query 절을 사용하여 데이터를 삭제(delete) 할 수 있습니다. *** === -----
    
    delete from TBL_EMPLOYEES_3060
    where department_id = (select department_id 
                           from employees
                           where employee_id = 118);
                           
    -- 6개 행 이(가) 삭제되었습니다.

    select *
    from TBL_EMPLOYEES_3060;
    
    -----------------------------------------------------------------
    -- !!!! 중요 JOIN 은 면접에 가면 무조건 물어본다 !!!! --
        
               ------- ====== **** JOIN **** ====== --------
   /*
       JOIN(조인)은 테이블(뷰)과 테이블(뷰)을 합치는 것을 말하는데 
       행(ROW) 과 행(ROW)을 합치는 것이 아니라, 컬럼(COLUMN) 과 컬럼(COLUMN)을 합치는 것을 말한다.
       위에서 말한 행(ROW) 과 행(ROW)을 합치는 것은 UNION 연산자를 사용하는 것이다.
   
       -- 면접질문 : INNER JOIN(내부조인) 과 OUTER JOIN(외부조인)의 차이점에 대해 말해보세요.
       -- 면접질문 : JOIN 과 UNION 의 차이점에 대해서 말해보세요.
       
       
       A = {1, 2, 3}    원소가 3개
       B = {a, b}       원소가 2개
       
       A ⊙ B = { (1,a), (1,b)
                 ,(2,a), (2,b)
                 ,(3,a), (3,b) }
                 
       데카르트곱(수학)  ==> 원소의 곱 :   3 * 2 = 6개(모든 경우의 수)
       --> 수학에서 말하는 데카르트곱을 데이터베이스에서는 Catersian Product(카테시안 프로덕트) 라고 부른다.
       
       
       JOIN  =>  SQL 1992 CODE 방식  -->  테이블(뷰) 과 테이블(뷰) 사이에 콤마(,)를 찍어주는 것.  
                                         콤마(,)를 찍어주는 것을 제외한 나머지 문법은 데이터베이스 밴더(회사) 제품마다 조금씩 다르다.   
       
       JOIN  =>  SQL 1999 CODE 방식(ANSI) --> 테이블(뷰) 과 테이블(뷰) 사이에 JOIN 이라는 단어를 넣어주는 것.
                                             ANSI(표준화) SQL
   */
   
    select *
    from employees;
    
    select count(*)
    from employees; -- 107개 행
    
    
    select *
    from departments;
    
    select count(*)
    from departments;   -- 27개 행
    
    select *
    from employees , departments;   --> SQL 1992 CODE 방식 : 명 사이에 , 를 찍는다.
    
    select count(*)
    from employees , departments;   -- 2889개 행
    
    select 107 * 27 -- 모든 경우의 수
    from dual;      
    
    select *
    from employees CROSS JOIN departments;   --> SQL 1999 CODE 방식(ANSI) : 테이블(뷰) 과 테이블(뷰) 사이에 JOIN 이라는 단어.
    
    select count(*)
    from employees CROSS JOIN departments;   --> SQL 1999 CODE 방식(ANSI)
                                             -- 2889개 행

    /*
      1. CROSS JOIN 은 프로야구를 예로 들면 10개팀이 있는데 
         각 1팀당 경기를 몇번해야 하는지 구할때 쓰인다. 1팀당 모든 팀과 경기를 펼쳐야 한다. 
         
      2. CROSS JOIN 은 그룹함수로 나온 1개의 행을 가지고 어떤 데이터 값을 얻으려고 할때 사용된다. 
    */                                             
                                             
     --- 100개행 * 1개행 == 100개 행
     
     -- [ CROSS JOIN 사용 예 ]
    /*
      사원번호    사원명    부서번호    기본급여    모든사원들의기본급여평균    기본급여평균과의차액    
      이 나오도록 하세요..
    */
    
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , department_id AS 부서번호
         , salary AS 기본급여
         , AVG(salary) AS 기본급여평균    -- 위에는 107개 행이지만, 기본급여평균 line 은 1개 행이므로 크기가 맞지 않는다.
    from employees; -- 오류!!!          -- 이때, 컬럼과 컬럼을 합치는 JOIN 을 사용한다.
         
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , department_id AS 부서번호
         , salary AS 기본급여
    from employees;  -- 107개 행
    
    select trunc(AVG(salary)) AS 기본급여평균   -- 6461 
    from employees   -- 1개 행    ==> CROSS JOIN 을 통해 107*1 = 107개 행으로!
     
                                             
    -- (사원번호    사원명    부서번호    기본급여)  +  (기본급여평균) ==> 기본급여평균 행을 , 를 통해 붙여준다.                                        
--  ① SQL 1992 CODE 방식 (,)
    select  A.employee_id AS 사원번호,    
            A.FULLNAME AS 성명,    
            A.department_id AS 부서번호 ,
            A.salary AS 월급,
            B.AVG_salary AS 평균급여,
            (A.salary - B.AVG_salary) AS "평균차액"
    from
    (
    select employee_id 
         , first_name || ' ' || last_name AS FULLNAME
         , department_id
         , salary
    from employees  -- 107개 행
    ) A
    ,     -- SQL 1992 년 방식
    (
    select trunc(AVG(salary)) AS AVG_salary
    from employees   
    ) B;
    
--  ② SQL 1999 CODE 방식(ANSI) - CROSS JOIN
    select trunc(AVG(salary)) AS AVG_salary
    from employees   
    ) B;
    
        select  A.employee_id AS 사원번호,    
            A.FULLNAME AS 성명,    
            A.department_id AS 부서번호 ,
            A.salary AS 월급,
            B.AVG_salary AS 평균급여,
            (A.salary - B.AVG_salary) AS "평균차액"
    from
    (
    select employee_id 
         , first_name || ' ' || last_name AS FULLNAME
         , department_id
         , salary
    from employees  -- 107개 행
    ) A
    CROSS JOIN     -- SQL 1999 년 방식 (CROSS JOIN)
    (
    select trunc(AVG(salary)) AS AVG_salary
    from employees   
    ) B;                                 
    
    ---- **** EQUI JOIN (SQL 1992 CODE 방식) **** ---- (EQUAL)
    /*
        [EQUI JOIN 예]
        
        부서번호    부서명     사원번호    사원명     기본급여
        이 나오도록 하세요...
    */
    
    /*   부서번호                        부서명         사원번호     사원명     기본급여
       -----------                     ------       ------------------------------
       departments.department_id       departments             employees
       employees.department_id
    */
    
    
    select *
    from employees , departments    -- SQL 1992 CODE
    where employees.department_id = departments.department_id;  -- 조인조건절 (모두 합쳐라, Mapping)
    
    select *
    from employees E , departments D   -- SQL 1992 CODE // E 와 D 는 별칭!
    where E.department_id = D.department_id;  -- 조인조건절     
    -- E.department_id (부서번호) 값이 NULL 인 것은 출력되지 않는다.
    
    select *
    from employees E , departments D   -- SQL 1992 CODE // E 와 D 는 별칭!
    where E.department_id = D.department_id(+);  -- 조인조건절     
    -- (+) 가 없는 쪽의 테이블인 employees E 테이블의 모든 행들을 먼저 출력해준다. (여기서는 107개 행)
    -- 즉, 107개 행을 모두 출력한 후 그 다음에 JOIN 조건절에 들어간다.
    -- E.department_id (부서번호) 값이 NULL 인 것도 출력된다.
           
    select *
    from employees E , departments D   
    where E.department_id(+) = D.department_id;  -- 조인조건절     
    -- (+) 가 없는 쪽의 테이블인 departments D 테이블의 모든 행들을 먼저 출력해준다.
    -- 즉, departments 27개 행을 모두 출력한 후 그 다음에 JOIN 조건절에 들어간다.
    -- E.department_id (부서번호) 값이 NULL 인 것은 출력되지 않는다.
 
    select *
    from employees E FULL OUTER JOIN departments D   -- SQL 1992 CODE
    ON E.department_id = D.department_id(+);  
    -- 양쪽 모두 (+)를 하면 오류이다.!! 
    -- 이렇게 하고자 한다면 SQL 1999 CODE 인 FULL OUTER JOIN 을 써야 한다.
    
    -- JOIN 조건절은 WHERE 대신 ON을 사용.▼
    -- JOIN 을 쓴다면 (+)를 쓰지 않는다.
    -- JOIN : NULL 빼겠다.
    -- LEFT JOIN : 왼쪽만 메모리에 올린다.
    -- RIGHT JOIN : 오른쪽만 메모리에 올린다.
    -- FULL JOIN : 다 보겠다.
    
    ---- **** ★(INNER) JOIN★ [내부조인] (SQL 1999 CODE 방식) **** ----     (INNER JOIN == JOIN)                   
    select *
--  from employees E INNER JOIN departments D   -- SQL 1999 CODE / E 와 D 는 별칭! (INNER와 다르게 CROSS 는 모든 경우의수 .) 
    from employees E JOIN departments D         -- INNER 는 생략가능하다. 
    ON E.department_id = D.department_id;       -- 조인조건절     
    -- E 와 D의 department_id 를 Mapping 시킴.
    

    ---- **** ★LEFT (OUTER)★ JOIN [외부조인] (SQL 1999 CODE 방식) **** ----                            
    select *
--  from employees E LEFT OUTER JOIN departments D   -- SQL 1999 CODE
    from employees E LEFT JOIN departments D         -- OUTER 는 생략가능하다.
    ON E.department_id = D.department_id;            -- 조인조건절     
    -- LEFT OUTER JOIN 글자를 기준으로 왼쪽에 기술된 employees E 테이블의 모든 행들을 먼저 출력해준다. 
    -- 즉, 107개 행을 모두 출력한 후 그 다음에 JOIN 조건절에 들어간다.
    -- E.department_id (부서번호) 값이 NULL 인 것도 출력된다.
    -- OUTER JOIN 을 기준으로 employees 는 왼쪽에 위치. (왼쪽에 있는 employees 행을(107개 행) 다 보여준 후 오른쪽에서 자기 행을 찾아간다.)

    ---- **** ★RIGHT (OUTER)★ JOIN [외부조인] (SQL 1999 CODE 방식) **** ----                                
    select *
--  from employees E RIGHT OUTER JOIN departments D   
    from employees E RIGHT JOIN departments D   -- OUTER 생략 가능.
    ON E.department_id = D.department_id;       -- 조인조건절     
    -- RIGHT OUTER JOIN 를 기준으로 오른쪽에 기술된 departments D 테이블의 모든 행들을 먼저 출력해준다.
    -- 즉, departments 27개 행을 모두 출력한 후 그 다음에 JOIN 조건절에 들어간다.
    -- E.department_id (부서번호) 값이 NULL 인 것은 출력되지 않는다.
    
    
        
    ---- **** ★FULL (OUTER)★ JOIN [외부조인] (SQL 1999 CODE 방식) **** ----                                
    select *
--  from employees E FULL OUTER JOIN departments D   
    from employees E FULL JOIN departments D    -- OUTER 생략 가능.
    ON E.department_id = D.department_id;       -- 조인조건절     
    -- FULL OUTER JOIN 를 기준으로 양쪽에 기술된 employees E 테이블과 departments D 테이블의 모든 행들을 먼저 출력해준다.
    -- 즉, 107개행 과 27개 행을 모두 출력한 후 그 다음에 JOIN 조건절에 들어간다.
    -- E.department_id (부서번호) 값이 NULL 인 것도 출력되고, 
    -- 페이퍼 부서인 부서번호 120번 부터 207번 부서 까지도 출력된다.
     
    
    ---- ========= *** JOIN 을 사용한 응용문제 *** ========= ----
    /*
    아래와 같이 나오도록 하세요.
    
    -----------------------------------------------------------------------
     부서번호   사원번호   사원명   기본급여   부서평균기본급여    부서평균과의차액
    -----------------------------------------------------------------------
    
    
    ---------------------------       ---------------------------------------
      부서번호   부서평균기본급여          부서번호   사원번호   사원명    기본급여
    ---------------------------       ---------------------------------------
        10          3500                 10        1001     홍길동    3700
        20          4000                 10        1002     이순신    2500
        30          2800                 20        2001     엄정화    3500
        ..          ....                 20        2002     유관순    4500
        110         3200                 ..        ....     .....    .....
     --------------------------       ---------------------------------------
    */
    --- *** 아래의 풀이는 부서번호가 NULL 인 Kimberly Grant 는 나오지 않는다. *** ---
    
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    JOIN
    (
        select department_id
             , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON V1.department_id = V2.department_id  -- 부서번호가 null 인 Kimberly 는 산출이 되지 않음. (그렇기 때문에 nvl을 사용해주어야 하는 것임. 화면에 보여줄때는 그대로 null 이라고 보여준다.)
    ORDER BY 1, 4 desc;
    
   --- *** 아래의 풀이는 틀린풀이다. (LEFT JOIN ver.) *** ---
   -- Department id가 null 값인 Kimberly의 값을 산출하기 위함.    
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    LEFT JOIN
    (
        select department_id
             , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON V1.department_id = V2.department_id  -- 
    ORDER BY 1, 4 desc;    
    
   --- *** 아래의 풀이는 틀린풀이다. (RIGHT JOIN ver.) *** ---
   -- Department id가 null 값인 Kimberly의 값을 산출하기 위함.
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    RIGHT JOIN
    (
        select department_id
             , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON V1.department_id = V2.department_id  -- 
    ORDER BY 1, 4 desc;     

   --- *** 아래의 풀이는 틀린풀이다. (FULL JOIN ver.) *** ---
   -- Department id가 null 값인 Kimberly의 값을 산출하기 위함.
   -- FULL JOIN을 하면 108개행이 나옴 (V1, V2 양쪽이 다 나온것이므로) 
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    FULL JOIN
    (
        select department_id
             , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON V1.department_id = V2.department_id  -- NULL 과 NULL 끼리 맺어라. (양쪽 테이블을 보여주고 같은것끼리 Mapping 해라)
    ORDER BY 1, 4 desc;       
    
   --- *** 아래의 풀이가 올바른 풀이다. (JOIN ver.) *** --- ▶ 108개 행이 나올 필요가 없으므로 FULL JOIN 을 사용하지 않는다.
   -- Department id가 null 값인 Kimberly의 값을 산출하기 위함.
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    JOIN
    (
        select department_id
             , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON NVL(V1.department_id, -9999) = NVL(V2.department_id, -9999)  -- NULL 과 NULL 끼리 Mapping. (양쪽 테이블을 보여주고 같은것끼리 Mapping 해라)
    ORDER BY 1, 4 desc;                                             
                                             
                                                 
 /*
    [퀴즈] 아래와 같이 나오도록 하세요.
    
    ----------------------------------------------------------------------------------------------------
     부서번호   사원번호   사원명   기본급여   부서평균기본급여    부서평균과의차액   부서내기본급여등수   전체기본급여등수
    ----------------------------------------------------------------------------------------------------
 */   
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
         , DEPT_RANK AS 부서내기본급여등수
         , TOTAL_RANK as 전체기본급여등수
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    JOIN
    (
        select department_id, employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
             , rank() over(partition by department_id
                           order by salary desc) AS DEPT_RANK
             , rank() over(order by salary desc) AS TOTAL_RANK                           
        from employees
    ) V2
    ON NVL(V1.department_id, -9999) = NVL(V2.department_id, -9999)  -- NULL 과 NULL 끼리 Mapping. (양쪽 테이블을 보여주고 같은것끼리 Mapping 해라)
    ORDER BY 1, 4 desc;   

--- ver 2.
    
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
         , rank() over(partition by V2.department_id
                       order by salary desc) AS 부서내기본급여등수
         , rank() over(order by salary desc) AS 전체기본급여등수
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    JOIN
    (
        select department_id , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON NVL(V1.department_id, -9999) = NVL(V2.department_id, -9999)  -- NULL 과 NULL 끼리 Mapping. (양쪽 테이블을 보여주고 같은것끼리 Mapping 해라)
    ORDER BY 1, 4 desc;   

 /*
    [퀴즈] 부서번호가 10, 30, 50 번 부서에 근무하는 사원들만 아래와 같이 나오도록 하세요.
    
    ----------------------------------------------------------------------------------------------------
     부서번호   사원번호   사원명   기본급여   부서평균기본급여    부서평균과의차액   부서내기본급여등수   전체기본급여등수
    ----------------------------------------------------------------------------------------------------
 */
 
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
         , rank() over(partition by V2.department_id
                       order by salary desc) AS 부서내기본급여등수
         , rank() over(order by salary desc) AS 전체기본급여등수
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        group by department_id
    ) V1
    JOIN
    (
        select department_id , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
    ) V2
    ON NVL(V1.department_id, -9999) = NVL(V2.department_id, -9999)  -- NULL 과 NULL 끼리 Mapping. (양쪽 테이블을 보여주고 같은것끼리 Mapping 해라)
    WHERE V2.department_id IN(10,30,50) -- WHERE 절을 추가한다. V1이 아닌 V2.의 DEPARTMENT_ID를 쓰는 이유는??
    ORDER BY 1, 4 desc;
    
    --- *** 위의 풀이과정도 맞지만 아래처럼 하기를 권장한다. !!! *** ---
    select V1.department_id as 부서번호     -- 첫번째 줄 만큼은 V1,V2 두 곳에 컬럼이 겹쳐 있기 때문에 반드시 컬럼명 앞에 V1인지 V2인지 표시를 해주어야 한다. (나머지는 생략 가능)
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
         , rank() over(partition by V2.department_id
                       order by salary desc) AS 부서내기본급여등수
         , rank() over(order by salary desc) AS 전체기본급여등수
    FROM
    ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        WHERE department_id IN(10,30,50) -- 필요한것만 끄집어 온다. (메모리 전체를 조회할 필요 x)
        group by department_id
    ) V1
    JOIN
    (
        select department_id , employee_id
             , first_name ||' '|| last_name AS ENAME
             , salary
        from employees
        WHERE department_id IN(10,30,50) -- 필요한것만 끄집어 온 후,
    ) V2
    ON V1.department_id = V2.department_id  
    ORDER BY 1, 4 desc; 
 
 
    --- 또는 
    --- ===== *** WITH 절을 사용한 INLINE VIEW 를 통해 JOIN 하기 *** ===== ---
    WITH 
    V1 AS ( 
        select department_id
             , trunc(avg(salary)) as DEPT_AVG_SAL
        from employees
        WHERE department_id IN(10,30,50) 
        group by department_id
    ),
    V2 AS (
        select department_id , employee_id
         , first_name ||' '|| last_name AS ENAME
         , salary
        from employees
        WHERE department_id IN(10,30,50)
    )
    select V1.department_id as 부서번호     
         , employee_id as 사원번호
         , ENAME as 사원명
         , salary as 기본급여
         , dept_avg_sal as 부서평균기본급여    
         , (salary - dept_avg_sal) as 부서평균과의차액
         , rank() over(partition by V2.department_id
                       order by salary desc) AS 부서내기본급여등수
         , rank() over(order by salary desc) AS 전체기본급여등수    
    FROM V1 JOIN V2
    ON V1.department_id = V2.department_id
    ORDER BY 1, 4;



    ---------- ======= **** NON-EQUI JOIN **** ======= ---------- == 같지 않아도(NON EQUI) 된다. 그 범위 안에만 들어오면 된다.
    /*
         조인조건절에 사용되는 컬럼의 값이 특정한 범위에 속할 때 사용하는 것이 NON-EQUI JOIN 이다.
         NON-EQUI JOIN 에서는 조인조건절에 = 을 사용하는 것이 아니라 between A and B 를 사용한다.
    */ 
    -- 소득세율 지표 관련 테이블을 생성한다. 
    create table tbl_taxindex
    (lowerincome   number       -- 연봉의 최저
    ,highincome    number       -- 연봉의 최대
    ,taxpercent    number(2,2)  -- 세율  -0.99 ~ 0.99 
    );
    
    insert into tbl_taxindex(lowerincome,highincome,taxpercent)
    values(1, 99999, 0.02);
    
    insert into tbl_taxindex(lowerincome,highincome,taxpercent)
    values(100000, 149999, 0.05);
    
    insert into tbl_taxindex(lowerincome,highincome,taxpercent)
    values(150000, 199999, 0.08);
    
    insert into tbl_taxindex(lowerincome,highincome,taxpercent)
    values(200000, 10000000000000000, 0.1);
    
    commit;
    
    select * 
    from tbl_taxindex;
    
    ------------------------------------------------------
    사원번호     사원명     연봉     세율      소득세액
    ------------------------------------------------------
    1001       홍길동    50000    0.02      50000 *  0.02
    1002       엄정화   170000    0.08     170000 *  0.08
    ....       ......  ......    .....     .............
    
 
    --- SQL 1992 CODE ---
    /*
        사원번호     사원명     연봉     세율      
        -------------------------   ======
             employees 테이블        tbl_taxindex 테이블 ▶ 두 table을 합치자.
    */
 
    select employee_id as 사원번호     
         , first_name ||' '||last_name as 사원명     
         , nvl(salary + (salary*commission_pct), salary)*12 as 연봉     
         , taxpercent as 세율
         , nvl(salary + (salary*commission_pct), salary)*12 * taxpercent as 소득세액
    from employees E , tbl_taxindex T   --SQL 1992 CODE
--  where nvl(E.salary + (E.salary * E.commission_pct), E.salary)*12 between T.LOWERINCOME AND T.HIGHINCOME; -- 조인조건절 ▶ 전부 중복이 아니기 때문에 E.와 T.를 빼도 된다.
--  또는
    where nvl(salary + (salary*commission_pct), salary)*12 between LOWERINCOME AND HIGHINCOME; -- 조인조건절
    
    --- SQL 1992 CODE 를 SQL 1999 CODE 로 바꾸기 --- (, 대신 JOIN && WHERE 대신 ON 으로 바꿀 것)
    select employee_id as 사원번호     
         , first_name ||' '||last_name as 사원명     
         , nvl(salary + (salary*commission_pct), salary)*12 as 연봉     
         , taxpercent as 세율
         , nvl(salary + (salary*commission_pct), salary)*12 * taxpercent as 소득세액
    from employees E JOIN tbl_taxindex T   --SQL 1999 CODE
    On nvl(salary + (salary*commission_pct), salary)*12 between LOWERINCOME AND HIGHINCOME; -- 조인조건절
    
    


    
    ------------------ ===== **** SELF JOIN(자기조인) **** ===== ------------------ 
   /*
       자기자신의 테이블(뷰)을 자기자신의 테이블(뷰)과 JOIN 시키는 것을 말한다.
       이때 ★반드시 테이블(뷰)에 대한 alias(별칭)★을 다르게 주고 실행해야 한다.
   */
   
   --- 아래처럼 나오도록 하세요... --- [ 전자결제 방식 구현시 들어가는 기능 ]
   --- 똑같은 컬럼이지만, 데이터값이 다름 (ex. 내 정보에서 직속상관번호를 가져오려면 다른 데이터값을 가져와야 한다.) == employee_id 로 나와 상사의 컬럼명은 같은데, 사원번호와 직속상관번호는 데이터 값이 다름.
   -------------------------------------------------------------------------------------------------------
    사원번호              사원명              이메일     급여      직속상관번호               직속상관명
  employee_id   first_name || last_name    email     salary   employee_id      first_name || last_name
  -------------------------------------------------------------------------------------------------------
     100             Steven King           SKING     24000     null                 null 
     102             Lex De Haan           LDEHAAN   17000     100                  Steven King
     103             Alexander Hunold      AHUNOLD   9000      102                  Lex De Haan
     104             Bruce Ernst           BERNST    6000      103                  Alexander Hunold

 
    select *
    from employees
    order by employee_id asc;

    --- SQL 1992 CODE
    select*
    from employees E1, employees E2             -- ex. 100번 1명이 다른 모든 사람들과 mapping 되는 것임. (본인-본인, 본인-다음번호, 본인-다다음번호 ....) == 모든 경우의 수
    where E1.manager_id = E2.employee_id;       -- 106개 행
    
    select *
    from employees E1, employees E2             -- ex. 100번 1명이 다른 모든 사람들과 mapping 되는 것임. (본인-본인, 본인-다음번호, 본인-다다음번호 ....) == 모든 경우의 수
    where E1.manager_id = E2.employee_id(+);    -- (+)가 없는쪽의 결과값이 다 산출된다.  -- 107개 행   
    
 
   
   
   ▼오류▼오류▼오류▼오류▼오류▼오류▼오류▼오류▼오류▼오류 
    -- SELF JOIN 이기 때문에 콜롬명앞에 E1, E2를 반드시 붙여준다. (양쪽에 다 있기 때문에)
    select E1.employee_id as 사원번호              
         , E1.first_name ||' '|| E2.last_name AS 사원명              
         , E1.email as 이메일     
         , E1.salary as 급여      
         , E2.employee_id  as 직속상관번호               
         , E2.first_name ||' '|| E2.last_name as 직속상관명
    from employees E1, employees E2             -- ex. 100번 1명이 다른 모든 사람들과 mapping 되는 것임. (본인-본인, 본인-다음번호, 본인-다다음번호 ....) == 모든 경우의 수
    where E1.manager_id = E2.employee_id(+)    
    order by E1.employee_id ;
    
    --- SQL 1999 CODE
   select  E1.employee_id as 사원번호              
         , E1.first_name ||' '|| E2.last_name AS 사원명              
         , E1.email as 이메일     
         , E1.salary as 급여      
         , E2.employee_id  as 직속상관번호               
         , E2.first_name ||' '|| E2.last_name as 직속상관명
    from employees E1 LEFT JOIN employees E2             -- ex. 100번 1명이 다른 모든 사람들과 mapping 되는 것임. (본인-본인, 본인-다음번호, 본인-다다음번호 ....) == 모든 경우의 수
    ON E1.manager_id = E2.employee_id    
    order by E1.employee_id ;    
    

   ------------------------------------------------------------------------ 
   select * 
   from tbl_authorbook;
   
   --- SELF JOIN(자기조인) 을 사용하여 tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명이 다른 도서)로 지어진 도서정보를 나타내세요... ---
   
   /*
       ---------------------------------
         도서명         작가명    로얄티
       ---------------------------------  
         로빈슨크루소    한석규    800
         로빈슨크루소    이순신    500
         그리스로마신화  유관순   1200
         그리스로마신화  이혜리   1300
         그리스로마신화  서강준   1700
       ---------------------------------  
   */
   
    --- SQL 1992 CODE

   select *
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname;  -- 조인조건절   ( 책 이름은 같은데, 작가이름은 다르다.)


   --- select 된 행의 결과물에서 중복된 행이 여러번 안나오고 1번만 나오도록 하려면 (여기서는 서강준,유관순,이혜리 이렇게 중복됨)
   --- select 바로 다음에 ★distinct★를 사용하면 된다.
   select distinct A1.*         -- A1 컬럼만 보이면 된다. (A2까지는 보일 필요가 X)
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname;  -- 조인조건절   ( 책 이름은 같은데, 작가이름은 다르다.)

   /*   !!!! select 문에서 distinct 와 order by 절을 함께 사용할때는 조심해야 한다. !!!!
        select 문에 distict 가 있는 경우 order by 절에는 select 문에서 사용된 컬럼만 들어올 수 있다.
        또는 select 문에 distict 가 있는 경우 order by 절을 사용하지 않아야 한다.
   */ 
   select distinct A1.*         -- A1 컬럼만 보이면 된다. (A2까지는 보일 필요가 X)
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname
   order by 1;
   
   select distinct A1.*         -- A1 컬럼만 보이면 된다. (A2까지는 보일 필요가 X)
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname
   order by 1, 3 desc;

   
   select A1.bookname, A1.authorname       -- A1 컬럼만 보이면 된다. (A2까지는 보일 필요가 X)
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname
   order by A1.bookname, A1.loyalty desc;   -- 잘나온다.
 
   select distinct A1.bookname, A1.authorname       -- A1 컬럼만 보이면 된다. (A2까지는 보일 필요가 X)
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname
   order by A1.bookname, A1.loyalty desc;           -- select 에 없는 loyalty를 써옴. ▶ 오류 (order by 를 할 때, select distinct 에 없는 컬럼을 썼을 경우 오류가 난다.)
   -- ORA-01791: not a SELECTed expression (오류!!)
   -- select 다음에 distinct 를 사용했을 때, order by 절에서는 select 다음에 보여지는 
   -- 컬럼이 아닌 컬럼으로 사용했기에 오류가 발생한다.
   -- ★★ select 다음에 order by 가 실행되는것이 순서!! ▶ 그러므로 select 에 있는 컬럼만 순서대로 실행되는 것이다!!
   
   select distinct A1.bookname, A1.authorname       -- A1 컬럼만 보이면 된다. (A2까지는 보일 필요가 X)
   from tbl_authorbook A1 , tbl_authorbook A2
   WHERE A1.bookname = A2.bookname AND A1.authorname != A2.authorname
   order by A1.bookname, A1.authorname desc;       

   --- SQL 1999 CODE
   select distinct A1.bookname , A1.authorname 
   from tbl_authorbook A1 JOIN tbl_authorbook A2
   ON A1.bookname = A2.bookname AND A1.authorname != A2.authorname   
   order by A1.bookname, A1.authorname desc;
   
   ----- ==== **** Multi Table Join(다중 테이블 조인) **** ==== -----
   -- 테이블 3개 이상 붙이는 것.
   --> 3개 이상의 테이블(뷰)을 가지고 조인시켜주는 것이다.
   
    /*
       
      -------------------------------------------------------------------------------------------------------------------------
         대륙명        국가명                       부서주소                    부서번호   부서명      사원번호  사원명       기본급여
      --------------------------------------------------------------------------------------------------------------------------   
         Americas     United States of America     Seattle 2004 Charade Rd      90      Executive   100    Steven King   24000
    
    
         대륙명   ==>  regions.region_name                                    regions.region_id 
         국가명   ==>  countries.country_name                                 countries.region_id       countries.country_id
         부서주소 ==> locations.city || ' ' || locations.street_address      locations.country_id      locations.location_id
         부서명   ==> departments.department_name                             departments.location_id   departments.department_id 
         사원명   ==> employees.first_name || ' ' || employees.last_name      employees.department_id
    */   
    
    select * from tab;
    
    select *     
    from REGIONS;
     
    select *     
    from COUNTRIES;
    
    select *         
    from LOCATIONS;
    
    select *        
    from DEPARTMENTS;

    select *
    from EMPLOYEES;   
    -----
    select *
    from REGIONS R
    JOIN COUNTRIES C
    ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
    JOIN LOCATIONS L
    ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
    JOIN DEPARTMENTS D
    ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
    JOIN EMPLOYEES E
    ON D.department_id = E.department_id
    order by 1;
    
    ----- 부서가 없는 Kimberly 가 나오게
    select *
    from REGIONS R
    JOIN COUNTRIES C
    ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
    JOIN LOCATIONS L
    ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
    JOIN DEPARTMENTS D
    ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
    RIGHT JOIN EMPLOYEES E              -- 부서번호가 없는 Kimberly 가 나오게 하기 위해 JOIN 을 기준으로 오른쪽에 있는 것들을 보인다(RIGHT)
    ON D.department_id = E.department_id
    order by 1;    
    
    ----- 완성
    select R.region_name AS 대륙명
         , C.country_name AS 국가명
         , L.city || ' ' || L.street_address AS 부서주소
         , E.department_id AS 부서번호
         , D.department_name AS 부서명
         , E.employee_id AS 사원번호
         , E.first_name || ' ' || E.last_name AS 사원명
         , E.salary AS 기본급여
    from REGIONS R
    JOIN COUNTRIES C
    ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
    JOIN LOCATIONS L
    ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
    JOIN DEPARTMENTS D
    ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
    RIGHT JOIN EMPLOYEES E              -- 부서번호가 없는 Kimberly 가 나오게 하기 위해 JOIN 을 기준으로 오른쪽에 있는 것들을 보인다(RIGHT JOIN)
    ON D.department_id = E.department_id
    order by 1;    
 
 
 
    
    /*
       부서번호가 30번, 90번에 근무하는 사원들만 아래와 같이 나오도록 하세요.   -- 부서번호가 정해져 있는 경우에 null 값을 신경쓰지 않아도 된다.
      -------------------------------------------------------------------------------------------------------------------------
         대륙명        국가명                       부서주소                    부서번호   부서명      사원번호  사원명       기본급여
      --------------------------------------------------------------------------------------------------------------------------   
         Americas     United States of America     Seattle 2004 Charade Rd      90      Executive   100    Steven King   24000
 
    */     
    
    select R.region_name AS 대륙명
         , C.country_name AS 국가명
         , L.city || ' ' || L.street_address AS 부서주소
         , E.department_id AS 부서번호
         , D.department_name AS 부서명
         , E.employee_id AS 사원번호
         , E.first_name || ' ' || E.last_name AS 사원명
         , E.salary AS 기본급여
    from REGIONS R
    JOIN COUNTRIES C
    ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
    JOIN LOCATIONS L
    ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
    JOIN DEPARTMENTS D
    ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
    JOIN EMPLOYEES E             
    ON D.department_id = E.department_id
    WHERE E.department_id IN(30,90)  -- 사원들이 근무하는 부서번호
    order by 1;    
    
    ----- 위의 것을 아래로 바꾸는 것이 best!! 다른 부서번호를 다 불러오고 30,90번을 추리는 것 보다는, 바로 30,90번으로 시작하는게 좋다.
    -- 또는
    select R.region_name AS 대륙명
         , C.country_name AS 국가명
         , L.city || ' ' || L.street_address AS 부서주소
         , E.department_id AS 부서번호
         , D.department_name AS 부서명
         , E.employee_id AS 사원번호
         , E.first_name || ' ' || E.last_name AS 사원명
         , E.salary AS 기본급여
    from REGIONS R
    JOIN COUNTRIES C
    ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
    JOIN LOCATIONS L
    ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
    JOIN DEPARTMENTS D
    ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
    JOIN (SELECT *
          FROM EMPLOYEES
          WHERE department_id IN(30,90)) E  -- 부서번호 30, 90번에 해당하는 것들을 E 로 본다.            
    ON D.department_id = E.department_id
    order by 1;    
   
   ------------------------------------------------------------------------
   -- * Kimberly 는 부서번호가 없기 때문에 결과값이 나오지 않는다.
   -- ※ 대 → 중 → 소분류로 가면서 점점 범위가 좁혀진다.
   
   --- [대분류 검색]
   --- *** 'Americas' 대륙에 근무하는 사원들만 
   --      국가명     부서주소     부서번호   부서명    사원번호  사원명   기본급여 를 나타내세요.
   WITH
   V AS 
   (
        select R.region_id, region_name,
               C.country_id, country_name,
               L.location_id, street_address, postal_code, city, state_province,
               D.department_id, department_name, D.manager_id,  -- D.manager_id 는 상사 본인의 id / E.manager_id 는 직속 상사의 id (같은 이름이지만 다른 뜻 ▶ 별칭을 주자 ▶ 아랫줄에 SASUNO 처럼)
               employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun 
        from REGIONS R
        JOIN COUNTRIES C
        ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
        JOIN LOCATIONS L
        ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
        JOIN DEPARTMENTS D
        ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
        JOIN EMPLOYEES E
        ON D.department_id = E.department_id
   )
    select country_name AS 국가명
          , city || ' ' || street_address AS 부서주소
          , department_id AS 부서번호
          , department_name AS 부서명
          , employee_id AS 사원번호
          , first_name || ' ' || last_name AS 사원명
          , salary AS 기본급여
    from V
    where region_name = 'Americas';
    
 
   --- [중분류 검색] 
   --- *** 'Seattle' 도시에 근무하는 사원들만 
   --      부서주소     부서번호   부서명    사원번호  사원명   기본급여 를 나타내세요.
   WITH
   V AS 
   (
        select R.region_id, region_name,
               C.country_id, country_name,
               L.location_id, street_address, postal_code, city, state_province,
               D.department_id, department_name, D.manager_id,  -- D.manager_id 는 상사 본인의 id / E.manager_id 는 직속 상사의 id (같은 이름이지만 다른 뜻 ▶ 별칭을 주자 ▶ 아랫줄에 SASUNO 처럼)
               employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun 
        from REGIONS R
        JOIN COUNTRIES C
        ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
        JOIN LOCATIONS L
        ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
        JOIN DEPARTMENTS D
        ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
        JOIN EMPLOYEES E
        ON D.department_id = E.department_id
   )
    select  city || ' ' || street_address AS 부서주소
          , department_id AS 부서번호
          , department_name AS 부서명
          , employee_id AS 사원번호
          , first_name || ' ' || last_name AS 사원명
          , salary AS 기본급여
    from V
    where region_name = 'Americas'  -- ex. 삼성을 찾은 다음에 ▶ 17인치 TV / 바로 17인치 TV를 찾을 순 없음.
          AND city = 'Seattle';     --- city가 어디입니까?
   
   
   
   
   --- [소분류 검색]
   --- *** 'Finance' 부서명에 근무하는 사원들만 
   --      부서번호   부서명    사원번호  사원명   기본급여 를 나타내세요.
   WITH
   V AS 
   (
        select R.region_id, region_name,
               C.country_id, country_name,
               L.location_id, street_address, postal_code, city, state_province,
               D.department_id, department_name, D.manager_id,  -- D.manager_id 는 상사 본인의 id / E.manager_id 는 직속 상사의 id (같은 이름이지만 다른 뜻 ▶ 별칭을 주자 ▶ 아랫줄에 SASUNO 처럼)
               employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun 
        from REGIONS R
        JOIN COUNTRIES C
        ON R.region_id = C.region_id    -- 겹치는 region 을 기준으로
        JOIN LOCATIONS L
        ON C.country_id = L.country_id  -- 겹치는 country 를 기준으로 
        JOIN DEPARTMENTS D
        ON L.location_id = D.location_id    -- 겹치는 location_id 를 기준으로
        JOIN EMPLOYEES E
        ON D.department_id = E.department_id
   )
    select department_id AS 부서번호
          , employee_id AS 사원번호
          , first_name || ' ' || last_name AS 사원명
          , salary AS 기본급여
    from V
    where region_name = 'Americas'  -- ex. 삼성을 찾은 다음에 ▶ 17인치 TV / 바로 17인치 TV를 찾을 순 없음.
          AND city = 'Seattle'     --- city가 어디입니까?
          AND department_name = 'Finance';      -- 소문자로 검색시 검색이 안됨.
   
      
   
   --- [퀴즈] 아래와 같이 나오도록 하세요..
   /*
       -------------------------------------------------------------------------------------------------
        부서번호           부서명                부서장성명                     사원번호   사원명   입사일 
       ------------------------------------------------------------------------------------------------- 
       D.department_id    D.department_name    E.first_name || E.last_name
       E.department_id 
       
                   D.manager_id                E.employee_id
                 (부서장의 사원번호)              (사원번호)
   */
   
   -- 부서번호가 NULL 값인 Kimberly는 나올 수 없음. (106개 행)
   WITH
   V1 AS  -- ▼ 중복되는 컬럼들은 앞에 D또는 E를 붙인다.  
   (select D.department_id 
        , department_name 
        , D.manager_id                                   -- 띄어쓰기 시 ""를 써준다. (기존 "부서장의 사원번호"
        , employee_id                                  -- 이것역시 부서장의 사원번호
        , first_name ||' '|| last_name AS MANAGER_NAME -- 부서장의 이름
   from departments D JOIN employees E
   ON D.manager_id = E.employee_id                       -- 두가지를 합친 조건  
   )
   ,
   V2 AS
   (
   select employee_id 
        , first_name ||' '|| last_name as ENAME   
        , hire_date
        , department_id         -- V1의 department_id 와 합치기 위해서 라인 추가
   from employees
   ) -- ▼ V1 과 V2 를 합치자.
   select V1.department_id as 부서번호           
        , V1.department_name as 부서명
        , V1.MANAGER_NAME as 부서장성명                     
        , V2.employee_id as 사원번호   
        , V2.ENAME as 사원명   
        , to_char(V2.hire_date, 'yyyy-mm-dd') as 입사일  
   from V1 JOIN V2
   ON V1.department_id = V2.department_id
   order by 1 ;  -- V1에 있는 department_id와 V2에 있는 department_id
   


--------- Kimberly 나오게 하기 (107개 행)
   WITH
   V1 AS  -- ▼ 중복되는 컬럼들은 앞에 D또는 E를 붙인다.  
   (select D.department_id 
        , department_name 
        , D.manager_id                                 -- 띄어쓰기 시 ""를 써준다. (기존 "부서장의 사원번호"
        , employee_id                                  -- 이것역시 부서장의 사원번호
        , first_name ||' '|| last_name AS MANAGER_NAME -- 부서장의 이름
   from departments D JOIN employees E
   ON D.manager_id = E.employee_id                       -- 두가지를 합친 조건  
   )
   ,
   V2 AS
   (
   select employee_id 
        , first_name ||' '|| last_name as ENAME   
        , hire_date
        , department_id         -- V1의 department_id 와 합치기 위해서 라인 추가
   from employees
   ) -- ▼ V1 과 V2 를 합치자.
   select V1.department_id as 부서번호           
        , V1.department_name as 부서명
        , V1.MANAGER_NAME as 부서장성명                     
        , V2.employee_id as 사원번호   
        , V2.ENAME as 사원명   
        , to_char(V2.hire_date, 'yyyy-mm-dd') as 입사일  
   from V1 RIGHT JOIN V2            -- 사원들 모두 나오게끔
   ON V1.department_id = V2.department_id
   order by 1 ; 
   
   
    ------ ====== **** SET Operator(SET 연산자, 집합연산자) **** ======= ------
     /*
            -- 종류 --
            1. UNION 
            2. UNION ALL
            3. INTERSECT
            4. MINUS
            
    -- 면접시 JOIN 과 UNION 의 차이점에 대해서 말해 보세요~~~ !! --  // join은 컬럼과 컬럼을 합치고, union은 행과행을 합친다.
        
    ==>  UNION 은 테이블(뷰)과 테이블(뷰)을 합쳐서 보여주는 것으로써,
         이것은 행(ROW)과 행(ROW)을 합친 결과를 보여주는 것이다.

        A = { a, x, b, e, g }
              -     -
        B = { c, d, a, b, y, k, m}    
                    -  -    
        A ∪ B = {a, b, c, d, e, g, k, m, x, y}  ==> UNION (중복 원소가 없음)               
                                                 {a, b, c, d, e, g, k, m, x, y}
    
                                                 ==> UNION ALL (중복 원소 다 포함)
                                                 {a, x, b, e, g, c, d, a, b, y, k, m} 
    
        A ∩ B = {a,b}  ==> INTERSECT
                           {a,b}
    
        A - B = {x,e,g} ==> MINUS 
                            {x,e,g}
    
        B - A = {c,d,y,k,m} ==> MINUS 
                               {c,d,y,k,m}
     */
    -- ① 2021년 11월    
    select *
    from tbl_panmae;
    
    -- tbl_panmae 테이블에서 2달전에 해당하는 월(현재가 2022년 1월 이므로 2021년 11월)에 판매된 정보만 추출해서 
    -- tbl_panmae_202111 이라는 테이블로 생성하세요.
    create table tbl_panmae_202111
    as      
    select *
    from tbl_panmae
    where to_char(panmaedate, 'yyyy-mm') = to_char( add_months(sysdate, -2),'yyyy-mm' );      -- 일이 아니라 월까지만 보고자 함. ▶ to_char( ,'yyyy-mm')
    --   Table TBL_PANMAE_202111이(가) 생성되었습니다.
    
    
    --  ②2021년 12월     
    select *
    from tbl_panmae_202111;
    
    -- tbl_panmae 테이블에서 1달전에 해당하는 월(현재가 2022년 1월 이므로 2021년 12월)에 판매된 정보만 추출해서 
    -- tbl_panmae_202112 이라는 테이블로 생성하세요.
    create table tbl_panmae_202112
    as      
    select *
    from tbl_panmae
    where to_char(panmaedate, 'yyyy-mm') = to_char( add_months(sysdate, -1),'yyyy-mm' );      -- 일이 아니라 월까지만 보고자 함. ▶ to_char( ,'yyyy-mm')
    --   Table TBL_PANMAE_202112이(가) 생성되었습니다.
    
    select *
    from tbl_panmae_202112;
    
    
    -- tbl_panmae 테이블에서 이번달에 해당하는 월(현재가 2022년 1월)에 판매된 정보만 남겨두고 나머지는 모두 삭제한다.
    DELETE FROM tbl_panmae
    WHERE to_char(panmaedate, 'yyyy-mm') < to_char( sysdate,'yyyy-mm' );   -- 문자(to_char) 끼리도 연산자 사용 가능.
    --  9개 행 이(가) 삭제되었습니다.

    select *    
    from tbl_panmae;

    commit;   
    --  커밋 완료.

    ---- *** 최근 3개월간 판매된 정보를 가지고 제품별 판매량의 합계를 추출해라. *** ----
    ---- 11월, 12월, 현재월의 *행*을 다 합쳐주는 것
    select *
    from tbl_panmae_202111; -- 2달전
    
    select *
    from tbl_panmae_202112; -- 1달전   
    
    select *
    from tbl_panmae;        -- 이번달
   
   
    --  행 합치기   
    select *
    from tbl_panmae_202111 -- 2달전
    UNION
    select *
    from tbl_panmae_202112 -- 1달전   
    UNION    
    select *
    from tbl_panmae;       -- 이번달
   
    -- 테이블 순서가 바뀌어도 항상 오름차순으로 결과가 출력된다. (자동정렬O)
    select *
    from tbl_panmae         -- 이번달
    UNION
    select *
    from tbl_panmae_202111  -- 2달전
    UNION
    select *
    from tbl_panmae_202112; -- 1달전  
    -- UNION 을 하면 항상 첫번째 칼럼(지금은 panmaedate)을 기준으로 오름차순 정렬되어 나온다.
    -- 그래서 2021년 11월 데이터부터 먼저 나온다.

    -- UNION ALL  (자동정렬X)
    select *
    from tbl_panmae         -- 이번달
    UNION ALL
    select *
    from tbl_panmae_202111  -- 2달전
    UNION ALL
    select *
    from tbl_panmae_202112; -- 1달전     
    -- UNION ALL을 하면 *정렬 없이* 그냥 (압력한)순서대로 행을 붙여서 보여줄 뿐이다.
    -- 그래서 순서는 tbl_panmae, tbl_panmae_202111, tbl_panmae_202112 대로 결과가 출력된다.
   
    -- 제품별 판매량의 합계 (VIEW 사용)
    select JEPUMNAME AS 제품명
         , sum(PANMAESU) AS 판매합계
    from 
    (
    select *
    from tbl_panmae_202111 -- 2달전
    UNION
    select *
    from tbl_panmae_202112 -- 1달전   
    UNION    
    select *
    from tbl_panmae       -- 이번달
    ) V    
    group by JEPUMNAME
    order by 2 desc;
    
    -- 제품별 판매량의 합계 (WITH 사용)
    WITH V AS
    (
    select *
    from tbl_panmae_202111 -- 2달전
    UNION
    select *
    from tbl_panmae_202112 -- 1달전   
    UNION    
    select *
    from tbl_panmae       -- 이번달
    )   
    select JEPUMNAME as 제품명
         , sum(panmaesu) as 판매합계
    from V
    group by JEPUMNAME
    order by 2 desc;
    


---- *** [퀴즈] 최근 3개월간 판매되어진 정보를 가지고 
--             아래와 같이 제품명, 판매년월, 판매량의합계, 백분율(%) 을 추출하세요 *** ----  
 
 ------------------------------------------------
  제품명     판매년월     판매량의합계    백분율(%)
 ------------------------------------------------
  감자깡     2021-11       20            8.2
  감자깡     2021-12       15            6.2
  감자깡     2022-01       15            6.2
  감자깡                   50           20.6
  새우깡     2021-11       38           15.6
  새우깡     2021-12        8            3.3
  새우깡     2022-01       30           12.3
  새우깡                   76           31.3
  .....     .......       ...          ....
  전체                    243          100.0
 ------------------------------------------------ 
    
    -- !!!! 중요 !!!! 조심해야 합니다. !!!! --
    -- *기준점*이 중요하다 (Ex. 판매일자 기준인지, 판매수 기준인지)
    
    -- 최근 3개월 간 판매된 판매량의 합계는?   
    
    -- 틀린 것(UNION: UNION 을 쓰면 중복을 없애버림 (panmaesu의 경우에도 날짜가 다르면 결과값이 산출 되어야 하는데, 무조건 panmaesu 기준으로 중복되는 값들을 다 지워버리고 한개만 남김.)
    select SUM(v.panmaesu)  -- 98개  (243개가 출력되어야 하는데 중복을 다 제거하고 합산되어 98개밖에 안나옴) ▶ 오류
    from 
    (
    select panmaesu
    from tbl_panmae_202111 -- 2달전
    UNION
    select panmaesu
    from tbl_panmae_202112 -- 1달전   
    UNION    
    select panmaesu
    from tbl_panmae       -- 이번달
    ) V;      
    
    
    -- 올바른 것 (UNION ALL : 중복인것도 그대로 다 산출) 
    select SUM(v.panmaesu)  -- 243개 ▶ 정답
    from 
    (
    select panmaesu
    from tbl_panmae_202111 -- 2달전
    UNION all
    select panmaesu
    from tbl_panmae_202112 -- 1달전   
    UNION all    
    select panmaesu
    from tbl_panmae       -- 이번달
    ) V;   


    ------ ▼▼▼▼▼▼▼ 퀴즈 정답 ▼▼▼▼▼▼▼
    -- group by grouping sets ▼
    select decode(grouping(jepumname), 0, jepumname, '전체') as 제품명       -- 0은 실제 데이터, 1은 그룹을 짓지 않았을 때의 '전체'에 해당하는 값) 
      -- 또는
      -- , nvl(jepumname, '전체') as 제품명                                -- null 값은 그룹을 짓지 않았을 때만 나오는 값이다.                                                                           
         , decode(grouping(to_char(panmaedate,'yyyy-mm')), 0, to_char(panmaedate,'yyyy-mm'), ' ')  as 판매년월  -- ' '는 공백
      -- 또는
      -- , nvl( to_char(panmaedate,'yyyy-mm'), '') as 판매년월  -- 여기서 ''는 null
         , sum(panmaesu) as "판매량의 합계"
         , round( sum(panmaesu)/(
                                 select SUM(V_2.panmaesu)  -- 243개 ▶ 정답
                                 from 
                                   (
                                     select panmaesu
                                     from tbl_panmae_202111 
                                     UNION all
                                     select panmaesu
                                     from tbl_panmae_202112    
                                     UNION all    
                                     select panmaesu
                                     from tbl_panmae       
                                   ) V_2 
                                  )*100, 1) as "백분율(%)"
    from 
    (
    select *
    from tbl_panmae_202111 -- 2달전
    UNION 
    select *
    from tbl_panmae_202112 -- 1달전   
    UNION     
    select *
    from tbl_panmae       -- 이번달
    ) V    
    group by grouping sets((JEPUMNAME, to_char(panmaedate,'yyyy-mm')), (jepumname), ());         -- v. 는 생략가능함. roll up 은 뒤의 것을 생략하기 위함..

    -- 또는
    

     -- group by roll up (JEPUMNAME, to_char(panmaedate,'yyyy-mm') ); ▼     
    WITH
    V AS
    (
    select *
    from tbl_panmae_202111
    UNION 
    select *
    from tbl_panmae_202112   
    UNION     
    select *
    from tbl_panmae    
    )
    ,
    V_2 AS
    (
     select panmaesu
     from tbl_panmae_202111 
     UNION all
     select panmaesu
     from tbl_panmae_202112    
     UNION all    
     select panmaesu
     from tbl_panmae
    )
    select nvl(jepumname, '전체') as 제품명       -- 0은 실제 데이터, 1은 그룹을 짓지 않았을 때의 '전체'에 해당하는 값) 
           , nvl( to_char(panmaedate,'yyyy-mm'), ' ') as 판매년월  -- ' '는 공백
           , sum(panmaesu) as "판매량의 합계"
           , round( sum(panmaesu)/(select sum(panmaesu) from V_2)*100, 1) AS "백분율(%)"
    FROM V
    group by rollup(JEPUMNAME, to_char(panmaedate,'yyyy-mm'));         -- v. 는 생략가능함. roll up 은 뒤의 것을 생략하기 위함..
    -- 또는
    -- group by roll up (JEPUMNAME, to_char(panmaedate,'yyyy-mm') ); 
    
    
    ----- ===== *** INTERSECT(교집합) *** ===== -----
    insert into tbl_panmae_202111(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01', 'yyyy-mm-dd'),'초코파이', 10);

    insert into tbl_panmae_202112(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01', 'yyyy-mm-dd'),'초코파이', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01', 'yyyy-mm-dd'),'초코파이', 10);

    ----------------------------------------------------------------------------
    
    -- ▼ 시간이 다 다르다.
    insert into tbl_panmae_202111(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 10:00:00', 'yyyy-mm-dd hh24:mi:ss'),'초코파이', 2); -- 시간이 10시
    
    insert into tbl_panmae_202112(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 14:00:00', 'yyyy-mm-dd hh24:mi:ss'),'초코파이', 2); -- 시간이 14시
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 16:00:00', 'yyyy-mm-dd hh24:mi:ss'),'초코파이', 2); -- 시간이 16시
    
    commit;    
    -- 커밋 완료.
    
    -- 항상 중복된 것이 있으면 제거해주어야 한다.!!
    select *
    from tbl_panmae_202111 
    INTERSECT
    select *
    from tbl_panmae_202112    
    INTERSECT    
    select *
    from tbl_panmae
    -- 21/09/01	초코파이	10
    -- ▲ 3개 테이블에 똑같은 행이 있으니 이를 지워야 한다.

    delete from tbl_panmae_202111
    where to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu in(  -- 초코파이, 10 line 만 지우고자 한다. (초코파이,2 line이 아니라!) // 복수개 이므로 in을 쓴다.                                                                                    
                                                                                    select to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu -- ▶ 이름은 같지만 시간이 다르므로 panmaedate를 to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') 로 바꾼다
                                                                                    from tbl_panmae_202111 
                                                                                    INTERSECT
                                                                                    select to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
                                                                                    from tbl_panmae_202112    
                                                                                    INTERSECT    
                                                                                    select to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
                                                                                    from tbl_panmae );
   -- 1 행 이(가) 삭제되었습니다.    (tbl_panmae_202111 에서 초코파이 10개가 사라짐)                                                                             
                                                                                    
    delete from tbl_panmae_202112
    where to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu in(  -- 초코파이, 10 line 만 지우고자 한다. (초코파이,2 line이 아니라!) // 복수개 이므로 in을 쓴다.                                                                                    
                                                                                    select to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
                                                                                    from tbl_panmae_202112    
                                                                                    INTERSECT    
                                                                                    select to_char(panmaedate,'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
                                                                                    from tbl_panmae );                                                                                    
    -- 1개 행 이(가) 삭제되었습니다. (이미 202111 에서 초코파이 10개를 지웠으므로 in 안의 맨 위의행 삭제하고 delete)


    -- 초코파이 10개 를 위의 두 11월, 12월 테이블에서 delete 하여 1개만 남았으므로 더이상 tbl_panmae 테이블에서 중복이 아니다.
    
    commit;
    -- 커밋 완료.
 
    -- 초코파이 10 개를 한 table에 만 남은 상태로 남긴 결과값 ▼  
    WITH
    V AS
    (
    select *
    from tbl_panmae_202111
    UNION 
    select *
    from tbl_panmae_202112   
    UNION     
    select *
    from tbl_panmae    
    )
    ,
    V_2 AS
    (
     select panmaesu
     from tbl_panmae_202111 
     UNION all
     select panmaesu
     from tbl_panmae_202112    
     UNION all    
     select panmaesu
     from tbl_panmae
    )
    select nvl(jepumname, '전체') as 제품명       -- 0은 실제 데이터, 1은 그룹을 짓지 않았을 때의 '전체'에 해당하는 값) 
         , nvl( to_char(panmaedate,'yyyy-mm'), ' ') as 판매년월  -- ' '는 공백
         , sum(panmaesu) as "판매량의 합계"
         , round( sum(panmaesu)/(select sum(panmaesu) from V_2)*100, 1) AS "백분율(%)"
    FROM V
    group by rollup(JEPUMNAME, to_char(panmaedate,'yyyy-mm'));         -- v. 는 생략가능함. roll up 은 뒤의 것을 생략하기 위함..
    -- 또는
    -- group by roll up (JEPUMNAME, to_char(panmaedate,'yyyy-mm') );     
    
    
    
    
    -------------- ===== **** MINUS(차집합) **** ===== --------------
    select * from tab;
    
    select *
    from TBL_EMPLOYEES_BACKUP_220111;
    
    select *
    from employees
    where employee_id IN(173, 185, 195);
    
    select *
    from TBL_EMPLOYEES_BACKUP_220111
    where employee_id IN(173, 185, 195);
    
    -- *** 개발자가 실수로 employees 테이블에 있던 사원들을 삭제(delete)했다. 그런데 누구를 삭제했는지 모른다.!!!!
    --     백업받은 TBL_EMPLOYEES_BACKUP 테이블을 이용하여 삭제된 사원들을 다시 복구하도록 하겠다. *** ---    
    
    -- *** 개발자가 실수로 employees 테이블에 있던 사원들을 삭제(delete)했다. 그런데 누구를 삭제했는지 모른다.!!!!    
    delete from employees
    where employee_id IN(173, 185, 195);
    -- 3개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.

    -- 백업받은 TBL_EMPLOYEES_BACKUP 테이블을 이용하여 삭제된 사원들을 아래의 순서를 통해 다시 복구 하겠다. *** ---   
    -- BACKUP 테이블에는 있지만 원래 employees 테이블에서 삭제된 것. MINUS == 너가 지운 행들이 이 행들이다!
    select *
    from TBL_EMPLOYEES_BACKUP_220111        -- 지웠던 3명이 이 백업테이블엔 有
    MINUS
    select *
    from employees;                          -- 여기선 3명이 지워져 있음.
    
    select *
    from employees
    where employee_id IN(173, 185, 195);    
    -- 지운 3개 행이 없는 상태.
    
    insert into employees
    select *                                -- select 된 173,185,195 번을 읽어 employees 에 넣으세요.
    from TBL_EMPLOYEES_BACKUP_220111        -- 지웠던 3명이 이 백업테이블엔 有
    MINUS
    select *
    from employees;    
    -- 3개 행 이(가) 삽입되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select *
    from employees
    where employee_id IN(173, 185, 195);   
    -- 지워졌던 3개의 행 복구 완료!!        
    
    
    
    
    ----------- ====== **** Pseudo(의사, 유사, 모조) Column **** ====== -----------
    ------ Pseudo(의사) Column 은 rowid 와 rownum 이 있다.
    
    /*
    1. rowid
    rowid 는 오라클이 내부적으로 사용하기 위해 만든 id 값으로써 행에 대한 id값 인데
    오라클 전체내에서 고유한 값을 가진다.
    ex. 아래 처럼 중복된 행을 여러번 넣었을 때, 그때 1개를 뺀 나머지 중복값들을 삭제해야 함.
    */    
    
    create table tbl_heowon
    (userid     varchar2(20),
    name        varchar2(20),
    address     varchar2(100)
    );
    
    insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
    insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
    insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
    
    insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
    insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
    insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
        
    insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
    insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
    insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
        
    commit;
    
    select *
    from tbl_heowon;
    
    select userid, name, address, rowid -- rowid 를 추가하게 되면 그 값은 매번 다름 (address 까지는 다 같을지 몰라도)
    from tbl_heowon;
    -- ▶ rowid 는 우리가 만든 컬럼이 아니고, 오라클에서 자체적으로 만든 컬럼이다. (항상 고유한 값을 가진다.)   
    
    select userid, name, address, rowid -- rowid 를 추가하게 되면 그 값은 매번 다름 (address 까지는 다 같을지 몰라도)
    from tbl_heowon;
    where rowid in ('AAAE8gAAEAAAAHLAAA','AAAE8gAAEAAAAHLAAB','AAAE8gAAEAAAAHLAAC');    -- 문자열이기 때문에 '' 사용.

    delete from tbl_heowon
    where rowid > 'AAAE8gAAEAAAAHLAAC';
    -- 6개 행 이(가) 삭제되었습니다.  (3개를 뺀 나머지 6개의 중복값들이 삭제됨)
    
    commit;

    select *
    from tbl_heowon;
    -- 3개의 값만 출력됨.

    
    /*
       2. rownum (!!!! 게시판 등 웹에서 아주 많이 사용됩니다. !!!!) ★★★★★
    */
   select boardno as 글번호
         , subject as 글제목
         , userid as 글쓴이
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as 작성일자
   from tbl_board
   order by boardno desc;
   
   ------------------------------------------------------------------------
   번호    글번호   글제목                             글쓴이   작성일자
   ------------------------------------------------------------------------
    1       5	  오늘도 좋은 하루되세요	            hongkd	2022-01-07 10:26:03
    2       4	  기쁘고 감사함이 넘치는 좋은 하루되세요	leess	2022-01-07 10:24:46
    3       3	  건강하세요	                        youks	2022-01-07 10:23:59
    4       2	  반갑습니다	                        eomjh	2022-01-07 10:23:07
    5       1	  안녕하세요	                        leess	2022-01-07 10:21:49
   -----------------------------------------------------------------------------
                  1   2   3   ==> 페이지바
                  
    select rownum   -- rownum(행번호)은 기본적으로 insert 된 순서대로 나온다.
         , boardno as 글번호
         , subject as 글제목
         , userid as 글쓴이
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as 작성일자
    from tbl_board

    select rownum, boardno, subject, userid, registerday     
    from 
    (                 
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc                  
    ) V;   
    
    -- 또는
    WITH V AS
    (           
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc                  
    )
    select rownum, boardno, subject, userid, registerday         
    from V;    
    
    
    -- 또는 rownum 을 사용하지 않고 row_number() 함수를 사용해서 나타낼 수 있다.
    select row_number() over(order by boardno desc)
         , boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as REGISTERDAY
    from tbl_board;
    
    -- 홈페이지에서 페이지바 시 사용 ★★★★★★ 잘 알아둘 것 ★★★★★★
    /*
        한 페이지당 2개씩 보여주고자 한다.
        
        1 페이지 ==>  rownum : 1 ~ 2   boardno : 5 ~ 4      
        2 페이지 ==>  rownum : 3 ~ 4   boardno : 3 ~ 2     
        3 페이지 ==>  rownum : 5 ~ 6   boardno : 1          
    */
    
    -- [틀린 SQL 문] --
    --  1 페이지 ==>  rownum : 1 ~ 2  /  boardno : 5 ~ 4 
    select rownum, boardno, subject, userid, registerday     
    from 
    (                 
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc                  
    ) V
    where rownum between 1 and 2;
    
    
    --  2 페이지 ==>  rownum : 3 ~ 4  /  boardno : 3 ~ 2 
    select rownum, boardno, subject, userid, registerday     
    from 
    (                 
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc                  
    ) V
    where rownum between 3 and 4;
    -- ▶결과값이 아무것도 뜨지 않는다.
    -- rownum 은 where 절에 바로 쓸 수 없음. (위의 rownum 1,2는 나오긴 하지만, 쓸 수 없음!!)
    -- 그래서 rownum 을 가지는 컬럼의 별칭을 만든 후에 inline view 를 사용해야만 한다.!!!

    -- 3 페이지 ==>  rownum : 5 ~ 6  /  boardno : 1
  
    -- [올바른 SQL문] --
    
    -- 1 페이지 ==>  rownum : 1 ~ 2  /  boardno : 5 ~ 4 
    /*  ★★★★★★ 반드시 기억 ! ★★★★★★
        >>> rownum : 1 ~ 2 를 구하는 공식 <<<
        (currentShowPageNo * sizePerPage) - (sizePerPage - 1);  -- 1
                        1  * 2            - ( 2 - 1 ) ==> 1  
             (현재 pageNo.)   (한p당 몇개를 보여줄래?)    
            
        sizePerPage 가 10인 서울교대 게시판 ▼ 공식 적용 ▼
                    1 * 10 - ( 10 - 1 )    ==> 1
            
        
        (currentShowPageNo * sizePerPage);  -- 2
                         1 * 2  ==> 2
                         
        sizePerPage 가 10인 서울교대 게시판
                         1 * 10 ==> 10              1페이지 : (1~10개)     
    */
    
   select boardno , subject, userid, registerday    -- RNO 를 보여줄 필요가 없다.
   from
   (
    select rownum AS RNO, boardno , subject, userid, registerday -- 이만큼을 하나의 테이블로 봐야하는 것.
    from
    (                 
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc        
    ) V
   ) T
  where T.RNO between 1 and 2;  -- 1페이지
   
    -- 2 페이지 ==>  rownum : 3 ~ 4  /  boardno : 3 ~ 2 
    /*  ★★★★★★ 반드시 기억 ! ★★★★★★
        >>> rownum : 3 ~ 4 를 구하는 공식 <<<
        (currentShowPageNo * sizePerPage) - (sizePerPage - 1);  -- 1
                        2  * 2            - ( 2 - 1 ) ==> 3  
             (현재 pageNo.)   (한p당 몇개를 보여줄래?)    
            
        sizePerPage 가 10인 서울교대 게시판 
                    2 * 10 - ( 10 - 1 )    ==> 11
            
        
        (currentShowPageNo * sizePerPage);  -- 4
                         2 * 2  ==> 4
                         
        sizePerPage 가 10인 서울교대 게시판
                         2 * 10 ==> 20               2페이지 : (11~20개)         
    */

   select boardno , subject, userid, registerday    -- RNO 를 보여줄 필요가 없다.
   from
   (
    select rownum AS RNO, boardno , subject, userid, registerday -- 이만큼을 하나의 테이블로 봐야하는 것.
    from
    (                 
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc            
    ) V
   ) T
  where T.RNO between 3 and 4;  -- 2페이지

  
    -- 3 페이지 ==>  rownum : 5 ~ 6  /  boardno : 1
    /*  ★★★★★★ 반드시 기억 ! ★★★★★★
        >>> rownum : 1 ~ 2 를 구하는 공식 <<<
        (currentShowPageNo * sizePerPage) - (sizePerPage - 1);  -- 1
                        3  * 2            - ( 2 - 1 ) ==> 5  
             (현재 pageNo.)   (한p당 몇개를 보여줄래?)    
            
    ●   sizePerPage 가 10인 서울교대 게시판 
                    3 * 10 - ( 10 - 1 )    ==> 21
            
        
        (currentShowPageNo * sizePerPage);  -- 6
                         3 * 2  ==> 6
                         
    ●   sizePerPage 가 10인 서울교대 게시판
                         3 * 10 ==> 30               3페이지 : (21~30개)         
    */

   select boardno , subject, userid, registerday    -- RNO 를 보여줄 필요가 없다.
   from
   (
    select rownum AS RNO, boardno , subject, userid, registerday -- 이만큼을 하나의 테이블로 봐야하는 것.
    from
    (                 
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as registerday
    from tbl_board
    order by boardno desc            
    ) V
   ) T
  where T.RNO between 5 and 6;  -- 3페이지
  
  
  -- 또는
  -- rownum 을 사용하지 않고 row_number() 함수를 사용하여 페이징 처리를 해봅니다.
  
  -- [틀린 SQL문] --
    select row_number() over(order by boardno desc)
         , boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')  as REGISTERDAY
    from tbl_board    
    where row_number() over(order by boardno desc) between 1 and 2;
    -- 오류!!! row_number() over(order by boardno desc) 은 where 절에 바로 쓸 수가 없다.!!!!
    -- 그러므로 이것 또한 inline view 를 사용해야 한다.
    
    -- [올바른 SQL문] --
    
    -- 1 페이지 ==>  row_number() : 1 ~ 2  /  boardno : 5 ~ 4 
    
    select boardno, subject, userid, registerday 
    from
    ( 
    select row_number() over(order by boardno desc) AS RNO
         , boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as REGISTERDAY
    from tbl_board 
    ) V   
    where RNO between 1 and 2    -- 1페이지
    
    
    -- 2 페이지 ==>  row_number():  3 ~ 4  /  boardno : 3 ~ 2 
    select boardno, subject, userid, registerday 
    from
    ( 
    select row_number() over(order by boardno desc) AS RNO
         , boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as REGISTERDAY
    from tbl_board 
    ) V   
    where RNO between 3 and 4 -- 2페이지 
    
    -- 3 페이지 ==>  row_number() : 5 ~ 6  /  boardno : 1 
    select boardno, subject, userid, registerday 
    from
    ( 
    select row_number() over(order by boardno desc) AS RNO
         , boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as REGISTERDAY
    from tbl_board 
    ) V   
    where RNO between 5 and 6; -- 3페이지     
    
   -------- **** 데이터 조작어(DML == Data Manipulation Language) **** ---------
   --- DML 문은 기본적으로 수동 commit 이다.
   --- 즉, DML 문을 수행한 다음에는 바로 디스크(파일)에 적용되지 않고 commit 해야만 적용된다.
   --- 그래서 DML 문을 수행한 다음에 디스크(파일)에 적용치 않고자 한다라면 rollback 하면 된다.
   
   1. insert  --> 데이터 입력
   2. update  --> 데이터 수정
   3. delete  --> 데이터 삭제
   4. merge   --> 데이터 병합 (insert + update)
    
   insert 는 문법이
   insert into 테이블명(컬럼명1,컬럼명2,...) values(값1,값2,...); 
   이다.    
    
    ※ Unconditional insert all  -- ==>조건이 없는 insert 
    [문법] insert all 
           into 테이블명1(컬럼명1, 컬럼명2, ....)
           values(값1, 값2, .....)
           into 테이블명2(컬럼명3, 컬럼명4, ....)
           values(값3, 값4, .....)
           SUB Query문; 
    
   
   create table tbl_emp1
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(6)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );       
   -- Table TBL_EMP1이(가) 생성되었습니다.
   
   
   create table tbl_emp1_backup
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(6)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );  
   -- Table TBL_EMP1_BACKUP이(가) 생성되었습니다.     
   select *
   from tbl_emp1;

   select *
   from tbl_emp1_backup;
   
   
   insert all 
   into tbl_emp1(empno, ename, monthsal, gender, manager_id, department_id, department_name) -- tbl_emp1 에 넣어주자!
   values(employee_id, ename, month_sal, gender||,manager_id, department_id, department_name)
   into tbl_emp1_backup(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender||,manager_id, department_id, department_name)    
   select employee_id
        , first_name || ' ' || last_name AS ename 
        , nvl(salary + (salary * commission_pct), salary) AS month_sal
        , case when substr(jubun,7,1) in('1','3') then '남' else '여' end AS gender
        , E.manager_id
        , E.department_id
        , department_name
   from employees E LEFT JOIN departments D 
   on E.department_id = D.department_id
   order by E.department_id asc, employee_id asc;    
   -- 214개 행 이(가) 삽입되었습니다. (107개 행 + 107개 행)
 
   -- 잘못 insert 했을 때, rollback 을 한다!! (commit 만 안했으면 된다.)
    
   commit;  
   -- 커밋 완료.

   ※ Conditional insert all -- ==> 조건이 있는 insert 
   조건(where절)에 일치하는 행들만 특정 테이블로 찾아가서 insert 하도록 하는 것이다.
   
   -- 부서번호 30번만 들어가도록.   
   create table tbl_emp_dept30
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );
   -- Table TBL_EMP_DEPT30이(가) 생성되었습니다.
   -- ▼ 각 30, 50, 80 table 에 나누어서 들어가게끔 함 (when 조건절 추가)
   insert all 
   when department_id = 30 then  -- 조건절을 여기에 추가 (무조건절과 다른 line)
   into tbl_emp_dept30(empno, ename, monthsal, gender, manager_id, department_id, department_name) -- tbl_emp1 에 넣어주자!
   values(employee_id, ename, month_sal, gender,manager_id, department_id, department_name)
   when department_id = 50 then  -- 조건절을 여기에 추가 (무조건절과 다른 line)
   into tbl_emp_dept50(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender,manager_id, department_id, department_name)
   when department_id = 80 then  -- 조건절을 여기에 추가 (무조건절과 다른 line)
   into tbl_emp_dept80(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender,manager_id, department_id, department_name)
   select employee_id
        , first_name || ' ' || last_name AS ename 
        , nvl(salary + (salary * commission_pct), salary) AS month_sal
        , case when substr(jubun,7,1) in('1','3') then '남' else '여' end AS gender
        , E.manager_id
        , E.department_id
        , department_name
   from employees E LEFT JOIN departments D 
   on E.department_id = D.department_id
   where E.department_id IN(30, 50, 80)             -- 30, 50, 80 각각의 테이블에 넣어주고자 한다.
   order by E.department_id asc, employee_id asc;    
   -- 85개 행 이(가) 삽입되었습니다.
   commit; 
    
   -- ※ 오류 발생했었음 : ORA-12899: value too large for column "HR"."TBL_EMP_DEPT30"."GENDER" (actual: 6, maximum: 4)
   -- GENDER 라는 항목에 GENDER||'자'를 붙였었는데, 위에서 table 을 만들 때, gender  varchar2(4) 라고 설정했기 때문에, value too large 였음. ▶ 4에 맞게 크기를 조정하면 해결됨.!!

   create table tbl_emp_dept50
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );
   -- Table TBL_EMP_DEPT50이(가) 생성되었습니다.

   create table tbl_emp_dept80
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );  
   -- Table TBL_EMP_DEPT80이(가) 생성되었습니다.
 
   select *
   from tbl_emp_dept30; 
    
   select *
   from tbl_emp_dept50; 

   select *
   from tbl_emp_dept80; 
    
   
   
    -------- ====== ****   merge(병합)   **** ====== --------
    -- 어떤 2개 이상의 테이블에 존재하는 데이터를 다른 테이블 한곳으로 모으는것(병합)이다.    
    
    1. 탐색기에서 C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN 에 간다.
    
    2. tnsnames.ora 파일을 메모장으로 연다.
    
    3. TEACHER =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = 211.238.142.72)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = XE)
        )
      )
     을 추가한다.
     HOST = 211.238.142.72 이 연결하고자 하는 원격지 오라클서버의 IP 주소이다.
     그런데 전제조건은 원격지 오라클서버(211.238.142.72)의 방화벽에서 포트번호 1521 을 허용으로 만들어주어야 한다.
     
     그리고 TEACHER 를 'Net Service Name 네트서비스네임(넷서비스명)' 이라고 부른다.
     
     
    4. 명령프롬프트를 열어서 원격지 오라클서버(211.238.142.72)에 연결이 가능한지 테스트를 한다. 
      C:\Users\sist>tnsping TEACHER 5
    
        Used TNSNAMES adapter to resolve the alias
        Attempting to contact (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 211.238.142.72)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = XE)))
        OK (0 msec)
        OK (40 msec)
        OK (10 msec)
        OK (30 msec)
        OK (20 msec)    

    5.  데이터베이스 링크(database link) 만들기
    
    create database link teacherServer   -- 해당 server로 붙겠다!
    connect to hr identified by cclass   -- 이때 hr 과 암호 cclass 는 연결하고자 하는 원격지 오라클서버(211.238.142.72)의 계정명과 암호 이다. 
    using 'TEACHER';  -- TEACHER 는 Net Service Name 네트서비스네임(넷서비스명) 이다.
    -- Database link TEACHERSERVER이(가) 생성되었습니다.    
    
    update employees set first_name = '민정', last_name = '김'
    where employee_id = 100;    -- Steven King
    -- 1 행 이(가) 업데이트되었습니다.

    commit;    
    -- 커밋 완료.
    
    select *
    from employees  -- 로컬서버
    order by employee_id;

    select *
    from employees@XE   -- 로컬서버
    order by employee_id;
    
    select *
    from employees@teacherServer  -- 원격지 오라클서버(211.238.142.72) // teacherServer 는 DB 링크 ▶ 강사님 이름이 출력됨
    order by employee_id;
    
    
    ---- **** 생성된 데이터베이스 링크를 조회해봅니다. **** ----    
    select *
    from user_db_links;
    /*
    ------------------------------------------------------------
    DB_LINK         USERNAME  PASSWORD      HOST        CREATED 
    ------------------------------------------------------------
    TEACHERSERVER	HR		  (NULL)        TEACHER	    22/01/14
                                         -- TEACHER 는 Net Service Name 네트서비스네임(넷서비스명)이다.
    */
    
    ---- **** 생성된 데이터베이스 링크를 삭제 해봅니다. **** ----    
    drop database link TEACHERSERVER;
    -- Database link TEACHERSERVER이(가) 삭제되었습니다.
   
    create database link bonjumlink      -- 본점 server 에 붙겠다.  
    connect to hr identified by cclass   -- 이때 hr 과 암호 cclass 는 연결하고자 하는 원격지 오라클서버(211.238.142.72)의 계정명과 암호 이다. 
    using 'TEACHER';  
    -- Database link BONJUMLINK이(가) 생성되었습니다.

    select *
    from employees@bonjumlink
    order by employee_id asc;
    --  1번에 강사님 이름 출력
    
    SELECT *
    FROM DBA_DB_LINKS;
    
    drop table tbl_reservation_kimminjeong purge;   -- 테이블 삭제
    -- Table TBL_RESERVATION_KIMMINJEONG이(가) 삭제되었습니다.

    ▼▼▼▼▼
    -- 각 지점은 tbl_reservation_kimminjeong 이라는 테이블을 생성한다.
    create table tbl_reservation_kimminjeong
    (rsvno       varchar2(20)    -- 예약고유번호
    ,memberid    varchar2(20)    -- 회원ID
    ,ticketcnt   number          -- 티켓개수
    ,constraint PK_tbl_reservation_kimminjeong primary key(rsvno)
    );
    -- Table TBL_RESERVATION_KIMMINJEONG이(가) 생성되었습니다.
    
    insert into tbl_reservation_kimminjeong(rsvno, memberid, ticketcnt)
    values('kimminjeong001', '김민정', 2);
    
    commit;
    -- 커밋 완료.
    
    -- 아래는 본점DB서버(샘PC)에서만 하는 것이다.
    create table tbl_reservation_merge
    (rsvno       varchar2(20)    -- 예약고유번호
    ,memberid    varchar2(20)    -- 회원ID
    ,ticketcnt   number          -- 티켓개수
    ,constraint PK_tbl_reservation_merge primary key(rsvno)
    );
    -- Table TBL_RESERVATION_MERGE이(가) 생성되었습니다.
    
    select *
    from tbl_reservation_merge; -- 샘이 하는것
    
    select *
    from tbl_reservation_merge@bonjumlink; -- 여러분들이 하는 것
    
    select * 
    from tbl_reservation_kimminjeong;
    
    -- 아래는 내(지사)가 하는 것 ---
    merge into tbl_reservation_merge@bonjumlink R       -- R(remote, 원격지)
    using tbl_reservation_kimminjeong L                 -- L(local)
    on (L.rsvno = R.rsvno)                              -- R 과 L 서버에 rsvno(예약번호)가 같은 것이 있는가?
    when matched then                                   -- resno가 같은것이 있다면?
        update set R.memberid = L.memberid              -- Update 해라.
                 , R.ticketcnt = L.ticketcnt
    when not matched then                               -- resno가 같은것이 없다면?
        insert(rsvno, memberid, ticketcnt) values(L.rsvno, L.memberid, L.ticketcnt);                  -- insert *into* 가 아니다.
    -- 1 행 이(가) 병합되었습니다.
    
    commit;    
    -- 커밋 완료.

    select *
    from tbl_reservation_merge@bonjumlink; -- 여러분들이 하는 것
    
    select * 
    from tbl_reservation_kimminjeong;    
    
    update tbl_reservation_kimminjeong set memberid = 'Kim M.J', ticketcnt = 3
    where rsvno = 'kimminjeong001';
    -- 1 행 이(가) 업데이트되었습니다.

    commit;
    -- 커밋 완료.
    
    -- 아래는 내(지사)가 하는 것.
    merge into tbl_reservation_merge@bonjumlink R       -- R(remote, 원격지)
    using tbl_reservation_kimminjeong L                 -- L(local)
    on (L.rsvno = R.rsvno)                              -- R 과 L 서버에 rsvno(예약번호)가 같은 것이 있는가?
    when matched then                                   -- resno가 같은것이 있다면?
        update set R.memberid = L.memberid              -- Update 해라.
                 , R.ticketcnt = L.ticketcnt
    when not matched then                               -- resno가 같은것이 없다면?
        insert(rsvno, memberid, ticketcnt) values(L.rsvno, L.memberid, L.ticketcnt);   
    -- 1 행 이(가) 병합되었습니다.

    commit; 
    -- 커밋 완료.
    
    insert into tbl_reservation_kimminjeong(rsvno, memberid, ticketcnt)
    values('kimminjeong002', '김민정2', 2);
    
    commit;
    
    -- 아래는 내(지사)가 하는 것.
    merge into tbl_reservation_merge@bonjumlink R       -- R(remote, 원격지)
    using tbl_reservation_kimminjeong L                 -- L(local)
    on (L.rsvno = R.rsvno)                              -- R 과 L 서버에 rsvno(예약번호)가 같은 것이 있는가?
    when matched then                                   -- resno가 같은것이 있다면?
        update set R.memberid = L.memberid              -- Update 해라.
                 , R.ticketcnt = L.ticketcnt
    when not matched then                               -- resno가 같은것이 없다면?
        insert(rsvno, memberid, ticketcnt) values(L.rsvno, L.memberid, L.ticketcnt);   
    -- 1 행 이(가) 병합되었습니다.

    commit; 
    -- 커밋 완료.  
    
    select *
    from tbl_reservation_merge@bonjumlink; -- 여러분들이 하는 것
    
    
    ----- **** 데이터 질의어(DQL == Data Query Language) **** -----
    --> DQL 은 select 를 말한다.
    
    ----- **** 트랜잭션 제어어(TCL == Transaction Control Language) **** -----
    --> TCL 은 commit, rollback 을 말한다.
    
    
   -- *** Transaction(트랜잭션) 처리 *** -- ★★★★ 매우 중요 ★★★★
   --> Transaction(트랜잭션)이라 함은 관련된 일련의 DML로 이루어진 한꾸러미(한세트)를 말한다.
   --> Transaction(트랜잭션)이라 함은 데이터베이스의 상태를 변환시키기 위하여 논리적 기능을 수행하는 ★하나의 작업단위★를 말한다. 
   /*
      예>   네이버카페(다음카페)에서 활동
            글쓰기(insert)를 1번하면 내포인트 점수가 10점이 올라가고(update),           -- insert 와 update 는 1set.  (서로다른 DML 문임)
            댓글쓰기(insert)를 1번하면 내포인트 점수가 5점이 올라가도록 한다(update)
           
           위와같이 정의된 네이버카페(다음카페)에서 활동은 insert 와 update 가 한꾸러미(한세트)로 이루어져 있는 것이다.
           이와 같이 서로 다른 DML문이 1개의 작업을 이룰때 Transaction(트랜잭션) 처리라고 부른다.  -- insert 와 update 는 서로다른 DML 문.
           ★★★★ ▼▼핵심▼▼
           Transaction(트랜잭션) 처리에서 가장 중요한 것은 
           모든 DML문이 성공해야만 최종적으로 모두 commit 을 해주고,
           DML문중에 1개라도 실패하면 모두 rollback 을 해주어야 한다는 것이다. 
           ★★★★
           예를 들면 네이버카페(다음카페)에서 글쓰기(insert)가 성공 했다면
           그 이후에 내포인트 점수가 10점이 올라가는(update) 작업을 해주고, update 작업이 성공했다면
           commit 을 해준다. 
           만약에 글쓰기(insert) 또는 10점이 올라가는(update) 작업이 실패했다라면
           rolllback 을 해준다.
           이러한 실습은 자바에서 하겠습니다.
   */    
    -- 즉, 글쓰기가 성공을 해야 포인트가 증가해야함. (insert 와 update 가 성공일때 commit을 해야함.)
    -- 글쓰기를 했는데 점수가 안올라간 상태에서 commit 을 하면 안됨. ( 한 개라도 실패하면 rollback 처리)
    insert --> 글쓰기       성공   성공  실패
    -- commit;
    update --> 포인트 증가   성공   실패  성공
    commit;
    -- rollback (둘 다 성공을 안했을 시, rollback 처리)
    
    
    ---- **** === ROLLBACK TO SAVEPOINT === **** ----
              ----> 특정 시점까지 rollback 을 할 수 있다.
    
    select *
    from employees
    where department_id = 50;
    
    update employees set first_name = '몰라'
    where department_id = 50;
    -- 45개 행 이(가) 업데이트되었습니다. (부서번호 50번인 45개의 행이 update 됨)
    
    savepoint point_1;
    -- Savepoint이(가) 생성되었습니다.

    delete from employees
    where department_id is null;    -- kimberly 행 삭제.
    -- 1 행 이(가) 삭제되었습니다.

    select first_name 
    from employees
    where department_id = 50;
    -- first_name 이 전부 '몰라' 로 출력된다.

    select *
    from employees
    where department_id is null;    
    -- de_id 가 null 인 kimberly 가 출력되지 않는다.
    
    ROLLBACK TO SAVEPOINT point_1;  -- point_1 에서 멈춘 후 rollback 을 한다. (rollback : commit 한 이후로 발생된 모든 DML 문을 rollback.)
    -- 롤백 완료.    
    -- savepoint point_1; 이 선언되어진 이후로 실행된 DML문을 rollback 시킨다.
    /*
       그러므로
       delete from employees
       where department_id is null; 만 롤백시킨다.
    */
    
    select *
    from employees
    where department_id is null;        
    -- Kimberly 가 다시 살아났음. (행이 출력된다.)
    
    select first_name 
    from employees
    where department_id = 50;
    -- first_name 이 *아직까지* 전부 '몰라' 로 출력된다. (rollback 을 했음에도 불구하고)
    
    rollback;   --> commit 한 이후로 수행된 모든 DML 문을 rollback 시킨다.
    -- 바로 위에서 first_name 이 전부 '몰라'로 출력되다가 원래 이름대로 돌아왔다.
    
    select first_name 
    from employees
    where department_id = 50;
    -- first_name 컬럼의 값이 원상복구됨.
    
    
    
    
    -------- **** 데이터 정의어(DDL == Data Defination Language) **** ---------
    ==> DDL : create, drop, alter, truncate 
    --> 여기서 중요한 것은 DDL 문을 실행을 하면 자동적으로 commit; 이 되어진다.
    --  즉, auto commit 되어진다.
    
    select *
    from employees
    where employee_id = 100;
    -- salary ==> 24000
    -- email  ==> SKING
    
    update employees set salary = 70000, email = 'abcdee'
    where employee_id = 100;
    -- 1 행 이(가) 업데이트되었습니다.
    
    create table tbl_imsi
    (no number
    , name varchar2 (20)
    );
    -- Table TBL_IMSI이(가) 생성되었습니다.
   
    
    -- DDL 문을 실행했으므로 자동적으로 commit; 이 된다.
    rollback;        
    -- 롤백 완료.
    
    select *
    from employees
    where employee_id = 100;    
    -- 그러나 이미 DDL 문인 create를 실행했으므로 rollback 을 해도 적용이 되지 않는다.
    -- rollback 안됨.

    update employees set salary = 24000         -- 원상복구함.
                       , email = 'SKING'    
                       , first_name = 'Steven'
                       , last_name = 'King'
    where employee_id = 100;
    
    commit;
    -- 커밋 완료.

    select *
    from employees
    where employee_id = 100;    
    
    
    ------ ====== **** TRUNCATE table 테이블명; **** ====== ------  
    --> TRUNCATE table 테이블명; 을 실행하면 테이블명 에 존재하던 모든 행(row)들을 삭제해주고,
    --  테이블명에 해당하는 테이블은 완전초기화 가 되어진다.
    --  중요한 사실은 TRUNCATE table 테이블명; 은 DDL 문이기에 auto commit; 되어지므로 rollback 이 불가하다.
   
    --  delete from 테이블명; 을 실행하면 이것도 테이블명 에 존재하던 모든 행(row)들을 삭제해준다.
    --  이것은 DML문 이므로 rollback 이 가능하다.    
    
    create table tbl_emp_copy_1
    as
    select * from employees;
    -- Table TBL_EMP_COPY_1이(가) 생성되었습니다.

    select *
    from tbl_emp_copy_1;  -- 0개행  
    
    delete from tbl_emp_copy_1          -- 그러나 delete 문은 DML 이기 때문에 **rollback**이 가능하다. 
    -- 107개 행 이(가) 삭제되었습니다.
    
    rollback;

    select *
    from tbl_emp_copy_1; -- 107개 행 복구 됨!
    
    truncate table tbl_emp_copy_1;
    -- Table TBL_EMP_COPY_1이(가) 잘렸습니다.

    select *
    from tbl_emp_copy_1;
    
    select count(*)
    from tbl_emp_copy_1;    -- 0개 행.
    
    rollback;   -- DDL 문인 truncate 를 사용하여 auto commit; 이 되어졌으므로 rollback 해봐야 소용없다.
    -- 롤백 완료. (불가!!!)
    
    select *
    from tbl_emp_copy_1;
    
    select count(*)
    from tbl_emp_copy_1;    -- 0개 행.
    
    
    -------- **** 데이터 제어어(DCL == Data Control Language) **** ---------
    ==> DCL : grant(권한 부여하기), revoke(권한 회수하기)
    --> 여기서 중요한 것은 DCL 문을 실행하면 자동적으로 commit; 이 된다.
    -- 즉, auto commit; 된다.
    
    
    ---- **** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 시작 **** ----
    show user;
    -- USER이(가) "SYS"입니다.
    
    -- orauser1 라는 오라클 일반 사용자 계정을 생성하겠습니다. 암호는 cclass 라고 하겠습니다.
    create user orauser1 identified by cclass default tablespace users;
    -- User ORAUSER1이(가) 생성되었습니다.
    
    -- 생성된 오라클 일반사용자 계정인 orauser1 에게 오라클 서버에 접속이 되고, 
    -- 접속이 된 이후 테이블 등을 생성할 수 있는 권한을 부여해주겠다.
    grant connect, resource, unlimited tablespace to orauser1;
    -- Grant을(를) 성공했습니다. (권한을 부여함)
    
    ---- **** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 종료 **** ----
    
    
    ---- *** HR 에서 아래와 같은 작업을 한다. *** ----
    show user;
    -- USER이(가) "HR"입니다.
    
    select *
    from HR.employees;        -- HR 유저 소유의 employees 테이블. (hr 스키마라고 한다.)// user name 을 스키마라고 부른다. (오른쪽 위의 USER 설정 base)
        
    -- ▼▼ cmd 창 실행하여 확인    
    -- 현재 오라클 서버에 접속한 사용자가 HR 이므로 HR.employees 대신에 employees 을 쓰면 HR.employees 로 인식한다. (즉, HR. 은 생략 가능하다.) 
    select *
    from employees;       -- SYS는 관리자이기 때문에 모든 DB 를 다 꺼내 볼 수 있다. (오른쪽 위를 local_sys로 설정해두고 HR.employees 로 읽어오면 그 값을 불러온다.!!)

    ---▼ ①권한 부여▼---   grant~to           
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 select 할 수 있도록 권한을 부여한다.
    grant select on employees to orauser1;  
    -- Grant을(를) 성공했습니다.
    
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 update 할 수 있도록 권한을 부여한다.
    grant update on employees to orauser1;  
    -- Grant을(를) 성공했습니다.
    select first_name, last_name
    from hr.employees
    where employee_id = 100;
    
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 delete 할 수 있도록 권한을 부여한다.
    grant delete on employees to orauser1;  
    -- Grant을(를) 성공했습니다.
    
    ---▼ ②권한 회수▼---   revoke~from
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 delete 할 수 있도록 부여한 권한을 회수한다.
    revoke delete on employees from orauser1;  
    -- Revoke을(를) 성공했습니다.    
    
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 update 할 수 있도록 부여한 권한을 회수한다.
    revoke update on employees from orauser1;  
    -- Revoke을(를) 성공했습니다.    
 
     -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 select 할 수 있도록 부여한 권한을 회수한다.
    revoke select on employees from orauser1;  
    -- Revoke을(를) 성공했습니다.    


    -- ▼ select, update, delete 를 한꺼번에 grant 함 ▼     
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 select, update, delete 할 수 있도록 권한을 부여한다.
    grant select, update, delete on employees to orauser1;  
    -- Grant을(를) 성공했습니다.
    
    -- ▼ select, update, delete 를 한꺼번에 revoke 함 ▼     
    -- orauser1 에게 HR 이 자신의 소유인 employees 테이블에 대해 select, update, delete 할 수 있도록 부여한 권한을 회수한다.
    revoke select, update, delete on employees from orauser1;  
    -- Revoke을(를) 성공했습니다.    
        
    -- view ★ 중요
    
    show user;
    -- USER이(가) "HR"입니다.
    
    select *
    from employees;
    
    /*
    == stored view 를 생성하는 이유 2 가지 == 
    ① 복잡한 SQL 문을 간단하게 만들어서 나중에 또 쓰기 위함.
    ② 민감한 정보가 들어있는 테이블은 공개할 행과 공개할 컬럼만 따로 만들어서 오라클 사용자에게 부여하고자 할 때 stored view 를 생성한다.    
    */
    
    create or replace view view_emp_3080
    as
    select employee_id, first_name, last_name, hire_date, salary, commission_pct
         , department_id, substr(jubun,1,6) AS BIRTHDAY         
    from employees
    where department_id in(30,50,80);
    -- View VIEW_EMP_3080이(가) 생성되었습니다.
    
    -- ▼ 생성한 view 에 대해서 grant 해주는 것 (table 이 아님!!)  -- ▶ 민감한 table 의 값까지 조회해서는 안되므로 view 를 따로 만들어서 권한을 부여한다. (view 쓰임새)
    grant select, update, delete on view_emp_3080 to orauser1;  
    -- Grant을(를) 성공했습니다.
    -- ▼▼▼▼
    -- stored view 를 쓰는 이유는 무엇인가?
    -- : 1. 복잡한 sql 문 간단하게, 2. 권한부여 시 (보안- 어떤 tbl 에 있는 모든 정보를 다 알게하기 위한 것은 위험함)   
    -- ex. 서울대 병원에서 해당 *tbl 값*의 정보를 다~~ 알려줄 수는 없음. 공개할 정보 행과 컬럼만 찍어서 *view 로 권한을 부여*해주는 것임.
    
    -- ▼ sys 가 local-orauser1 에 권한을 주기 위함.
    ---- **** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 시작 **** ----
    show user;
    -- USER이(가) "SYS"입니다.    
    
    grant create synonym to orauser1;
    -- Grant을(를) 성공했습니다.
    ---- **** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 종료 **** ----



    ---- **** ORAUSER1 에서 아래와 같은 작업을 한다. 시작 **** ----
    show user;
    -- USER이(가) "ORAUSER1"입니다.
        
    select *
    from hr.view_emp_3080;
    
    select *
    from emp;   -- view_emp_3080 == emp (Synonym)
    
    --- *** 생성된 시노님(동의어, Synonym) 을 조회해본다.
    select *
    from user_synonyms;
    
    /*
    ---------------------------------------------------
    SYNONYM_NAME   TABLE_OWNER   TABLE_NAME     DB_LINK
    ---------------------------------------------------
    EMP	           HR	         VIEW_EMP_3080	(null)
    --> 원래 이름은 HR.VIEW_EMP_3080 이고 Synonym 은 EMP 이다. 
    */
    ---- **** ORAUSER1 에서 아래와 같은 작업을 한다. 종료 **** ----


    
    ---- **** HR 또는 SYSTEM 에서 아래와 같은 작업을 한다. 시작 **** ----
    show user;
    -- USER이(가) "HR"입니다.      
    
    
    
   ----- **** ==== 시퀀스(Sequence) ==== **** ----- ★★★★★ 자주쓰인다. ★★★★★

   -- 시퀀스(sequence)란? 쉽게 생각하면 은행에서 발급해주는 대기번호표 와 비슷한 것이다.
   -- 시퀀스(sequence)는 숫자로 이루어져 있으며 매번 정해진 증가치 만큼 숫자가 증가되는 것이다.    
   
   /*
     create sequence seq_yeyakno   -- seq_yeyakno 은 시퀀스(sequence) 이름이다.
     start with 1    -- 첫번째 출발은 1 부터 한다.
     increment by 1  -- 증가치 값    2 3 4 5 ......
     maxvalue 5      -- 최대값이 5 이다.
  -- nomaxvalue      -- 최대값이 없는 무제한. 계속 증가시키겠다는 말이다.
     minvalue 2      -- 최소값이 2 이다. cycle 이 있을때만 minvalue 에 주어진 값이 사용된다. 
                     --                nocycle 일 경우에는 minvalue 에 주어진 값이 사용되지 않는다.
                     -- minvalue 숫자 에 해당하는 숫자 값은 start with 숫자 에 해당하는 숫자 값과 같든지 
                     -- 아니면 start with 숫자 에 해당하는 숫자보다 작아야 한다.
                     
  -- nominvalue      -- 최소값이 없다.   
     cycle           -- 반복을 한다.
  -- nocycle         -- 반복이 없는 직진.
     nocache;
    */
    
    create sequence seq_yeyakno_1
    start with 1    -- 첫번째 출발은 1 부터 한다.
    increment by 1  -- 얼만큼 증가할 것인지 == 증가치 값. 즉 1씩 증가한다. ( i++ 과 비슷. )
    maxvalue 5      -- 최대값이 5 이다.
    minvalue 2      -- 최소값이 2 이다. (start with 보다 큰 값 X)
    cycle           -- 반복 한다.
    nocache;        -- 메모리에는 cache 를 올리지 마라. 
    /*
    (start with 보다 minvalue 가 큰 경우 오류 발생)
    오류 보고 -
    -- ORA-04006: START WITH cannot be less than MINVALUE
    -- start with > minvalue 여야 한다.    

    minvalue 숫자에 해당하는 숫자 값은 start wiht 숫자에 해당하는 숫자 값과 같든지 
    또는 start with 숫자에 해당하는 숫자보다 작아야 한다.
    */
    
    drop sequence seq_yeyakno_1;
    -- Sequence SEQ_YEYAKNO_1이(가) 삭제되었습니다.

        
    create sequence seq_yeyakno_1
    start with 2    -- 첫번째 출발은 2 부터 한다.
    increment by 1  -- 얼만큼 증가할 것인지 == 증가치 값. 즉 1씩 증가한다. ( i++ 과 비슷. )
    maxvalue 5      -- 최대값이 5 이다.
    minvalue 1      -- 최소값이 1 이다. (start with 보다 큰 값 X)
    cycle           -- 반복 한다.
    nocache;        -- 메모리에는 cache 를 올리지 마라. 
    -- 2 3 4 5(max) 1 2 3 4 5 cycle 만나고 minvalue 숫자를 사용한다. (start with 숫자 값으로 cycle 시작하는 것이 아니다.)
    -- 1 2 3 4 5 0 1 2 3 4 5 0 1 2 3 4 5 (start 가 1이고 minvalue 가 0 일 경우)
    -- Sequence SEQ_YEYAKNO_1이(가) 생성되었습니다.


    ----- *** 생성된 시퀀스(Sequence) 를 조회해봅니다. *** -----
    select * 
    from user_sequences;
    
    select last_number  -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다.
    from user_sequences
    where sequence_name = 'SEQ_YEYAKNO_1';    
    
    create table tbl_board_test_1
    (boardno         number     -- sequence 는 꼭 number 여야 한다.
    ,subject         varchar2(100)
    ,registerdate    date default sysdate
    );
    -- Table TBL_BOARD_TEST_1이(가) 생성되었습니다.

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'첫번째 글입니다.');  -- registerdate 는 default 값이므로 안넣어도 무방. (default 값이 나올 것이므로)
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 start 값이 2 였다. 

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'두번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'세번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'네번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
    -- seq_yeyakno_1 시퀀스의 maxvalue 값이 5 였고, cycle 이었다. 즉, 반복을 한다.
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'다섯번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
    -- seq_yeyakno_1 시퀀스의 minvalue 값이 2 이었고, cycle 이었으므로
    -- maxvalue 값이 사용된 다음에 들어오는 시퀀스 값은 minvalue 값인 1이 들어온다.
  
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'여섯번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'일곱번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
    
    select *
    from tbl_board_test_1;    
    
    rollback;
    -- 롤백 완료. (데이터 한 값을 insert 하지 않았을 때 사용 , commit 전에!)    
    -- 그러나 sequence 는 계속 되는 것이기 때문에 rollback 사용하지 않고, sequence 를 없앤 후에 다시 만들어야 한다.
    -- drop sequence seq_yeyakno_1;
    -- Sequence SEQ_YEYAKNO_1이(가) 삭제되었습니다.

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval,'여덟번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
      
    select *
    from tbl_board_test_1;  -- sequence 는 계속 소모되는 것이기 때문에, rollback 을 해도 그 전 숫자에 이어서 계속 증가한다.    

    /*
     seq_yeyakno_1 시퀀스값의 사용은 
     2(start)  3  4  5(maxvalue) 1(minvalue) 2 3 4 5(maxvalue) 1(minvalue) 2 3 4 5 1 2 3 ...... 
     와 같이 사용된다.
    */        

    commit;
    
    delete from tbl_board_test_1;
    
    create sequence seq_yeyakno_2
    start with 1    -- 첫번째 출발은 1 부터 한다.
    increment by 1  -- 얼만큼 증가할 것인지 == 증가치 값. 즉 1씩 증가한다. ( i++ 과 비슷. )
    nomaxvalue      -- 최대값이 없는 무제한 (계속 증가시키겠다는 말이다.)
    nominvalue      -- 최소값이 없다.  (start with 보다 큰 값 X)
    nocycle         -- 반복을 안한다.
    nocache;         
    -- Sequence SEQ_YEYAKNO_2이(가) 생성되었습니다.
    
    select * 
    from user_sequences;    
    
    create table tbl_board_test_2
    (boardno         number     -- sequence 는 꼭 number 여야 한다.
    ,subject         varchar2(100)
    ,registerdate    date default sysdate
    );
    -- Table TBL_BOARD_TEST_2이(가) 생성되었습니다.

    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'첫번째 글입니다.');  -- registerdate 는 default 값이므로 안넣어도 무방. (default 값이 나올 것이므로)

    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'두번째 글입니다.');  

    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'세번째 글입니다.');  

    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'네번째 글입니다.');  
    
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'다섯번째 글입니다.');  
      
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'여섯번째 글입니다.');  

    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'일곱번째 글입니다.');  
    
    select *
    from tbl_board_test_2;    
    
    rollback;
    -- 롤백 완료. (데이터 한 값을 insert 하지 않았을 때 사용 , commit 전에!)    
    -- 그러나 sequence 는 계속 되는 것이기 때문에 rollback 사용하지 않고, sequence 를 없앤 후에 다시 만들어야 한다.
    -- drop sequence seq_yeyakno_1;
    -- Sequence SEQ_YEYAKNO_1이(가) 삭제되었습니다.

    -- *** 다음번에 들어올 seq_yeyakno_2 시퀀스의 값이 얼마가 들어오는지 알고 싶다. *** --
    select last_number  -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다. 여기서는 8임. (테이블의 boardno 가 last_number로 시작한다.)
    from user_sequences
    where sequence_name = 'SEQ_YEYAKNO_2';    
      
    

    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'여덟번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_2 시퀀스의 increment 값이 1 이었다. 
      
    select *
    from tbl_board_test_2;    
    
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval,'아홉번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_2 시퀀스의 increment 값이 1 이었다. 
    
    select *
    from tbl_board_test_2;    

    -- *** 시퀀스 SEQ_YEYAKNO_2 가 마지막으로 사용된 값을 알아보려고 한다. *** --   
    select seq_yeyakno_2.currval
    from dual;     -- 현재 쓰인 것 : 9 (아홉번째 글입니다.)
        
    -- *** 다음번에 들어올 seq_yeyakno_2 시퀀스의 값이 얼마가 들어오는지 알고 싶다. *** --
    select last_number  -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다. 
    from user_sequences
    where sequence_name = 'SEQ_YEYAKNO_2'; -- 10
    
    --- *** 시퀀스(sequence) 삭제하기 *** ---
    drop sequence seq_yeyakno_2;
    -- Sequence SEQ_YEYAKNO_2이(가) 삭제되었습니다.

    ----- *** 생성된 시퀀스(Sequence) 를 조회해봅니다. *** -----
    select * 
    from user_sequences;
    
    
    ------------- ★★★★★ !!!!!!! 매우 중요하다 !!!!!!! ★★★★★  -------------------
    --------------------------------------------------------------------------------
    -- **** Constraint(제약조건) 을 사용하여 테이블을 생성해 보겠습니다. **** --
    
    /*
    >>>> 제약조건(Constraint)의 종류 <<<<
    
    -- *제약조건의 이름*은 오라클 전체에서 고유해야 한다.
    -- 제약조건의 이름은 30 bytes 이내여야 한다.
    
    1. Primary Key(기본키, 대표식별자) 제약 [P]    -- 하나의 테이블당 오로지 *1개만 생성*할 수 있다.
                                               -- 어떤 컬럼에 Primary Key(기본키) 제약을 주면 그 컬럼에는 자동적으로 NOT NULL 이 주어지면서 동시에 그 컬럼에는 중복된 값은 들어올 수 없고 *오로지 고유한 값만* 들어오게 되어진다.
                                               -- 컬럼 1개를 가지고 생성된 Primary Key 를 *Single Primary Key* 라고 부르고,
                                               -- 컬럼 2개 이상을 가지고 생성된 Primary Key 를 *Composite(복합) Primary Key* 라고 부른다. 
                                                  (★ Composite primary key () 안에 순서를 틀리면 안된다. 순서를 그대로 유지해야한다 .!!! ★★★★)
        
    2. Unique 제약 [U]              -- 하나의 테이블당 여러개를 생성할 수 있다.                                 
                                   -- 어떤 컬럼에 Unique 제약을 주면 그 컬럼에는 NULL 을 허용할 수 있으며, 그 컬럼에는 중복된 값은 들어올 수 없고 오로지 고유한 값만 들어오게 되어진다.             
                                   -- Unique Key 중에 후보키, 후보식별자가 되려면 해당 컬럼은 NOT NULL 이어야 한다. 
    
    3. Foreign Key(외래키) 제약 [R]  -- 하나의 테이블당 여러개를 생성할 수 있다. 
                                   -- Foreign Key(외래키) 제약에 의해 참조(Reference)받는 컬럼은 반드시 NOT NULL 이어야 하고, 중복된 값을 허락하지 않는 고유한 값만 가지는 컬럼이어야 한다. 
                                 
    4. Check 제약 [C]               -- 하나의 테이블당 여러개를 생성할 수 있다.
                                   -- insert(입력) 또는 update(수정) 시 어떤 컬럼에 입력되거나 수정되는 데이터값을 아무거나 허락하는 것이 아니라 *조건에 맞는 데이터값만 넣고자 할 경우*에 사용되는 것이다.
    
    5. NOT NULL 제약 [C]            -- 하나의 테이블당 여러개를 생성할 수 있다.
                                   -- 특정 컬럼에 NOT NULL 제약을 주면 그 컬럼에는 반드시 데이터값을 주어야 한다는 말이다. 
    */ 
    
    ---- >>> Primary Key(기본키, 대표식별자) 제약에 대해서 알아봅시다. <<< ----
    
    ---- *** "고객" 이라는 테이블을 생성해 보겠습니다. *** ----
    -- // ROW Level // 주로 사용하는 것을 추천 (DB 유지보수를 위해)
    create table tbl_gogek
    (gogekID    varchar2(30) primary key -- COLUMN Level 제약조건    -- ID는 null 값 , 중복 X (not null & 고유값 이어야 한다.) (Primary Key(기본키) 제약을 주면 그 컬럼에는 자동적으로 NOT NULL)
    ,gogekName  varchar2(30)
    ,gogekPhone varchar2(30)
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    drop table tbl_gogek purge;
    -- Table TBL_GOGEK이(가) 삭제되었습니다.
    
    create table tbl_gogek
    (gogekID    varchar2(30) 
    ,gogekName  varchar2(30)
    ,gogekPhone varchar2(30)
    ,constraint tbl_gogek_gogekId_PK primary key(gogekID)   -- Row Level 제약조건 (유지보수를 위해 이렇게 사용한다.) ★ 권장 
    );                                                      -- Single Primary Key (컬럼 1개에 PK)
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    desc tbl_gogek;
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone) values(null, '이순신', null);
    -- ★오류 ORA-01400: cannot insert NULL into ("HR"."TBL_GOGEK"."GOGEKID") HR의 gogek 테이블의 gogekid 컬럼에 null 값을 insert 할 수 없다.!! (핸드폰은 null 값 가능)
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone) values('leess', '이순신', null);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone) values('leess', '이삼식', '010-1234-5678');
    /*  
    gogkeID 컬럼에 Primary key를 // Column Level // 제약조건으로 주었을 시,
    -- ★전 오류 ORA-00001: unique constraint (HR.SYS_C007043) violated   ( 아이디가 중복되었을 때 오류.!!) -- table 생성 시 gogekID 바로 옆에 PK를 설정했을 때 뜨는 오류 창.
    
    gogkeID 컬럼에 Primary key를 / Row Level // 제약조건으로 주었을 시,    
    -- ★현 오류 ORA-00001: unique constraint (HR.TBL_GOGEK_GOGEKID_PK) violated ▶ 오류 부분이 좀 더 명확하게 보인다.!!! (유지보수 시 편리)
    */  
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone) values('samsik', '이삼식', '010-1234-5678');
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone) values('soonshin', '이순신', null);
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    
    select *
    from tbl_gogek;
    
    --- *** tbl_gogek 에 생성된 제약조건을 조회해봅니다. *** ---
    select *
    from user_constraints
    where table_name = 'TBL_GOGEK'; -- 컬럼네임이 대문자가 defalut.  
    -- gogekID 컬럼에 PK를 주었구나 를 알 수 있음.!!(Primary Key) & 제약조건의 이름을 잘 부여하자.
    
    --- *** tbl_gogek 에 생성된 제약조건을 조회해 보는데 어떤 컬럼에 생성되어 있는지 보겠습니다. *** ---
    select *
    from user_cons_columns
    where table_name = 'TBL_GOGEK';
    -- 컬럼명 & 제약조건이름(CONSTRAINT_NAME) 모두 조회가 된다. -- 고객 ID 컬럼에는 CONSTRAINT_NAME의 제약조건이 걸려있다.
    
    --- *** 일반적으로 제약조건을 조회할 경우에는 JOIN 을 통해서 조회합니다. *** ---
    select *
    from user_constraints A JOIN user_cons_columns B
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- 컬럼네임이 대문자가 defalut.   -- JOIN 조건절은 WHERE 대신 ON
    where A.table_name = 'TBL_GOGEK';     
    
    create table tbl_jumun    
    (gogekID      varchar2(30)
    ,productCode  varchar2(30)
    ,productName  varchar2(30)
    ,jumunSu      number
    ,jumunDate    date default sysdate
    ,constraint tbl_jumun_gogekID_PK primary key(gogekID)           -- PK1
    ,constraint tbl_jumun_productCode_PK primary key(productCode)   -- PK2
    );
    -- ★오류★ ORA-02260: table can have only one primary key (primary key 는 하나의 테이블당 오로지 *1개만 생성*할 수 있다.)
    
    create table tbl_jumun    
    (gogekID      varchar2(30)
    ,productCode  varchar2(30)
    ,productName  varchar2(30)
    ,jumunSu      number
    ,jumunDate    date default sysdate
    ,constraint tbl_jumun_PK primary key(gogekID, productCode)  -- 두개의 컬럼을 묶어서 1개의 PK 를 만드는 것. (결론적으로 PK 가 2개가 아님.)           
    );                                                          -- Composite(복합) Primary Key : 컬럼 2개 이상을 가지고 생성된 Primary Key 
    -- Table TBL_JUMUN이(가) 생성되었습니다.
    
    desc tbl_jumun    
    /*
        이름       널?        유형           
    ----------- -------- ------------ 
    GOGEKID     NOT NULL VARCHAR2(30) 
    PRODUCTCODE NOT NULL VARCHAR2(30) 
    PRODUCTNAME          VARCHAR2(30) 
    JUMUNSU              NUMBER       
    JUMUNDATE            DATE 
    */
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('leess','swk','새우깡',10);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('leess','kjk','감자깡',20);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('samsik','swk','새우깡',10);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('leess','swk','새우깡',50);
    -- ★오류 ORA-00001: unique constraint (HR.TBL_JUMUN_PK) violated
    -- 중복이 발생하면 안된다. (여기서는 (leess, swk)이 중복)    
    
    commit;
    -- 커밋 완료.
    
    drop table tbl_jumun purge;
    -- Table TBL_JUMUN이(가) 삭제되었습니다.
    
    create table tbl_jumun    
    (gogekID      varchar2(30)
    ,productCode  varchar2(30)
    ,productName  varchar2(30)
    ,jumunSu      number
    ,jumunDate    date default sysdate
    ,constraint tbl_jumun_PK primary key(gogekID, productCode, jumundate)  -- Composite(복합) Primary Key : 컬럼 2개 이상을 가지고 생성된 Primary Key 
    );                                                                     -- ★ Composite primary key () 안에 순서를 틀리면 안된다. 순서를 그대로 유지해야한다 .!!! ★★★★
    -- Table TBL_JUMUN이(가) 생성되었습니다.
    
    desc tbl_jumun    
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('leess','swk','새우깡',10);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('leess','kjk','감자깡',20);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('samsik','swk','새우깡',10);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunSu)       -- jumunDate 는 default 값이 sysdate 이므로 쓰지 않아도 된다.
    values('leess','swk','새우깡',50);
    -- 1 행 이(가) 삽입되었습니다.
    -- constraint tbl_jumun_PK primary key(gogekID, productCode, jumundate) 했을 경우, 과거의 시간과 현재의 시간이 다르기 때문에 leess 가 swk 을 주문하는 것이 가능한 것이다. (중복 O)
    
    commit;
    
    select *
    from tbl_jumun;
    
    --- *** 일반적으로 제약조건을 조회할 경우에는 JOIN 을 통해서 조회합니다. *** ---
    -- Single Primary key
    select *
    from user_constraints A JOIN user_cons_columns B
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- 컬럼네임이 대문자가 defalut.   -- JOIN 조건절은 WHERE 대신 ON
    where A.table_name = 'TBL_GOGEK' and A.constraint_type = 'P';     
    -- TBL_GOGEK 테이블에 존재하는 Primary key 제약조건을 조회하고자 하는 것이다.
    -- Single Primary key
    
    -- 제약을 3개에 걸어놨기 때문에 행이 3개가 나오게 될 것이다. ▼
    -- Composite(복합) Primary key
    select *
    from user_constraints A JOIN user_cons_columns B
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- 컬럼네임이 대문자가 defalut.   -- JOIN 조건절은 WHERE 대신 ON
    where A.table_name = 'TBL_JUMUN' and A.constraint_type = 'P';     
    -- TBL_JUMUN 테이블에 존재하는 Primary key 제약조건을 조회하고자 하는 것이다.
    -- Composite(복합) Primary key
    
        
    ---- >>> Unique Key(후보키, 후보식별자) 제약에 대해서 알아봅시다. <<< ----
    --   Unique Key 중에 후보키, 후보식별자가 되려면 해당 컬럼은 NOT NULL 이어야 한다.
    --   아래의 예제에서는 gogekEmail 컬럼이 후보키, 후보식별자가 된다.
    
    ---- *** "고객" 이라는 테이블을 생성해 보겠습니다. *** ----
    drop table tbl_gogek purge;
    -- Table TBL_GOGEK이(가) 삭제되었습니다.
    
    create table tbl_gogek
    (gogekID    varchar2(30) 
    ,gogekName  varchar2(30) not null
    ,gogekPhone varchar2(30) -- null ==> null 을 허용함
    ,gogekEmail varchar2(50) not null                        -- email 은 null 이 되면 안된다. == 반드시 입력해야 한다.
    ,constraint PK_tbl_gogek_gogekID primary key(gogekID)    -- ID 를 잊어버렸을 때, 이메일 or 휴대폰 번호를 물어봄. (email, phone 둘다 고유값이어야 함.)
    ,constraint UQ_tbl_gogek_gogekPhone unique(gogekPhone)   -- gogekPhone 컬럼에 unique 제약을 준것이다.
    ,constraint UQ_tbl_gogek_gogekEmail unique(gogekEmail)   -- gogekEmail 컬럼에 unique 제약을 준것이다. // Primary 는 1개 밖에 안되지만, Unique 는 한개의 테이블에 여러개 생성이 가능하다.
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    desc tbl_gogek;
    /*  
    이름         널?       유형           
    ---------- -------- ------------ 
    GOGEKID    NOT NULL VARCHAR2(30) ▶ PK 이기 때문에 NOT NULL 이다.!!
    GOGEKNAME  NOT NULL VARCHAR2(30) 
    GOGEKPHONE          VARCHAR2(30) ▶ phone 은 NULL 값이 가능하면서 UNIQUE 이다. (그러나 중복은 X // NULL 여러번 중복은 o) ※MS-SQL 에서는 컬럼의 unique를 주었을 때, NULL 도 중복이 안된다...
    GOGEKEMAIL NOT NULL VARCHAR2(50)    
    */  
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('leess', '이순신', '010-1234-5678', 'leess@gmail.com');
    -- 1 행 이(가) 삽입되었습니다.     
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('eomjh', '엄정화', null, 'eomjh@gmail.com');
    -- 1 행 이(가) 삽입되었습니다.     
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('youks', '유관순', null, 'youks@gmail.com');
    -- 1 행 이(가) 삽입되었습니다.     
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('seokj', '서강준', '010-1234-5678', 'seokj@gmail.com');
    -- ★ 오류 : ORA-00001: unique constraint (HR.UQ_TBL_GOGEK_GOGEKPHONE) violated ▶▶ 휴대폰번호가 이순신과 중복됨. (NULL 값은 가능하지만, 이미 쓰고있는 번호라면 사용 불가)
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('seokj', '서강준', '010-3567-5678', 'eomjh@gmail.com');
    -- ★ 오류 : ORA-00001: unique constraint (HR.UQ_TBL_GOGEK_GOGEKEMAIL) violated ▶▶ 이메일도 Unique 해야 한다.!!!
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('seokj', '서강준', '010-3567-5678', 'seokj@gmail.com');
    -- 1 행 이(가) 삽입되었습니다.     
    
    insert into tbl_gogek(gogekID, gogekName, gogekPhone, gogekEmail) 
    values('leehr', '이혜리', '010-8754-7653', null);
    -- ★ 오류 : ORA-01400: cannot insert NULL into ("HR"."TBL_GOGEK"."GOGEKEMAIL")
    -- 이메일은 반드시 입력해야 한다.!!!
    
    commit;
    -- 커밋 완료.
    
    select *
    from tbl_gogek;    
    
    
    --- *** Composite(복합) Unique Key 예제 *** ---       
    create table tbl_jumun_2    
    (gogekID      varchar2(30) not null
    ,productCode  varchar2(30) not null
    ,productName  varchar2(30) not null
    ,jumunSu      number
    ,jumunDate    date default sysdate not null
    ,constraint UQ_tbl_jumun_2 unique(gogekID, productCode, jumundate)  
                                    -- Composite(복합) Unique Key (3개 묶어서 고유해야함)
    );                              -- ★ Composite primary key () 안에 순서를 틀리면 안된다. 순서를 그대로 유지해야한다 .!!! ★★★★
    -- Table TBL_JUMUN_2이(가) 생성되었습니다.

    desc TBL_JUMUN_2;
/*    
    이름          널?       유형           
    ----------- -------- ------------ 
    GOGEKID     NOT NULL VARCHAR2(30) 
    PRODUCTCODE NOT NULL VARCHAR2(30) 
    PRODUCTNAME NOT NULL VARCHAR2(30) 
    JUMUNSU              NUMBER       
    JUMUNDATE   NOT NULL DATE         
*/

    --- *** 일반적으로 제약조건을 조회할 경우에는 JOIN 을 통해서 조회합니다. *** ---
    -- Single Unique key
    select *
    from user_constraints A JOIN user_cons_columns B
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- 컬럼네임이 대문자가 defalut.   -- JOIN 조건절은 WHERE 대신 ON
    where A.table_name = 'TBL_GOGEK' and A.constraint_type = 'U';     
    -- TBL_GOGEK 테이블에 존재하는 Unique key 제약조건을 조회하고자 하는 것이다.
    -- Unique key
    -- Single Unique key 
    
    select *
    from user_constraints A JOIN user_cons_columns B
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- 컬럼네임이 대문자가 defalut.   -- JOIN 조건절은 WHERE 대신 ON
    where A.table_name = 'TBL_JUMUN_2' and A.constraint_type = 'U';     
    -- TBL_JUMUN_2 테이블에 존재하는 Unique key 제약조건을 조회하고자 하는 것이다.
    -- Unique key
    -- Composite(복합) Unique key 
  
    
    
    ---- >>> CHECK 제약에 대해서 알아봅시다. <<< ----
    -- CHECK : *검사* 한다.!! 
    -- insert(입력) 또는 update(수정) 시 어떤 컬럼에 입력되거나 수정되는 데이터값을 아무거나 허락하는 것이 아니라 *조건에 맞는 데이터값만 넣고자 할 경우*에 사용되는 것이다.
    -- 위에 컬럼명 쓰고, 제약줄 컬럼에 대해서 아래에 constraint 추가를 통해서 테이블을 만들어 나간다.
    create table tbl_sawon
    (sano       number                      -- 사원번호
    ,saname     varchar2(20) not null       -- 사원명
    ,salary     number(5) not null          -- 급여는 commission 보다 커야한다.
    ,commission number(5)                   -- commission 은 최소 0 이상이어야 한다.
    ,jik        varchar2(20) default '사원'  -- 직급에 대한 종류를 잡아주어야 한다. ▶직급의 종류는 '사장','부장','차장','과장','대리','사원' 만 가능하다. (이외의 값이 들어올 수 없다.)
    ,email      varchar2(50) not null       -- 후보키 (Unique) 이므로 not null! (사원no 까먹으면 email 통해서 찾아야 함. (대체키))
    ,hire_date  date default sysdate        -- 입사일자
    
    ,constraint PK_tbl_sawon_sano primary key(sano)
    ,constraint CK_tbl_sawon_salary_commission check( commission >=0 and salary > commission )  -- check 제약(CK) (조건을 통해 check 해야한다.)
    ,constraint CK_tbl_sawon_jik check( jik in( '사장','부장','차장','과장','대리','사원') ) 
    ,constraint UQ_tbl_sawon_email unique(email)    --  후보키(UNIQUE)    
    );
    -- Table TBL_SAWON이(가) 생성되었습니다.    
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 1000, '과장', 'hongkd@naver.com');
    -- ★오류 ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
    -- salary 가 commi 보다 작으면 안됨
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, -1000, '과장', 'hongkd@naver.com');    
    -- ★오류 ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
    -- commi 가 - 면 안됨.

    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 100, '장군', 'hongkd@naver.com');      
    -- ★오류 ORA-02290: check constraint (HR.CK_TBL_SAWON_JIK) violated
    -- 직급에 장군은 없음.
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 100, '과장', 'hongkd@naver.com');        
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select *
    from tbl_sawon;    
    
    
    ---- >>> Foreign Key(외래키, 참조키 Reference Key(R)) 제약에 대해서 알아봅시다. <<< ----
    
    --- *** 고객들의 예약을 받아주는 "예약" 테이블을 생성해보겠습니다. *** ---
    select *
    from tbl_gogek;
    
    desc tbl_gogek
    
    select A.CONSTRAINT_NAME, A.CONSTRAINT_type, A.search_condition,
           B.column_name, B.position                                             -- gogek 테이블의 제약조건을 조회
    from user_constraints A JOIN user_cons_columns B
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME        
    where A.table_name = 'TBL_GOGEK';         
    
    --- 어떤 한명의 고객은(예: leess  이순신) 예약을 1번도 안 할 수도 있고,
    --- 예약을 딱 1번만 할 수 있고, 예약을 여러번 할 수도 있다.  
    drop table tbl_yeyak purge;
    
    select * 
    from tbl_yeyak    
    
    create table tbl_yeyak
    (yeyakno       number       --> 예약번호. 예약번호의 값은 NOT NULL 이면서 고유한 값만 가져야 한다.
                                --> 그러므로 yeyakno 컬럼에는 primary key 제약을 주어야 한다. (예약no 가 중복되면 안됨.!!)
                                /*
                                    예약번호는 사용자가 수동적으로 입력치 않고 자동적으로 들어와야 한다.
                                    그리고 예약번호는 매번 그 숫자가 증가되면서 고유해야 한다.
                                    이렇게 되려면 ★sequence★ 를 사용하면 된다.
                                */
    ,FK_gogekID    varchar2(30) not null --> gogek 테이블에서 gogekID 를 참조한다.(foreign key)   -- gogek 테이블 desc 한 뒤 유형(varchar(30))을 똑같이 맞춰준다.
                                         -- 고객아이디 
                                         -- FK_gogekID 컬럼에 들어올 수 있는 값은 tbl_gogek 테이블의 gogekId 컬럼의 값만 들어와야 한다. 
                                         -- 참조를 받는 컬럼은 (여기서는 tbl_gogek 테이블의 gogekid 임) 반드시 고유한 값을 가지는 컬럼이어야 한다.
                                         -- 즉, 참조를 받는 컬럼은 (여기서는 tbl_gogek 테이블의 gogekid 임) *Primary Key 또는 Unique 제약*을 가져야 한다.   
                                         
    ,ticketCnt     number(2) not null    -- 예약티켓개수   
                                         -- 데이터 타입이 number(2) 이므로 -99 ~ 99 값들이 들어온다.
                                         -- 그런데 예약티켓개수는 1번 예약에 최대 10개 까지만 허락하고자 한다.
                                         -- 즉, ticketCnt 컬럼에 들어오는 값은 1 ~ 10 까지만 가능하도록 해야 한다.
                                         -- 이러한 경우 값을 검사해야 하므로 Check 제약을 사용하면 된다.    
    ,registerDay  date default sysdate
    
    ,constraint PK_tbl_yeyak_yeyakno primary key(yeyakno)           --> 해당 column 에 대해 primary key를 주겠다.
    ,constraint FK_tbl_yeyak_FK_gogekID foreign key(FK_gogekID) references tbl_gogek(gogekID)    --> 이 컬럼(FK_gogekID) 은 foreign 키에 해당한다. (Reference) // references 로 's' 까지 꼭 붙인다!!
    /*
      tbl_yeyak 테이블의 fk_gogekID 컬럼에는 foreign key 제약을 만들었는데
      그 뜻은 tbl_yeyak 테이블의 fk_gogekID 컬럼에 입력되거나 수정되어지는 값은 반드시 tbl_gogek 테이블의 gogekID 컬럼에 존재하는 값들만 가능하다는 말이다.
      즉, tbl_gogek 테이블의 gogekid 컬럼에 존재하지 않는 값은 tbl_yeyak 테이블의 fk_gogekID 컬럼에 들어올 수 없다는 말이다.
      그리고 중요한 것은 tbl_gogek 의 gogekid 컬럼은 식별자 컬럼(Primary Key, Unique Key)이어야 한다. 
   */
    ,constraint CK_tbl_yeyak_ticketCnt check( 1 <= ticketCnt and ticketCnt <= 10 )
    );
    -- Table TBL_YEYAK이(가) 생성되었습니다.

    create sequence seq_tbl_yeyak
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    -- Sequence SEQ_TBL_YEYAK이(가) 생성되었습니다.

    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt) values(seq_tbl_yeyak.nextval, 'leess', 5);
    -- 1 행 이(가) 삽입되었습니다.
        
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt) values(seq_tbl_yeyak.nextval, 'superman', 5);
    -- 오류 ★ ORA-02291: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - parent key not found
    -- foreign key 에 위배 된다. (gogekID(parent) 에는 superman 이라는 ID 가 없었다.) // parent key : 참조 받는 테이블(부모테이블,parent table) : 예약테이블(자식)이 고객테이블(부모-parent)을 참조함.    
        
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt) values(seq_tbl_yeyak.nextval, 'eomjh', 3);
    -- 1 행 이(가) 삽입되었습니다.

    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt) values(seq_tbl_yeyak.nextval, 'eomjh', 20);
    -- ★ 오류 ORA-02290: check constraint (HR.CK_TBL_YEYAK_TICKETCNT) violated
    -- check 제약에 걸림. ticketCnt는 10번까지만 가능.
        
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt) values(seq_tbl_yeyak.nextval, 'eomjh', 10);
    -- 1 행 이(가) 삽입되었습니다.
   
    commit;
    -- 커밋 완료.
    
    select *
    from tbl_yeyak
    -- 그러나, yeyakno 가 1,3,5로 나오는데 중간에 잘못 넣었던 2,4번째 행까지(실패행) sequence로 값이 세어지기 때문이다.
    
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt) values(seq_tbl_yeyak.nextval, 'eomjh', 7);
    -- 1 행 이(가) 삽입되었습니다.
  
    commit;
    -- 커밋 완료.
    
    
    ---- **** foreign key 제약이 있는 테이블을 "자식" 테이블 이라고 하고, 
    ----      foreign key 에 의해 참조를 받는 테이블을 "부모" 테이블(parent) 이라고 한다. **** ----
    
    --- "자식" 테이블(여기서는 tbl_yeyak 테이블)에 입력된 데이터가 "부모" 테이블(여기서는 tbl_gogek)에 존재하는 경우에
    --- "부모" 테이블의 행을 삭제할 때 어떻게 되는지 알아봅니다.
    select *
    from tbl_yeyak; -- "자식" 테이블
        
/*    
    ------------------------------------------------------
    yeyakno   fk_gogekid   ticketcnt   registerday
    ------------------------------------------------------
    1	        leess	    5	        22/01/17
    3	        eomjh	    3	        22/01/17
    5	        eomjh	    10	        22/01/17
    6	        eomjh	    7	        22/01/17
*/    
    select *
    from tbl_gogek; -- "부모" 테이블
/*    
    --------------------------------------------------
    gogekid   gogekname   gogekphone       gogekemail
    --------------------------------------------------
    leess	   이순신	    010-1234-5678	leess@gmail.com
    eomjh	   엄정화		                eomjh@gmail.com
    youks	   유관순		                youks@gmail.com
    seokj	   서강준	    010-3567-5678	seokj@gmail.com    
*/    
      
    delete from tbl_gogek
    where gogekID = 'seokj';
    -- 1 행 이(가) 삭제되었습니다.

/*    
    --------------------------------------------------
    gogekid   gogekname   gogekphone       gogekemail
    --------------------------------------------------
    leess	   이순신	    010-1234-5678	leess@gmail.com
    eomjh	   엄정화		                eomjh@gmail.com
    youks	   유관순		                youks@gmail.com
*/    

    delete from tbl_gogek
    where gogekID = 'leess';
    -- ★오류 ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found (이순신이 예약(자식테이블) 한 기록이 有) child record(자식'행')
    -- 예약 기록(yeyak,자식)이 남아있는데 고객(gogek,부모)을 삭제할 수 있다? (X , 불가능함 - 고객이 삭제됐는데 예약 기록이 남아있을 수가 없다..) // 서강준은 예약을 안했기 때문에 삭제해도 무방 ▶ TBL_YEYAK(자식테이블) 만 바꾸면 된다.
    -- child ==> 자식 테이블인 tbl_yeyak 을 말한다.
    -- child record found 말은 tbl_yeyak 테이블에 존재하는 1  leess	5 22/01/17 행을 말한다.
    
    
    
    --- [★★★중요★★★] tbl_gogek 테이블에 모든 행들을 삭제하려고 한다. (child record found 일 때)
    delete from tbl_gogek;  -- [부모]테이블 ▶ 누군가가 나를 참조(reference) 하고 있는 것이다. ( 자식테이블의 행이 나(부모)를 참조하고 있다! )
/*
     ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found (자식 테이블에 행이 존재한다.(foreign key 존재) ▶ 그래서 삭제를 못한다.)
     HR.FK_TBL_YEYAK_FK_GOGEKID 은 tbl_gogek 테이블의 자식테이블인 곳에서 Foreign Key 가 제약조건 이름으로 HR.FK_TBL_YEYAK_FK_GOGEKID 이 사용되고 있다.
     그러면 Foreign Key 가 제약조건 이름으로 HR.FK_TBL_YEYAK_FK_GOGEKID 을 사용하는 테이블명을 알아와야 한다.
*/
    
    --- *** Foreign Key 가 제약조건 이름으로 HR.FK_TBL_YEYAK_FK_GOGEKID 을 사용하는 테이블명 알아오기 *** ---
    select table_name
    from user_constraints
    where constraint_type = 'R' and constraint_name = 'FK_TBL_YEYAK_FK_GOGEKID';
    -- TBL_YEYAK        
        
        
    -- !!!!! [퀴즈] TBL_YEYAK 테이블에 존재하는 제약조건 중에 Foreign Key 제약조건을 조회하는데 아래와 같이 나오도록 하세요.. !!!!!
    ----------------------------------------------------------------------------------------------------------
           제약조건명               제약조건타입       컬럼명          참조를받는부모테이블명       참조를받는식별자컬럼명
    ----------------------------------------------------------------------------------------------------------
      FK_TBL_YEYAK_FK_GOGEKID         R         FK_GOGEKID          TBL_GOGEK                 GOGEKID    

    select constraint_name, constraint_type, r_constraint_name
    from user_constraints
    where table_name = 'TBL_YEYAK' and constraint_type ='R';
    -- 오류 고침.. ▶ constraint_type 을 constraint_name 으로 쓰고 있어서 계속 안나왔다..^^;;    
    -- ▼결과
/*    
    ------------------------------------------------------------------
    constraint_name         constraint_type    r_constraint_name
    ------------------------------------------------------------------  
    FK_TBL_YEYAK_FK_GOGEKID       R            PK TBL GOGEK COGEKID

*/    
    select constraint_name, column_name    
    from user_cons_columns
    where table_name = 'TBL_YEYAK';
    -- ▼결과
/*
    ---------------------------------------------------
    constraint_name             column_name
    ---------------------------------------------------
    SYS_C007076	                FK_GOGEKID
    SYS_C007077	                TICKETCNT
    CK_TBL_YEYAK_TICKETCNT  	TICKETCNT
    PK_TBL_YEYAK_YEYAKNO	    YEYAKNO
    FK_TBL_YEYAK_FK_GOGEKID	    FK_GOGEKID
*/
    select constraint_name, table_name, column_name
    from user_cons_columns
    where constraint_name = ( select r_constraint_name
                              from user_constraints
                              where table_name = 'TBL_YEYAK' and constraint_type ='R');
    -- ▼결과                          
/*
    ----------------------------------------------------
    CONSTRAINT_NAME       TABLE_NAME  COLUMN_NAME
    ----------------------------------------------------
    PK_TBL_GOGEK_GOGEKID  TBL_GOGEK	  GOGEKID      
*/  

    -- 겹치는 것 끼리 JOIN 한다.
    with 
    A as
    (
    select constraint_name, constraint_type, r_constraint_name
    from user_constraints
    where table_name = 'TBL_YEYAK' and constraint_type ='R'  
    )
    ,
    B as
    (
    select constraint_name, column_name    
    from user_cons_columns
    where table_name = 'TBL_YEYAK' 
    )
    ,
    C as
    (
    select constraint_name, table_name, column_name
    from user_cons_columns
    where constraint_name = ( select r_constraint_name
                              from user_constraints
                              where table_name = 'TBL_YEYAK' and constraint_type ='R')
    )
    select A.constraint_name AS 제약조건명
         , A.constraint_type AS 제약조건타입
         , B.column_name AS 컬럼명
         , C.table_name AS 참조받는부모테이블
         , C.column_name AS 참조받는식별자컬럼
    from A JOIN B 
    ON A.constraint_name = B.constraint_name            -- WHERE 대신 ON
    JOIN C                                              -- A,B 먼저 JOIN 하고 (한개가 되어짐) ▶ 그 다음에 C JOIN 한다. (AB가 이미 한개로 묶어졌으니 A or B 어디에 묶여도 상관 없다.)
    ON A.r_constraint_name = C.constraint_name;
/*    
   ----------------------------------------------------------------------------------------
   제약조건명                    제약조건타입    컬럼명         참조받는부모테이블   참조받는식별자컬럼
   ----------------------------------------------------------------------------------------
   FK_TBL_YEYAK_FK_GOGEKID	       R	   FK_GOGEKID	    TBL_GOGEK	       GOGEKID
   
   -- yeyak 테이블은 r(참조) 해오는데, 컬럼명은 fk_gogekid 이고, 참조 해온 부모테이블은 gogek 테이블이며, 그 부모테이블의 컬럼이름은 gogekid 이다.
*/

    delete from tbl_gogek;  -- 부모 자식 관계를 끊어야 delete 가 가능하다. (FK 를 없애주자!)
    -- ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found (자식 테이블에 행이 존재한다.(foreign key 존재) ▶ 그래서 삭제를 못한다.)
    
    -- *** TBL_YEYAK 테이블에 존재하는 R(foreign key) 제약조건인 FK_TBL_YEYAK_FK_GOGEKID 을 삭제하겠습니다. (== 부모자식관계를 삭제하자.!!) *** --
    alter table TBL_YEYAK       -- TBL_YEYAK(자식테이블) 만 바꾸면 된다.
    drop constraint FK_TBL_YEYAK_FK_GOGEKID;
    -- Table TBL_YEYAK이(가) 변경되었습니다. (altar 는 DDL 이므로 auto commit 됨)    
    
    select * 
    from tbl_gogek;
   
    delete from tbl_gogek;
    -- 3개 행 이(가) 삭제되었습니다.   // 바로 위에서 alter 를 함으로써 부모자식 관계를 삭제했기 때문에 비로소 tbl_gogek 테이블이 delete 되었다.
    
    commit;
    -- 커밋 완료.
    
    
    ---- ★★★★★ 중요 ★★★★★ 
    -- ex1. 상품후기 : 상품이 존재 해야만 상품 후기가 나온다. // 상품후기쓰기는 상품의 자식테이블이 되는 것임. // ①상품(부모테이블) - ②상품후기쓰기(자식테이블)
    -- ex2. 초코파이 파는 곳에 새우깡 후기를 쓰면 안됨..
    -- ex3. 부모테이블 == 상품, 예약테이블 == 상품후기
    
    ---- **** ==== !!!! Foreign Key 생성시 on delete cascade 옵션을 주는 것 !!!! ==== **** ----    
    -- 가장 좋은 예시는 ★상품후기쓰기★

    create table tbl_sangpum    --> "상품" 테이블
    (sangpum_code   varchar(20)
    ,sangpum_name   varchar(20) not null
    ,price          number(10) not null
    ,constraint PK_tbl_sangpum_sangpum_code primary key(sangpum_code)
    );
    -- Table TBL_SANGPUM이(가) 생성되었습니다.   
    
    insert into tbl_sangpum(sangpum_code, sangpum_name, price) values('swk','새우깡',3000);
    insert into tbl_sangpum(sangpum_code, sangpum_name, price) values('kjk','감자깡',4000);
    insert into tbl_sangpum(sangpum_code, sangpum_name, price) values('ypr','양파링',5000);
    
    commit; 
    
    create table tbl_sangpum_review  --> "상품후기"테이블
    (review_no          number                      -- 후기글번호
    ,fk_sangpum_code    varchar2(20) not null       -- 후기를 남길 상품코드, 참조받는 애는 항상 not null 이면서 고유해야 한다.!! (여기서 상품코드는 primary key로 not null 이며 고유함)
    ,review_contents    Nvarchar2(2000) not null    -- 후기내용물 , Nvarchar2 는 max 2000, varchar2 는 max4000
    ,register_day       date default sysdate        -- 작성일자
    
    ,constraint PK_tbl_sangpum_review primary key(review_no)
    ,constraint FK_tbl_sangpum_review foreign key(fk_sangpum_code) references tbl_sangpum(sangpum_code) -- 상품테이블에서 상품코드컬럼을 참조해온다..
    );
    -- Table TBL_SANGPUM_REVIEW이(가) 생성되었습니다.

    insert into tbl_sangpum_review(review_no, fk_sangpum_code, review_contents) values(1,'swk','아주 맛있어요!!!');
    insert into tbl_sangpum_review(review_no, fk_sangpum_code, review_contents) values(2,'kjk','또 구매하겠습니다.');
    insert into tbl_sangpum_review(review_no, fk_sangpum_code, review_contents) values(3,'swk','빠른배송 감사합니다!');

    commit;
    -- 커밋 완료.
    
    select * 
    from tbl_sangpum_review;
        
    select * 
    from tbl_sangpum
    
    delete from tbl_sangpum     -- ypr 후기가 없을 경우 삭제 가능.
    where sangpum_code = 'ypr';
    -- 1 행 이(가) 삭제되었습니다.  ★ 후기가 없을경우 !! ★
    
    delete from tbl_sangpum -- ypr 후기가 없을 경우 삭제 가능.
    where sangpum_code = 'swk';    
    -- ★오류 ORA-02292: integrity constraint (HR.FK_TBL_SANGPUM_REVIEW) violated - child record found
    -- 새우깡은 후기가 있기 때문에 지워지지 않음.
    
    delete from tbl_sangpum_review      -- ① tbl_sangpum_review 리뷰 테이블(자식) 을 먼저 지우고 ▼▼▼▼
    where fk_sangpum_code = 'swk';
    -- 2 개 행 이(가) 삭제되었습니다.
    
    select * 
    from tbl_sangpum_review;    
    
    delete from tbl_sangpum             -- ② tbl_sangpum 상품 테이블(부모) 을 지우면 된다. (리뷰를 먼저 지워주고, 상품을 지워주는 순서)
    where sangpum_code = 'swk';   
    
    rollback;
    
    drop table tbl_sangpum_review purge;
    -- Table TBL_SANGPUM_REVIEW이(가) 삭제되었습니다.

    -- [Table tbl_sangpum_review_2] Foreign Key 생성시 제한 뒤에 on delete cascade 를 붙임
    -- ★on delete cascade★ 붙임으로써 리뷰가 남아있어 상품(부모)을 지우지 못했던 것이 이제 삭제가 가능함.
    -- FK 에서 ★on delete cascade★ : 부모테이블(상품테이블)에서 어떤 행을 지울 때, 먼저 자식테이블인 review 테이블에서 child record 를 지운다. ▶ 그래서 review 가 남아있어도 부모테이블 delete 가 되는것이다.
    
    create table tbl_sangpum_review_2  --> "상품후기"테이블
    (review_no          number                      -- 후기글번호
    ,fk_sangpum_code    varchar2(20) not null       -- 후기를 남길 상품코드, 참조받는 애는 항상 not null 이면서 고유해야 한다.!! (여기서 상품코드는 primary key로 not null 이며 고유함)
    ,review_contents    Nvarchar2(2000) not null    -- 후기내용물, Nvarchar2 는 max 2000, varchar2 는 max4000
    ,register_day       date default sysdate        -- 작성일자
    
    ,constraint PK_tbl_sangpum_review_2 primary key(review_no)        -- ★ 제약조건 이름도 고유해야 한다.!!
    ,constraint FK_tbl_sangpum_review_2 foreign key(fk_sangpum_code) references tbl_sangpum(sangpum_code) on delete cascade -- 상품테이블에서 상품코드컬럼을 참조해온다..
    /*
    on delete cascade 를 해주었으므로 부모테이블은 tbl_sangpum 테이블에서 행을 delete 를 할 때 먼저 자식테이블인 tbl_sangpum_review_2 테이블에서 자식레코드(행)를 먼저 delete 를 해준다.
    */
    );
    -- 상품이 사라지면 후기가 사라지도록 on delete cascade 을 달아주는 것이 편하다.!!
    -- 그러나 HR에서는 다름. 
    
    
    -- Table tbl_sangpum_review_2(가) 생성되었습니다.

    insert into tbl_sangpum_review_2(review_no, fk_sangpum_code, review_contents) values(1,'swk','아주 맛있어요!!!');
    insert into tbl_sangpum_review_2(review_no, fk_sangpum_code, review_contents) values(2,'kjk','또 구매하겠습니다.');
    insert into tbl_sangpum_review_2(review_no, fk_sangpum_code, review_contents) values(3,'swk','빠른배송 감사합니다!');

    commit;
    -- 커밋 완료.
    
    select * 
    from tbl_sangpum_review_2;
        
    select * 
    from tbl_sangpum
    
    delete from tbl_sangpum     -- ypr 후기가 없을 경우 삭제 가능.
    where sangpum_code = 'ypr';
    -- 1 행 이(가) 삭제되었습니다.  ★ 후기가 없을경우 !! ★
    
    commit; -- ypr(양파링) 날림
    
    delete from tbl_sangpum 
    where sangpum_code = 'swk';    
    -- ★오류 ORA-02292: integrity constraint (HR.FK_TBL_SANGPUM_REVIEW) violated - child record found
    -- 새우깡은 후기가 있기 때문에 지워지지 않음.
    
    delete from tbl_sangpum_review_2   -- 자식테이블  ① tbl_sangpum_review 리뷰 테이블(자식) 을 먼저 지우고 ▼▼▼▼
    where fk_sangpum_code = 'swk';
    -- 2 개 행 이(가) 삭제되었습니다.
    /*
    on delete cascade 를 해주었으므로 부모테이블은 tbl_sangpum 테이블에서 행을 delete 를 할 때 먼저 자식테이블인 tbl_sangpum_review_2 테이블에서 자식레코드(행)를 먼저 delete 를 해준다.
    ★ 즉, 아래의 DML 문이 자동적으로 실행된다.     
    delete from tbl_sangpum_review_2   
    where fk_sangpum_code = 'swk';
    -- 2 개 행 이(가) 삭제되었습니다.
    */
    -- ▼ 자동적으로 상품테이블에서 사라짐..
        
    select * 
    from tbl_sangpum_review_2; 
    
    select * 
    from tbl_sangpum;    
   
    rollback;    

    
    
    delete from tbl_sangpum            -- 부모테이블    ② tbl_sangpum 상품 테이블(부모) 을 지우면 된다. (리뷰를 먼저 지워주고, 상품을 지워주는 순서)
    where sangpum_code = 'swk';   
    -- 1 행 이(가) 삭제되었습니다.

    
    commit;
    
    -- 상품이 사라지면 후기가 사라지도록 on delete cascade 을 달아주는 것이 편하다.!!
    -- 그러나 HR에서는 다름. 
    
    select *
    from departments; 
    
    
    select *
    from employees;     
    -- 여기서 department_id 컬럼은 Foreign Key 로 사용됨.
    -- departments 테이블의 department_id 컬럼을 참조하는 foreign key로 사용된다.
    
    
    update employees set department_id = 500
    where employee_id = 100;    
    -- ORA-02291: integrity constraint (HR.EMP_DEPT_FK) violated - parent key not found
   
    delete from departments
    where department_id = 60;
    -- ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
    -- 부서만 통폐합 시키는데, on delete cascade 를 시키면서 그 부서에 속한 사람들을 짤리게 하면 안됨 . . .
    -- 부서 통폐합시 특정 부서가 delete 된다 하더라도 그 부서의 근무하는 사원들은 delete 가 되면 안된다.
    -- 그러므로 employees 테이블에서 department_id 컬럼에 foreign key 를 생성시 on delete cascade 옵션을 주면 안된다.
    
    [원글테이블]
    원글글번호   원글내용
    P.K
    
    [댓글테이블]
    댓글번호    F.K 원글글번호   댓글내용
    P.K          F.K(원글 삭제하면 댓글도 지워져야 하니까 on delete cascade 를 사용한다.)
    
 
    
    ---- **** ==== !!!! Foreign Key 생성시 on delete set null 옵션을 주는 것 !!!! ==== **** ---- (자식테이블을 먼저 null 로 설정한다. ▶ 이후에 부모테이블에서 수행)   
    
    create table tbl_buseo
    (buno       number(2)
    ,buname     varchar2(30) not null
    ,constraint PK_tbl_buseo_buno primary key(buno)
    );
    -- Table TBL_BUSEO이(가) 생성되었습니다.

    insert into tbl_buseo(buno, buname) values(10,'관리부');
    insert into tbl_buseo(buno, buname) values(20,'영업부');
    insert into tbl_buseo(buno, buname) values(30,'생산부');
    
    commit;
        
    drop table tbl_jikwon purge;
    -- Table TBL_JIKWON이(가) 삭제되었습니다.

    create table tbl_jikwon
    (jikwonno      number(5)
    ,name          varchar2(30) not null
    ,FK_buno       number(2) -- not null 을 주면 안된다. (not null 을 쓰게되면 구조조정을 할 수 없음. 어떤 사원이 부서에 근무하다가 그 부서가 사라지면, 그 부서를 null 로 하고 다른 부서로 가거나 해야한다.)
    ,constraint PK_tbl_jikwon_jikwonno primary key(jikwonno)
    ,constraint FK_tbl_jikwon_FK_buno  foreign key(FK_buno) references tbl_buseo(buno) on delete set null
    -- on delete set null 을 넣어주면 부모테이블인 tbl_buseo 테이블에서 특정 행을 delete 시, 
    -- 자식테이블인 tbl_jikwon 테이블에서 참조하던 행들의 fk_buno 컬럼의 값을 먼저 *null* 로 update 시킨다.
    -- 그런 다음에 부모테이블인 tbl_buseo 테이블에서 특정 행을 delete 해준다.    
    );
    -- Table TBL_JIKWON이(가) 생성되었습니다.
        


    insert into tbl_jikwon(jikwonno, name, FK_buno) values(1001, '이순신', 10);
    insert into tbl_jikwon(jikwonno, name, FK_buno) values(1002, '삼순신', 20);
    insert into tbl_jikwon(jikwonno, name, FK_buno) values(1003, '사순신', 20);
    insert into tbl_jikwon(jikwonno, name, FK_buno) values(1004, '오순신', 30);
    insert into tbl_jikwon(jikwonno, name, FK_buno) values(1005, '육순신', 30);
    
    commit;
    
    select *
    from tbl_buseo;
    
    select *
    from tbl_jikwon;
    
    delete from tbl_buseo
    where buno = 30;
    -- case ①
    -- 30번 buno 들이 null 값으로 바뀜. (Foreign Key 생성시 on delete set null 옵션을 줬을 때)
    -- case ② (fk 행을 not null & Foreign Key 생성시 on delete set null 옵션을 줬을때) ▶ 상충됨
    -- ORA-01407: cannot update ("HR"."TBL_JIKWON"."FK_BUNO") to NULL
    -- fk_buno 를 not null 로 설정했을 때 뜨는 오류. (컬럼 자체가 not null 인데 on delete set null 을 쓰면 null 로 바꾸는 과정을 거치게 된다. 이때 서로 상충되는 부분이 있으므로 *오류*
    
    rollback;
    
    commit;
    
  수정 ing~~  
    --------- >> NOT NULL 제약에 대해서 알아보겠습니다. <<< ---------
    -- 어떤 컬럼에 값을 입력하거나 수정할 때, NULL 을 허락하지 않는다는 말이다.

    drop table tbl_jikwon purge;
    -- Table TBL_JIKWON이(가) 삭제되었습니다.
    
    create table tbl_jikwon
    (sano         number 
    ,saname       varchar2(20) constraint NN_tbl_jikwon_saname not null -- NOT NULL 은 컬럼 다음에 적어주는 것이디 ROW LEVEL 은 없다.!! NN== NOT NULL
    ,salary       number(5) not null          -- 급여는 커미션 보다 커야 한다.
    ,commission   number(5)                   -- 커미션은 0 이상이어야 한다. 
    ,jik          varchar2(20) default '사원'  -- 직급의 종류는 '사장','부장','과장','대리','사원' 만 가능하다.
    ,email        varchar2(50) not null 
    ,hire_date    date default sysdate 
    ,constraint  PK_tbl_jikwon_sano  primary key(sano)
    ,constraint  UQ_tbl_jikwon_email unique(email)
    ,constraint  CK_tbl_jikwon_jik check( jik in('사장','부장','과장','대리','사원') )
    ,constraint  CK_tbl_jikwon_salaryCommission check( salary > commission and commission >= 0 )
    );
    -- Table TBL_JIKWON이(가) 생성되었습니다.
    
    insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 200, '부장', 'hongkd@gmail.com');
    
    insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
    values(1002, '엄정화', 600, 300, '과장', 'eomjh@gmail.com');
    
    insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
    values(1003, '이순신', 300, 100, '대리', 'leess@gmail.com');
    
    commit;
    
    select A.constraint_name, A.constraint_type, A.search_condition, 
         B.column_name, B.position 
    from user_constraints A join user_cons_columns B 
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_JIKWON';    
    
    --- *** [중요] Sub Query 를 사용하여 어떤 테이블을 생성할 경우 원본테이블에 존재하던 제약조건중 NOT NULL 제약만 복사가 되어지고 
    ---     나머지 제약조건은 복사가 안 됩니다.  또한 복사되는 NOT NULL 제약의 제약조건명은 SYS_C뭐뭐뭐로 변경되어집니다.    
    ---     백업(복사)본에 나머지 제약조건까지 다 복사를 해올 수 있어야 한다. !!!
    create table tbl_jikwon_copy
    as
    select *
    from tbl_jikwon;
    -- Table TBL_JIKWON_COPY이(가) 생성되었습니다.

    select *
    from tbl_jikwon_copy;

    -- ▼ 제약조건 조회 (CONSTRAINT_NAME)        
    select A.constraint_name, A.constraint_type, A.search_condition, 
         B.column_name, B.position 
    from user_constraints A join user_cons_columns B 
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_JIKWON_COPY';        ---  백업(복사)본에 NOT NULL 외에 나머지 제약조건까지 다 복사를 해올 수 있어야 한다. !!!



    ----- *** 어떤 테이블에 제약조건을 추가하기 *** -----
    /*
    * 30글자 MAXIMUM, 제약조건 이름은 고유해야 한다.
    제약조건 추가시 NOT NULL 제약을 제외한 나머지 4개 제약조건은 아래와 같이 한다.   (COPY한 TABLE에 4개 조약을 추가해주기 위함)
    
    alter table 테이블명 add constraint 제약조건명 primary key(컬럼명, 컬럼명2, ....);
    alter table 테이블명 add constraint 제약조건명 unique(컬럼명, 컬럼명2, ....);
    alter table 테이블명 add constraint 제약조건명 check (.....);        () 안에 check 할 것들 넣기.
    
    alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명, 컬럼명2, ....) references 부모테이블명(식별자컬럼명);
    alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명, 컬럼명2, ....) references 부모테이블명(식별자컬럼명) on delete cascade;
    alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명, 컬럼명2, ....) references 부모테이블명(식별자컬럼명) on delete set null;
    
    */
    
    /*
    NOT NULL 제약을 추가할 때는 아래와 같이 한다.
    
    alter table 테이블명 modify 컬럼명 not null;   --> 제약조건명이 SYS_C뭐뭐뭐
    
    alter table 테이블명 modify 컬럼명 제약조건명 not null;       
    */
    
    alter table TBL_JIKWON_COPY 
    add constraint PK_TBL_JIKWON_COPY_SANO primary key(SANO);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    alter table TBL_JIKWON_COPY 
    add constraint UQ_TBL_JIKWON_COPY_EMAIL unique(EMAIL);
   -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    alter table TBL_JIKWON_COPY 
    add constraint CK_TBL_JIKWON_COPY_JIK check ( jik in('사장','부장','과장','대리','사원') );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    alter table TBL_JIKWON_COPY 
    add constraint CK_TBL_JIKWON_COPY_SALCOMM check ( salary > commission and commission >= 0 );   
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.



    ---- *** 어떤 테이블에 ★제약조건을 삭제★하기 *** ----
    /*
      alter table 테이블명 drop constraint 제약조건명;
        
      그런데 *NOT NULL 제약*은 위의 것처럼 해도 되고, 또는 아래처럼 해도 된다.
      alter table 테이블명 modify 컬럼명 null;
        
      어떤 테이블에 *primary key 제약조건을 삭제*할 경우에는 위의 것처럼 해도 되고, 또는 아래처럼 해도 된다. (어차피 테이블당 primary key 는 1개니까!!!)
      alter table 테이블명 drop primary key;
    */
    
     -- ① TBL_JIKWON_COPY 테이블의 *CHECK 제약* CK_TBL_JIKWON_COPY_SALCOMM 삭제
     alter table TBL_JIKWON_COPY 
     drop constraint CK_TBL_JIKWON_COPY_SALCOMM;
     -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
     -- ② TBL_JIKWON_COPY 테이블의 SALARY 컬럼에 존재하는 NOT NULL 제약 삭제   
    /*            
     alter table TBL_JIKWON_COPY 
     drop constraint SYS_C007114;
    */
    -- 또는 
    alter table TBL_JIKWON_COPY 
    modify SALARY null;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    -- ③ TBL_JIKWON_COPY 테이블의 PRIMARY KEY 제약 삭제   
    /*
    alter table TBL_JIKWON_COPY 
    drop constraint PK_TBL_JIKWON_COPY_SANO;    
    */
    --또는    (어차피 테이블 당 Primary Key는 한개니까 굳이 PK_TBL_JIKWON_COPY_SANO를 쓰지 않고 drop primary key를 쓰는 것으로도 삭제됨.
    alter table TBL_JIKWON_COPY 
    drop primary key;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.


    select A.constraint_name, A.constraint_type, A.search_condition, 
         B.column_name, B.position 
    from user_constraints A join user_cons_columns B 
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_JIKWON_COPY';


    ---- *** 어떤 테이블에 생성되어진 제약조건의 내용을 변경하기 *** ----
    --->     기존 제약조건을 삭제하고나서 내용이 변경된 제약조건을 추가하는 것이다. 
    --->     *없애고 다시 만드는 방법(없애고 -> 추가)밖에 없다*
    
    --- TBL_JIKWON_COPY 테이블에 생성되어진 JIK 컬럼에 대한 check 제약의 내용을 변경하겠습니다.
    -- ① 먼저 drop 한다.   
    alter table TBL_JIKWON_COPY
    drop constraint CK_TBL_JIKWON_COPY_JIK;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    -- ② 그 다음 check 안의 내용 수정하고 add 한다.
    alter table TBL_JIKWON_COPY
    add constraint CK_TBL_JIKWON_COPY_JIK check( jik in('사장','이사','부장','과장','대리','사원') );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.


    ---- *** 어떤 테이블에 생성된 제약조건의 이름을 변경하기 *** ----
    /*
        alter table 테이블명
        rename constraint 현재사용중인제약조건명 to 새로운제약조건명;
    */
    
    alter table TBL_JIKWON_COPY
    rename constraint SYS_C007113 to NN_TBL_JIKWON_COPY_SANAME;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    
    ---- *** 어떤 테이블에 존재하는 제약조건을 비활성화 시키기 *** ----
    ---- 없애는 것이 아니라, 쓰지 않겠다는 의미
    /*
        alter table 테이블명 disable contraint 제약조건명;        
    */
    select constraint_name, constraint_type, search_condition, status
    from user_constraints
    where table_name = 'TBL_JIKWON_COPY';
    
    alter table TBL_JIKWON_COPY 
    disable constraint CK_TBL_JIKWON_COPY_JIK;        
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    -- CK_TBL_JIKWON_COPY_JIK 의 STATUS 가 DISABLED 로 변경됨. (비활성화됨)    

    ---- *** 어떤 테이블에 존재하는 제약조건을 활성화 시키기 *** ----
    /*
        alter table 테이블명 enable contraint 제약조건명;        
    */
    alter table TBL_JIKWON_COPY 
    enable constraint CK_TBL_JIKWON_COPY_JIK;        
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    -- CK_TBL_JIKWON_COPY_JIK 의 STATUS 가 DISABLED 에서 ENABLED 로 변경됨. (활성화됨)    
    
    
    select constraint_name, constraint_type, search_condition, status
    from user_constraints
    where table_name = 'TBL_JIKWON_COPY';

    /*
    --- *** TBL_JIKWON_COPY 테이블의 JUBUN 컬럼에 UNIQUE 제약 추가하기.
    
    alter table TBL_JIKWON_COPY 
    add constraint UQ_TBL_JIKWON_COPY_JUBUN unique(JUBUN);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    */

    ---- **** 어떤 테이블에 새로운 컬럼 추가하기 *** ----
    /*
    alter table 테이블명 add 추가할컬럼명 데이터타입;        
    */    
    desc TBL_JIKWON_COPY;
    
    alter table TBL_JIKWON_COPY 
    add JUBUN varchar2(13);         -- JUBUN '컬럼' 만 넣고, 값을 넣지 않음.(NULL)      
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    /*
    이름         널?       유형           
    ---------- -------- ------------ 
    JUBUN               VARCHAR2(13) 
    */    
    
    select *
    from TBL_JIKWON_COPY;  
    
    --- *** TBL_JIKWON_COPY 테이블의 JUBUN 컬럼에 NOT NULL 제약 추가하기. (Modify 이다.!!!)
    alter table TBL_JIKWON_COPY 
    modify JUBUN constraint NN_TBL_JIKWON_COPY_JUBUN NOT NULL;
    -- ★오류 ORA-02296: cannot enable (HR.NN_TBL_JIKWON_COPY_JUBUN) - null values found
    -- 왜냐하면 TBL_JIKWON_COPY 에 입력된 행들 중에 JUBUN 컬럼에 값이 NULL 인 것이 존재하기 때문이다. (처음에 컬럼을 추가하면서 아무런 값도 넣지 않았으므로..)
    -- 이때 NOT NULL 을 주고싶다면 ??? ▶ NULL 이 없게끔 만든다.
    
    update TBL_JIKWON_COPY set jubun = ' '       --(''는 null 이므로 주의할 것, '' != ' ')
    where jubun is null;
    -- 3개 행 이(가) 업데이트되었습니다.
    
    alter table TBL_JIKWON_COPY 
    modify JUBUN constraint NN_TBL_JIKWON_COPY_JUBUN NOT NULL;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.    -- JUBUN 의 NULL 을 ' ' 을 변경하고, UQ를 drop 한 뒤에 JUBUN 컬럼에 NOT NULL 제약 추가하기 



    ---- **** 어떤 테이블에 존재하는 컬럼 삭제하기 *** ----
    /*
        alter table 테이블명 drop column 삭제할컬럼명;
    */
    --- *** TBL_JIKWON_COPY 테이블에 존재하는 JUBUN 컬럼 삭제하기. ***
    alter table TBL_JIKWON_COPY 
    drop column JUBUN;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;

    select * 
    from TBL_JIKWON_COPY;
    
    ---- **** 어떤 테이블에 새로운 컬럼 추가하면서 NOT NULL 을 주고싶다. *** ----
    /*
    alter table 테이블명 add 추가할컬럼명 데이터타입 NOT NULL; 이 아니라.!!!        

    alter table 테이블명 add 추가할컬럼명 데이터타입 default 기본값 NOT NULL; 이다. ( 즉, 값이 없으면 default 가 들어간다는 뜻. == NULL 이 아니게됨.)        

    */        
    
    alter table TBL_JIKWON_COPY 
    add JUBUN VARCHAR2(13) NOT NULL; 
    /*
    오류 보고 -
    ORA-01758: table must be empty to add mandatory (NOT NULL) column
    들어갈 컬럼의 값을 모르는데, NOT NULL 로 넣어야 한다?? ▶ 모순.!!! ▶ 그 대신 default 값으로 넣는다.
    */
    
    alter table TBL_JIKWON_COPY 
    add JUBUN VARCHAR2(13) default ' ' NOT NULL; --> 여기서는 ' ' 을 기본값(default)으로 주었음.
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    desc TBL_JIKWON_COPY;
/*
    이름         널?       유형           
    ---------- -------- ------------   
    JUBUN      NOT NULL VARCHAR2(13) 
*/
    
    select * 
    from TBL_JIKWON_COPY;    
    
    ---- **** 어떤 테이블의 존재하는 컬럼명을 변경하기. **** ----
    /*
        alter table 테이블명
        rename column 현재컬럼명 to 새롭게변경할컬럼명;
    */
    
    -- *** TBL_JIKWON_COPY 테이블에 존재한느 jubun 컬럼명을 juminbunho 컬럼명으로 변경하기 *** ---    
    alter table TBL_JIKWON_COPY
    rename column JUBUN to JUMINBUNHO;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;   
    
    select *
    from TBL_JIKWON_COPY;
    
    
    --- *** 어떤 테이블에 존재하는 컬럼의 데이터타입 변경하기 *** ---
    /*
        alter table 테이블명 
        modify 컬럼명 새로운데이터타입;
    */
    desc TBL_JIKWON_COPY;   
    -- EMAIL      NOT NULL VARCHAR2(50) 
    
    alter table TBL_JIKWON_COPY 
    modify EMAIL VARCHAR2(100);    
    -- EMAIL      NOT NULL VARCHAR2(100) 
    -- 위의 VARCHAR2(50) 에서 VARCHAR2(100) 으로 변경됨.
    
    select *
    from TBL_JIKWON_COPY;
    
    alter table TBL_JIKWON_COPY 
    modify EMAIL VARCHAR2(10);    
    -- ★ ORA-01441: cannot decrease column length because some value is too big
    -- 이미 email 컬럼에 10 이상의 email 주소가 들어가 있으므로, VARCHAR2(10) 로 줄일 수 없음.
    -- 존재하는 행이 없었다면 줄이는 것이 가능하지만, 10개보다 더 큰 행이 있기 때문에 column length cannot decrease .
    
    alter table TBL_JIKWON_COPY 
    modify EMAIL VARCHAR2(20);    
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;       
    -- EMAIL      NOT NULL VARCHAR2(20) 
    
    
    ---- **** 어떤 테이블의 테이블명 변경하기 **** ----
    /*
    rename 현재테이블명 to 새로운테이블명;
    */
    -- TBL_JIKWON_COPY 테이블 이름을 TBL_JIKWON_BACKUP 이라는 테이블명으로 변경하기.
    
    rename TBL_JIKWON_COPY to TBL_JIKWON_BACKUP;        
    
    select *
    from TBL_JIKWON_COPY;
    -- ★오류 ORA-00942: table or view does not exist
    
    select *
    from TBL_JIKWON_BACKUP;
    -- 테이블명이 TBL_JIKWON_COPY 에서 TBL_JIKWON_BACKUP 로 변경됨 
    
    
    --- *** 어떤 테이블이 부모 테이블로 사용하고 있을 경우 부모 테이블을 drop 하기 *** --- 
    /*
        drop table 부모테이블명 cascade constraints purge;
        -- 테이블이 너~~무 방대하면 일일이 찾아서 drop 하기가 힘듦. 아래의 방법을 사용해서 FK 키를 drop 해주도록 한다.
        -- constraints cascade 이 있으면
           ① 부모테이블명 을 drop 하기전 먼저 부모테이블명 에 딸려진 자식테이블의 foreign key 제약을 먼저 drop 을 해준다.
           ② 그 다음에 부모테이블명 을 drop 해준다.
    */
    --- ★ 부모-자식 테이블 관계는 ""foreign key"" 가 있기 때문이다.!!
    
    create table tbl_board_a    -- 게시판 테이블 (부모 테이블)
    (boardno        number
    ,board_content  varchar2(4000) not null
    
    ,constraint PK_tbl_board_a_boardno primary key(boardno)
    );
    -- Table TBL_BOARD_A이(가) 생성되었습니다.
    
    insert into tbl_board_a(boardno, board_content) values(1, '안녕하세요~~');
    insert into tbl_board_a(boardno, board_content) values(2, '만나서 반갑습니다^_^');
               
    commit;
    
    create table tbl_board_a_add    -- 게시판 댓글 테이블 (자식테이블)
    (addno              number
    ,add_content        varchar2(4000) not null  
    ,fk_boardno         number
    
    ,constraint PK_tbl_board_a_add_addno primary key(addno)
    ,constraint FK_tbl_board_a_add_fk_boardno foreign key(fk_boardno) references tbl_board_a(boardno) on delete cascade
    );
    -- Table TBL_BOARD_A_ADD이(가) 생성되었습니다.

    insert into tbl_board_a_add(addno, add_content, fk_boardno) 
    values(1001, '안녕하세요~~ 에 대한 댓글입니다', 1);
    -- 1 행 이(가) 삽입되었습니다.

    commit;
    -- 커밋 완료.

    select *
    from tbl_board_a
    
    select *
    from tbl_board_a_add;
    
    drop table tbl_board_a purge;
    /*
    오류 보고 -
    ORA-02449: unique/primary keys in table referenced by foreign keys
    
    왜냐하면 tbl_board_a 테이블은 자식테이블(tbl_board_a_add) 에 의해 참조를 받는 부모테이블 이므로 
    바로 drop table 이 불가하다.
    ▶ 해결책? 자식 테이블에 있는 foreign key를 없애서 부모-자식 관계를 끊는다.
       그러나, 테이블이 방대할 경우에 일일이 끊기가 어렵다. 
    */
    -- ▼ 아래 를 통해 참조하고 있는 R_CONSTRAINT_NAME 을 파악한다.

    select *
    from user_constraints
    where table_name = 'TBL_BOARD_A_ADD' and constraint_type ='R';
    -- 결과물이 나온다.
    
    -- ① drop 한다.    
    drop table tbl_board_a cascade constraints purge;
    
    select *
    from tbl_board_a;
    -- ★오류 ORA-00942: table or view does not exist
    
    select *
    from tbl_board_a_add;    
 
    select *
    from user_constraints
    where table_name = 'TBL_BOARD_A_ADD' and constraint_type ='R';
    -- 결과물이 없다. 왜냐하면 foreign key 제약조건을 자동적으로 drop 해주었기 때문이다. (참조하고 있던 부모테이블이 drop 함으로써 사라짐.)
    
        
    ---- !!!! 테이블을 생성한 이후에 웬만하면 *테이블명에 대한 주석문*을 달아주도록 합시다.!!!! ----
    ---- 테이블명에 대한 이름이 기억에 안남을 수 있다. ▶ 방대한 테이블에 대한 용도를 주석 남겨주자.
    /*
        comment on table 테이블명
        is '테이블명에 대한 주석문';
    */
    
    --- *** 테이블명에 달려진 주석문 조회하기 *** --
    select *
    from user_tab_comments;    
    
    
    comment on table TBL_JIKWON --> 테이블을 만든 다음에, comment(주석)을 달아준다.
    is '우리회사 사원들의 정보가 들어있는 테이블';
    -- Comment이(가) 생성되었습니다.

    
   ---- !!!! 테이블을 생성한 이후에 웬만하면 *컬럼명에 대한 주석문*을 달아주도록 합시다.!!!! ----
    /*
        comment on column
        테이블명.컬럼명 is '컬럼명에 대한 주석문';
    */
   select * 
   from user_col_comments
   where table_name = 'EMPLOYEES';
   
   
   select * 
   from user_col_comments
   where table_name = 'TBL_JIKWON';    
    
   comment on column TBL_JIKWON.SANO is '사원번호 Primary Key';                     -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.SANAME is '사원명 NOT NULL';                        -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.SALARY is '기본급여 0보다 크면서 COMMISSION 보다 크다'; -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.COMMISSION is '커미션 최소 0이면서 SALARY 보다 작다';   -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.JIK is '직급 사장,이사,부장,과장,대리,사원 만 가능함';    -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.EMAIL is '이메일';                                  -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.HIRE_DATE is '입사일자 기본값은 sysdate';             -- Comment이(가) 생성되었습니다.
      
   select column_name, comments  
   from user_col_comments
   where table_name = 'TBL_JIKWON'; 
   
    ------------------------------------------------------------------------------------
    ---- !!!! 테이블을 삭제시 휴지통에 버리기 
    -- ==> drop 되어진 테이블을 복구가 가능하도록 만들어 주는 것이다. !!!! ----
    
    create table tbl_exam_01
    (name  varchar2(20));
    
    insert into tbl_exam_01(name) values('연습1');
    commit;
    
    create table tbl_exam_02
    (name  varchar2(20));
    
    insert into tbl_exam_02(name) values('연습2');
    commit;
    
    create table tbl_exam_03
    (name  varchar2(20));
    
    insert into tbl_exam_03(name) values('연습3');
    commit;
    
    create table tbl_exam_04
    (name  varchar2(20));
    
    insert into tbl_exam_04(name) values('연습4');
    commit;
    
    create table tbl_exam_05
    (name  varchar2(20));
    
    insert into tbl_exam_05(name) values('연습5');
    commit;
      
    create table tbl_exam_06
    (name  varchar2(20));
    
    insert into tbl_exam_06(name) values('연습6');
    commit;
    
    drop table tbl_exam_01;  --> tbl_exam_01 테이블을 영구히 삭제하는 것이 아니라 휴지통에 버리는 것이다. (▶ 단순히 휴지통에 들어가는 것과 비슷한 것)
    -- Table TBL_EXAM_01이(가) 삭제되었습니다.

    select * from tab;
    -- 결과물에서 TNAME 컬럼에 BIN$ 로 시작하는 것은 휴지통에 버려진 테이블이다.
       
    drop table tbl_exam_02;  --> tbl_exam_01 테이블을 영구히 삭제하는 것이 아니라 휴지통에 버리는 것이다. (▶ 단순히 휴지통에 들어가는 것과 비슷한 것)
    -- Table TBL_EXAM_02이(가) 삭제되었습니다.

    select * from tab;
    -- 결과물에서 TNAME 컬럼에 BIN$ 로 시작하는 것은 휴지통에 버려진 테이블이다.
       
    select *   
    from tbl_exam_01;   
    -- ORA-00942: table or view does not exist (drop 했으므로 table 이 없음.)   

    select *   
    from tbl_exam_02;   
    -- ORA-00942: table or view does not exist (drop 했으므로 table 이 없음.)   
   
    select * from tab;
    -- 결과물에서 TNAME 컬럼에 BIN$ 로 시작하는 것은 휴지통에 버려진 테이블이다.
    
    select *   
    from "BIN$AljiLBMgSeSFs7UVEsIUAw==$0";  --> BIN$ 로 시작하는 것은 반드시 "" 를 붙여주어야 한다.
    
    select * 
    from "BIN$hJknzMSRSMme7MDsjPHr0g==$0";
    
    
    ----- === *** 휴지통 조회하기 *** === ----- 
    select *
    from user_recyclebin;
    
    ----- === *** 휴지통에 있던 테이블을 복원하기 *** === ----- 
    -- flashback table ORGINAL_NAME to before drop;
    
    flashback table TBL_EXAM_01 to before drop;
    -- Flashback 을(를) 성공했습니다.
    -- TBL_EXAM_01 은 original_name 컬럼에 나오는 것이다.
    
    select *
    from TBL_EXAM_01;
    -- 복원됨.
    
    ----- === *** 휴지통에 있던 특정 테이블을 영구히 삭제하기 *** === ----- 
    ----- drop table 은 휴지통에 넣기만 하는 것이고, purge table 은 영구히 삭제하는 것이다.
    select *
    from user_recyclebin;    
    
    purge table TBL_EXAM_02;
    -- Table이(가) 비워졌습니다.
    -- TBL_EXAM_02 는 orginal_name 컬럼에 나오는 것이다.
    
    ----- === *** 휴지통에 있던 모든 테이블을 영구히 삭제하기 *** === ----- 
    drop table tbl_exam_03;
    -- Table TBL_EXAM_03이(가) 삭제되었습니다. (휴지통으로 보냄)
    drop table tbl_exam_04;
    -- Table TBL_EXAM_04이(가) 삭제되었습니다. (휴지통으로 보냄)
    
    select *
    from user_recyclebin;    
    
    purge recyclebin; 
    -- Recyclebin이(가) 비워졌습니다.
    -- 휴지통에 있던 모든 테이블을 영구히 삭제하기. (휴지통 비우기!!)
    
    select *
    from user_recyclebin;    
    
    select * from tab;    
    
    
    --- *** 테이블을 영구히 삭제하기 ==> drop-purge 된 테이블은 복원이 불가하다. *** ---
    --- drop table 지울테이블이름 purge;
    --- 나중에 복원해야 할 테이블일 경우에는 purge 를 하지 않고 drop 한다.!!!

    select *
    from tbl_exam_05;

    drop table tbl_exam_05 purge;
    -- Table TBL_EXAM_05이(가) 삭제되었습니다.

    
    
        
    ---------- ==== *** 계층형 쿼리 *** ==== ----------
    /*
        계층형 쿼리는 Spring 프레임워크 시간에 답변형 게시판에서 사용한다. (댓글게시판 != 답변형게시판)
        또한 전자결재 에서도 사용된다.
    */
    
    /*
        1       차은우
                  |
        2       박보검
             ----------- 
               |     |
        3    최우식 서강준
               |     |
        4    박형식                 
    */
    
    select *
    from employees
    order by employee_id asc;
    
    -- 결재라인을 만들어 보겠습니다.
    -- 출발       104 ==> 103(manager) ==> 102 ==> 100 (최종결재자)==> null                (직속상관 순서대로 올라가는 것)
    -- level      1       2                3       4
    
    
    -------------------------------------------------------
    level   사원번호   사원명              직속결재권자사원번호
    -------------------------------------------------------
      1     104       Bruce Ernst       103
      2     103       Alexander	Hunold  102
      3     102       Lex De Haan       100
      4     100       Steven King       null
    
    select level    
         , employee_id as 사원번호
         , first_name ||' '|| last_name as 사원명
         , manager_id as 직속결재권자사원번호
    from employees
    start with employee_id = 104                        -- start with employee_id = 103   start with employee_id = 102  start with employee_id = 100
    connect by prior manager_id = employee_id;          -- '=' 의 양쪽 순서에 유의할 것. (  connect by 직속상사 = prior 부하직원 )
    -- *** !!! prior 다음에 나오는 column 이름인 manager_id 은 start with 되는 행의 manager_id 컬럼의 값이다. !!! *** --
    /*
        connect by prior manager_id = employee_id;        
        connect by prior 103  = employee_id;
        connect by prior 102  = employee_id;
        connect by prior 100  = employee_id;
        connect by prior null = employee_id;
    */
      
    select level    
         , employee_id as 사원번호
         , first_name ||' '|| last_name as 사원명
         , manager_id as 직속결재권자사원번호
    from employees
    start with employee_id = 100                        
    connect by prior employee_id = manager_id       -- 사원번호 100 부터 내 밑으로 다 출력해라.
    order by 1;         -- level 오름차순.( 같은 레벨은 동급이다. )
    /*
        connect by prior 100 = manager_id;       -- 100번 을 직속상관으로 모시고 있는 사람들
        connect by prior 101 = manager_id;       -- 101번 을 직속상관으로 모시고 있는 사람들
        connect by prior 108 = manager_id;       -- 108번 을 직속상관으로 모시고 있는 사람들
        connect by prior 109 = manager_id;       -- 109번 을 직속상관으로 모시고 있는 사람들        
    */
    
    
    select * 
    from employees
    start with manager_id = 109
    connect by prior employee_id = manager_id;      
    -- 없다. ( 109 번 밑에는 없다.)
    
    
    
      
    ---------- ==== *** INDEX(인덱스, 색인) *** ==== ----------
    -- 왜 쓰는가 ? select 의 속도를 빠르게 하기 위함.
    /* 
       index(==색인)는 예를 들어 설명하면 아주 두꺼운 책 뒤에 나오는 "찾아보기" 와 같은 기능을 하는 것이다.
       "찾아보기" 의 특징은 정렬되어 있는 것인데 index(==색인) 에 *저장된 데이터도 정렬되어 저장되어 있다*는 것이 특징이다.
    */
    -- index(==색인)를 생성해서 사용하는 이유는 where 절이 있는 select 명령문의 속도를 향상 시키기 위함이다.
    -- index(==색인)은 어떤 컬럼에 만들어 할까요?
    /*
       1. where 절에서 "자주" 사용된 컬럼에 만들어야 한다.       
       2. 조인조건절에서 "자주" 사용된 컬럼에 만들어야 한다.       
       3. order by 절에 "자주" 사용된 컬럼에 만들어야 한다.
          group by 절에 "자주" 사용된 컬럼에 만들어야 한다.
              
       4. 선택도(selectivity)가 높은 컬럼에 만들어야 한다.
       ※ 선택도(selectivity)가 높다라는 것은 고유한 데이터일수록 선택도(selectivity)가 높아진다.
       예: 성별컬럼 --> 선택도(selectivity)가 아주 낮다. 왜냐하면 수많은 사람중 남자 아니면 여자중 하나만 골라야 하므로 선택의 여지가 아주 낮다. (선택의 폭이 좁다. index 를 썼을 때 더 느릴 수 있다.)
           학번    --> 선택도(selectivity)가 아주 좋다. 왜냐하면 학번은 다양하고 고유하므로 골라야할 대상이 아주 많으므로 선택도가 높은 것이다. (선택의 폭이 넓다. ▶ 일일이 고유한 데이터를 찾아다닐때 index 를 써야 더 빠름)
    
       5. 카디널리티(cardinality)가 높은 컬럼에 만들어야 한다.
       ※ 카디널리티(cardinality)의 사전적인 뜻은 집합원의 갯수를 뜻하는 것으로서,
          카디널리티(cardinality)가 높다라는 것은 중복도가 낮아 고유한 데이터일수록 카디널리티(cardinality)가 상대적으로 높다 라는 것이다.
          카디널리티(cardinality)가 낮다라는 것은 중복도가 높아 중복된 데이터가 많을수록 카디널리티(cardinality)가 상대적으로 낮다 라는 것이다.
          
          카디널리티(cardinality)는 "상대적인 개념" 이다.
          예를들어, 주민등록번호 같은 경우는 중복되는 값이 없으므로 카디널리티(cardinality)가 높다고 할 수 있다.
          이에 비해 성명같은 경우는 "주민등록번호에 비해" 중복되는 값이 많으므로, 성명은 "주민등록번호에 비해" 카디널리티가 낮다고 할 수 있다. (성명은 동명이인이 많으므로 중복 多) // 주민번호 카디널 > 성명 카디널
          이와같이 카디널리티(cardinality)는 상대적인 개념으로 이해해야 한다.
    */     
    
    create table tbl_student_1
    (hakbun      varchar2(20) not null
    ,name        varchar2(20)
    ,email       varchar2(30)
    ,address     varchar2(200)
    );
    -- Table TBL_STUDENT_1이(가) 생성되었습니다.
    
        
    --- *** ① unique 한 index 생성하기 *** ---
    /* 
      어떤 컬럼에 unique 한 index 를 생성하면 그 컬럼에 중복된 값은 들어올 수 없으며 오로지 고유한 값만 들어오게 된다. (Unique key 나 Primary key 와 비슷)
      unique 한 index 가 뒤에 나오는 non-unique 한 index 보다 검색속도가 조금 더 빠르다.
    */ 
    /*
     [문법]
     create unique index 인덱스명
     on 해당테이블명(컬럼명 asc|desc);
    */
    
    create unique index idx_TBL_STUDENT_1_hakbun 
    on tbl_student_1(hakbun);   -- on tbl_student_1(hakbun asc); 와 동일하다.
    -- Index IDX_TBL_STUDENT_1_HAKBUN이(가) 생성되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('1', '일미자', 'ilmj@naver.com', '서울시 강동구');
    -- 1 행 이(가) 삽입되었습니다.

    insert into tbl_student_1(hakbun, name, email, address) values('1', '이미자', 'twomj@naver.com', '서울시 강서구');
    -- ★ 오류 ORA-00001: unique constraint (HR.IDX_TBL_STUDENT_1_HAKBUN) violated (중복됐으므로 X)
    
    insert into tbl_student_1(hakbun, name, email, address) values('2', '이미자', 'twomj@naver.com', '서울시 강서구');
    -- 1 행 이(가) 삽입되었습니다.

    commit;
    -- 커밋 완료.

    ----- **** TBL_STUDENT_1 테이블에 생성된 index 조회하기 **** -----
    select *
    from user_indexes
    where table_name = 'TBL_STUDENT_1';
    
    select *
    from user_ind_columns       -- 위의 인덱스 조회 시, 컬럼이 나오지 않을때 사용
    where table_name = 'TBL_STUDENT_1';

    select A.index_name, uniqueness, column_name, descend
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';



    --- *** ② non-unique 한 index 생성하기 *** --- (중복을 허락한다.)
    /* 
     어떤 컬럼에 non-unique 한 index 생성하면 *그 컬럼에 들어오는 값은 중복된 값이 들어올 수 있다*는 것이다.
     non-unique 한 index 는 unique 한 index 보다 검색속도가 다소 늦은 편이다.
    */ 
    /*
        [문법]
        create index 인덱스명
        on 해당테이블명(컬럼명 asc|desc);
    */    
    -- ex. 이름같은 경우엔 동명이인이 있을 수 있으므로 non-unique 하다.
    create index idx_tbl_student_1_name
    ON tbl_student_1(name);                                    -- desc 를 쓰는 경우는 ? 물품번호, 게시판은 sequence 를 많이 쓰는데, 최신 게시물을 보기위해 desc 로 한다. 
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 생성되었습니다.

    insert into tbl_student_1(hakbun, name, email, address) values('3', '삼미자', 'threemj@naver.com', '서울시 강서구');
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('4', '삼미자', 'threemj2@naver.com', '서울시 강남구');
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    -- 커밋 완료.

    select *
    from tbl_student_1

    select A.index_name, uniqueness, column_name, descend
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- UNIQUENESS 가 UNI~ 일때는 중복 허용, NONUNI~ 일때는 중복 허용 X
    /*
    -------------------------------------------------------------------
    index_name                  uniqueness      column_name    descend
    -------------------------------------------------------------------
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	        ASC
    IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	    NAME	        ASC
    -------------------------------------------------------------------
    */

    select *
    from tbl_student_1
    where hakbun = '2';  -->  unique한 인덱스 IDX_TBL_STUDENT_1_HAKBUN 를 사용하여 빠르게 조회해옴.
    
    
    select *
    from tbl_student_1
    where name = '이미자';  --> non-unique한 인덱스 IDX_TBL_STUDENT_1_NAME 를 사용하여 빠르게 조회해옴.
    
    
    select *
    from tbl_student_1
    where address = '서울시 강동구';  --> address 컬럼에는 인덱스가 없으므로 tbl_student_1 테이블에 있는 모든 데이터를 조회해서 
                                    --  address 컬럼의 값이  '서울시 강동구' 인 데이터를 가져온다.
                                    --  이와 같이 인덱스를 사용하지 않고 데이터를 조회해올 때를 Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회) 이라고 부른다.
                                    --  Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회)이 속도가 가장 느린 것이다.
                                    
    
    delete from tbl_student_1;  
    -- 4개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.

    -- drop sequence seq_tbl_student_1;
    
    -- Sequence 만들기.
    
    create sequence seq_tbl_student_1
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    -- Sequence SEQ_TBL_STUDENT_1이(가) 생성되었습니다.
    
    
    declare
       v_cnt  number := 1;
       v_seq  number;
       v_day  varchar2(8);
    begin
        loop 
           exit when v_cnt > 10000;
        
           select seq_tbl_student_1.nextval, to_char(sysdate, 'yyyymmdd') 
                  into v_seq, v_day
           from dual;
        
           insert into tbl_student_1(hakbun, name, email, address)
           values(v_day||'-'||v_seq, '이순신'||v_seq, 'leess'||v_seq||'@gmail.com', '서울시 마포구 월드컵로 '||v_seq);
           
           v_cnt := v_cnt + 1;
        end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    commit;
    -- 커밋 완료.
    
    
    select *
    from tbl_student_1;
    
    select count(*)
    from tbl_student_1;   -- 10000

    select seq_tbl_student_1.currval AS 최근에사용한시퀀스값   -- 10000
    from dual;
    
    
    insert into tbl_student_1(hakbun, name, email, address)
    values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 1), '배수지'||(seq_tbl_student_1.currval + 1), 'baesuji'||(seq_tbl_student_1.currval + 1)||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 1));
    --                      '20220120 - 10001'                      

    insert into tbl_student_1(hakbun, name, email, address)
    values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 2), '배수지'||(seq_tbl_student_1.currval + 2), 'baesuji'||(seq_tbl_student_1.currval + 2)||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 2));
    --                      '20220120 - 10002'                      

    insert into tbl_student_1(hakbun, name, email, address)
    values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 3), '배수지'||(seq_tbl_student_1.currval + 3), 'baesuji'||(seq_tbl_student_1.currval + 3)||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 3));
    --                      '20220120 - 10003'                      
                    
    commit;
    -- 커밋 완료.
    
    
    select count(*)
    from tbl_student_1;    -- 10003
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- UNIQUENESS 가 UNI~ 일때는 중복 허용 X, NONUNI~ 일때는 중복 가능 O
    /*
    -------------------------------------------------------------------
    index_name                  uniqueness      column_name    descend
    -------------------------------------------------------------------
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	        ASC
    IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	    NAME	        ASC
    -------------------------------------------------------------------
    */    
    
    -- ==== *** ① SQL*Developer 에서 Plan(실행계획) 확인하는 방법 *** ==== --
    /*
      select 문이 실행될 때 인덱스를 사용하여 데이터를 얻어오는지 인덱스를 사용하지 않고 
      Table Full Scan 하여 얻어오는지 알아봐야 한다.
      이럴때 사용하는 것이 SQL Plan(실행계획)이다. 
      
      SQL*Developer 에서는 "SQL편집창(SQL 워크시트)"에 Plan(실행계획) 과 Trace(자동추적) 메뉴가 상단에 있다.
      
      Plan(실행계획) 과 Trace(자동추적) 의 차이는,
      Plan(실행계획) 은 SQL을 **실행하기 전**에 Oracle Optimizer(옵티마이저, 최적화기)가 SQL을 어떻게 실행할지를 미리 알려주는 것이고,
      Trace(자동추적) 는 SQL을 **실행해보고**, Oracle Optimizer(옵티마이저, 최적화기)가 SQL을 어떻게 실행했는지 그 결과를 알려주는 것이다.

      그러므로, 정확도로 말하자면, Trace(자동추적)가 Plan(실행계획) 보다 훨씬 정확한 것이다.
      Plan(실행계획) 은 말그대로 계획이라서 Oracle Optimizer가 계획은 그렇게 세우긴 했으나 
      실제 실행할때는 여러가지 이유로 다르게 실행할 수도 있기 때문이다.
      그래서 Trace(자동추적)가 정확하기는 하나 Trace(자동추적)는 한번 실행해봐야 하는것이라서 
      시간이 오래 걸리는 SQL인 경우에는 한참 기다려야 하는 단점이 있기는 하다.
   */       
    
    
   /* 
      실행해야할 SQL문을 블럭으로 잡은 후에
      "SQL 워크시트" 의 상단 아이콘들중에 3번째 아이콘( 계획 설명... (F10) )을 클릭하면 현재 SQL의 Plan(실행계획)을 아래에 보여준다.
      COST(비용)의 값이 적을 수록 속도가 빠른 것이다.
      (오라클이 알아서 Table Full-scan 인지 index 를 할 것인지 sql *plan* 을 세우는 것)
   */    
    
    select *
    from tbl_student_1
    where hakbun = '20220120-6789'; --> Unique 한 인덱스 IDX_TBL_STUDENT_1_HAKBUN 를 사용하여 빠르게 조회해옴. hakbun '20220120-6789' 에 mapping 된 ROWID 가 있을 것이다.
    
        '20220120-6789' --- 'sdfsfsgdfgfsfs' (고유한 ROWID)
        '이순신'         --- 143 페이지 // 즉, 페이지 숫자에 해당하는 것이 ROWID 임.
    
    select *
    from tbl_student_1    
    where name = '이순신5783';        --> non-unique 한 인덱스 IDX_TBL_STUDENT_1_NAME 을 사용하여 빠르게 조회해옴. (이름은 중복이 있으므로 non-unique 함)
    

    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 3987';  --> address 컬럼에는 인덱스가 없으므로 tbl_student_1 테이블에 있는 모든 데이터를 조회해서 (책 맨뒤에 있는 index 처럼 오라클의 index에 없으므로 책 모든 내용을 다 찾아봐야함.)
                                                --  address 컬럼의 값이  '서울시 마포구 월드컵로 3987' 인 데이터를 가져온다.
                                                --  이와 같이 인덱스를 사용하지 않고 데이터를 조회해올 때를 Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회) 이라고 부른다.
                                                --  Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회)이 속도가 가장 느린 것이다.

    select *
    from tbl_student_1
    where email = 'leess2654@gmail.com';        -- email 컬럼에는 인덱스가 없으므로 Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회)하여 조회해 오는 것임.
                                                -- 책 맨뒤에 있는 index 처럼 오라클의 index에 없으므로 책 모든 내용을 다 찾아봐야함. (Table Full-scan)   


    -------------------------------------------------------------------------------------------------------------------
    -- *** ② Trace(자동추적)을 하기 위해서는 SYS 또는 SYSTEM 으로 부터 아래와 같은 권한을 부여 받은 후 HR은 재접속을 해야 한다. *** --
    show user;
    -- USER이(가) "SYS"입니다.
    
    grant SELECT_CATALOG_ROLE to HR;
    -- Grant을(를) 성공했습니다.
    
    grant SELECT ANY DICTIONARY to HR;
    -- Grant을(를) 성공했습니다.
    -------------------------------------------------------------------------------------------------------------------
    
    /* 
      실행해야할 SQL문을 블럭으로 잡은 후에
      "SQL 워크시트" 의 상단 아이콘들중에 4번째 아이콘( 자동 추적... (F6) )을 클릭하면 현재 SQL의 Trace(자동추적)을 아래에 보여준다.
      
      Trace(자동추적)을 하면 Plan(실행계획) 도 나오고, 동시에 아래쪽에 통계정보도 같이 나온다.

      오른쪽에 Plan(실행계획)에서는 보이지 않던 LAST_CR_BUFFER_GETS 와 LAST_ELAPSED_TIME 컬럼이 나온다.
      LAST_CR_BUFFER_GETS 는 SQL을 실행하면서 각 단계에서 읽어온 블록(Block) 갯수를 말하는 것이고,
      LAST_ELAPSED_TIME 은 경과시간 정보이다.
      즉, 이 정보를 통해서 어느 구간에서 시간이 많이 걸렸는지를 확인할 수 있으므로, 이 부분의 값이 적게 나오도록 SQL 튜닝을 하게 된다.
    */

    select *
    from tbl_student_1
    where hakbun = '20220120-6789';         --> 인덱스에 有
    
    select *
    from tbl_student_1
    where email = 'leess2654@gmail.com';    --> index 에 없으므로 Table Full-scan 이 수행되어 LAST_ELAPSED_TIME 이 늘어나게 됨.
    
    ---- ★★★ 중요 ★★★
    ---- *** DML(insert, update, delete)이 빈번하게 발생하는 테이블에 index가 생성되어 있으면
    ---      DML(insert, update, delete) 작업으로 인해 Index 에 나쁜 결과를 초래하므로  
    ---      index 가 많다고 해서 결코 좋은 것이 아니기에 *테이블당 index 의 개수는 최소한의 개수로 만드는 것*이 좋다.
    
    ---- *① index 가 생성된 테이블에 insert 를 하면 Index Split(인덱스 쪼개짐) 가 발생하므로
    ----     index 가 없을때 보다 insert 의 속도가 떨어지게 된다.
    ----     그러므로 index 가 많다고 결코 좋은 것이 아니므로 최소한의 개수로 index 를 만드는 것이 좋다.
    ----     Index Split(인덱스 쪼개짐)란 Index 의 block(블럭)들이 1개에서 2개로 나뉘어지는 현상을 말한다.
    ----     Index Split(인덱스 쪼개짐)이 발생하는 이유는 Index 는 정렬이 되어 저장되기 때문에 
    ---      Index 의 마지막 부분에 추가되는 것이 아니라 정렬로 인해 중간 자리에 끼워들어가는 현상이
    ----     발생할 수 있기 때문이다. 
    ----     ex1) 책에서 모든 컬럼에 대해 다 INDEX 를 만드는 것이 효율적이지 않을 수 있다. (DML 을 할때마다 index 에도 자꾸 영향이 가게되므로 좋지 X)    
    ----     ex2) 어떤 테이블에 index 가 없으면 insert를 그냥 하면 되는데, index 가 있으면 insert 를 하는 동시에 index 도 변경을 해주어야 한다. 
    ----     ☞ 그러므로 반드시 필요한 컬럼에만 index 를 만들어준다.
    
    ---- *② index 가 생성되어진 테이블에 delete 를 하면 테이블의 데이터는 삭제되지만 
    ----     Index 자리에는 데이터는 삭제되지 않고서 사용하지 않는다는 표시만 하게 된다.
    ----     그래서 10만 건이 들어있던 테이블에 9만건의 데이터를 delete 를 하면 테이블에는 데이터가 삭제되지만
    ----     Index 자리에는 10만 건의 정보가 그대로 있고 1만건만 사용하고 9만건은 사용되지 않은채로 남아있기에
    ----     *사용하지 않는 9만건의 Index 정보로 인해서* index를 사용해서 select를 해올 때 index 검색속도가 떨어지게 된다.   
    ----     이러한 경우 *Index Rebuild 작업*을 해주어 사용하지 않는 9만건의 index 정보를 삭제해주어야만 
    ----     select를 해올 때 index 검색속도가 빨라지게 된다. 
    ----     ex1) 책에서 어떤 한 페이지를 찢는다(delete) 면, 그 페이지는 내용이 사라지지만, index 는 동시에 삭제되지 않고 그대로 남아있게 된다.(사용하지 않는다는 표시만 남게된다.) 
    
    ---- *③ index 가 생성되어진 테이블에 update 를 하면 테이블의 데이터는 "수정" 되지만 
    ----     Index 는 "수정" 이라는 작업은 없고 index 를 delete 를 하고 새롭게 insert 를 해준다.
    ----     그러므로 index 를 delete 할 때 발생하는 단점 및 index 를 insert 를 할 때 발생하는 Index Split(인덱스 쪼개짐) 가 발생하므로
    ----     Index 에는 최악의 상황을 맞게 된다. 
    ----     이로 인해 테이블의 데이터를 update를 빈번하게 발생시켜 버리면 select를 해올 때 index 검색속도가 현저히 느려지게 된다. 
    ----     이러한 경우도 select를 해올 때 index 검색속도가 빨라지게끔 Index Rebuild 작업을 해주어야 한다.           
    
    
    ---- **** Index(인덱스)의 상태 확인하기 **** ----
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.    
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
              0          <== 0 에 가까울 수록 인덱스 상태가 좋은 것이다. ( 깨진 것이 없다. )
    */
    
    select count(*)
    from tbl_student_1;  
    -- 10003
    
    delete from tbl_student_1
    where hakbun between '20220120-400' and '20220120-9400';
    -- 6,001개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select count(*)
    from tbl_student_1; 
    -- 4002

    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
              0          <== delete 하기 전의 index 를 분석한 것이므로 0 이라고 나올 뿐이다. (삭제 후의 index 는 분석하지 않았다.)
    */

    ---- **** Index(인덱스)의 상태 확인하기 **** ----
    ---- 삭제를 하고 난 이후에 아래와 같이 analyze 절차를 한 번 거친 다음에 인덱스상태를 확인해야 정확한 결과가 나온다. 삭제후에 바로 인덱스상태를 조회하는 것이 아니다.
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.    

    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
       59.99108333467217197114534967787542374243          ==> 인덱스 밸런스가 대략 60% 정도가 깨진 것이다.
    */
    
    update tbl_student_1 set name = '홍길동'
    where hakbun between '20220120-9401' and '20220120-9901';
    -- 556개 행 이(가) 업데이트되었습니다.

    commit;
    -- 커밋 완료.
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.    
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
       60.72728298586622281152142635483961971394          ==> 인덱스 밸런스가 대략 60% 정도가 깨진 것이다.
    */    
    
    -- 따라서, 위와 같이 인덱스가 깨졌을 때 Rebuild 를 한다. ▼
    ----- *** ==== Index Rebuild(인덱스 재건축) 하기 ==== *** -----
    
    -- 인덱스 밸런스가 대략 60% 정도 깨진 IDX_TBL_STUDENT_1_NAME 을 Index Rebuild(인덱스 재건축) 하겠습니다. --
    alter index IDX_TBL_STUDENT_1_NAME rebuild;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 변경되었습니다.
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.    

    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
              0                      ==> 인덱스 밸런스가 Rebuild 된 후 깨진 비율이 0% 으로 줄었다.
    */    

    

    --- *** INDEX 삭제하기 
    /* 
        drop index 삭제할 index 명
    */
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- UNIQUENESS 가 UNI~ 일때는 중복 허용 X, NONUNI~ 일때는 중복 가능 O
    /*
    -------------------------------------------------------------------
    index_name                  uniqueness      column_name    descend
    -------------------------------------------------------------------
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	        ASC
    IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	    NAME	        ASC
    -------------------------------------------------------------------
    */    

    drop index IDX_TBL_STUDENT_1_NAME;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 삭제되었습니다.
    drop index IDX_TBL_STUDENT_1_HAKBUN;
    -- Index IDX_TBL_STUDENT_1_HAKBUN이(가) 삭제되었습니다.

    select *
    from tbl_student_1
    -- index 만 사라지는 것이지, 테이블이 사라지는 것이 아니다.



    ------ **** !!!!! 복합인덱스(Composite index) 생성하기 !!!!! **** -------
    -- 복합인덱스(composite index)란? 
    -- *2개 이상의 컬럼으로 묶어진 인덱스*를 말하는 것으로서
    -- where 절에 2개의 컬럼이 사용될 경우 각각 1개 컬럼마다 각각의 인덱스를 만들어서 사용하는 것보다
    -- *2개의 컬럼을 묶어서 하나의 인덱스로 만들어 사용*하는 것이 속도가 좀 더 빠르다.

    select *
    from tbl_student_1
    where name = '배수지10001' and address = '서울시 마포구 월드컵로 10001';

    -- !!!!  중요  !!!! --
    -- 복합인덱스(composite index) 생성시 중요한 것은 선행컬럼을 정하는 것이다.
    -- 선행컬럼은 맨처음에 나오는 것으로 아래에서는 name 이 선행컬럼이 된다.
    -- 복합인덱스(composite index)로 사용되는 컬럼중 선행컬럼으로 선정되는 기준은 where 절에 가장 많이 사용되는 것이며 
    -- 선택도(selectivity)가 높은 컬럼이 선행컬럼으로 선정되어야 한다.

    create index idx_tbl_student_1_name_addr
    on tbl_student_1(name, address);             -- name 컬럼이 선행컬럼, 두개의 컬럼을 묶어서 1개의 index 로 사용.
    -- Index IDX_TBL_STUDENT_1_NAME_ADDR이(가) 생성되었습니다.


/*
    create index idx_tbl_student_1_name_addr
    on tbl_student_1(address, name);             -- address 컬럼이 선행컬럼, 두개의 컬럼을 묶어서 1개의 index 로 사용.
*/

    -- 내가 자주보는 컬럼 위주로 index 순서를 정해야함. 그렇지 않으면 table full-screen 처리가 되어 속도가 늦다.


    select A.index_name, uniqueness, column_name, descend 
         , B.column_position                                -- 선행컬럼 표시(B.column_position)
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';

/*
    ---------------------------------------------------------------------------
    index_name                  UNIQUENESS  column_name descend column_potision    
    ---------------------------------------------------------------------------
    IDX_TBL_STUDENT_1_NAME_ADDR	NONUNIQUE	ADDRESS	    ASC	        2
    IDX_TBL_STUDENT_1_NAME_ADDR	NONUNIQUE	NAME	    ASC	        1 (숫자 1이 선행컬럼이다.)
*/


    select *
    from tbl_student_1
    where name = '배수지10001' and address = '서울시 마포구 월드컵로 10001';
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하여 빨리 조회해온다.
    
    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 10001' and name = '배수지10001';
    -- where 절에 선행컬럼이 나오기만 한다면 순서가 바뀌어도 상관 없다.
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하여 빨리 조회해온다.

    select *
    from tbl_student_1
    where name = '배수지10001' ;
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하여 빨리 조회해온다.

    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 10001';
    -- table full-screen    
    -- where 절에 선행컬럼이 없으므로 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하지 못하고 Table Full Scan 하여 조회해오므로 속도가 떨어진다.

    
    create table tbl_member
    (userid      varchar2(20)
    ,passwd      varchar2(30) not null
    ,name        varchar2(20) not null 
    ,address     varchar2(100)
    ,email       varchar2(50) not null 
    ,constraint  PK_tbl_member_userid primary key(userid)
    ,constraint  UQ_tbl_member_email unique(email)
    );    
    -- Table TBL_MEMBER이(가) 생성되었습니다.
        
    declare 
         v_cnt  number := 1;  
    begin
         loop
             exit when v_cnt > 10000;
             
             insert into tbl_member(userid, passwd, name, address, email)
             values('hongkd'||v_cnt, 'qwer1234$', '홍길동'||v_cnt, '서울시 마포구 '||v_cnt, 'hongkd'||v_cnt||'@gmail.com');
             
             v_cnt := v_cnt + 1;
         end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.

    commit;    
    -- 커밋 완료.
    
    select *
    from tbl_member;

    --- 로그인을 하는데 로그인에 성공하면 그 회원의 성명만을 보여주도록 한다.
    select name
    from tbl_member
    where userid = 'hongkd5001' and passwd = 'qwer1234$';
    -- 처음엔 UNIQUE KEY 를 SCAN 하고, USER_ID를 본 다음에 테이블에 가서 NAME 을 얻어온다. 
    -- F10(계획) & F6(추적)을 통해서 알 수 있다.
    
    
    --- **** userid, passwd, name 컬럼을 가지고 복합인덱스(composite index)를 생성해 봅니다. **** ---
    create index idx_tbl_member_id_pwd_name
    on tbl_member(userid, passwd, name);       -- ★ 선행 컬럼이 제일 중요하다. // userid 는 PK 이며, 선택도가 가장 높음. 그러므로 선행컬럼으로 사용.
    -- Index IDX_TBL_MEMBER_ID_PWD_NAME이(가) 생성되었습니다.
    
    select name
    from tbl_member
    where userid = 'hongkd5001' and passwd = 'qwer1234$';   
    -- where 절 및 select 에 복합인덱스(composite index)인 IDX_TBL_MEMBER_ID_PWD_NAME 에 사용되어진 컬럼만 있으므로
    -- 테이블 tbl_member 에는 접근하지 않고 인덱스 IDX_TBL_MEMBER_ID_PWD_NAME 에만 접근해서 조회하므로 속도가 빨라진다.
    
    select name, address
    from tbl_member
    where userid = 'hongkd5001' and passwd = 'qwer1234$';   
    -- address 에는 index 가 없음(id,pw,name 만 有) ▶ index 를 읽은 후 없으니 table 에 가야함. (조금 더 시간이 걸린다.)
    -- index 가 많으면 DML 속도가 떨어지기 때문에 꼭 필요한 컬럼에만 해야한다.
    -- 로그인 하면 id, pw, name 만 보여질테니 굳이 address 까지 index 를 할 필요가 없다.!!!!

    drop index idx_tbl_member_id_pwd_name;
    -- Index IDX_TBL_MEMBER_ID_PWD_NAME이(가) 삭제되었습니다.

    
    
    
    
    ------ **** 함수기반 인덱스(function based index) 생성하기 **** -------
    -- 콜롬에 함수를 덮어쓴 형태 func(컬럼)        
    
    drop index IDX_TBL_STUDENT_1_NAME_ADDR;
    -- Index IDX_TBL_STUDENT_1_NAME_ADDR이(가) 삭제되었습니다.

    select A.index_name, uniqueness, column_name, descend 
         , B.column_position                                -- 선행컬럼 표시(B.column_position)
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';    
    -- 생성된 index 가 없습니다.
    
    create index idx_tbl_student_1_name
    on tbl_student_1(name);
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 생성되었습니다.

    select *
    from tbl_student_1
    where name = '배수지10002';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하여 조회해온다.
    

    select *
    from tbl_student_1
    where substr(name, 2, 2) = '수지';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하지 않고, Table Full Scan 해서 조회해온다.

    select *
    from tbl_student_1
    where name||'A' = '배수지10002A';
    -- 조회할 때 name 만 들어와야 함. 변형하면 index 를 타지 않고 무조건 table full scan 이다.        
    
    
    create index idx_func_student_1_name
    on tbl_student_1( substr(name, 2, 2) ); -- 함수 기반 인덱스(Function based index) 생성
    
    create index idx_func_age_jubun
    on employees ( func_age(jubun) );
    /*
     오류 보고 -
     ★오류 - ORA-30553: The function is not deterministic
     func_age(jubun) 함수내에 sysdate 가 사용되어지므로 년도가 바뀌면 나이도 변경되므로
     인덱스로 만들 수 없다. 즉, 매번 값이 변동되는 sysdate 는 인덱스로 생성이 불가하다.
    */
    
    select *
    from tbl_student_1
    where substr(name, 2, 2) = '수지';
    -- 함수기반 index 인 IDX_FUNC_STUDENT_1_NAME 를 사용하여 조회해온다.
    
    drop index IDX_FUNC_STUDENT_1_NAME;
    -- Index IDX_FUNC_STUDENT_1_NAME이(가) 삭제되었습니다. (함수기반 index 삭제)
    

    select *
    from tbl_student_1
    where name = '배수지10002';    
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하여 조회해온다.
    
    select *
    from tbl_student_1
    where name like '배수지%';    
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하여 조회해온다.
    
    select *
    from tbl_student_1
    where name like '%배수지%';    
    -- 맨앞에 % 또는 _ (wild character) 가 나오면 IDX_TBL_STUDENT_1_NAME 인덱스를 사용하지 않고, 무조건 Table Full Scan 해서 조회해온다.
    
    
    
    
    --- **** 어떤 테이블의 어떤 컬럼에 Primary Key 제약 또는 Unique 제약을 주면
    --       자동적으로 그 컬럼에는 unique 한 index가 생성되어진다.
    --       인덱스명은 제약조건명이 된다. **** 
    
    create table tbl_student_2
    (hakbun      varchar2(10) 
    ,name        varchar2(20)
    ,email       varchar2(20) not null
    ,address     varchar2(20)
    ,constraint PK_tbl_student_2_hakbun primary key(hakbun)
    ,constraint UQ_tbl_student_2_email unique(email)
    );
    -- Table TBL_STUDENT_2이(가) 생성되었습니다.
    
    select A.index_name, uniqueness, column_name, descend 
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_2';
    
    
    -- Primary Key 제약 또는 Unique 제약으로 생성되어진 index 의 제거는 
    -- drop index index명; 이 아니라
    -- alter table 테이블명 drop constraint 제약조건명; 이다.
    -- *제약조건을 삭제하면 자동적으로 index 도 삭제*가 된다.
    
    drop index PK_TBL_STUDENT_2_HAKBUN;     
    /*
    오류 보고 -
    ORA-02429: cannot drop index used for enforcement of unique/primary key
    ▶ *Action:   drop the constraint instead of the index.
    */

    drop index UQ_TBL_STUDENT_2_EMAIL;     
    /*
    오류 보고 -
    ORA-02429: cannot drop index used for enforcement of unique/primary key
    ▶ *Action:   drop the constraint instead of the index.
    */

    alter table tbl_student_2
    drop primary key;
    -- 제약조건을 없애버림. (P KEY 는 한개뿐이니까!)
    -- Table TBL_STUDENT_2이(가) 변경되었습니다.

    alter table tbl_student_2
    drop constraint UQ_TBL_STUDENT_2_EMAIL;    
    -- Table TBL_STUDENT_2이(가) 변경되었습니다.


    select A.constraint_name, A.constraint_type, A.search_condition, 
           B.column_name, B.position 
    from user_constraints A join user_cons_columns B 
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_STUDENT_2';







    -- ★ 반드시 기억할 것!! ★ --
    ----- ===== ***** 데이터사전(Data Dictionary) ***** ===== -----
    
    ---- **** ORACLE DATA DICTIONARY VIEW(오라클 데이터 사전 뷰) **** ----
    show user;
    -- USER이(가) "HR"입니다.
      
    select *
    from dictionary;    
    
    -- 또는     
    select *
    from dict;
    /*
        USER_CONS_COLUMNS
        ALL_CONS_COLUMNS

    */

    ------------------------------------------------------
    -- ===== SYS 로 접속한 것 시작 ===== --
    
    show user;
    -- USER이(가) "SYS"입니다.
      
    select *
    from dictionary;    
    
    -- 또는     
    select *
    from dict;
    /*
        USER_CONS_COLUMNS
        ALL_CONS_COLUMNS
        DBA_CONS_COLUMNS
    */    
    select *
    from dba_tables;
    
    select *
    from dba_tables
    where OWNER = 'HR';     -- HR 소유의 테이블들!!
    -- ===== SYS 로 접속한 것 끝 ===== --
    ------------------------------------------------------
    
    /*
    DBA_로 시작하는 것 
    ==> ★관리자★만 조회가능한 것으로 '모든'오라클사용자정보, 모든테이블, 모든인덱스, 모든데이터베이스링크 등등등 의 정보가 다 들어있는 것.
    
    USER_로 시작하는 것 
    ==> ★오라클서버★에 접속한 사용자 소유의 '자신'의오라클사용자정보, 자신이만든테이블, 자신이만든인덱스, 자신이만든데이터베이스링크 등등등 의 정보가 다 들어있는 것.
    
    ALL_로 시작하는 것 
    ==> ★오라클서버에 접속한 사용자 소유★의 즉, '자신'의오라클사용자정보, 자신이만든테이블, 자신이만든인덱스, 자신이만든데이터베이스링크 등등등 의 정보가 다 들어있는 것
     과(와)
     ★자신의 것은 아니지만 조회가 가능한★ '다른'사용자의오라클사용자정보, 다른사용자소유의테이블, 다른사용자소유의인덱스, 다른사용자소유의데이터베이스링크 등등등 의 정보가 다 들어있는 것. 
     (자신의 것이 아니지만 권한을 부여받은 것)
    */
    ------------------------------------------------------
   
    -- ===== HR 로 접속한 것 시작 ===== -- 
    show user;
    -- USER이(가) "HR"입니다.
    
    select *
    from dba_tables;
    -- ORA-00942: table or view does not exist (일반 유저인 HR 은 dba_tables 를 조회할 수 없음.)
    
    select *
    from user_tables;
    -- user_ 로 시작하는 것은 자기가 만든것이므로 TABLE_NAME 만 있고 OWNER 컬럼이 존재하지 않는다.
    
    select *
    from all_tables;
    
    -- *** """자신이 만든 테이블"""에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---    
    -- 이때 데이터사전(Data Dictionary) 을 사용한다!!
    -- ""키워드"" 만 잘 잡으면 된다.!!!
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%table%'; -- 첫,가운데,끝에 나오는 상관 없이 % %가운데 글자만 포함되어 있으면 된다. user_ 로 시작하는 것
    
    select *
    from USER_TABLES;
    
    -- *** USER_TABLES 에서 보여지는 컬럼에 대한 설명을 보고 싶으면 아래와 같이하면 됩니다. *** --    
    select *
    from dict_columns
    where table_name = 'USER_TABLES';
    
    -- *** 자신이 만든 테이블의 컬럼에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%column%'; -- 첫,가운데,끝에 나오는 상관 없이 % %가운데 글자만 포함되어 있으면 된다. user_ 로 시작하는 것
 
    select *
    from USER_TAB_COLUMNS
    where table_name = 'TBL_JIKWON';
    
    --- TBL_JIKWON 테이블의 jik 컬럼에 default 를 '대리'로 변경하려고 한다. ---
    alter table TBL_JIKWON
    modify jik default '대리';
    -- Table TBL_JIKWON이(가) 변경되었습니다.
    --> DATA_DEFAULT 가 '사원'에서 '대리'로 바뀜.
    
    --- TBL_JIKWON 테이블의 jik 컬럼에 default 를 삭제하려고(null) 한다. ---
    alter table TBL_JIKWON
    modify jik default null;    -- null 이 default 가 없는 것이다. (default 를 삭제한 것.)
    --> DATA_DEFAULT 가 null 로 바뀜. ==> (null) 이나 null 이나 같은 것임.
    --> 단, 'null' 라고 주면 안됨. 글자가 null 이기 때문이다.
    
    --- TBL_JIKWON 테이블의 jik 컬럼에 default 를 '사원'으로 변경하려고 한다. ---
    alter table TBL_JIKWON
    modify jik default '사원';
    --> DATA_DEFAULT 가 null에서 '사원'으로 바뀜.
    
    -- *** 자신이 만든 테이블의 제약조건에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    -- 어떻게 조회하는지 까먹었을 경우 ▼ 아래와 같이 한다.
    -- ① dict 를 통해 불러온다.
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%constraint%';    
    
    -- ② select 를 통해서 조회해본다. CONSTRAINT TYPE, SEARCH_CONDITION 을 확인!
    select *
    from USER_CONSTRAINTS
    where table_name ='EMPLOYEES';
    
    select CONSTRAINT_NAME, COLUMN_NAME, POSITION       -- 복합이 아니기 때문에 POSITION 이 1 이다.
    from USER_CONS_COLUMNS
    where table_name = 'EMPLOYEES';  -- EMPLOYEES 테이블에 걸린 제약조건을 보고싶다.
    
    -- *** 자신이 만든 데이터베이스 링크에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    -- """키워드"""에 database link 라고 적어주면 된다.
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%database link%';    
   
    select *
    from USER_DB_LINKS;
    
    -- *** 자신이 만든 시퀀스에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    -- ""키워드"" : sequence
    select *    
    from dict
    where table_name like 'USER_%' and lower(comments) like '%sequence%';    
       
    select *
    from USER_SEQUENCES;


    
    
    --------------------------------------------------------------------------
    ----- *** PL/SQL(Procedure Language / Structured Query Language) *** -----    
    
    ---- *** PL/SQL 구문에서 변수의 사용법 *** ----
    ---- execute = exec
    
    execute pcd_empInfo(101);       -- 매개변수(파라미터)에 사원번호를 넣을 것이다.
    /*
        [결과물]
        ---------------------------------------------
        사원번호    사원명    성별    월급
        ---------------------------------------------
        101       .....    ...     ....  
    */
    
    exec pcd_empInfo(103);       -- 매개변수(파라미터)에 사원번호를 넣을 것이다.
    /*
        [결과물]
        ---------------------------------------------
        사원번호    사원명    성별    월급
        ---------------------------------------------
        101       .....    ...     ....  
    */
    select lpad('-',40,'-')       -- 가운데자리 40byte 확보 ▶ 첫번째 '-'(39byte 남음) ▶ 나머지 39byte 도 '-'로 왼쪽부터 채워라.
    from dual;
    
    select rpad('-',40,'-')       -- 가운데자리 40byte 확보 ▶ 첫번째 '-'(39byte 남음) ▶ 나머지 39byte 도 '-'로 오른쪽부터 채워라.
    from dual;
    
    ---- ★★★★★ ▼▼▼ 오류 다수 발생 주의 ★★★★★ ----
    -- 오류 : 세미콜론, 쉼표, where 절 
    -- ** procedure 쓰는 이유는 **속도가 빠르기 때문** 이다. ** --

    create or replace procedure pcd_empInfo
    (p_employee_id IN number)               -- IN 뒤의 데이터타입에 ()하고 수를 지정해주면 XXX .변수는 보통 v를 쓴다. 여기선 파라미터이므로 p. (하는 사람 마음)
                                            -- IN 은 입력모드를 말한다.
                                            -- IN 만큼은 생략가능하다. (== 즉, 입력모드는 생략하고 사용 가능하다. OUT 모드와 IN, OUT 모드는 꼭! 써주어야 한다.)
                                            -- 파라미터에는 3 가지 모드가 있다. ① IN 모드 ② OUT 모드 ③ IN, OUT 모드 이다.
                                            -- 중요한 것은 파라미터에 설정된 데이터 타입은 원형만 사용해야 하며, *자릿수를 표현하면 오류*이다. 
                                            -- (ex. p_employee_id IN NUMBER(5) 이렇게 쓰면 오류이다. // p_employee_id NUMBER(데이터타입) 으로 쓴다.)
    is
        -- 변수의 선언부
        v_employee_id     number(5);      -- 자리수를 사용한다.                 
        v_ename           varchar2(50);   -- 자리수를 사용한다.
        v_gender          varchar2(10);
        v_monthsal        varchar2(15);
    begin
        -- 실행부 (select 부분은 변수에 담아야 한다.)
        select employee_id
             , first_name||' '||last_name 
             , case when substr(jubun, 7, 1) in ('1','3') then '남' else '여' end 
             , to_char(nvl(salary + (salary * commission_pct), salary),'$9,999,999') 
             INTO 
             v_employee_id, v_ename, v_gender, v_monthsal          -- v_로 시작하는 이름으로 변수를 담을 것이다.
        from employees 
        where employee_id = p_employee_id;
        
        dbms_output.put_line(lpad('-',40,'-'));     -- java에서 말하는 sysout.prinout 과 비슷.
        dbms_output.put_line('사원번호    사원명    성별    월급');     -- java에서 말하는 sysout.prinout 과 비슷.
        dbms_output.put_line(lpad('-',40,'-'));     -- java에서 말하는 sysout.prinout 과 비슷.
        
        dbms_output.put_line( v_employee_id ||' '|| v_ename ||' '|| v_gender ||' '|| v_monthsal );
        
    end pcd_empInfo;
    -- Procedure PCD_EMPINFO 이(가) 컴파일되었습니다.
        
        
    /* === SQL Developer 의 메뉴의 보기를 클릭하여 DBMS 출력을 클릭해주어야 한다. ===
       === 이어서 하단부에 나오는 DBMS 출력 부분의 녹색 + 기호를 클릭하여 local_hr 로 연결을 해준다. === 
    */    
    
    execute pcd_empInfo(101);
    ----------------------------------------
    사원번호    사원명    성별    월급
    ----------------------------------------
    101 Neena Kochhar 남     $17,000    
        
    execute pcd_empInfo(103);
    ----------------------------------------
    사원번호    사원명    성별    월급
    ----------------------------------------
    103 Alexander Hunold 남      $9,000    
    
    
    -------------- pcd_empInfo 의 procedure 에서 정보를 추가하고 싶을 때 (여기서는 age 추가)-------
    create or replace procedure pcd_empInfo
    (p_employee_id IN number)               
    is
        v_employee_id     number(5);                     
        v_ename           varchar2(50);   
        v_gender          varchar2(10);
        v_monthsal        varchar2(15);
        v_age             number(3);               
    begin
        select employee_id
             , first_name||' '||last_name 
             , case when substr(jubun, 7, 1) in ('1','3') then '남' else '여' end 
             , to_char(nvl(salary + (salary * commission_pct), salary),'$9,999,999')
             , extract (year from sysdate) - ( case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun, 1, 2)) ) + 1
             INTO 
             v_employee_id, v_ename, v_gender, v_monthsal, v_age          
        from employees 
        where employee_id = p_employee_id;      -- 그냥 sql 문을 써도 되는데 굳이 쓰는이유는 파싱작업이 들어가기 때문에 속도가 저하된다. (처음부터 procedure 를 만들어서 문법검사 일일이 안하고 실행)
        
        dbms_output.put_line(lpad('-',50,'-'));    
        dbms_output.put_line('사원번호    사원명    성별    월급    나이');     
        dbms_output.put_line(lpad('-',50,'-'));     
        
        dbms_output.put_line( v_employee_id ||' '|| v_ename ||' '|| v_gender ||' '|| v_monthsal ||'  '|| v_age);
        
    end pcd_empInfo;    
    -- Procedure PCD_EMPINFO 이(가) 컴파일되었습니다.

    exec pcd_empInfo(104);
    /*
    --------------------------------------------------
    사원번호    사원명          성별    월급        나이
    --------------------------------------------------
    104       Bruce Ernst     여     $6,000      62    
    */
    
    
    ------- **** 생성된 procedure 의 소스를 조회해봅니다. **** -------
    select text 
    from user_source                                    -- user(내가만든)_source
    where type = 'PROCEDURE' and name = 'PCD_EMPINFO';
    /*    
    "procedure pcd_empInfo
    "
    "    (p_employee_id IN number)               
    "
    "    is
    "
    "        v_employee_id     number(5);                     
    "
    "        v_ename           varchar2(50);   
    "
    "        v_gender          varchar2(10);
    "
    "        v_monthsal        varchar2(15);
    "
    "        v_age             number(3);  
    "
    "    begin
    "
    "        select employee_id
    "
    "             , first_name||' '||last_name 
    "
    "             , case when substr(jubun, 7, 1) in ('1','3') then '남' else '여' end 
    "
    "             , to_char(nvl(salary + (salary * commission_pct), salary),'$9,999,999')
    "
    "             , extract (year from sysdate) - ( case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun, 1, 2)) ) + 1
    "
    "             INTO 
    "
    "             v_employee_id, v_ename, v_gender, v_monthsal, v_age          
    "
    "        from employees 
    "
    "        where employee_id = p_employee_id;
    "
    "
    "
    "        dbms_output.put_line(lpad('-',50,'-'));    
    "
    "        dbms_output.put_line('사원번호    사원명    성별    월급    나이');     
    "
    "        dbms_output.put_line(lpad('-',50,'-'));     
    "
    "
    "
    "        dbms_output.put_line( v_employee_id ||' '|| v_ename ||' '|| v_gender ||' '|| v_monthsal ||'  '|| v_age);
    "
    "
    "
        end pcd_empInfo;    
    */    
    
    create or replace procedure pcd_empInfo_2
    (p_employee_id IN employees.employee_id%type)        -- p_employeeid 변수의 타입은 employees 테이블에 있는 employee_id 컬럼의 데이터타입과 동일하게 쓰겠다는 말이다.(employees 테이블에 있는 employee_id 컬럼 값의 type 을 참조한다는 뜻.)               
    is
        v_employee_id     employees.employee_id%type;    -- 이부분을 변경한 것임 (똑같이 procedure 된다.)                 
        v_ename           varchar2(50);   
        v_gender          varchar2(10);
        v_monthsal        varchar2(15);
        v_age             number(3);  
    begin
        select employee_id
             , first_name||' '||last_name 
             , case when substr(jubun, 7, 1) in ('1','3') then '남' else '여' end 
             , to_char(nvl(salary + (salary * commission_pct), salary),'$9,999,999')
             , extract (year from sysdate) - ( case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun, 1, 2)) ) + 1
             INTO 
             v_employee_id, v_ename, v_gender, v_monthsal, v_age          
        from employees 
        where employee_id = p_employee_id;
        
        dbms_output.put_line(lpad('-',50,'-'));    
        dbms_output.put_line('사원번호    사원명    성별    월급    나이');     
        dbms_output.put_line(lpad('-',50,'-'));     
        
        dbms_output.put_line( v_employee_id ||' '|| v_ename ||' '|| v_gender ||' '|| v_monthsal ||'  '|| v_age);
        
    end pcd_empInfo_2;        
    -- Procedure PCD_EMPINFO_2이(가) 컴파일되었습니다.
    
    
    exec pcd_empInfo_2(105);
/*    
    --------------------------------------------------
    사원번호    사원명          성별    월급     나이
    --------------------------------------------------
    105       David Austin   남      $4,800   58    
*/    


    ----    pcd_empInfo_3 에 RECORD 타입 생성하기  ---
    create or replace procedure pcd_empInfo_3
    (p_employee_id IN employees.employee_id%type)                     
    is
        -- record 타입 생성 --    
        type myEmpType is record
        (employee_id     employees.employee_id%type                    
        ,ename           varchar2(50) 
        ,gender          varchar2(10)
        ,monthsal        varchar2(15)
        ,age             number(3)                  
         );
        v_rcd myEmpType;           -- 변수 선언함. (myEmpType 는 우리가 만든 record 타입)
        
    begin
        select employee_id
             , first_name||' '||last_name 
             , case when substr(jubun, 7, 1) in ('1','3') then '남' else '여' end 
             , to_char(nvl(salary + (salary * commission_pct), salary),'$9,999,999')
             , extract (year from sysdate) - ( case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun, 1, 2)) ) + 1
             INTO       -- ★ INTO ★ : select 행들을 into v_rcd 에 담아준다.    
             v_rcd      -- rcd : record
        from employees 
        where employee_id = p_employee_id;
        
        dbms_output.put_line(lpad('-',50,'-'));    
        dbms_output.put_line('사원번호    사원명    성별    월급    나이');     
        dbms_output.put_line(lpad('-',50,'-'));     
        
        dbms_output.put_line( v_rcd.employee_id ||' '||     -- RECORD 타입 변수에 집어넣고 v.rcd_ 를 함으로써 꺼내본다.
                              v_rcd.ename ||' '|| 
                              v_rcd.gender ||' '|| 
                              v_rcd.monthsal ||'  '|| 
                              v_rcd.age);                   -- v_rcd 안에 select 행들이 들어있으므로 원래 값들을 지우고 레코드타입으로 수정한다.
                            
    end pcd_empInfo_3;            
    -- Procedure PCD_EMPINFO_3이(가) 컴파일되었습니다.
    
    
    exec pcd_empInfo_3(106);
/*
    --------------------------------------------------
    사원번호    사원명            성별    월급      나이
    --------------------------------------------------
    106       Valli Pataballa   남     $4,800   63
*/
    
    ---- pcd_empInfo_4 에 v_result  ----  :: 속도가 빠르기 때문에 Procedure pcd_empInfo_4 를 많이 쓴다.!! (Procedure)
    --- 오류 ) v_result    varchar2(1000) 에 ; 를 붙이지 않아서 오류 발생함.
    create or replace procedure pcd_empInfo_4
    (p_employee_id IN employees.employee_id%type)                     
    is
        v_all       employees%rowtype;    -- v_all 변수의 타입은 employees 테이블의 모든 컬럼을 받아주는 행타입이다.
        v_result    varchar2(1000);       -- v_result 변수 선언을 해야함.
    begin
        select * INTO v_all         -- 모든 컬럼을 읽어서 v_all 에 집어 넣는다. (v_all 은 변수임을 선언해주어야 한다.)
        from employees 
        where employee_id = p_employee_id;
        
        v_result := v_all.employee_id ||' '||       -- v_all select 되어 나온 것 중에 컬럼명(employee_id) // , 대신 ||' '|| 를 넣는다. (계속 붙어줘야 하므로 ,를 쓰지 않는다.)
                    v_all.first_name||' '|| v_all.last_name ||' '||
                    case when substr(v_all.jubun, 7, 1) in ('1','3') then '남' else '여' end ||' '||
                    to_char(nvl(v_all.salary + (v_all.salary * v_all.commission_pct), v_all.salary),'$9,999,999') ||' '||
                    ( extract (year from sysdate) - ( case when substr(v_all.jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(v_all.jubun, 1, 2)) ) + 1);
             -- v_result 값에 v_all를 넣자 (:=)
        
        dbms_output.put_line(lpad('-',50,'-'));    
        dbms_output.put_line('사원번호    사원명    성별    월급    나이');     
        dbms_output.put_line(lpad('-',50,'-'));     
        
        dbms_output.put_line( v_result );                   -- 이제 v_result 변수에 다 들어온 것임. 이것들을 dbms 에 보이자.!
                            
    end pcd_empInfo_4;            
    -- Procedure PCD_EMPINFO_4이(가) 컴파일되었습니다.
    
    exec pcd_empInfo_4(107);
    /*
    --------------------------------------------------
    사원번호    사원명    성별    월급    나이
    --------------------------------------------------
    107 Diana Lorentz 남      $4,200 15
    */

    
    
   -----------------------------------------------------------------------------------------
   ------- **** 사용자 정의 함수 **** -------
   -----------------------------------------------------------------------------------------           
   
   ----  주민번호를 입력받아서 성별을 알려주는 함수 func_gender(주민번호)을 생성해보겠습니다. ----
   /*
      [문법]
      create or replace function 함수명 
      (파라미터변수명  IN  파라미터변수의타입)
      return 리턴될타입
      is
         변수선언;           --②작성
      begin                 
         실행문;             --①작성
         return 리턴될값;
      end 함수명;
   */
    
    create or replace function func_gender
    (p_jubun  IN  varchar2) -- varchar2(13) 와 같이 자릿수를 쓰면 오류이다. !!!
    return     varchar2     -- varchar2(6) 와 같이 자릿수를 쓰면 오류이다.!!
    is
         v_result   varchar2(6);    -- 여기서는 자릿수를 써야 한다.!!
    begin
        select case when substr(p_jubun, 7, 1) in ('1','3') then '남' else '여' end             -- 입력받은 p_jubun 
               INTO
               v_result        -- select 문을 v_result 에 담겠다. --> is 로 가서 변수 선언하기.
        from dual;
        
        return v_result;
    end func_gender;
    -- Function FUNC_GENDER이(가) 컴파일되었습니다.
        
    
    select func_gender('9412172148488'),
           func_gender('9412171148488'),
           func_gender('9412173148488'),
           func_gender('9412174148488')
    from dual;
   
   ▼오류오류오류 11년생 나이가 왜저래?.... 12?.. 
   ----  주민번호를 입력받아서 나이를 알려주는 함수 func_age(나이)을 생성해보겠습니다. ----
    create or replace function func_age
    (p_jubun  IN  varchar2) -- varchar2(13) 와 같이 자릿수를 쓰면 오류이다. !!!
    return     number       -- varchar2(6) 와 같이 자릿수를 쓰면 오류이다.!!
    is
         v_result   number(3);    -- 여기서는 자릿수를 써야 한다.!!
    begin
        select extract (year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1
               INTO
               v_result        -- select 문을 v_result 에 담겠다. --> is 로 가서 변수 선언하기.
        from dual;
        
        return v_result;
    end func_age;
    -- Function FUNC_AGE(가) 컴파일되었습니다. 
    
    -- select 문 대신 := 꼴로 만들기 ①func_gender_2
    create or replace function func_gender_2
    (p_jubun  IN  varchar2) 
    return     varchar2     
    is
        v_result   varchar2(6);   
    begin
        v_result := case when substr(p_jubun, 7, 1) in ('1','3') then '남' else '여' end;       -- select 대신 바꾼 line. // := 는 '대입한다' 는 뜻.
        return v_result;
    end func_gender_2;    
    -- Function FUNC_GENDER_2이(가) 컴파일되었습니다.
    
    -- select 문 대신 := 꼴로 만들기 ①func_age_2
    
    create or replace function func_age_2
    (p_jubun  IN  varchar2) -- varchar2(13) 와 같이 자릿수를 쓰면 오류이다. !!!
    return     number       -- varchar2(6) 와 같이 자릿수를 쓰면 오류이다.!!
    is
         v_result   number(3);    -- 여기서는 자릿수를 써야 한다.!!
    begin        
        v_result := extract (year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1;
        return v_result;
    end func_age_2;
    -- Function FUNC_AGE_2(가) 컴파일되었습니다. 
    
    select employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , jubun AS 주민번호
         , func_gender(jubun) AS 성별1
         , func_gender_2(jubun) AS 성별2
         , func_age(jubun) AS 나이1
         , func_age_2(jubun) AS 나이2
    from employees;


    -- employees 테이블에서 나이가 25세 이상 35세 이하인 여자만
    -- 사원번호, 사원명, 주민번호, 나이, 성별을 나타내세요.
    select employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , jubun AS 주민번호
         , func_age(jubun) AS 나이
         , func_gender(jubun) AS 성별    
    from employees
    where func_age(jubun) between 25 and 35 AND 
          func_gender(jubun) = '여'

    
    
    -- employees 테이블에서 연령대별, 성별 인원수와 퍼센티지(%) 를 나타내세요.
    -- inline view 쓸 필요 없이 *함수*를 쓰는것이 훨씬 편하다.
    -- ① round 함수       
    select trunc( func_age(jubun), -1 ) AS 연령대
         , nvl(func_gender(jubun),' ') AS 성별
         , count(*) AS 인원수
         , round(count(*) /(select count(*) from employees) * 100, 1) AS 퍼센티지 
    from employees
    group by trunc( func_age(jubun), -1 ), func_gender(jubun)           -- ①연령대'별' 그룹 (20대, 30대, 40대 ...) ② 성별 그룹
    order by 1;             
    
    -- ② ROLLUP 함수
    select NVL(TO_CHAR(trunc( func_age(jubun), -1 )),' ') AS 연령대     -- 문자로 바꿔야 공백이 혼용 가능 // 숫자만 오른쪽 문자는 왼쪽 정렬 . ▶ 연령대가 왼쪽 정렬이 됨.(문자화)
         , NVL(func_gender(jubun),' ') AS 성별
         , count(*) AS 인원수
         , round(count(*) /(select count(*) from employees) * 100, 1) AS 퍼센티지 
    from employees
    group by ROLLUP (trunc( func_age(jubun), -1 ), func_gender(jubun));          

    
    --- *** ==== 생성된 함수의 소스를 조회해봅니다.  ==== *** ---
    select LINE, TEXT
    from user_source
    where type = 'FUNCTION' and name = 'FUNC_AGE';      
    /*
    "function func_age
    "
    "    (p_jubun  IN  varchar2) -- varchar2(13) 와 같이 자릿수를 쓰면 오류이다. !!!
    "
    "    return     number       -- varchar2(6) 와 같이 자릿수를 쓰면 오류이다.!!
    "
    "    is
    "
    "         v_result   number(4);    -- 여기서는 자릿수를 써야 한다.!!
    "
    "    begin
    "
    "        select extract (year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1
    "
    "               INTO
    "
    "               v_result        -- select 문을 v_result 에 담겠다. --> is 로 가서 변수 선언하기.
    "
    "        from dual;
    "
    "
    "
    "        return v_result;
    "
        end func_age;
    */


    ---- [퀴즈] 아래와 같은 결과물이 나오도록 프로시저( pcd_employees_info )를 생성하세요...
    ----       성별과 나이는 위에서 만든 함수를 사용하세요..
    
    execute pcd_employees_info(101);  -- 여기서 숫자 101은 사원번호이다. 
    exec    pcd_employees_info(101);  -- 여기서 숫자 101은 사원번호이다.
    
    /*
      ----------------------------------------------------
       사원번호    부서명    사원명    입사일자   성별   나이
      ----------------------------------------------------
        101       .....    ......   .......   ....  ....
    */
    
    -- 각각의 다른 테이블에 있는 데이터들을 꺼내와야 하므로 JOIN 을 쓴다.
    create or replace procedure pcd_employees_info
    (p_employee_id IN employees.employee_id%type)       --employees 테이블에 있는 employee_id 컬럼의 타입을 받겠다. 파라미터는 사원번호(p_employee_id) 를 받는 것이다. p(파라미터)_employee_id.
    is  -- 변수 선언부
        v_employee_id       employees.employee_id%type;                     
        v_department_name   departments.department_name%type;
        v_ename             varchar2(40);       -- 컬럼 두개를 합친 것이기 때문에 특정 컬럼을 말할 수 없어서 varchar 로 씀.
        v_hiredate          varchar2(10);
        v_gender            varchar2(6);
        v_age               number(3);               
    begin   
        WITH E AS
        (
            select employee_id
                 , first_name ||' '|| last_name AS ENAME
                 , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                 , func_gender(jubun) AS GENDER 
                 , func_age(jubun) AS AGE
                 , department_id -- JOIN 조건절 때문에 department_id 를 넣어줌.   
            from employees
            where employee_id = p_employee_id         -- 입력받은 p_employee_id 사원의 행만 뽑아온다.
        )
        select E.employee_id, D.department_name, E.ENAME, E.HIREDATE, E.GENDER, E.AGE
             INTO
               v_employee_id, v_department_name, v_ENAME, v_HIREDATE, v_GENDER, v_AGE -- 하나하나 다 변수 v_ 들어옴 ▶ 변수 선언해야함 (위에 is로 올라가서)
        from departments D RIGHT JOIN E           -- employees 테이블에는 성별, 나이(함수로 만들어둠)가 없으므로 view 를 만들어서 필요한 정보만 뽑아온다. ▶ 위의 WITH 절 // Kimberly 는 department_id 가 null 이기 때문에 right join 씀.
        ON D.department_id = E.department_id;    -- 위의 WITH 절 가서 department_id 추가했음.
        
        dbms_output.put_line(lpad('-',50,'-'));    
        dbms_output.put_line('사원번호    부서명    사원명    입사일자   성별   나이');     
        dbms_output.put_line(lpad('-',50,'-'));     
        
        dbms_output.put_line( v_employee_id ||' '|| v_department_name ||' '|| v_ename ||' '|| v_hiredate ||' '|| v_gender ||' '|| v_age);
        
    end pcd_employees_info;    
    -- Procedure PCD_EMPLOYEES_INFO이(가) 컴파일되었습니다.

    execute pcd_employees_info(101);  -- 여기서 숫자 101은 사원번호이다. 
    exec    pcd_employees_info(101);  -- 여기서 숫자 101은 사원번호이다.    
    /*
        --------------------------------------------------
        사원번호    부서명    사원명    입사일자   성별   나이
        --------------------------------------------------
        101 Executive Neena Kochhar 2005-09-21 남 38
    */

    --------------------------------------------------------------------------------------------------------------
    -- data_not_found 일 때 예외처리 하기.
    
    execute pcd_employees_info(337);            -- 사원번호 337 은 존재하지 않는 사원번호 이다.
    -- ★오류 01403. 00000 -  "no data found" ==> 프로시저에서 데이터(행)가 없으면 no data found 라는 오류가 발생한다.
    -- 오류가 발생하면 exception 처리를 해야 한다.
    
    -- [데이터(행)가 없을 경우 해결책] --
    --> 예외절(Exception) 처리를 해주면 된다. (end 절 위를 보자.)
    create or replace procedure pcd_employees_info
    (p_employee_id IN employees.employee_id%type)       
    is  -- 변수 선언부
        v_employee_id       employees.employee_id%type;                     
        v_department_name   departments.department_name%type;
        v_ename             varchar2(40);               
        v_hiredate          varchar2(10);
        v_gender            varchar2(6);
        v_age               number(3);               
    begin   
        WITH E AS
        (
            select employee_id
                 , first_name ||' '|| last_name AS ENAME
                 , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                 , func_gender(jubun) AS GENDER 
                 , func_age(jubun) AS AGE
                 , department_id -- JOIN 조건절 때문에 department_id 를 넣어줌.   
            from employees
            where employee_id = p_employee_id         -- 입력받은 p_employee_id 사원의 행만 뽑아온다.
        )
        select E.employee_id, D.department_name, E.ENAME, E.HIREDATE, E.GENDER, E.AGE
             INTO
               v_employee_id, v_department_name, v_ENAME, v_HIREDATE, v_GENDER, v_AGE 
        from departments D RIGHT JOIN E           
        ON D.department_id = E.department_id;    
        
        dbms_output.put_line(lpad('-',50,'-'));    
        dbms_output.put_line('사원번호    부서명    사원명    입사일자   성별   나이');     
        dbms_output.put_line(lpad('-',50,'-'));     
        
        dbms_output.put_line( v_employee_id ||' '|| v_department_name ||' '|| v_ename ||' '|| v_hiredate ||' '|| v_gender ||' '|| v_age);
    
        EXCEPTION
            WHEN no_data_found THEN          -- no data found 오류가 발생하면, no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임.
                dbms_output.put_line('>> 사원번호 ' || p_employee_id || '은 존재하지 않습니다. <<');      -- java 의 sysout.println 과 같이 출력해주는 부분
    end pcd_employees_info; 
    
    -- Procedure PCD_EMPLOYEES_INFO이(가) 컴파일되었습니다.
    
    --- EXCEPTION 처리 후 다시한번 존재하지 않는 사원번호 337 번을 출력하여 아래와 같은 문구가 DBMS 에서 출력되도록 한다.
    execute pcd_employees_info(107);      
    -- 107 번 행은 존재하는 사원번호 이므로 정상적으로 출력.    
    execute pcd_employees_info(337);      
    -- >> 사원번호 337은 존재하지 않습니다. <<

    
    
    ------- ===== ***** 제어문(IF문) ***** ===== ------- 
    /*
        ※ 형식
        
        if      조건1  then  실행문장1;       -- 조건 1이 참이라면 실행문장1을 끝낸다.
        elsif   조건2  then  실행문장2;       -- elsif 엘시프.
        elsif   조건3  then  실행문장3;        
        else                실행문장4;       -- 전부 다 아니라면 else.        
        end     if;                           -- end if; 꼭 써주기
    
    */
    
    update employees set employee_id = 101
    where employee_id = 102;
    -- ★오류 ORA-00001: unique constraint (HR.EMP_EMP_ID_PK) violated
    -- employee_id 는 Primary key 이므로 막 바꿀 수 X..
    
    create or replace function func_age_3
    (p_jubun  IN  varchar2) -- varchar2(13) 와 같이 자릿수를 쓰면 오류이다. !!!
    return number           -- varchar2(6) 와 같이 자릿수를 쓰면 오류이다.!!
    is
       v_genderNum  varchar2(1) := substr(p_jubun, 7, 1);
       -- v_genderNum 에는 '1' 또는 '2' 또는 '3' 또는 '4' 가 들어올 것이다. (jubun 7,1 이 1/2/3/4)
       v_year       number(4);
       error_jubun  EXCEPTION; -- error_jubun 는 사용자(개발자)가 정의하는 예외절(Exception) 임을 선언한다. 
       v_age        number(3);
    begin
        if     length(p_jubun) != 13 then RAISE error_jubun;      -- error_jubun 는 사용자(개발자)가 정의하는 예외절(Exception)이다. (13 자리가 아니라면 아래 if elsif 절로 넘어가지도 않는다.)
        end if;

        if     v_genderNum IN('1','2') then v_year := 1900;        --> 변수인 v_year 에 넣겠다. --> is 에 가서 v_year 변수 선언하기.
        elsif  v_genderNum IN('3','4') then v_year := 2000;        --> 변수인 v_year 에 넣겠다. --> is 에 가서 v_year 변수 선언하기.
        else   RAISE error_jubun;                                  -- error_jubun 는 사용자(개발자)가 정의하는 예외절(Exception)이다. // 1,2,3,4 외의 것이 들어오면?        
                                                                   -- error_jubun 가 무엇인지 is 에 가서 변수로 정의 해주자.
        end if;
        
        v_age := extract (year from sysdate) - ( v_year + to_number( substr(p_jubun,1,2) ) ) + 1;
        return v_age;
        
     EXCEPTION
        WHEN error_jubun THEN 
             RAISE_APPLICATION_ERROR(-20001, '>> 올바르지 않은 주민번호 입니다. <<');        
             -- -20001 은 오류번호로써, 사용자(개발자)가 정의해주는 EXCEPTION 에 대해서는 오류번호를 -20001 부터 -20999 까지만 사용하도록 오라클에서 비워두었다.
             -- ORACLE -20001 부터 -20999 까지 쓰지 않고 사용자가 사용하게끔 비워둠.(오류번호는 항상 정해져있음.)
             -- (ex. 오라클에서 쓰는 형식 ==> *ORA-00001*: unique constraint (HR.EMP_EMP_ID_PK) violated)
             
    end func_age_3;
    -- Function FUNC_AGE_3(가) 컴파일되었습니다. 
    
    
    select '9001192345988', func_age_3('9001192345988')
    from dual;
    -- 나이가 33 살로 잘 나옴.
    
    -- [▼ 검증 ▼] -- 
    -- EXCEPTION 처리 해둔 것 결과 ▼   ( 7번째로 시작하는 자리에서 1,2,3,4 를 제외한 숫자가 들어감.)
    select '9001190345988', func_age_3('9001190345988')
    from dual;    
    -- ORA-20001: >> 올바르지 않은 주민번호 입니다. <<
    
    select '900119234598', func_age_3('900119234598') -- 주민번호 길이가 틀림. (13자리 → 12자리)
    from dual;
    -- ORA-20001: >> 올바르지 않은 주민번호 입니다. <<   -- if 절로 오류 만들었음.

    select '9001192s45987', func_age_3('9001192s45987') -- 주민번호 가운데에 s 라는 문자가 들어감. ▶ 하나하나 숫자인지 검증하는 것이 필요.(반복 검증)
    from dual;
    -- 9001192s45987	33  ==> 지금은 잘못된 주민번호 이더라도 지금은 나이가 나온다.
    --                          잘못된 주민번호 이므로 오류가 뜨게끔 반복문을 배운 후에 고치도록 하겠습니다.                                                                          
    
    
    ---- ▼ func_age_3(jubun) AS 나이3 결과물 확인용 select 문

    select employee_id AS 사원번호
         , first_name ||' '|| last_name AS 사원명
         , jubun AS 주민번호
         , func_age(jubun) AS 나이1
         , func_age_2(jubun) AS 나이2
         , func_age_3(jubun) AS 나이3
    from employees;
    
    
        


    ---------- ===== **** 반복문 **** ===== ----------
      /*
         반복문에는 종류가 3가지가 있다.
      
         1. 기본 LOOP 문
         2. FOR LOOP 문
         3. WHILE LOOP 문
      */

    ----- ====== ****  1. 기본 LOOP 문 **** ====== -----
    /*
      [문법]
      LOOP
          실행문장;
      EXIT WHEN 탈출조건;   -- 탈출조건이 참 이라면 LOOP 를 탈출한다.
      END LOOP;
    */

    create table tbl_looptest_1
    (bunho      number
    ,name       varchar2(50)
    );
    -- Table TBL_LOOPTEST_1이(가) 생성되었습니다.

    --- *** tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다. *** ---
    create or replace procedure pcd_tbl_looptest_1_insert
    (p_name     IN      tbl_looptest_1.name%type        -- tbl_looptest_1 컬럼에 있는 name의 type 을 참조하겠다.
    ,p_count    IN      number)                         -- p_count 에 20000 을 넣을 것이다.
    is
        v_bunho tbl_looptest_1.bunho%type := 0;         -- 변수의 초기화!!! (변수에 값을 처음부터 넣어주기, 초기값을 0 으로 하겠다.)
    begin
        LOOP
            v_bunho := v_bunho +1;          -- v_bunho 는 반복할때마다 1씩 증가한다.( java 에는 ++ 이 있지만, 오라클에서는 +1 로 1 증가를 나타낸다.)
            
        EXIT WHEN v_bunho > p_count;        -- 20001 > 20000탈출조건이 참 이라면 LOOP 를 탈출한다.
        
            insert into tbl_looptest_1(bunho, name) values(v_bunho, p_name||v_bunho);
        END LOOP;        
    end pcd_tbl_looptest_1_insert;
    -- Procedure PCD_TBL_LOOPTEST_1_INSERT이(가) 컴파일되었습니다.

    exec pcd_tbl_looptest_1_insert('이순신',20000);
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.

    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;    -- 20000
    
    rollback;
    -- 롤백 완료.
    
    exec pcd_tbl_looptest_1_insert('엄정화',50000);   

    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;     -- 50000
    
    commit;
    
    exec pcd_tbl_looptest_1_insert('설현',30000);    -- 30000

    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;     -- 80000  
    
    commit;
    -- 커밋 완료.
    
    truncate table tbl_looptest_1;      
    -- tbl_looptest_1 테이블을 싹다 비우고 완전 초기화 시킴. (autocommit 이므로 rollback 불가.)
    -- Table TBL_LOOPTEST_1이(가) 잘렸습니다.

    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;     -- 0  
    
    
    --- **** 이름이 없는 익명 프로시저(Anonymous Procedure)로 tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다. **** ---    
    --  일회용 프로시저(이름이 없는 익명 procedure, 접속에 들어가서 프로시저 조회해도 없음)
    declare
        v_bunho number := 0;                -- 변수의 선언 및 초기화
    begin
        LOOP
            v_bunho := v_bunho +1;          -- v_bunho 는 반복할때마다 1씩 증가한다.
        
            EXIT WHEN   v_bunho > 20000;    -- 20000 보다 크면 탈출해라.
        
            insert into tbl_looptest_1(bunho, name) values(v_bunho, '이혜리'||v_bunho);
        
        END LOOP;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    -- '이혜리' 가 20000개 들어온다. 
    
    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;    -- 20000
    
    rollback;
    -- 롤백 완료.
    
    ----- ====== ****  2. FOR LOOP 문 **** ====== -----
    /*
      [문법]
      declare               --> 변수가 필요할때만 declare 를 쓴다.
      
      begin
          for 변수  in  [reverse]  시작값..마지막값  loop                --> [reverse 를 쓰면 ] 마지막값에서 매번 1씩 빼서 시작값까지 가는 것 (reverse, 거꾸로)
              실행문장;
              
          end loop;
      end
    */    
    
    select count(*)
    from tbl_looptest_1;    -- 0
    
    
    --- **** 이름이 없는 익명 프로시저(Anonymous Procedure)로 tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다. **** ---    
    --  일회용 프로시저(이름이 없는 익명 procedure, 접속에 들어가서 프로시저 조회해도 없음)

    begin
        for i in 1..20000 loop        --  변수 i에 맨처음 1이 들어가고 매번 1씩 증가된 값이 i 에 들어가는데, 20000 까지 i에 들어간다.(loop) // 변수는 자동적으로 number 타입이 됨. 변수 선언 안해도 됨.
            insert into tbl_looptest_1(bunho, name) values(i, '이혜리'||i);    -- 즉, 20000번 반복하는 것이다.
        
        END LOOP;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.    
    
    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;     -- 20000
    
    rollback;
    
    ---------------------- 변수를 쓰고자 할 때 declare 를 추가한다. (변수추가 !!) ------------------------
    -- 여기서는 v_name 이 변수
    declare
        v_name  varchar2(20) := '강감찬';  -- 변수의 선언 및 초기화
    begin
        for i in 1..20000 loop            --  변수 i에 맨처음 1이 들어가고 매번 1씩 증가된 값이 i 에 들어가는데, 20000 까지 i에 들어간다.(loop) // 변수는 자동적으로 number 타입이 됨. 변수 선언 안해도 됨.
            insert into tbl_looptest_1(bunho, name) values(i, v_name||i);    -- 즉, 20000번 반복하는 것이다.
        
        END LOOP;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.     
        
    select *
    from tbl_looptest_1
    order by bunho asc;      -- 강감찬 1~ 강감찬 20000
    
    select count(*)
    from tbl_looptest_1;     -- 20000
    
    rollback;
    
    ---------------------- FOR LOOP 문에서 reverse 를 썼을 때 ------------------------        
    declare
        v_name  varchar2(20) := '아이유';  -- 변수의 선언 및 초기화
    begin
        for i in reverse 1..100 loop            --  변수 i에 맨처음 100이 들어가고 매번 1씩 감소된 값이 i 에 들어가는데, 1 까지 i에 들어간다.(loop) // 변수는 자동적으로 number 타입이 됨. 변수 선언 안해도 됨.
            insert into tbl_looptest_1(bunho, name) values(i, v_name||i);    -- 즉, 100번 반복하는 것이다.
        
        END LOOP;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.     
    
    
    select *
    from tbl_looptest_1;      -- 아이유100 ~ 아이유1
    
    select count(*)
    from tbl_looptest_1;     -- 100
    
    rollback;    
    -- 롤백 완료.
    
    ----- ====== ****  3. WHILE LOOP 문 **** ====== -----
    /*
     [문법]
     WHILE  조건  LOOP
         실행문장;   -- 조건이 참이라면 실행함. 조건이 거짓이 되어지면 반복문을 빠져나간다.
     END LOOP;
    */
    
    declare
          v_cnt   number := 1;    -- 변수의 선언 및 초기화
    begin
          while not(v_cnt > 20000) loop          -- not(탈출조건): 탈출조건이 참이라면 전체가 거짓이 되므로 반복문을 빠져나간다. (~라면 하지마!) --> v_cnt 가 20000 보다 크면 탈출해라.
          insert into tbl_looptest_1(bunho, name) values(v_cnt, '홍길동'||v_cnt);
          v_cnt := v_cnt + 1;
          end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.

    select *
    from tbl_looptest_1
    order by bunho asc;      
    
    select count(*)
    from tbl_looptest_1;                
    
    rollback;    
    -- 롤백 완료.    
    
    --- 잘못된 주민번호를 반복문으로 검사하여 오류 고치기 ---
    select '9001192s45987', func_age_3('9001192s45987') -- 주민번호 가운데에 s 라는 문자가 들어감. ▶ 하나하나 숫자인지 검증하는 것이 필요.(반복 검증)
    from dual;
    
    create or replace function func_age_3
    (p_jubun  IN  varchar2) -- varchar2(13) 와 같이 자릿수를 쓰면 오류이다. !!!
    return number           -- varchar2(6) 와 같이 자릿수를 쓰면 오류이다.!!
    is
       v_genderNum  varchar2(1) := substr(p_jubun, 7, 1);
       -- v_genderNum 에는 '1' 또는 '2' 또는 '3' 또는 '4' 가 들어올 것이다. (jubun 7,1 이 1/2/3/4)
       
       v_cnt        number(2) := 1;
       v_chr        varchar2(3);        -- 한글이 올 수 있기 때문에 3 써줌
       
       v_year       number(4);
       error_jubun  EXCEPTION;          -- error_jubun 는 사용자(개발자)가 정의하는 예외절(Exception) 임을 선언한다. 
       v_age        number(3);
    begin
        if length(p_jubun) != 13 then RAISE error_jubun;    -- ① 13 자리가 아니라면 아래 if elsif 절로 넘어가지도 않는다. (주민번호는 13 자리가 기본임)
        else
        /*
            loop
                v_chr := substr(p_jubun, v_cnt, 1);          -- v_cnt 가 1씩 증가하면서 하나하나씩 입력한 주민번호(p_jubun)가 숫자인지 검사(v_cnt는 변수이므로 위에 올라가서 변수선언)                
                if not(v_chr between '0' and '9') 
                   then RAISE error_jubun;                  ---- error_jubun 는 사용자(개발자)가 정의하는 예외절(Exception) 임을 선언한다. 
                end if;
                v_cnt := v_cnt + 1;
                exit when v_cnt > 13;                       -- v_cnt 가 13 보다 크면 탈출! (위에서 v_cnt +1 임)
            end loop;    
        */
        -- 또는 for loop 문 사용
            for i in 1..13 loop                     -- i 에 첫번째가 들어옴.
                v_chr := substr(p_jubun, i, 1);     -- v_chr 라는 변수에 := 뒤의 것을 넣어준다.
                if not(v_chr between '0' and '9')
                    then RAISE error_jubun;
                end if;                
            end loop;
        
        end if;

        if     v_genderNum IN('1','2') then v_year := 1900;        --> 변수인 v_year 에 넣겠다. --> is 에 가서 v_year 변수 선언하기.
        elsif  v_genderNum IN('3','4') then v_year := 2000;        --> 변수인 v_year 에 넣겠다. --> is 에 가서 v_year 변수 선언하기.
        else   RAISE error_jubun;                                  -- error_jubun 는 사용자(개발자)가 정의하는 예외절(Exception)이다. // 1,2,3,4 외의 것이 들어오면?        
                                                                   -- error_jubun 가 무엇인지 is 에 가서 변수로 정의 해주자.
        end if;

        v_age := extract (year from sysdate) - ( v_year + to_number( substr(p_jubun,1,2) ) ) + 1;
        return v_age;

     EXCEPTION
        WHEN error_jubun THEN 
             RAISE_APPLICATION_ERROR(-20001, '>> 올바르지 않은 주민번호 입니다. <<');        
             -- -20001 은 오류번호로써, 사용자(개발자)가 정의해주는 EXCEPTION 에 대해서는 오류번호를 -20001 부터 -20999 까지만 사용하도록 오라클에서 비워두었다.
             -- ORACLE -20001 부터 -20999 까지 쓰지 않고 사용자가 사용하게끔 비워둠.(오류번호는 항상 정해져있음.)
             -- (ex. 오라클에서 쓰는 형식 ==> *ORA-00001*: unique constraint (HR.EMP_EMP_ID_PK) violated)

    end func_age_3;    
    -- Function FUNC_AGE_3이(가) 컴파일되었습니다.
    
    --- ▼ 위의 식을 통해서 아래의 잘못된 주민번호를 반복문으로 검사하여 오류 고치기 ---
    -- 9001192s45987	33  ==> 지금은 잘못된 주민번호 이더라도 지금은 나이가 나온다. (반복문을 쓰기 전에는..)
    --                          잘못된 주민번호 이므로 오류가 뜨게끔 반복문을 배웠으니 지금부터 고치도록 하겠습니다.                 
    select '9001192s45987', func_age_3('9001192s45987') -- 주민번호 가운데에 s 라는 문자가 들어감. ▶ 하나하나 숫자인지 검증하는 것이 필요.(반복 검증)
    from dual;
    -- ORA-20001: >> 올바르지 않은 주민번호 입니다. <<   (사용자(개발자) 가 설정한 오류 문구 출력)
    
    
    
    
    
    create table tbl_member_test1
    (userid      varchar2(20)
    ,passwd      varchar2(20) not null
    ,name        varchar2(30) not null
    ,constraint  PK_tbl_member_test1_userid  primary key(userid)
    );
    -- Table TBL_MEMBER_TEST1이(가) 생성되었습니다.
    
    
    -- [퀴즈] tbl_member_test1 테이블에 insert 해주는 pcd_tbl_member_test1_insert 라는 프로시저를 작성하세요.    ( 패스워드 검사 )
    
    exec pcd_tbl_member_test1_insert('hongkd','qwer1234$','홍길동');  --> 정상적으로 insert 되어진다.
    
    exec pcd_tbl_member_test1_insert('eomjh','a3$','유관순');      --> 오류메시지 -20002 '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' 이 뜬다. 그러므로 insert 가 안되어진다. 
    exec pcd_tbl_member_test1_insert('eomjh','abc1234','유관순');  --> 오류메시지 -20002 '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' 이 뜬다. 그러므로 insert 가 안되어진다.    
 
    -- ▼ 아래 만들기
    create or replace procedure pcd_tbl_member_test1_insert
    (p_userid   IN   tbl_member_test1.userid%type
    ,p_passwd   IN   tbl_member_test1.passwd%type
    ,p_name     IN   tbl_member_test1.name%type
    )
    is 
        v_length        number(20);                  -- passwd 가 varchar2(20) 이므로 number(20)으로 설정.
        error_insert    exception;                   -- error_insert 는 exception 이라고 알려주는 것
        v_ch            varchar2(1);
        v_flag_alphabet number(1):= 0;               -- 초기값을 0으로 설정
        v_flag_number   number(1):= 0;
        v_flag_special  number(1):= 0;
    begin
        v_length := length(p_passwd);                -- 검사대상인 passwd
    
        if ( v_length < 5 OR v_length > 20 ) then    -- ① 길이 검사
             raise error_insert;                     -- 사용자가 정의하는 예외절(exception) 을 구동시켜라.
        else
            for i in 1..v_length loop               -- ② 입력한 passwd 글자 수 만큼 내용 제대로 들어갔는지 검사.
                 v_ch := substr(p_passwd, i, 1);
                 
                 if (v_ch between 'a' and 'z' OR v_ch between 'A' and 'Z') then  -- ③ 입력받은 v_ch 가 영문 소문자 or 영문 대문자 확인
                     v_flag_alphabet := 1;
                 elsif (v_ch between '0' and '9') then      -- ④ 숫자라면 (숫자라면 깃발_number 가 1)   
                     v_flag_number := 1;
                 else                                       -- ⑤ 특수문자라면
                     v_flag_special := 1;
                 end if;
            end loop;
             
            if(v_flag_alphabet * v_flag_number * v_flag_special = 1) then   -- 한개라도 0이면 0, 모두 1이면 1!! (java에서 깃발처럼!!)
               insert into tbl_member_test1(userid, passwd, name) values (p_userid, p_passwd, p_name);
            else
                 raise error_insert;                     -- 사용자가 정의하는 예외절(exception) 을 구동시켜라.
            end if;
            
        end if;
        
        exception
            when error_insert then
                 raise_application_error(-20002, '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' ); 
        
    end pcd_tbl_member_test1_insert;
  -- Procedure PCD_TBL_MEMBER_TEST1_INSERT이(가) 컴파일되었습니다.
      
  ------------ ▼ 올바른지 확인  
    select * 
    from tbl_member_test1;
    
    exec pcd_tbl_member_test1_insert('eomjh','a3$','유관순');      --> 오류
/*
    오류 보고 -
    ORA-20002: 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.
*/    
    exec pcd_tbl_member_test1_insert('eomjh','abc1234','유관순');  --> 오류  
/*
    오류 보고 -
    ORA-20002: 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.
*/    
    exec pcd_tbl_member_test1_insert('hongkd','qwer1234$','홍길동');  --> 정상적으로 insert 되어진다.
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.

    select * 
    from tbl_member_test1;    
    -- 홍길동
    
    commit;
    -- 커밋 완료.
    
    
    ------------ ***** 사용자 정의 예외절(EXCEPTION) ***** ----------------
     예외절 = 오류절
     
     ※ 형식
     
     exception
          when  익셉션이름1  [or 익셉션이름2]  then
                실행문장1;
                실행문장2;
                실행문장3;
                
          when  익셉션이름3  [or 익셉션이름4]  then
                실행문장4;
                실행문장5;
                실행문장6; 
                
          when  others  then  
                실행문장7;
                실행문장8;
                실행문장9; 
   ------------------------------------------------------------------   
   
   /*
      === tbl_member_test1 테이블에 insert 할 수 있는 *요일명*과 *시간*을 제한해 두겠습니다. ===
      --- ex. 은행 오후 3시반까지만 영업 / 주말은 휴일 
        
          tbl_member_test1 테이블에 insert 할 수 있는 요일명은 월,화,수,목,금 만 가능하며
          또한 월,화,수,목,금 중에 오후 2시 부터 오후 5시 이전까지만(오후 5시 정각은 안돼요) insert 가 가능하도록 하고자 한다.
          만약에 insert 가 불가한 요일명(토,일)이거나 불가한 시간대에 insert 를 시도하면 
          '영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!' 이라는 오류메시지가 뜨도록 한다. 
   */
   
   --- ①요일명, 날짜 exception
   --- ②passwd 검사 exception
   
    create or replace procedure pcd_tbl_member_test1_insert
    (p_userid   IN   tbl_member_test1.userid%type
    ,p_passwd   IN   tbl_member_test1.passwd%type
    ,p_name     IN   tbl_member_test1.name%type
    )
    is
      error_dayTime    exception;
      v_length         number(20);
      error_insert     exception; 
      v_ch             varchar2(1);
      v_flag_alphabet  number(1) := 0;
      v_flag_number    number(1) := 0;
      v_flag_special   number(1) := 0;      
    begin
        
        -- 입력(insert)이 불가한 요일명과 시간대 인지 아닌지 알아봅니다. --
        if (to_char(sysdate, 'd') IN('1','7') OR  -- to_char(sysdate, 'd') ==> '1'(일), '2'(월), '3'(화), '4'(수), '5'(목), '6'(금), '7'(토)
            to_char(sysdate, 'hh24') < '14' OR to_char(sysdate, 'hh24') > '16')        -- 13시 59분 59초 까지 이므로 < 14로 // 16시 59분 59초 까지 이므로 > 17  
           then raise error_dayTime;    -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
            
        end if;        
        
        v_length := length(p_passwd);
        
        if ( v_length < 5 OR v_length > 20 ) then
             raise error_insert;        -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
        else
            for i in 1..v_length loop
                v_ch := substr(p_passwd, i, 1);
                
                if (v_ch between 'a' and 'z' OR v_ch between 'A' and 'Z') then  -- 영문자라면 
                    v_flag_alphabet := 1;
                elsif (v_ch between '0' and '9') then  -- 숫자 라면    
                    v_flag_number := 1;
                else  -- 특수문자 라면
                    v_flag_special := 1;
                end if;
            end loop;
            
            if(v_flag_alphabet * v_flag_number * v_flag_special = 1) then
               insert into tbl_member_test1(userid, passwd, name) values(p_userid, p_passwd, p_name);
            else
               raise error_insert;  -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
            end if;
            
        end if;
        
        exception 
             when error_dayTime then
                  raise_application_error(-20002, '영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!');
                  
             when error_insert then
                  raise_application_error(-20003, '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.');
                                                                            
    end pcd_tbl_member_test1_insert;
    
    -- Procedure PCD_TBL_MEMBER_TEST1_INSERT이(가) 컴파일되었습니다.
   
   
    ----- ▼ 검사
    exec pcd_tbl_member_test1_insert('eomjh','qwer1234$','엄정화');  --> 정상적으로 insert 된다.

    
    commit;
    
    select *
    from tbl_member_test1;
    
    exec pcd_tbl_member_test1_insert('leess','qwer1234$','이순신');  --> 17 시가 지나서 오류창이 뜬다.
    /*
    오류 보고 -
    ORA-20002: 영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!
    
    왜냐하면 현재 목요일 오후 17시 0분 30초 이므로 입력 불가.
    */






    ----- ==== **** 오라클에서는 배열이 없지만 배열처럼 사용되는 table 타입 변수가 있다. **** ===== -----
    ----            그래서 *table 타입 변수*를 사용하여 자바의 배열처럼 사용한다. -- 
  
    create or replace procedure pcd_employees_info_deptid
    (p_department_id  IN  employees.department_id%type)             -- 입력을 받는 파라미터가 사원번호(employees_id) 가 아니라 부서번호(department_id) 이다.
    is
      v_department_id      employees.department_id%type;
      v_department_name    departments.department_name%type;
      v_employee_id        employees.employee_id%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
    
    begin
        
        with E as
        (
          select department_id
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE
          from employees
          where department_id = p_department_id
        )
        select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
               into
               v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age 
        from departments D right join E
        on D.department_id = E.department_id;
        
        dbms_output.put_line( lpad('-',60,'-') );
        dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
        dbms_output.put_line( lpad('-',60,'-') );
        
        dbms_output.put_line( v_department_id || ' ' || v_department_name || ' ' || 
                              v_employee_id || ' ' || v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );
                              
        EXCEPTION 
           WHEN no_data_found THEN   -- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임.
                dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        
    end pcd_employees_info_deptid;       
    -- Procedure PCD_EMPLOYEES_INFO_DEPTID이(가) 컴파일되었습니다.

    exec pcd_employees_info_deptid(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. <<
    
    exec pcd_employees_info_deptid(10);    
/*    
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    10 Administration 200 Jennifer Whalen 2003-09-17 여 45        
*/            
        
    exec pcd_employees_info_deptid(30); -- (직원이 6명 : 복수개 행 ▶ 변수 1개에 다 담아서 처리가 불가함)
    /*
    오류보고 -
    01422. 00000 -  "exact fetch returns more than requested number of rows" (요구된 행의 갯수 = 1개, 실제 출력될 갯수 = 6개)
    
    왜냐하면
    30번 부서에 근무하는 직원은 6명이므로 
    select 된 결과는 6개 행이 나와야 하는데, Procedure 에서 select 된 컬럼의 값을 담을 변수 (v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age) 는
    데이터 값을 1개 밖에 담지 못하므로 위와 같은 오류가 발생한다.
    변수는 값을 1개밖에 못받음. (6개를 다 받을 수 없다.)
    
    [예시]
    자바를 예를 들면
     int jumsu = 0;
     
     변수 jumsu 에 90, 95, 88, 75, 91, 80 이라는 6개의 점수를 입력하고자 한다.
     돼요? 안돼요?  안됩니다.
 
     jumsu = 90;
     jumsu = 85;
     jumsu = 88;
     jumsu = 75;
     jumsu = 91;
     jumsu = 80;
     
     최종적으로 변수 jumsu 에 담긴 값은 80 이 된다. (맨 나중에 들어온 값만 들어가게 됨)
     
     그래서 *자바에서는* 아래와 같이 배열로 만들어서 한다. 
     int[] jumsuArr = new int[6]; 
     
     jumsuArr[0] = 90;
     jumsuArr[1] = 85;
     jumsuArr[2] = 88;
     jumsuArr[3] = 75;
     jumsuArr[4] = 91;
     jumsuArr[5] = 80;
     
     -------------------------------
     | 90 | 85 | 88 | 75 | 91 | 80 | 
     -------------------------------
    */
    
    select employee_id
    from employees
    where department_id = 30;       -- 6개 행이 출력되어야 함.
    /*
    [ORACLE 의 배열 (마치 JAVA 의 배열과 비슷하다.)]
    아래의 모양은 자바에서 사용되던 배열의 모양을 90도 회전한 것과 같다.
    그래서 오라클에서는 자바의 배열처럼 *컬럼을 1개만 가지는 table 타입 변수*를 사용하여 쓴다.
    
    EMPLOYEE_ID 
     -------
     | 114 |
     -------
     | 115 |
     -------
     | 116 |
     -------
     | 117 |
     -------
     | 118 |
     -------
     | 119 |
     -------
    
    */        
        
    ----- **** [위에서 만든 pcd_employees_info_deptid 을 올바르게 작동하도록 해결하기] **** -----
    
    create or replace procedure pcd_employees_info_deptid
    (p_department_id  IN  employees.department_id%type)                     -- 입력을 받는 파라미터가 사원번호(employees_id) 가 아니라 부서번호(department_id) 이다.
    is
      type department_id_type
      is table of employees.department_id%type index by binary_integer;     -- 방번호 주는 것처럼
      
      type department_name_type
      is table of departments.department_name%type index by binary_integer;
      
      type employee_id_type
      is table of varchar2(30) index by binary_integer;                     -- 새로 만든것이기 때문에 varchar2 로 한다.
      
      type ename_type
      is table of varchar2(30) index by binary_integer;
      
      type hiredate_type
      is table of varchar2(10) index by binary_integer;
      
      type gender_type
      is table of varchar2(6) index by binary_integer;
      
      type age_type
      is table of number(3) index by binary_integer;                        -- 테이블 타입인데 컬럼 1개짜리 숫자(number) 만 들어온다.
      
      
      
      v_department_id      department_id_type;        -- table 타입의 변수이다.
      v_department_name    department_name_type;
      v_employee_id        employee_id_type;
      v_ename              ename_type;
      v_hiredate           hiredate_type;
      v_gender             gender_type;
      v_age                age_type;
      
      i binary_integer := 0;                        -- i 가 마치 JAVA 에서 배열의 방번호 용도처럼 쓰인다.
                                                    -- 그런데 자바에서 배열의 시작은 0 번부터 시작하지만 오라클은 1부터 시작한다.
    
    begin
        -- 방에 하나씩 값을 넣어준다. (FOR 문이 끝날때까지)
        FOR v_rcd IN (select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
                      FROM departments D RIGHT JOIN                                -- 부서번호 컬럼을 추가해주기 위해 JOIN 사용 (Kimberly 행을 보기 위해 RIGHT JOIN 사용)
                          (select department_id
                               , employee_id
                               , first_name || ' ' || last_name AS ENAME
                               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                               , func_gender(jubun) AS GENDER
                               , func_age(jubun) AS AGE
                          from employees
                          where department_id = p_department_id) E                 -- p_department_id : 입력받은 부서 번호를 넣는다.
                      ON D.department_id = E.department_id) LOOP                   -- rcd: record
                      
                      
          i := i+1;         
        
          v_department_id(i) := v_rcd.department_id;                                -- v_rcd(첫번째 행에 들어온 값) , java에서는 [] 를 썼지만 오라클은 () 사용.
          v_department_name(i) := v_rcd.department_name;                             -- v_rcd.컬럼명 을 변수 v_컬럼명에 넣어준다. (like 배열)    
          v_employee_id(i) := v_rcd.employee_id;                                    -- select 된 갯수만큼 반복한다. (여기서는 7개)
          v_ENAME(i) := v_rcd.ENAME;                                                -- 변수 v_ 에 차곡차곡 쌓아놓았다.
          v_HIREDATE(i) := v_rcd.HIREDATE;
          v_GENDER(i) := v_rcd.GENDER;
          v_AGE(i) := v_rcd.AGE;
          
        END LOOP;
          
        -- dbms_output.put_line('확인용 i => '|| i);
        
        if(i = 0) then 
            raise no_data_found;                                -- 확인용 i 가 0이라면, no_data_found 문구를 띄우겠다.! (no_data_found 는 사용자가 만든 오류가 아니라, 오라클에서 만든 것)
        else
            dbms_output.put_line( lpad('-',60,'-') );
            dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
            dbms_output.put_line( lpad('-',60,'-') );
            
            FOR k IN 1..i LOOP      -- i 번째 반복인 것 ..
                dbms_output.put_line(v_department_id(k) || ' ' ||
                                     v_department_name(k) || ' ' ||
                                     v_employee_id(k) || ' ' ||
                                     v_ENAME(k) || ' ' ||
                                     v_HIREDATE(k) || ' ' ||
                                     v_GENDER(k) || ' ' ||
                                     v_AGE(k)
                                     );
            END LOOP;        
        end if;
        
        EXCEPTION
            WHEN no_data_found THEN                             --  no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류이다.
                 dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        
    end pcd_employees_info_deptid;     
    
    -- Procedure PCD_EMPLOYEES_INFO_DEPTID이(가) 컴파일되었습니다.

    exec pcd_employees_info_deptid(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. <<
    -- 확인용 i => 0 (dbms_output.put_line('확인용 i => '|| i);) 으로 TEST
     
    exec pcd_employees_info_deptid(10);
    -- 확인용 i => 1

/*    
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    10 Administration 200 Jennifer Whalen 2003-09-17 여 45        
*/            
    
    exec pcd_employees_info_deptid(30);    
/*
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    30 Purchasing 114 Den Raphaely 2002-12-07 여 56
    30 Purchasing 115 Alexander Khoo 2003-05-18 남 62
    30 Purchasing 116 Shelli Baida 2005-12-24 남 63
    30 Purchasing 117 Sigal Tobias 2005-07-24 여 62
    30 Purchasing 118 Guy Himuro 2006-11-15 남 45
    30 Purchasing 119 Karen Colmenares 2007-08-10 남 44    
*/


    -----------------------------------------------------------------------------
    
                    ---- ===== **** CURSOR **** ===== -----
              
    --  PL/SQL 에서 SELECT 되어져 나오는 *행의 개수가 2개 이상*인 경우에는 위에서 한 것처럼
    --  ① table 타입의 변수를 사용하여 나타낼 수 있고, 또는 ② CURSOR 를 사용하여 나타낼 수도 있다. 
    --  table 타입의 변수를 사용하는 것 보다 *CURSOR 를 사용하는 것이 더 편하므로* 
    --  대부분 CURSOR 를 많이 사용한다.
    
    
    ----- *** 명시적 CURSOR 만들기 *** -----
    ※ 형식
    
    1.단계 -- CURSOR 의 선언(정의)
     
    CURSOR 커서명
    IS
    SELECT 문;  
    
    2.단계 -- CURSOR 의 OPEN
    
    OPEN 커서명;
    
    3.단계 -- CURSOR 의 FETCH
           (FETCH 란? SELECT 되어진 결과물을 끄집어 내는 작업을 말한다)
    
    FETCH  커서명 INTO 변수;
    
    4.단계 -- CURSOR 의 CLOSE
    
    CLOSE 커서명;
      
    
    
    ※ ==== 커서의 속성변수 ==== ※
    
    1. 커서명%ISOPEN   ==> 커서가 OPEN 되어진 상태인가를 체크하는 것.
                          만약에 커서가 OPEN 되어진 상태이라면 TRUE.
    
    2. 커서명%FOUND    ==> FETCH 된 레코드(행)이 있는지 체크하는 것.
                          만약에 FETCH 된 레코드(행)이 있으면 TRUE.
    
    3. 커서명%NOTFOUND ==> FETCH 된 레코드(행)이 없는지 체크하는 것.
                          만약에 FETCH 된 레코드(행)이 없으면 TRUE.
    
    4. 커서명%ROWCOUNT ==> 현재까지 FETCH 된 레코드(행)의 갯수를 반환해줌.    
    
    
    --------- ▼ CURSOR 실행 ▼ -----------
    
    create or replace procedure pcd_employees_ideptid_cursor
    (p_department_id  IN  employees.department_id%type)                     -- 입력을 받는 파라미터가 사원번호(employees_id) 가 아니라 부서번호(department_id) 이다.
    is    
  
        -- 1.단계 -- CURSOR 의 선언(정의)         
        CURSOR cur_empinfo
        is
        select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
        FROM departments D RIGHT JOIN                                -- 부서번호 컬럼을 추가해주기 위해 JOIN 사용 (Kimberly 행을 보기 위해 RIGHT JOIN 사용)
          (select department_id
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE
          from employees
          where department_id = p_department_id) E                 -- p_department_id : 입력받은 부서 번호.
        ON D.department_id = E.department_id;
        
        v_department_id      employees.department_id%type;         -- 변수를 만들어 준다.
        v_department_name    departments.department_name%type;
        v_employee_id        employees.employee_id%type;
        v_ename              varchar2(30);
        v_hiredate           varchar2(10);
        v_gender             varchar2(6);
        v_age                number(3);
        
        v_cnt number := 0;   
    begin 
        
        -- 2.단계 -- CURSOR 의 OPEN            -- 커서를 여는 것.    
        OPEN cur_empinfo;        
        
        -- 3.단계 -- CURSOR 의 FETCH
        --                   (FETCH 란? SELECT 되어진 결과물을 끄집어 내는 작업을 말한다)
        -- 반복문은 FETCH 를 꼭 사용한다. (FETCH 는 1번만 이루어지기 때문에 반복문을 사용해서 반복해주어야 한다.)
        LOOP
            FETCH cur_empinfo                                  -- cur_empinfo 가 select 한 것인데, 여기서 끄집어 내는 작업을 한다.(FETCH)
            INTO                                               -- cur_empinfo 를 v_컬럼에 에 넣는다. 
            v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age;
            
            v_cnt := cur_empinfo%ROWCOUNT;          -- fetch 된게 있으면 v_cnt 값은 매번 바뀐다.
        --  dbms_output.put_line('>> 확인용 fetch 된 행의 갯수 => ' || cur_empinfo%ROWCOUNT );
            
            EXIT WHEN cur_empinfo%NOTFOUND; -- 이것이 참이라면 빠져나간다. (더이상 select 된 행이 없다면(FETCH 된게 없다면) LOOP를 빠져나간다.(반복문을 빠져나간다.))
            
            -- 타이틀은 한번만 찍어줘야 하기 때문에 if 로 묶는다.
            if (v_cnt = 1) then                  -- 끄집어 온 것이 1개라도 있으면 if 아래를 실행한다.
                dbms_output.put_line( lpad('-',60,'-') );
                dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
                dbms_output.put_line( lpad('-',60,'-') );
            end if;
            
            dbms_output.put_line( v_department_id ||' '|| 
                                  v_department_name ||' '|| 
                                  v_employee_id ||' '|| 
                                  v_ename ||' '|| 
                                  v_hiredate ||' '|| 
                                  v_gender ||' '|| 
                                  v_age );
            
        END LOOP;
        
        -- 4.단계 -- CURSOR 의 CLOSE
        CLOSE cur_empinfo;           
        
        if(v_cnt = 0) then
            dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        else
            dbms_output.put_line(' ');  -- 한줄 띄우기
            dbms_output.put_line('>> 조회된 행의 개수 : ' || v_cnt || '개 << ');  
        end if;
        
    end pcd_employees_ideptid_cursor;
    -- Procedure PCD_EMPLOYEES_IDEPTID_CURSOR이(가) 컴파일되었습니다.

    exec pcd_employees_ideptid_cursor(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. <<
    exec pcd_employees_ideptid_cursor(10);
/*
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    10 Administration 200 Jennifer Whalen 2003-09-17 여 45 
    
    >> 조회된 행의 개수 : 1개 << 
*/

    exec pcd_employees_ideptid_cursor(30);
/*
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    30 Purchasing 114 Den Raphaely 2002-12-07 여 56
    30 Purchasing 115 Alexander Khoo 2003-05-18 남 62
    30 Purchasing 116 Shelli Baida 2005-12-24 남 63
    30 Purchasing 117 Sigal Tobias 2005-07-24 여 62
    30 Purchasing 118 Guy Himuro 2006-11-15 남 45
    30 Purchasing 119 Karen Colmenares 2007-08-10 남 44 
    
    >> 조회된 행의 개수 : 6개 << 
*/






    -------------- *****  FOR LOOP CURSOR 만들기 ***** -----------------
    /*
     FOR LOOP CURSOR 문을 사용하면
     커서의 OPEN, 커서의 FETCH, 커서의 CLOSE 가 자동적으로 발생되어지기 때문에
     우리는 커서의 OPEN, 커서의 FETCH, 커서의 CLOSE 문장을 기술할 필요가 없다.
    */
    
    ※ 형식
    FOR 변수명(select 되어진 행의 정보가 담기는 변수) IN 커서명 LOOP
      실행문장;
    END LOOP;        

    --------------- ▼ FOR LOOP CURSOR 실행코드 ▼ ---------------

    create or replace procedure pcd_employees_deptid_forcursor
    (p_department_id  IN  employees.department_id%type)                     -- 입력을 받는 파라미터가 사원번호(employees_id) 가 아니라 부서번호(department_id) 이다.
    is    
  
        -- 1.단계 -- CURSOR 의 선언(정의)         
        CURSOR cur_empinfo
        is
        select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
        FROM departments D RIGHT JOIN                                -- 부서번호 컬럼을 추가해주기 위해 JOIN 사용 (Kimberly 행을 보기 위해 RIGHT JOIN 사용)
          (select department_id
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE
          from employees
          where department_id = p_department_id) E                 -- p_department_id : 입력받은 부서 번호.
        ON D.department_id = E.department_id;
        
        v_cnt number := 0;  -- END LOOP; 뒤에 있는 v_cnt 에 대해서 변수선언
        
    begin
        /*
        -- 2단계
        FOR 변수명(select 되어진 행의 정보가 담기는 변수) IN 커서명 LOOP
            실행문장;
        END LOOP;                
        */
        FOR v_rcd IN cur_empinfo LOOP           -- record 타입의 변수

            v_cnt := cur_empinfo%ROWCOUNT;          -- fetch 된게 있으면 v_cnt 값은 매번 바뀐다.
            -- dbms_output.put_line('>> 확인용 fetch 된 행의 갯수 => ' || v_cnt );

            if (v_cnt = 1) then                  -- 끄집어 온 것이 1개라도 있으면 if 아래를 통해 타이틀을 찍어준다.
                dbms_output.put_line( lpad('-',60,'-') );
                dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
                dbms_output.put_line( lpad('-',60,'-') );
            end if;        

            dbms_output.put_line( v_rcd.department_id ||' '||               -- 이 컬럼명은 커서를 정의한 select 에서 나온 것.
                                  v_rcd.department_name ||' '|| 
                                  v_rcd.employee_id ||' '|| 
                                  v_rcd.ename ||' '|| 
                                  v_rcd.hiredate ||' '|| 
                                  v_rcd.gender ||' '|| 
                                  v_rcd.age );

        END LOOP;               
        
        if(v_cnt = 0) then
            dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        else
            dbms_output.put_line(' ');  -- 한줄 띄우기
            dbms_output.put_line('>> 조회된 행의 개수 : ' || v_cnt || '개 << ');  
        end if;        
        
    end pcd_employees_deptid_forcursor;
    -- Procedure PCD_EMPLOYEES_DEPTID_FORCURSOR이(가) 컴파일되었습니다.

    exec pcd_employees_deptid_forcursor(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. <<
    exec pcd_employees_deptid_forcursor(10);
/*
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    10 Administration 200 Jennifer Whalen 2003-09-17 여 45 
    
    >> 조회된 행의 개수 : 1개 << 
*/

    exec pcd_employees_deptid_forcursor(30);
/*
    ------------------------------------------------------------
    부서번호    부서명     사원번호     사원명    입사일자   성별   나이
    ------------------------------------------------------------
    30 Purchasing 114 Den Raphaely 2002-12-07 여 56
    30 Purchasing 115 Alexander Khoo 2003-05-18 남 62
    30 Purchasing 116 Shelli Baida 2005-12-24 남 63
    30 Purchasing 117 Sigal Tobias 2005-07-24 여 62
    30 Purchasing 118 Guy Himuro 2006-11-15 남 45
    30 Purchasing 119 Karen Colmenares 2007-08-10 남 44 
    
    >> 조회된 행의 개수 : 6개 << 
*/


   -------------------- ****** PACKAGE(패키지) ****** ----------------------
   
   --->   PACKAGE(패키지)란?  여러개의 Procedure 와 여러개의 Function 들의 묶음

   --- 1. PACKAGE(패키지) 의 선언하기
   create or replace package employee_pack
   is
     -- employee_pack 패키지에 들어올 프로시저 또는 함수를 선언해준다. (아래와 같이 2개의 procedure 와 function 을 담겠다.)
     procedure pcd_emp_info(p_deptno IN employees.department_id%type);
     procedure pcd_dept_info(p_deptno IN departments.department_id%type);
     function  func_sex(p_jubun IN employees.jubun%type) return varchar2;    -- 함수는 꼭 return varchar2 까지 써주어야 한다.
   end employee_pack;
   -- Package EMPLOYEE_PACK이(가) 컴파일되었습니다.
   
   --- 2. PACKAGE(패키지) 의 Body(본문) 생성하기
   create or replace package body employee_pack
   is 
     procedure pcd_emp_info(p_deptno IN employees.department_id%type)           -- 각 procedure, function 에 대한 is begin end 를 적어줘야 함.
     is 
       cursor cur_empinfo     -- select 된 결과물이 복수개가 나오므로 cursor 를 사용한다.
       is
       select D.department_id, D.department_name,
              E.employee_id, E.first_name || ' ' || E.last_name AS ENAME 
       from departments D JOIN employees E 
       ON D.department_id = E.department_id
       where E.department_id = p_deptno;                 -- p_deptno : 입력받은 파라미터
           
       v_cnt number := 0;   
     begin
          for v_rcd in cur_empinfo loop
              v_cnt := cur_empinfo%ROWCOUNT;
              if(v_cnt = 1) then
                 dbms_output.put_line( lpad('-',60,'-'));                            -- 19행 오류?
                 dbms_output.put_line('부서번호  부서명        사원번호    사원명');
                 dbms_output.put_line( lpad('-',60,'-'));
              end if;
              
              dbms_output.put_line(v_rcd.department_id || ' ' ||
                                   v_rcd.department_name || ' ' ||
                                   v_rcd.employee_id || ' ' ||
                                   v_rcd.ENAME
                                   );
          end loop;
          
          if ( v_cnt = 0 ) then
              dbms_output.put_line('>> 부서번호 ' || p_deptno || '은 없습니다. <<');
          else 
              dbms_output.put_line(' ');
              dbms_output.put_line('>> 조회건수 : ' || v_cnt || '개');
              
          end if;
     end pcd_emp_info;
     
     procedure pcd_dept_info(p_deptno IN departments.department_id%type)
     is 
            V_department_id    departments.department_id%type;        
            V_department_name  departments.department_name%type;
            
     begin
            select department_id, department_name
                   into
                   V_department_id, V_department_name
            from departments
            where department_id = p_deptno;
            
                 dbms_output.put_line( lpad('-',40,'-'));
                 dbms_output.put_line('부서번호  부서명');
                 dbms_output.put_line( lpad('-',40,'-'));            
            
                 dbms_output.put_line(v_department_id ||' '|| v_department_name);
                 
                 exception 
                    when no_data_found then
                         dbms_output.put_line('>> 부서번호 ' || p_deptno || '은 없습니다. <<');
            
     end pcd_dept_info;  
     
     function  func_sex(p_jubun IN employees.jubun%type) 
     return varchar2       
     is 
         v_result       varchar2(100);
         v_gender_num   varchar2(1);
     begin
         if( length(p_jubun) = 13 ) then 
            v_gender_num := substr(p_jubun, 7, 1);
            
            if(v_gender_num IN('1','3')) then 
                v_result := '남';
            elsif (v_gender_num IN('2','4')) then 
                v_result := '여';
            else
                v_result := '주민번호가 올바르지 않습니다.';
            end if;
            
         else
            v_result := '주민번호의 길이가 13자리가 아닙니다.';
         end if;
         
         return v_result;
     end func_sex;   
   
   end employee_pack;
   -- Package Body EMPLOYEE_PACK이(가) 컴파일되었습니다.


   
   begin
        employee_pack.pcd_emp_info(10);
   end;
/*
    ------------------------------------------------------------
    부서번호  부서명        사원번호    사원명
    ------------------------------------------------------------
    10 Administration 200 Jennifer Whalen
     
    >> 조회건수 : 1개 
*/    
   begin
        employee_pack.pcd_dept_info(30);
   end;
/*
    ----------------------------------------
    부서번호  부서명
    ----------------------------------------
    30 Purchasing
*/

   begin
        employee_pack.pcd_dept_info(9999);
   end;
   -- >> 부서번호 9999은 없습니다. <<


    ------------- 함수 부분 ------------------
    
    select employee_pack.func_sex('9001121456789')
         , employee_pack.func_sex('9001122456789')
         , employee_pack.func_sex('0101123456789')
         , employee_pack.func_sex('0101124456789')
    from dual;      
    -- 남	여	남	여
   
   
   select  employee_pack.func_sex('9001121456789')
         , employee_pack.func_sex('90011224567899')
   from dual;      
   -- 남	        주민번호의 길이가 13자리가 아닙니다.     
   
   select employee_id, first_name, jubun, employee_pack.func_sex(jubun)
   from employees
   order by 1;

   ---- **** 패키지 소스 보기 **** ----
   select text
   from user_source
   where type = 'PACKAGE' and name = 'EMPLOYEE_PACK';

   
   ---- **** 패키지 BODY(본문) 소스 보기 **** ----
   select line, text
   from user_source
   where type = 'PACKAGE BODY' and name = 'EMPLOYEE_PACK';   


   

