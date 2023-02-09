drop table BOARD cascade constraints purge;

create table BOARD (
	BOARD_NUM NUMBER(5) primary key,
	BOARD_NAME VARCHAR2(30), 
	BOARD_PASS NUMBER(30),
	BOARD_SUBJECT VARCHAR2(300),	
	BOARD_CONTENT VARCHAR2(4000),		
	BOARD_DEPT VARCHAR2(10),		
	BOARD_RE_REF NUMBER(5),	
	BOARD_RE_LEV NUMBER(5),	
	BOARD_RE_SEQ NUMBER(5),
	BOARD_READCOUNT NUMBER(5),
	BOARD_DATE DATE DEFAULT SYSDATE,
	BOARD_NOTICE VARCHAR2(2) 
	CONSTRAINT BOARD_NO_CK check(BOARD_NOTICE in ('Y','N'))
);

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
	FILE_DATE DATE,
	DEPT VARCHAR2(30) check (dept in ('홍보팀', '개발팀', '인사팀', '기획팀', '영업팀'))
);

--내 글 보기
select count(*) from BOARD, file_board
on BOARD_NAME = FILE_NAME
where BOARD_NAME = 'ADMIN'



insert into BOARD
(BOARD_NUM,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,BOARD_DEPT,BOARD_RE_REF,BOARD_RE_LEV,
BOARD_RE_SEQ,BOARD_READCOUNT,BOARD_NOTICE)
values(1,'어드민', 1234, '첫 글', '첫 글', '인사팀', 1,0,0,0,'N');

delete BOARD
where BOARD_NUM = 1

select count(*) from BOARD 
where BOARD_NOTICE = 'Y';

--게시판 조회 쿼리
select * from BOARD
ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC		

--다음글 쿼리
SELECT * FROM(
select ROWNUM RNUM, J.* from
(select * from BOARD
ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
WHERE ROWNUM <	(select RNUM from
				(select ROWNUM RNUM, J.* from
				(select * from BOARD
				ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
				WHERE BOARD_NUM = 16)
) WHERE RNUM = (SELECT MAX(RNUM) from
				(select ROWNUM RNUM, J.* from
				(select * from BOARD
				ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
				WHERE ROWNUM <	(select RNUM from
								(select ROWNUM RNUM, J.* from
								(select * from BOARD
								ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
								WHERE BOARD_NUM = 16)))

--이전글 쿼리
SELECT * FROM
(SELECT * FROM(
	select ROWNUM RNUM, J.* from
			(select * from BOARD
			ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
) WHERE RNUM > (select RNUM from
								(select ROWNUM RNUM, J.* from
									(select * from BOARD
									ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
						WHERE BOARD_NUM = 16)		
) WHERE RNUM = (SELECT MIN(RNUM) FROM(
					select ROWNUM RNUM, J.* from
							(select * from BOARD
							ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
				) WHERE RNUM > (select RNUM from
												(select ROWNUM RNUM, J.* from
													(select * from BOARD
													ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
										WHERE BOARD_NUM = 16))




insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(1, '처음', 'admin', 1, 'N');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(2, '처음', 'admin', 2, 'N');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(3, '처음', 'admin', 3, 'N');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(4, '둘째', 'admin', 4, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(5, '셋째', 'admin', 5, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(6, '셋째', 'admin', 5, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(7, '셋째', 'admin', 5, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(8, '셋째', 'admin', 8, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(9, '셋째', 'admin', 9, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(10, '셋째', 'admin', 10, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(11, '셋째', 'admin', 11, 'Y');
insert into BOARD (BOARD_NUM, BOARD_SUBJECT, BOARD_NAME, BOARD_RE_REF, BOARD_NOTICE) values(12, '처음', 'admin', 12, 'N');

insert into BOARD_COMMENT (B_C_NUM, B_C_ID, B_COMMENT_NUM) values(1, 'ADMIN', 1);
insert into BOARD_COMMENT (B_C_NUM, B_C_ID, B_COMMENT_NUM) values(2, 'ADMIN', 1);
insert into BOARD_COMMENT (B_C_NUM, B_C_ID, B_COMMENT_NUM) values(3, 'ADMIN', 2);
insert into BOARD_COMMENT (B_C_NUM, B_C_ID, B_COMMENT_NUM) values(4, 'ADMIN', 2);

update board
set board_subject = '오늘도 행복하세요'
where board_num=1;




select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT
												GROUP BY B_COMMENT_NUM)			
					ON BOARD_NUM = B_COMMENT_NUM
					WHERE BOARD_NOTICE = 'Y'
					ORDER BY BOARD_RE_REF DESC,
					BOARD_RE_SEQ ASC
					) j
			where rownum<= 3
UNION ALL
select*from(select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT
												GROUP BY B_COMMENT_NUM)			
					ON BOARD_NUM = B_COMMENT_NUM
					ORDER BY BOARD_RE_REF DESC,
					BOARD_RE_SEQ ASC
					) j
			where rownum<= 10)
where rnum>=1 and rnum<=13;



