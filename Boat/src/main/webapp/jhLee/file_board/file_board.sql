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
	
	insert into file_board
	values(1,1,1,1,1,1,1,0,0,0,0,sysdate);
	
	insert into file_board
	values(2,1,1,1,1,1,1,0,0,1,0,sysdate);
	
	insert into file_board
	values(3,1,1,1,1,1,1,0,0,2,0,sysdate);
	
	select * from file_board;
	
	
	drop table FILE_COMMENT cascade constraints purge;

--게시판 글이 삭제되면 참조하는 댓글도 삭제됩니다.
insert into comm(num,id,comment_board_num) values(1,'admin',1);
insert into comm(num,id,comment_board_num) values(2,'admin',1);
insert into comm(num,id,comment_board_num) values(3,'admin',2);
insert into comm(num,id,comment_board_num) values(4,'admin',2);




--public class FileDAO {
--	public int getListcount() {

select count(*) from file_board;

--	public List<FileBean> getBoardList(int page, int limit) {

SELECT * FROM (select rownum rnum, j.* from (
							 select board.*, nvl(CNT ,0) CNT 
							from board left outer join (select comment_board_num,count(*) CNT  
														from comm 
														group by comment_board_num) 
												on board_num = comment_board_num 
							order by board_re_ref desc, 
							board_re_seq asc)j
							 				where rownum<=? ) 
							WHERE rnum>=? and rnum<=?

SELECT * FROM (select rownum rnum, j.* from (
							 select file_board.*, nvl(CNT ,0) CNT 
							from file_board left outer join (select F_COMMENT_NUM,count(*) CNT  
														from FILE_COMMENT 
														group by F_COMMENT_NUM) 
												on FILE_NUM = F_COMMENT_NUM 
							order by FILE_RE_REF desc, 
							FILE_RE_SEQ asc)j
							 				where rownum<=? ) 
							WHERE rnum>=? and rnum<=?;
