remote_semi_prj_shoes


String sql = "select qnaNum "+
          " , case when length(qnaSubject) > 20 then substr(qnaSubject, 0, 15) || '...' else qnaSubject end AS qnaSubject "+
          " , qnaWriter "+
          " , to_char(qnaRegDate, 'yyyy-mm-dd') as qnaRegDate "+
          " , qnaReadCount "+
          " from qna_board "+
          " order by qnaNum desc ";


String sql = " insert into qna_board( qnaNum, qnaWriter, qnaSubject, qnaContent, imgFileName, pNum )"
           + " values(board_seq.nextval, ?, ?, ?, ?, ? )";

String sql = " delete from qna_board "
           + " where qnaNum =? ";

QNANUM	NUMBER	No	
QNAWRITER	VARCHAR2(50 BYTE)	Yes	
QNASUBJECT	VARCHAR2(100 BYTE)	Yes	
QNACONTENT	VARCHAR2(2000 BYTE)	Yes	
QNAREADCOUNT	NUMBER	Yes	0
QNAREGDATE	DATE	Yes	"sysdate -- 작성일"

-------------------------- 세미플젝 테이블 생성 ----------------------
--  전체 테이블 생성 !! --
create table tbl_qnaBoard
( qna_num        VARCHAR2(50) NOT NULL,
  qna_writer     VARCHAR2(100),
  qna_subject    VARCHAR2(100),
  qna_content    VARCHAR2(2000),
  qna_file       VARCHAR2(100),
  qna_regDate    date default sysdate,    
  qna_viewCnt    NUMBER,
  CONSTRAINT PK_Qna_Board PRIMARY KEY(qna_num),
  CONSTRAINT FK_tbl_qnaBoard_FK_qna_writer foreign key (qna_writer) REFERENCES tbl_member(userid)
);

-- 작성자 제약조건 추가 (tbl_member 의 userid 에 tbl_qnaBoard 의 qna_writer 에 fk 제약조건 추가)
ALTER TABLE tbl_qnaBoard ADD CONSTRAINT qna_writer foreign KEY(qna_writer) references tbl_member(userid);
--Table TBL_QNABOARD이(가) 변경되었습니다.

-- 조회수 컬럼 삭제, 추가
alter table tbl_qnaBoard drop column qna_viewCnt

alter table tbl_qnaBoard add (qna_viewCnt number default 0);

alter table tbl_qnaBoard drop column qna_re_seq;

commit;

select *
from tbl_qnaBoard
--

drop table tbl_qnaBoard purge;



alter table tbl_qnaBoard
modify qna_regDate default sysdate;
-- Table TBL_QNABOARD이(가) 변경되었습니다.


-- tbl_qnaBoard 생성 완료

select * 
from tbl_qnaBoard;

create sequence seq_qnaBoard
start with 1
increment by 1;

-- Sequence SEQ_QNABOARD이(가) 생성되었습니다.

-- 테이블, 시퀀스 테스트용 --

select qna_num
, case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
, qna_writer
, to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
, qna_viewCnt 
from tbl_qnaBoard
order by qna_num desc


--- 테스트용 끝 ---

insert into tbl_qnaBoard( qna_num, qna_writer, qna_subject, qna_content, qna_regDate, qna_viewCnt )
values(seq_qnaBoard.nextval, '작성자1', '배송문의 드립니다.', '저번주에 주문했는데 언제 배송되나요?', sysdate, default );

commit;


----- 글 상세 조회용
select qna_num
, case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
, qna_writer
, to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
, qna_content
from tbl_qnaBoard
order by qna_num desc



----- fk 제약조건 추가 필요 --------
-- 멤버 id 를 불러와야 하므로, 멤버 테이블에서 id 의 제약조건을 가져온다. )fk)
Member_Board 테이블에서 board_id 값은 회원 테이블의 ID 값을 참조하기 위해 외래키 제약조건을 추가




------------------------------

---- 1. 전체글조회 sql문 

select qna_num
, case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
, qna_writer
, to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
, qna_viewCnt 
from tbl_qnaBoard
order by qna_num desc

delete from tbl_qnaBoard;

-- 2. 글쓰기 sql 문
insert into tbl_qnaBoard(qna_num, qna_subject, qna_writer, qna_content, qna_file)
                 values (seq_qnaBoard.nextval, ?, ?, ?, ?) 

String sql = "insert into tbl_qnaBoard(qna_num, qna_subject, qna_writer, qna_content, qna_file)\n"+
"                 values (seq_qnaBoard.nextval, ?, ?, ?, ?)";


-- 3. 글조회 sql 문

select qna_num
, case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
, qna_writer
, qna_content
, to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
, qna_viewCnt 
, qna_file
from tbl_qnaBoard
where qna_num = 8;

select qna_num  , case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject  , 
qna_writer  , qna_content  , to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate  , qna_viewCnt  , qna_file  
from tbl_qnaBoard  
 
 
-- 4. 글수정 sql 
update tbl_qnaBoard set qna_writer = ?, qna_subject = ?, qna_content =? , qna_file = ?
where qna_num = ?






-- 5. 글삭제 sql 문


 
commit;


delete from tbl_qnaBoard
where qna_num = 9 ;

commit;


------------------------- 댓글달기 테이블 / 시퀀스
create table tbl_qna_comment(
qna_commentno      number,
fk_qna_num         VARCHAR2(50),    -- tbl_qna_board 테이블과 데이터타입이 같다.
fk_qna_cmtWriter   varchar2(40),
qna_cmtContent     varchar2(300),
qna_cmtRegDate     date default sysdate,    
constraint  PK_tbl_qnaCmt primary key(qna_commentno), 
constraint  FK_tbl_qnaCmt_fk_qna_num foreign key(fk_qna_num) 
            references tbl_qnaBoard(qna_num) on delete cascade,  
constraint  FK_tbl_qnaCmt_fk_qna_writer foreign key(fk_qna_writer) 
            references tbl_member(userid) 
);
-- Table TBL_QNA_COMMENT이(가) 생성되었습니다.

alter table tbl_qna_comment rename column fk_qna_writer to fk_qna_cmtWriter

commit;

create sequence seq_comment
start with 1
increment by 1
nomaxvalue 
nominvalue
nocache;
-- Sequence SEQ_COMMENT이(가) 생성되었습니다.

insert into tbl_qna_comment(qna_commentno, fk_qna_num, fk_qna_writer, qna_cmtContent)
values(seq_comment.nextval, '43' ,'kimkimkim', 'test 입니다');

select * 
from tbl_qna_comment

String sql = " insert into tbl_qna_comment(qna_commentno, fk_qna_num, fk_qna_writer, qna_cmtContent) "+
" values(seq_comment.nextval, '43' ,'kimkimkim', 'test 입니다') ";


---------------- 댓글내용 보기 테이블
create table tbl_qna_comment(
qna_commentno      number,
fk_qna_num         VARCHAR2(50),    -- tbl_qna_board 테이블과 데이터타입이 같다.
fk_qna_cmtWriter   varchar2(40),
qna_cmtContent     varchar2(300),
qna_cmtRegDate     date default sysdate,    
constraint  PK_tbl_qnaCmt primary key(qna_commentno), 
constraint  FK_tbl_qnaCmt_fk_qna_num foreign key(fk_qna_num) 
            references tbl_qnaBoard(qna_num) on delete cascade,  
constraint  FK_tbl_qnaCmt_fk_qna_writer foreign key(fk_qna_cmtWriter)
            references tbl_member(userid) 
);
-- Table TBL_QNA_COMMENT이(가) 생성되었습니다.

/*
SEMIORAUSER1.FK_TBL_QNACMT_FK_QNA_WRITER

select *
from tbl_member;

select *
from tbl_qna_comment;

*/



-- 제약조건 삭제
ALTER TABLE tbl_qna_comment DROP CONSTRAINT FK_tbl_qnaCmt_fk_qna_writer CASCADE;

-- 제약조건 추가
ALTER TABLE tbl_qna_comment ADD CONSTRAINT FK_tbl_qnaCmt_fk_qna_writer FOREIGN KEY(fk_qna_cmtWriter) 
REFERENCES tbl_member(userid);

commit;

-- 제약조건 추가
alter table tbl_qna_comment add foreign key(fk_qna_cmtWriter) references tbl_member(userid);

-- 제약조건 조회
SELECT * FROM ALL_CONSTRAINTS
WHERE TABLE_NAME = 'tbl_qna_comment';


--------------------------------
select *
from tbl_qna_comment;

insert into tbl_qna_comment(qna_commentno, fk_qna_num, fk_qna_cmtWriter, qna_cmtContent) values(seq_comment.nextval, '43' , 'kimkimkim' , '댓글 test 입니다!!!!')
commit;

select *
from tbl_member 

select * 
from tbl_qna_comment;

-- 댓글내용 보기 시퀀스

create sequence seq_comment
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;
-- Sequence SEQ_COMMENT이(가) 생성되었습니다.

---- 댓글보기 SQL 문 --1
select qna_cmtContent, M.name, C.qna_cmtRegDate
from
(select qna_cmtContent, to_char(qna_cmtRegDate, 'yyyy-mm-dd hh24:mi:ss') as qna_cmtRegDate, fk_qna_cmtWriter
from tbl_qna_comment
where fk_qna_num = '1') C JOIN tbl_member M
ON C.fk_qna_cmtWriter = M.userid;

---- 댓글보기 SQL 문 --2

select qna_commentno, fk_qna_num, fk_qna_cmtWriter, qna_cmtContent, to_char(qna_cmtRegDate, 'yyyy-mm-dd') as qna_cmtRegDate
from tbl_qna_comment
where fk_qna_num = '43'
order by qna_cmtRegDate asc;

select *
from tbl_qna_comment

--- 자바 복사용


String sql = " select qna_commentno, fk_qna_num, fk_qna_cmtWriter, qna_cmtContent, to_char(qna_cmtRegDate, 'yyyy-mm-dd') as qna_cmtRegDate "+
" from tbl_qna_comment "+
" where fk_qna_num = '1' "+
" order by qna_cmtRegDate asc ";

---

-- 테스트용
insert into tbl_qna_comment (qna_commentno, fk_qna_num, fk_qna_cmtWriter, qna_cmtContent)
values(1, '43', 'kimkimkim', '댓글 테스트입니다!!');

commit;

----
String sql = " select qna_cmtContent, M.name, C.qna_cmtRegDate "+
" from "+
" (select qna_cmtContent, to_char(qna_cmtRegDate, 'yyyy-mm-dd hh24:mi:ss') as qna_cmtRegDate, fk_qna_cmtWriter "+
" from tbl_qna_comment "+
" where fk_qna_num = '1') C JOIN tbl_member M "+
" ON C.fk_qna_cmtWriter = M.userid ";


----------------------- FAQ 테이블






------------------------ 매장찾기 테이블

create table tbl_storeSearch
( storeId      VARCHAR2(20),    -- 매장 일련번호
  storeName    VARCHAR2(100),   -- 매장이름
  storeInfo    VARCHAR2(200),   -- 주소, 전화번호
  lat           NUMBER,
  lng           NUMBER,
  zIndex        NUMBER,
  constraint tbl_storeSearch_storeId_PK primary key(storeId)
);
-- Table TBL_STORESEARCH이(가) 생성되었습니다.

create sequence seq_storeSearch -- 매장 일련번호 시퀀스
start with 1
increment by 1
nomaxvalue
nocycle
nocache;
-- Sequence SEQ_STORESEARCH이(가) 생성되었습니다.

--------------------------- 매장찾기 끝


String sql = " select ceil(count(*)) "+
" from tbl_qnaBoard ";

select *
from tbl_qnaBoard;

String sql = " select count(*) "+
" from tbl_qnaBoard "+
" where QNA_SUBJECT like '%'||'배송'||'%' ";




--------------------- 글조회 sql 문 페이징 처리 하기 -------------------------
-- 1. 전체 글목록 조회하기
select qna_num
, case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
, qna_writer
, qna_content
, to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
, qna_viewCnt 
, qna_file
from tbl_qnaBoard

-- 2. 페이징 처리를 위해 rownum 을 추가하기.
select rownum, qna_num
, case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
, qna_writer
, qna_content
, to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
, qna_viewCnt 
, qna_file
from tbl_qnaBoard
where rownum between 1 and 10
order by qna_num desc;

-- 3. select 에 rownum as rno 에서 rno 부분을 추가한다.

select rno, qna_num, qna_subject, qna_writer, qna_regDate, qna_viewCnt 
from 
  (  
    select rownum as rno, qna_num, qna_subject, qna_writer, qna_regDate, qna_viewCnt
    from
    (
        select qna_num
        , case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject
        , qna_writer , to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate
        , qna_viewCnt
        from tbl_qnaBoard
        order by qna_num desc
    ) V
) T
where rno between 1 and 10;  -- 1 페이지 (1 페이지당 10개를 보여줄 때)

-- 자바 복사용 sql

String sql = " select rno, qna_num, qna_subject, qna_writer, qna_regDate, qna_viewCnt "+
" from "+
"  (  "+
"    select rownum as rno, qna_num, qna_subject, qna_writer, qna_regDate, qna_viewCnt "+
"    from "+
"    ( "+
"        select qna_num "+
"        , case when length(qna_subject) > 20 then substr(qna_subject, 0, 20) || '...' else qna_subject end AS qna_subject "+
"        , qna_writer , to_char(qna_regDate, 'yyyy-mm-dd') as qna_regDate "+
"        , qna_viewCnt "+
"        from tbl_qnaBoard "+
"        order by qna_num desc "+
"    ) V "+
" ) T "+
" where rno between 1 and 10 ";

--




-------------- member 용 테이블

select *
from tbl_member;

SELECT 
	CONSTRAINT_NAME
    , CONSTRAINT_TYPE
    , TABLE_NAME
    , R_CONSTRAINT_NAME  
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'tbl_member';

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'tbl_qna_comment';


-----------------------------

delete from tbl_qnaBoard
where qna_num = '14';

commit;

select *
from tbl_qnaBoard

------------------------------

delete from tbl_qnaBoard where qna_num = 43
commit;

select *
from tbl_qnaboard

update tbl_qnaBoard set qna_viewCnt = qna_viewCnt + 1
where qna_num = 61

commit;


---------------- 자주묻는질문 FAQ table 생성
create table tbl_faqBoard
(
    faq_num        CHAR(5),    
    faq_question   varchar2(500),
    faq_answer     varchar2(3000),
    faq_userid     varchar2(100),
    CONSTRAINT tbl_faqBoard_faq_num_pk primary key(faq_num)
);
-- faq_userid 추가
alter table tbl_faqBoard add (faq_userid varchar2(100));

-- faq_question 데이터 타입(길이) 변경
alter table tbl_faqBoard modify faq_question varchar2(500);

select faq_num, faq_userid, faq_question, faq_answer 
from tbl_faqBoard



-- faq test
insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 온라인(쇼핑몰, 경매사이트, 개인사이트 등)에서 판매되고 있는 제품은 진짜인가요?', 
                                                   '저희 제품은 공식쇼핑몰에서만 판매하고 있습니다.
													현재 온라인(쇼핑몰, 경매사이트, 개인사이트 등)에서 판매되고 있는 뉴발란스 제품에 대해서는 
													정품유무 판별이 불가하며 병행수입제품 또는 유사/모조품에 대해서는 A/S등의 서비스를 제공받으실 수 없습니다.')

insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 회원의 혜택은 무엇인가요?', 
                                                   '1. 모든 회원 서비스의 자유로운 이용과 혜택을 받으실 수 있습니다.
							            <br>2. 신상품 및 다양한 이벤트와 행사 정보를 받아보실 수 있습니다.
							            <br>3. 다양한 이벤트 및 행사에 우선적으로 참가하실 수 있는 권한을 드립니다.
							            <br>4. My NB에서는 회원님만을 위한 상세정보 조회 및 맞춤 서비스를 편리하게 제공받으실 수 있습니다.
							            <br>5. 오프라인 매장에서 회원등록 카드를 발급 받으셨을 경우, 온/오프 구매 마일리지를 통합하여 적립 및 사용하실 수 있습니다.
							            <br />')
                                                    
insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 회원을 탈퇴하고 싶습니다.', 
                                       '회원정보확인/수정 페이지에서 비밀번호와 본인확인을 거치면
										즉시 탈퇴처리가 완료됩니다. 탈퇴안내를 반드시 확인해주시기 바랍니다.<br>
										</p>')                                                    
commit;
                                                    
insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 회원정보를 변경하고 싶어요.', 
                                       '회원정보수정 페이지에서 원하는 회원정보를 언제든지 수정하실 수 있습니다.<br>
										변경된 회원정보는 수시로 수정하시어 다양한 행사 및 이벤트 소식을 받아보시고 이벤트 당첨 시 연락이 되지 않는다거나 경품 배송지 오류로 인한 피해를 입지 않도록 해주십시오.<br /></p>')       
                                                    
insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 회원가입 당시의 e-mail 주소를 사용하지 않아요',
                                        '로그인 후 회원정보수정 페이지에서 e-mail 주소 입력란에
							            <br>현재 사용하시는 e-mail 주소를 입력하고 수정해주십시오.
							            <br>소식지 수신여부 정기메일에 체크해주시면 새로운 e-mail 주소로 다양한 소식을 받아보실 수 있습니다.<br />
										</p>')       
                                        
insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 게시물의 삭제 기준은 무엇인가요?',
                                      ' 1. 욕설 및 비속어 사용으로 미풍양속을 저해하는 경우<BR>
							            2. 타인의 권리를 침해하거나 명예를 훼손하는 경우<BR>3. 각 게시판의 성격에 맞지 않는 경우, 광고/홍보 목적의 글 등 기타 게시하기에 부적합하다고 판단되는 경우 관리자에 의해 임의 삭제될 수 있습니다.<br></P>')     

                                        
insert into tbl_faqBoard(faq_num, faq_userid, faq_question, faq_answer)
values(seq_qnaBoard.nextval, 'admin', 'Q. 회원가입을 하지 않고 서비스 이용하는 방법은 없나요?',
                                      '현재 비회원 서비스 이용이 가능하지 않습니다. <br> 감사합니다. <br></p><br />')     
                                                          
commit;

select *
from tbl_faqBoard

insert into tbl_qnaBoard( qna_num, qna_writer, qna_subject, qna_content, qna_regDate, qna_viewCnt )
values(seq_qnaBoard.nextval, '작성자1', '배송문의 드립니다.', '저번주에 주문했는데 언제 배송되나요?', sysdate, default );



--자주묻는질문 FAQ 시퀀스(CHAR(5))
CREATE SEQUENCE seq_faqBoard
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE;

-- 시퀀스명 변경
rename seq_tbl_faqBoard_faq_num to seq_faqBoard;

insert into tbl_faqBoard values(

 


--------------------
select *
from tbl_qnaboard
order by to_number(qna_num) desc;
