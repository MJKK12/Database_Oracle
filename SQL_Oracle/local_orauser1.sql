    show user;
    
    select *
    from hr.view_emp_3080;
    
    --- === *** 시노님(Synonym, 동의어) *** === ---
    create or replace synonym emp for HR.view_emp_3080;        -- view_emp_3080 를 emp로 바꾸겠다!! (원래 이름이 너무 기니까 Synonym을 써서 줄이겠다.)
    /*
    오류 보고 -
    ORA-01031: insufficient privileges
    */
    
    -- ▼ SYS 에서 권한을 부여한 이후
    create or replace synonym emp for HR.view_emp_3080;        -- view_emp_3080  를 emp로 바꾸겠다!! (원래 이름이 너무 기니까 Synonym을 써서 줄이겠다.)
    -- Synonym EMP이(가) 생성되었습니다.
    
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


