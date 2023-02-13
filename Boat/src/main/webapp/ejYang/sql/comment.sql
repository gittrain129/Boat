drop table BOARD_COMMENT cascade constraints purge;

create table BOARD_COMMENT(
	B_C_NUM					number 			PRIMARY KEY,--글번호
	B_C_ID 					varchar2(30)	references MEMBER(EMPNO),
	B_CONTENT				varchar2(200),
	B_REG_DATE				date DEFAULT SYSDATE,
	B_COMMENT_NUM			number	--원문글번호
	references BOARD(BOARD_NUM) on delete cascade,--comm 테이블이 참조하는 보드 글 번호
	B_COMMENT_RE_LEV		number(1)	check(B_COMMENT_RE_LEV in (0,1,2)),--원문이면0 답글이면1
	B_COMMENT_RE_SEQ		number,	--원문이면0, 1레벨이면 1레벨 시퀀스 + 1
	B_COMMENT_RE_REF		number	--원문은 자신 글번호, 답글이면 원문 글번호
);
--게시판 글이 삭제되면 참조하는 댓글도 삭제됩니다.

insert into BOARD_COMMENT 
(B_C_NUM, B_C_ID, B_CONTENT, B_COMMENT_NUM, B_COMMENT_RE_REF, B_COMMENT_RE_LEV, B_COMMENT_RE_SEQ) 
values(1, 'ADMIN', '댓글', 1, 1, 0, 0);
insert into BOARD_COMMENT 
(B_C_NUM, B_C_ID, B_CONTENT, B_COMMENT_NUM, B_COMMENT_RE_REF, B_COMMENT_RE_LEV, B_COMMENT_RE_SEQ) 
values(2, 'ADMIN', '댓글', 2, 1, 1, 1);



drop sequence BOARD_COM_SEQ;

--시퀀스를 생성합니다.
create sequence BOARD_COM_SEQ;

delete BOARD_COMMENT
WHERE B_C_ID = 'dltnstls'

select*from BOARD_COMMENT;


select count(*) from BOARD_COMMENT 
where B_COMMENT_NUM = 10


select B_C_NUM, B_C_ID, B_CONTENT, REG_DATE, B_COMMENT_RE_LEV, 
B_COMMENT_RE_SEQ, B_COMMENT_RE_REF, MEMBER.MEMBERFILE 
from BOARD_COMMENT join MEMBER 
on	 	BOARD_COMMENT.B_C_ID = MEMBER.EMPNO 
where 	B_COMMENT_NUM = 1 
order by B_COMMENT_RE_REF asc, 
B_COMMENT_RE_SEQ asc
