--file_board sql
select * from file_board;

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
	FILE_DATE DATE ,
	DEPT VARCHAR2(30) check (dept in ('홍보팀', '개발팀', '인사팀', '기획팀', '영업팀'))
	);
	update file_board set file_date = sysdate;
	insert into file_board
	values(1,1,1,1,1,1,1,0,0,0,0,sysdate);
	
	insert into file_board
	values(2,1,1,1,1,1,1,0,0,1,0,sysdate);
	
	insert into file_board
	values(3,1,1,1,1,1,1,0,0,2,0,sysdate);
	
	select * from file_board;
	delete from file_board where FILE_NUM =1;
	delete from file_board ;
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
							 select file_board.*, nvl(CNT ,0) CNT 
							from file_board left outer join (select F_COMMENT_NUM,count(*) CNT  
														from FILE_COMMENT 
														group by F_COMMENT_NUM) 
												on FILE_NUM = F_COMMENT_NUM 
							order by FILE_RE_REF desc, 
							FILE_RE_SEQ asc)j
							 				where rownum<=? ) 
							WHERE rnum>=? and rnum<=?;
						
--		public boolean fileboardInsert(FileboBean filedata) {

select nvl(max(FILE_NUM),0)+1 from file_board
							
							
insert into board (FILE_NUM ,
	FILE_NAME , 
	FILE_PASS,
	FILE_SUBJECT,	
	FILE_CONTENT ,		
	FILE_FILE ,
	FILE_FILE2 ,		
	FILE_RE_REF ,	
	FILE_RE_LEV ,	
	FILE_RE_SEQ ,
	FILE_READCOUNT 
	)
 	values ("+max_sql+",?,?,?,?,?,?,"+max_sql+",?,?,?);
 	
 				String max_sql = "(select nvl(max(FILE_NUM),0)+1 from file_board)";
				
				insert into file_board 
						(FILE_NUM , 
							FILE_NAME, 
							FILE_PASS, 
							FILE_SUBJECT,
							FILE_CONTENT ,	
							FILE_FILE , 
							FILE_FILE2 ,	
							FILE_RE_REF ,	
							FILE_RE_LEV ,	
			 				FILE_RE_SEQ , 
							FILE_READCOUNT, 
						 DEPT
								) 
						values (0,0,0,0,0,0,0,0,0,0,0,'개발팀');
						
							String max_sql = "(select nvl(max(FILE_NUM),0)+1 from file_board)";
				
				String sql = "insert into file_board "
						+ "(FILE_NUM , "
						+ "	FILE_NAME , "
						+ "	FILE_PASS, "
						+ "	FILE_SUBJECT,	"
						+ "	FILE_CONTENT ,	"
						+ "	FILE_FILE , "
						+ "	FILE_FILE2 ,	"
						+ "	FILE_RE_REF ,	"
						+ "	FILE_RE_LEV ,	"
			 			+ "	FILE_RE_SEQ , "
						+ "	FILE_READCOUNT, "
						+ " DEPT"
						
						+ "	) "
						+ "values ("+max_sql+",?,?,?,?,?,?,"+max_sql+",?,?,?,"+"'"+filedata.getDEPT()+"'"+")";
				
						
--		public FileboBean getDetail(int num) {

select * from file_board where FILE_NUM =?








 select * from 
				(select b.*, rownum rnum from 
					(select file_board.* , nvl(CNT ,0)  CNT
					from file_board left outer join  
					 				(select F_COMMENT_NUM ,count(*) CNT from FILE_COMMENT group by F_COMMENT_NUM 
									order by  CNT desc) 
					on FILE_NUM = F_COMMENT_NUM 
					where dept = '개발팀'
					and FILE_NAME = '이지현' 
				order by FILE_RE_REF desc 
				, FILE_READCOUNT desc )b 
				where rownum<=10 )
				where rnum>=1 and rnum<=10;
				
				
				
				
				
				
 select * from 
				(select b.*, rownum rnum from 
					(select file_board.* , nvl(CNT ,0)  CNT
					from file_board left outer join  
					 				(select F_COMMENT_NUM ,count(*) CNT from FILE_COMMENT group by F_COMMENT_NUM 
									order by  CNT desc) 
					on FILE_NUM = F_COMMENT_NUM 
					where dept = '개발팀'
					and FILE_NAME = '이지현' 
				order by FILE_RE_REF desc 
				, FILE_READCOUNT desc )b 
				where rownum<=10 )
				where rnum>=1 and rnum<=10;
				
				
	select count(*) 
					from file_board 
					where dept = '개발팀'
					and FILE_NAME = '이지현' 
				order by FILE_RE_REF desc 
				, FILE_READCOUNT desc 
