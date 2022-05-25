/*
   == SQL 과제1 ==

    [문제 1]
    employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
    부서번호, 사원명, 주민번호, 성별을 나타내세요.
    성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.

    ------------------------------------------------------------
    부서번호        사원명             주민번호            성별
    ------------------------------------------------------------
    30	        Den Raphaely	    670915*******	여
    30	        Alexander Khoo	    611015*******	남
    30	        Shelli Baida	    600930*******	남
    30	        Sigal Tobias	    611015*******	여
    30	        Guy Himuro	        781015*******	남
    30	        Karen Colmenares    790915*******	남
    50	        Matthew Weiss	    770215*******	여
    50	        Adam Fripp	        700915*******	남
    50	        Payam Kaufling	    711101*******	남
    50	        Shanta Vollman	    801013*******	남
    50	        Kevin Mourgos	    811019*******	남
    50	        Julia Nayer	        901213*******	여
    50	        Irene Mikkilineni   940625*******	남
    50	        James Landry	    940825*******	여
    50	        Steven Markle	    920415*******	여
    50	        Laura Bissot	    850725*******	남
    50	        Mozhe Atkinson	    651111*******	남
    50	        James Marlow	    001015*******	남
    50	        TJ Olson	        000525*******	여
    50	        Jason Mallin	    011019*******	여
    50	        Michael Rogers	    041215*******	여
    50	        Ki Gee	            050325*******	남
    50	        Hazel Philtanker    951001*******	여
    50	        Renske Ladwig	    951002*******	남
    50	        Stephen Stiles	    961004*******	남
    50	        John Seo	        961005*******	여
    50	        Joshua Patel	    731001*******	남
    50	        Trenna Rajs	        731009*******	여
    50	        Curtis Davies	    751012*******	남
    50	        Randall Matos	    761201*******	여
    50	        Peter Vargas	    771006*******	남
    50	        Winston Taylor	    831001*******	여
    50	        Jean Fleaur	        651019*******	남
    50	        Martha Sullivan	    651022*******	남
    50	        Girard Geoni	    651023*******	여
    50	        Nandita Sarchand    851213*******	남
    50	        Alexis Bull	        851018*******	여
    50	        Julia Dellinger	    751019*******	여
    50	        Anthony Cabrio	    851219*******	여
    50	        Kelly Chung	        951115*******	남
    50	        Jennifer Dilly	    750930*******	여
    50	        Timothy Gates	    851016*******	남
    50	        Randall Perkins	    951019*******	여
    50	        Sarah Bell	        051013*******	남
    50	        Britney Everett	    081019*******	여
    50	        Samuel McCain	    091018*******	남
    50	        Vance Jones	        101013*******	여
    50	        Alana Walsh	        951003*******	여
    50	        Kevin Feeney	    971018*******	남
    50	        Donald OConnell	    981016*******	여
    50	        Douglas Grant	    751117*******	남
    
*/
    
    
    [쌤 답]
    /*
    [문제 1]
    employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
    부서번호, 사원명, 주민번호, 성별을 나타내세요.
    성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.


    ------------------------------------------------------------
    부서번호        사원명             주민번호            성별
    ------------------------------------------------------------
    30	        Den Raphaely	    670915*******	여
    30	        Alexander Khoo	    611015*******	남
    30	        Shelli Baida	    600930*******	남
    30	        Sigal Tobias	    611015*******	여
    30	        Guy Himuro	        781015*******	남
    30	        Karen Colmenares    790915*******	남
    50	        Matthew Weiss	    770215*******	여
    50	        Adam Fripp	        700915*******	남
    50	        Payam Kaufling	    711101*******	남
    50	        Shanta Vollman	    801013*******	남
    50	        Kevin Mourgos	    811019*******	남
    50	        Julia Nayer	        901213*******	여
    50	        Irene Mikkilineni   940625*******	남
    50	        James Landry	    940825*******	여
    50	        Steven Markle	    920415*******	여
    50	        Laura Bissot	    850725*******	남
    50	        Mozhe Atkinson	    651111*******	남
    50	        James Marlow	    001015*******	남
    50	        TJ Olson	        000525*******	여
    50	        Jason Mallin	    011019*******	여
    50	        Michael Rogers	    041215*******	여
    50	        Ki Gee	            050325*******	남
    50	        Hazel Philtanker    951001*******	여
    50	        Renske Ladwig	    951002*******	남
    50	        Stephen Stiles	    961004*******	남
    50	        John Seo	        961005*******	여
    50	        Joshua Patel	    731001*******	남
    50	        Trenna Rajs	        731009*******	여
    50	        Curtis Davies	    751012*******	남
    50	        Randall Matos	    761201*******	여
    50	        Peter Vargas	    771006*******	남
    50	        Winston Taylor	    831001*******	여
    50	        Jean Fleaur	        651019*******	남
    50	        Martha Sullivan	    651022*******	남
    50	        Girard Geoni	    651023*******	여
    50	        Nandita Sarchand    851213*******	남
    50	        Alexis Bull	        851018*******	여
    50	        Julia Dellinger	    751019*******	여
    50	        Anthony Cabrio	    851219*******	여
    50	        Kelly Chung	        951115*******	남
    50	        Jennifer Dilly	    750930*******	여
    50	        Timothy Gates	    851016*******	남
    50	        Randall Perkins	    951019*******	여
    50	        Sarah Bell	        051013*******	남
    50	        Britney Everett	    081019*******	여
    50	        Samuel McCain	    091018*******	남
    50	        Vance Jones	        101013*******	여
    50	        Alana Walsh	        951003*******	여
    50	        Kevin Feeney	    971018*******	남
    50	        Donald OConnell	    981016*******	여
    50	        Douglas Grant	    751117*******	남
    
*/

select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , rpad( substr(jubun, 1, 6), length(jubun), '*')  AS 주민번호
 --  , rpad( substr(jubun, 1, 6), 13, '*')  AS 주민번호
     , case when substr(jubun,7,1) in('2','4') then '여'
       else '남'
       end AS 성별
from employees
where department_id in (30,50)
order by department_id;




    

/*
    [문제2]
    employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
    사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.

    ---------------------------------------------
    사원명           공개연락처       비공개연락처
    ---------------------------------------------
    Steven King	    515.123.4567	515.***.4567
    Neena Kochhar	515.123.4568	515.***.4568
    Lex De Haan	    515.123.4569	515.***.4569
*/

/*
   국번만 '*' 로 마스킹 처리한다.
   
   phone_number 컬럼에서 국번전까지만 발췌하고 || 국번 || 국번다음부터 끝까지 발췌한다.
   국번만 translate 를 사용하여 '*' 로 바꾸어주면 되겠다.
*/
select phone_number, translate(phone_number, '0123456789', '**********')
from employees;

/*
   국번만 발췌해와야 하는데 어떻게 할까?
   국번만 발췌 ==> phone_number 컬럼에서 최초로 . 이 나오는 위치 그 다음부터 두번째로 . 이 나오는 위치 그 앞까지만 발췌를 해오면 된다. 
*/
select phone_number,
   --  substr(phone_number, 출발점, 몇글자) AS "국번만 발췌"
   
   --  출발점 ==>  최초로 . 이 나오는 위치 그 다음
   --             instr(phone_number, '.', 1, 1) + 1
   
   --  몇글자 ==> phone_number 컬럼에서 두번째로 . 이 나오는 위치 - 1 ==> 예  7-1 = 6
   --            phone_number 컬럼에서 첫번째로 . 이 나오는 위치     ==> 예   4
   --           (phone_number 컬럼에서 두번째로 . 이 나오는 위치 - 1) - phone_number 컬럼에서 첫번째로 . 이 나오는 위치 ==> 예 6-4 = 2 
   --           instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)
   
   --            phone_number 컬럼에서 두번째로 . 이 나오는 위치 - 1 ==> 예  8-1 = 7 
   --            phone_number 컬럼에서 첫번째로 . 이 나오는 위치     ==> 예   4 
   --           (phone_number 컬럼에서 두번째로 . 이 나오는 위치 - 1) - phone_number 컬럼에서 첫번째로 . 이 나오는 위치 ==> 예 7-4 = 3  
   --           instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)
   
   -- substr(phone_number, 출발점, 몇글자) AS "국번만 발췌"
   substr(phone_number, instr(phone_number, '.', 1, 1) + 1, instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)) AS "국번만 발췌"
   
from employees;


select phone_number AS "원래전화번호"
     , substr(phone_number, 1, instr(phone_number, '.', 1, 1) ) AS "국번전까지"
     , substr(phone_number, instr(phone_number, '.', 1, 1) + 1, instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)) AS "국번"
     , substr(phone_number, instr(phone_number, '.', 1, 2) )  AS "국번다음부터 끝까지"
from employees;


select phone_number AS "원래전화번호"
     , substr(phone_number, 1, instr(phone_number, '.', 1, 1) ) AS "국번전까지"
     
     , substr(phone_number, instr(phone_number, '.', 1, 1) + 1, instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)) AS "국번"
     , translate( substr(phone_number, instr(phone_number, '.', 1, 1) + 1, instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)) , '0123456789' , '**********') AS "마스킹"
     
     , substr(phone_number, instr(phone_number, '.', 1, 2) )  AS "국번다음부터 끝까지"
from employees;


select phone_number AS "원래전화번호"
     , substr(phone_number, 1, instr(phone_number, '.', 1, 1) ) || 
       translate( substr(phone_number, instr(phone_number, '.', 1, 1) + 1, instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)) , '0123456789' , '**********') || 
       substr(phone_number, instr(phone_number, '.', 1, 2) )  AS "마스킹처리한전화번호"
from employees;


                
select first_name || ' ' || last_name AS 사원명
     , phone_number AS 공개연락처
     , substr(phone_number, 1, instr(phone_number, '.', 1, 1) ) || 
       translate( substr(phone_number, instr(phone_number, '.', 1, 1) + 1, instr(phone_number, '.', 1, 2) - 1 - instr(phone_number, '.', 1, 1)) , '0123456789' , '**********') || 
       substr(phone_number, instr(phone_number, '.', 1, 2) ) AS 비공개연락처
from employees
where department_id = 90;







/*
    [문제3]
    employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
    사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

    ---------------------------------------------------------------
    사원명               공개연락처               비공개연락처
    ---------------------------------------------------------------
    John Russell	    011.44.1344.429268	    011.**.1344.******
    Karen Partners	    011.44.1344.467268	    011.**.1344.******
    Alberto Errazuriz   011.44.1344.429278	    011.**.1344.******
    Gerald Cambrault    011.44.1344.619268	    011.**.1344.******
    Eleni Zlotkey	    011.44.1344.429018	    011.**.1344.******
    Peter Tucker	    011.44.1344.129268	    011.**.1344.******
    David Bernstein	    011.44.1344.345268	    011.**.1344.******
    Peter Hall	        011.44.1344.478968	    011.**.1344.******
    Christopher Olsen   011.44.1344.498718	    011.**.1344.******
    Nanette Cambrault   011.44.1344.987668	    011.**.1344.******
    Oliver Tuvault	    011.44.1344.486508	    011.**.1344.******
    Janette King	    011.44.1345.429268	    011.**.1345.******
    Patrick Sully	    011.44.1345.929268	    011.**.1345.******
    Allan McEwen	    011.44.1345.829268	    011.**.1345.******
    Lindsey Smith	    011.44.1345.729268	    011.**.1345.******
    Louise Doran	    011.44.1345.629268	    011.**.1345.******
    Sarath Sewall	    011.44.1345.529268	    011.**.1345.******
    Clara Vishney	    011.44.1346.129268	    011.**.1346.******
    Danielle Greene     011.44.1346.229268	    011.**.1346.******
    Mattea Marvins	    011.44.1346.329268	    011.**.1346.******
    David Lee	        011.44.1346.529268	    011.**.1346.******
    Sundar Ande	        011.44.1346.629268	    011.**.1346.******
    Amit Banda	        011.44.1346.729268	    011.**.1346.******
    Lisa Ozer	        011.44.1343.929268	    011.**.1343.******
    Harrison Bloom	    011.44.1343.829268	    011.**.1343.******
    Tayler Fox	        011.44.1343.729268	    011.**.1343.******
    William Smith	    011.44.1343.629268	    011.**.1343.******
    Elizabeth Bates	    011.44.1343.529268	    011.**.1343.******
    Sundita Kumar	    011.44.1343.329268	    011.**.1343.******
    Ellen Abel	        011.44.1644.429267	    011.**.1644.******
    Alyssa Hutton	    011.44.1644.429266	    011.**.1644.******
    Jonathon Taylor	    011.44.1644.429265	    011.**.1644.******
    Jack Livingston	    011.44.1644.429264	    011.**.1644.******
    Charles Johnson	    011.44.1644.429262	    011.**.1644.******

*/

select first_name || ' ' || last_name AS 사원명
     , phone_number AS 공개연락처
     , substr(phone_number,1,instr(phone_number,'.',1,1)) 
    || lpad('*',instr(phone_number,'.',1,2)-instr(phone_number,'.',1,1)-1,'*') 
    || substr(phone_number,instr(phone_number,'.',1,2), instr(phone_number,'.',1,3)-instr(phone_number,'.',1,2))
    || translate( substr(phone_number,instr(phone_number,'.',1,3)), '0123456789','**********')  AS 비공개연락처
from employees
where department_id = 80;






    
    
/*
    [문제4]
    employees 테이블에서 80번, 90번 부서에 근무하는 사원들만 아래와 같이
    부서번호, 사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

    ------------------------------------------------------------------------------
    부서번호        사원명              공개연락처               비공개연락처
    ------------------------------------------------------------------------------  
    80	        John Russell	    011.44.1344.429268	    011.**.1344.******
    80	        Karen Partners	    011.44.1344.467268	    011.**.1344.******
    80	        Alberto Errazuriz   011.44.1344.429278	    011.**.1344.******
    80	        Gerald Cambrault    011.44.1344.619268	    011.**.1344.******
    80	        Eleni Zlotkey	    011.44.1344.429018	    011.**.1344.******
    80	        Peter Tucker	    011.44.1344.129268	    011.**.1344.******
    80	        David Bernstein	    011.44.1344.345268	    011.**.1344.******
    80	        Peter Hall	        011.44.1344.478968	    011.**.1344.******
    80	        Christopher Olsen   011.44.1344.498718	    011.**.1344.******
    80	        Nanette Cambrault   011.44.1344.987668	    011.**.1344.******
    80	        Oliver Tuvault	    011.44.1344.486508	    011.**.1344.******
    80	        Janette King	    011.44.1345.429268	    011.**.1345.******
    80	        Patrick Sully	    011.44.1345.929268	    011.**.1345.******
    80	        Allan McEwen	    011.44.1345.829268	    011.**.1345.******
    80	        Lindsey Smith	    011.44.1345.729268	    011.**.1345.******
    80	        Louise Doran	    011.44.1345.629268	    011.**.1345.******
    80	        Sarath Sewall	    011.44.1345.529268	    011.**.1345.******
    80	        Clara Vishney	    011.44.1346.129268	    011.**.1346.******
    80	        Danielle Greene	    011.44.1346.229268	    011.**.1346.******
    80	        Mattea Marvins	    011.44.1346.329268	    011.**.1346.******
    80	        David Lee	        011.44.1346.529268	    011.**.1346.******
    80	        Sundar Ande	        011.44.1346.629268	    011.**.1346.******
    80	        Amit Banda	        011.44.1346.729268	    011.**.1346.******
    80	        Lisa Ozer	        011.44.1343.929268	    011.**.1343.******
    80	        Harrison Bloom	    011.44.1343.829268	    011.**.1343.******
    80	        Tayler Fox	        011.44.1343.729268	    011.**.1343.******
    80	        William Smith	    011.44.1343.629268	    011.**.1343.******
    80	        Elizabeth Bates	    011.44.1343.529268	    011.**.1343.******
    80	        Sundita Kumar	    011.44.1343.329268	    011.**.1343.******
    80	        Ellen Abel	        011.44.1644.429267	    011.**.1644.******
    80	        Alyssa Hutton	    011.44.1644.429266	    011.**.1644.******
    80	        Jonathon Taylor	    011.44.1644.429265	    011.**.1644.******
    80	        Jack Livingston	    011.44.1644.429264	    011.**.1644.******
    80	        Charles Johnson	    011.44.1644.429262	    011.**.1644.******
    90	        Steven King	        515.123.4567	        515.***.****
    90	        Neena Kochhar	    515.123.4568	        515.***.****
    90	        Lex De Haan	        515.123.4569	        515.***.****

*/

select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , phone_number AS 공개연락처
     , substr(phone_number, 1, instr(phone_number,'.',1,1)) 
    || lpad('*', instr(phone_number,'.',1,2)-instr(phone_number,'.',1,1)-1, '*')
    || case 
       when instr(phone_number,'.',1,3) > 0 
            then substr(phone_number, instr(phone_number,'.',1,2), instr(phone_number,'.',1,3)-instr(phone_number,'.',1,2))
       else ''
       end
    || translate(substr(phone_number, instr(phone_number,'.',-1,1)), '0123456789', '**********')
    AS 비공개연락처
from employees
where department_id in (80,90)
order by department_id;

    
    

/*
    [문제2]
    employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
    사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.

    ---------------------------------------------
    사원명           공개연락처       비공개연락처
    ---------------------------------------------
    Steven King	    515.123.4567	515.***.4567
    Neena Kochhar	515.123.4568	515.***.4568
    Lex De Haan	    515.123.4569	515.***.4569

*/


/*
    [문제3]
    employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
    사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

    ---------------------------------------------------------------
    사원명               공개연락처               비공개연락처
    ---------------------------------------------------------------
    John Russell	    011.44.1344.429268	    011.**.1344.******
    Karen Partners	    011.44.1344.467268	    011.**.1344.******
    Alberto Errazuriz   011.44.1344.429278	    011.**.1344.******
    Gerald Cambrault    011.44.1344.619268	    011.**.1344.******
    Eleni Zlotkey	    011.44.1344.429018	    011.**.1344.******
    Peter Tucker	    011.44.1344.129268	    011.**.1344.******
    David Bernstein	    011.44.1344.345268	    011.**.1344.******
    Peter Hall	        011.44.1344.478968	    011.**.1344.******
    Christopher Olsen   011.44.1344.498718	    011.**.1344.******
    Nanette Cambrault   011.44.1344.987668	    011.**.1344.******
    Oliver Tuvault	    011.44.1344.486508	    011.**.1344.******
    Janette King	    011.44.1345.429268	    011.**.1345.******
    Patrick Sully	    011.44.1345.929268	    011.**.1345.******
    Allan McEwen	    011.44.1345.829268	    011.**.1345.******
    Lindsey Smith	    011.44.1345.729268	    011.**.1345.******
    Louise Doran	    011.44.1345.629268	    011.**.1345.******
    Sarath Sewall	    011.44.1345.529268	    011.**.1345.******
    Clara Vishney	    011.44.1346.129268	    011.**.1346.******
    Danielle Greene     011.44.1346.229268	    011.**.1346.******
    Mattea Marvins	    011.44.1346.329268	    011.**.1346.******
    David Lee	        011.44.1346.529268	    011.**.1346.******
    Sundar Ande	        011.44.1346.629268	    011.**.1346.******
    Amit Banda	        011.44.1346.729268	    011.**.1346.******
    Lisa Ozer	        011.44.1343.929268	    011.**.1343.******
    Harrison Bloom	    011.44.1343.829268	    011.**.1343.******
    Tayler Fox	        011.44.1343.729268	    011.**.1343.******
    William Smith	    011.44.1343.629268	    011.**.1343.******
    Elizabeth Bates	    011.44.1343.529268	    011.**.1343.******
    Sundita Kumar	    011.44.1343.329268	    011.**.1343.******
    Ellen Abel	        011.44.1644.429267	    011.**.1644.******
    Alyssa Hutton	    011.44.1644.429266	    011.**.1644.******
    Jonathon Taylor	    011.44.1644.429265	    011.**.1644.******
    Jack Livingston	    011.44.1644.429264	    011.**.1644.******
    Charles Johnson	    011.44.1644.429262	    011.**.1644.******

*/
    
    
/*
    [문제4]
    employees 테이블에서 80번, 90번 부서에 근무하는 사원들만 아래와 같이
    부서번호, 사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

    ------------------------------------------------------------------------------
    부서번호        사원명              공개연락처               비공개연락처
    ------------------------------------------------------------------------------  
    80	        John Russell	    011.44.1344.429268	    011.**.1344.******
    80	        Karen Partners	    011.44.1344.467268	    011.**.1344.******
    80	        Alberto Errazuriz   011.44.1344.429278	    011.**.1344.******
    80	        Gerald Cambrault    011.44.1344.619268	    011.**.1344.******
    80	        Eleni Zlotkey	    011.44.1344.429018	    011.**.1344.******
    80	        Peter Tucker	    011.44.1344.129268	    011.**.1344.******
    80	        David Bernstein	    011.44.1344.345268	    011.**.1344.******
    80	        Peter Hall	        011.44.1344.478968	    011.**.1344.******
    80	        Christopher Olsen   011.44.1344.498718	    011.**.1344.******
    80	        Nanette Cambrault   011.44.1344.987668	    011.**.1344.******
    80	        Oliver Tuvault	    011.44.1344.486508	    011.**.1344.******
    80	        Janette King	    011.44.1345.429268	    011.**.1345.******
    80	        Patrick Sully	    011.44.1345.929268	    011.**.1345.******
    80	        Allan McEwen	    011.44.1345.829268	    011.**.1345.******
    80	        Lindsey Smith	    011.44.1345.729268	    011.**.1345.******
    80	        Louise Doran	    011.44.1345.629268	    011.**.1345.******
    80	        Sarath Sewall	    011.44.1345.529268	    011.**.1345.******
    80	        Clara Vishney	    011.44.1346.129268	    011.**.1346.******
    80	        Danielle Greene	    011.44.1346.229268	    011.**.1346.******
    80	        Mattea Marvins	    011.44.1346.329268	    011.**.1346.******
    80	        David Lee	        011.44.1346.529268	    011.**.1346.******
    80	        Sundar Ande	        011.44.1346.629268	    011.**.1346.******
    80	        Amit Banda	        011.44.1346.729268	    011.**.1346.******
    80	        Lisa Ozer	        011.44.1343.929268	    011.**.1343.******
    80	        Harrison Bloom	    011.44.1343.829268	    011.**.1343.******
    80	        Tayler Fox	        011.44.1343.729268	    011.**.1343.******
    80	        William Smith	    011.44.1343.629268	    011.**.1343.******
    80	        Elizabeth Bates	    011.44.1343.529268	    011.**.1343.******
    80	        Sundita Kumar	    011.44.1343.329268	    011.**.1343.******
    80	        Ellen Abel	        011.44.1644.429267	    011.**.1644.******
    80	        Alyssa Hutton	    011.44.1644.429266	    011.**.1644.******
    80	        Jonathon Taylor	    011.44.1644.429265	    011.**.1644.******
    80	        Jack Livingston	    011.44.1644.429264	    011.**.1644.******
    80	        Charles Johnson	    011.44.1644.429262	    011.**.1644.******
    90	        Steven King	        515.123.4567	        515.***.****
    90	        Neena Kochhar	    515.123.4568	        515.***.****
    90	        Lex De Haan	        515.123.4569	        515.***.****

*/
    
/*    
    email : tjdudgkr0959@naver.com 
    메일제목 : SQL과제_1_김민정
    첨부파일 : SQL과제_1_김민정.txt 
    제출기한 : 2022.01.17 18:00 까지 제출
*/    

/*
    == SQL 과제2 ==

    --  아래와 같이 나오도록 하세요...
    
    /*
        ----------------------------------------------------------------------------------------------------------------------------------------------------
         부서번호    부서명    부서주소    부서장성명    사원번호   사원명    성별    나이    연봉    연봉소득세액    부서내연봉평균차액    부서내연봉등수     전체연봉등수 
        ----------------------------------------------------------------------------------------------------------------------------------------------------
    */
    
    select * 
    from tbl_taxindex;    
/*    
    email : tjdudgkr0959@naver.com 
    메일제목 : SQL과제_2_김민정
    첨부파일 : SQL과제_2_김민정.txt 
    제출기한 : 2022.01.17 18:00 까지 제출
*/    

    -------- 과제 0116 ----
/*
    [문제 1]
    employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
    부서번호, 사원명, 주민번호, 성별을 나타내세요.
    성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.
*/    
    select department_id as 부서번호
         , first_name||' '||last_name as 사원명
         , substr(jubun,1,6)||decode(length(jubun),13,''||substr(jubun,6,1)||'*******') as 주민번호
         , CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END as 성별
    from employees
    where department_id in(30, 50)
    order by 1;
/*    
    [문제 2]
    employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
    사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.
*/
    select first_name||' '||last_name as 사원명
         , phone_number as 공개연락처
         , REGEXP_REPLACE(phone_number, '^(515)(.*)(....)$'
                                      , '\1.***.\3' ) as 비공개연락처    
    from employees
    where department_id = 90;    

/* 
    [문제 3]
    employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
    사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.
*/    
    
    
    select first_name||' '||last_name as 사원명
         , phone_number as 공개연락처
         , REGEXP_REPLACE(phone_number, '^(011)(.*)(...........)$'
                                      , '\1.**.\3' ) as 비공개연락처    
    from employees
    where department_id = 80;      
    
    
/*
    [문제4]
    employees 테이블에서 80번, 90번 부서에 근무하는 사원들만 아래와 같이
    부서번호, 사원명, 공개연락처, 비공개연락처를 나타내세요.
    여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.
*/
    select department_id as 부서번호
         , first_name||' '||last_name as 사원명
         , phone_number as 공개연락처
         , REGEXP_REPLACE(phone_number, '^(011|515)(.*)(...........)$'
                                      , '\1.***.\3' ) as 비공개연락처    
    from employees
    where department_id in(80, 90)       
    order by 1;
    

/*    
    == SQL 과제2 ==    
    --  아래와 같이 나오도록 하세요...
    
    /*
        ----------------------------------------------------------------------------------------------------------------------------------------------------
         부서번호    부서명    부서주소    부서장성명    사원번호   사원명    성별    나이    연봉    연봉소득세액    부서내연봉평균차액    부서내연봉등수     전체연봉등수 
        ----------------------------------------------------------------------------------------------------------------------------------------------------
    */
    -- [답] -- 
    -- 테이블 1: departments
    -- 테이블 2: employees
    -- 테이블 3: Locations
    -- 테이블 4: tbl_taxindex
    select E.department_id as 부서번호    
         , D.department_name as 부서명    
         , L.city || ' ' || L.street_address as 부서주소    
         , E.first_name || E.last_name as 부서장성명    
         , E.employee_id as 사원번호   
         , E.first_name || ' ' || E.last_name as 사원명    
         , E.CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END as 성별    
         , E.EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 as 나이    
         , E.nvl(salary + (salary*commission_pct), salary)*12 as 연봉    
         , T.nvl(salary + (salary*commission_pct), salary)*12 * taxpercent as 연봉소득세액    
         , (salary - dept_avg_sal) as 부서내연봉평균차액    
         , RANK() OVER(PARTITION BY department_id
                       ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) as 부서내연봉등수     
         , RANK() OVER(ORDER BY nvl(salary + (salary*commission_pct), salary) DESC) AS as 전체연봉등수
    from departments D, employees E, locations L, tbl_taxindex T
    where T.tbl_taxindex(select employee_id as 사원번호     
                     , first_name ||' '||last_name as 사원명     
                     , nvl(salary + (salary*commission_pct), salary)*12 as 연봉     
                     , taxpercent as 세율
                     , nvl(salary + (salary*commission_pct), salary)*12 * taxpercent as 소득세액
                       from employees E , tbl_taxindex T )    
    and C.country_id = L.country_id  
    and L.location_id = D.location_id    
    and D.department_id = E.department_id;     
 ----참고
 
    
    -- taxindex
    select employee_id as 사원번호     
     , first_name ||' '||last_name as 사원명     
     , nvl(salary + (salary*commission_pct), salary)*12 as 연봉     
     , taxpercent as 세율
     , nvl(salary + (salary*commission_pct), salary)*12 * taxpercent as 소득세액
    from employees E , tbl_taxindex T
    
    ---
    select E.department_id as 부서번호    
         , D.department_name as 부서명    
         , L.city || ' ' || L.street_address as 부서주소    
         , E.first_name || E.last_name as 부서장성명    
         , E.employee_id as 사원번호   
         , E.first_name || ' ' || E.last_name as 사원명    
         , E.CASE WHEN substr(jubun, 7, 1) IN('1','3') THEN '남' ELSE '여' END as 성별    
         , E.EXTRACT(YEAR FROM sysdate) - ( substr(jubun, 1,2)+ CASE WHEN substr(jubun, 7, 1) IN('1','2') THEN 1900 ELSE 2000 END ) + 1 as 나이    
         , E.nvl(salary + (salary*commission_pct), salary)*12 as 연봉    
    from departments D, employees E, locations L
    where L.location_id = D.location_id    
    and D.department_id = E.department_id;

*/    





[쌤답 2 _ 과제 2]
-- 사원수가 107명이 나오도록 하겠습니다.


WITH A as
  (
     select D.department_id
          , department_name
          , street_address || ' ' || city || ' ' || state_province AS Address 
          , E.first_name || ' ' || E.last_name AS DeptHeadName
     from departments D JOIN locations L 
     ON D.location_id = L.location_id
     JOIN employees E
     ON D.manager_id = E.employee_id
   )
 , V as 
 (  select department_id
         , trunc(avg(nvl(salary+(salary*commission_pct), salary)*12)) AS DeptAvgYearSal
    from employees
    group by department_id
  ) 
  , B as
  (
    select E.department_id
          , employee_id 
          , first_name || ' ' || last_name AS Ename
          , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS Gender
          , extract(year from sysdate) - (case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end) + 1 AS Age
          , to_char( nvl(salary+(salary*commission_pct), salary)*12, '999,999') AS YearSal
          , to_char( nvl(salary+(salary*commission_pct), salary)*12 * taxpercent, '99,999.9') AS YearSalTax 
          , nvl(salary+(salary*commission_pct), salary)*12 - DeptAvgYearSal AS DeptAvgYearSalDiff
          , rank() over(partition by E.department_id
                        order by nvl(salary+(salary*commission_pct), salary)*12 desc) AS DeptYearSalRank
          , rank() over(order by nvl(salary+(salary*commission_pct), salary)*12 desc) AS TotalYearSalRank                                      
     from employees E JOIN tbl_taxindex T  
     ON nvl(salary+(salary*commission_pct), salary)*12 between lowerincome and highincome 
     JOIN V
     ON nvl(E.department_id, -9999) = nvl(V.department_id, -9999)
   )
  select A.department_id AS 부서번호
        , department_name AS 부서명
        , Address AS 부서주소
        , DeptHeadName AS 부서장성명
        , employee_id AS 사원번호
        , Ename AS 사원명
        , Gender AS 성별
        , Age AS 나이 
        , YearSal AS 연봉
        , YearSalTax AS 연봉소득세액
        , DeptAvgYearSalDiff AS 부서내연봉평균차액
        , DeptYearSalRank AS 부서내연봉등수
        , TotalYearSalRank AS 전체연봉등수  
   from A RIGHT JOIN B
   ON A.department_id = B.department_id
   order by 1, 9;














