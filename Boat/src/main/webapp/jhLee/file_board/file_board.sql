--file_board sql
drop table file_board cascade constraints purge;

create table file_board (
	FILE_NUM NUMBER(5) primary key,
	FILE_NAME VARCHAR2(30), 
	FILE_PASS NUMBER(30),
	FILE_SUBJECT VARCHAR2(300),	
	FILE_CONTENT VARCHAR2(4000),		
	FILE_FILE VARCHAR2(50),
	FILE_FILE2 VARCHAR2(50),		
	FILE_RE_REF NUMBER(5),	
	FILE_RE_LEV NUMBER(5),	
	FILE_RE_SEQ NUMBER(5),
	FILE_READCOUNT NUMBER(5),
	FILE_DATE DATE );
	
	select * from file_board;
	
	
	drop table FILE_COMMENT cascade constraints purge;

create table FILE_COMMENT (
F_C_NUM number primary key,
F_C_ID varchar2(30) references member(empno),
F_CONTENT varchar2(200),
F_COMMENT_NUM NUMBER references file_board(FILE_NUM) on delete cascade,
F_COMMENT_RE_LEV number check(f_comment_re_lev in(0,1,2)),
F_COMMENT_RE_SEQ number(1) ,
F_COMMENT_RE_REF number
);


--게시판 글이 삭제되면 참조하는 댓글도 삭제됩니다.
insert into comm(num,id,comment_board_num) values(1,'admin',1);
insert into comm(num,id,comment_board_num) values(2,'admin',1);
insert into comm(num,id,comment_board_num) values(3,'admin',2);
insert into comm(num,id,comment_board_num) values(4,'admin',2);
