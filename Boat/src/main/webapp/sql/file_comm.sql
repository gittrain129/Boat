drop table FILE_COMMENT cascade constraints purge;



create table FILE_COMMENT (
F_C_NUM number primary key,
F_C_ID varchar2(30) references member(empno),
F_CONTENT varchar2(200),
F_COMMENT_DATE date,
F_COMMENT_NUM NUMBER references file_board(FILE_NUM) on delete cascade,
F_COMMENT_RE_LEV number check(f_comment_re_lev in(0,1,2)),
F_COMMENT_RE_SEQ number(38), 
F_COMMENT_RE_REF number(38) 
);
create sequence filecom nocache;

drop sequence filecom;

select * from FILE_COMMENT;






