show user;

select * from dba_users; 






--------------------------------------------------------
create user semiorauser1 identified by cclass default tablespace users;
-- User SEMIORAUSER1이(가) 생성되었습니다.

grant connect, resource, unlimited tablespace, create view to semiorauser1;
-- Grant을(를) 성공했습니다.
