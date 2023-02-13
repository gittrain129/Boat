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

select*from BOARD

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


--내 글 리스트 
SELECT * FROM (
SELECT rownum rnum, J.* FROM(
SELECT BOARD_NUM, BOARD_SUBJECT, BOARD_DEPT, BOARD_NAME, BOARD_READCOUNT, BOARD_DATE, BOARD_NOTICE FROM BOARD
where BOARD_NAME = '홍길동' 
UNION ALL
SELECT FILE_NUM, FILE_SUBJECT, DEPT, FILE_NAME, FILE_READCOUNT, FILE_DATE, FILE_FILE FROM file_board
where FILE_NAME = '홍길동' 
) J
where rownum <= 4
ORDER BY BOARD_DATE DESC)
where rnum>=1 and rnum<=4


SELECT * FROM (
SELECT rownum rnum, J.* FROM(
SELECT BOARD_NUM, BOARD_SUBJECT, BOARD_DEPT, BOARD_NAME, BOARD_READCOUNT, BOARD_DATE, BOARD_NOTICE, NVL(CNT, 0) AS CNT 
FROM BOARD LEFT OUTER JOIN  (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT
												GROUP BY B_COMMENT_NUM)
ON BOARD_NUM = B_COMMENT_NUM
where BOARD_NAME = '홍길동' 
UNION ALL
SELECT FILE_NUM, FILE_SUBJECT, DEPT, FILE_NAME, FILE_READCOUNT, FILE_DATE, FILE_FILE, NVL(CNT, 0) AS CNT  
FROM file_board LEFT OUTER JOIN (SELECT F_COMMENT_NUM, COUNT(*) CNT FROM FILE_COMMENT
												GROUP BY F_COMMENT_NUM)
ON FILE_NUM = F_COMMENT_NUM
where FILE_NAME = '홍길동' 
) J
where rownum <= 4
ORDER BY BOARD_DATE DESC)
where rnum>=1 and rnum<=4



SELECT * FROM(
SELECT * FROM BOARD
where BOARD_NAME = '홍길동' 
UNION ALL
SELECT * FROM file_board
where FILE_NAME = '홍길동' 
)
ORDER BY BOARD_DATE DESC;


SELECT * FROM BOARD
SELECT * FROM file_board


--내 글 개수
SELECT SUM(c) FROM
(select count(*) c from BOARD
where BOARD_NAME = '홍길동' 
UNION ALL
select count(*) c from file_board
where FILE_NAME = '길동')


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
WHERE BOARD_NOTICE = 'N'
ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
WHERE ROWNUM <	(select RNUM from
				(select ROWNUM RNUM, J.* from
				(select * from BOARD
				WHERE BOARD_NOTICE = 'N'
				ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
				WHERE BOARD_NUM = 6)
) WHERE RNUM = (SELECT MAX(RNUM) from
				(select ROWNUM RNUM, J.* from
				(select * from BOARD
				WHERE BOARD_NOTICE = 'N'
				ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
				WHERE ROWNUM <	(select RNUM from
								(select ROWNUM RNUM, J.* from
								(select * from BOARD
								WHERE BOARD_NOTICE = 'N'
								ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
								WHERE BOARD_NUM = 6)))

--이전글 쿼리
SELECT * FROM
(SELECT * FROM(
	select ROWNUM RNUM, J.* from
			(select * from BOARD
			WHERE BOARD_NOTICE = 'N'
			ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
) WHERE RNUM > (select RNUM from
								(select ROWNUM RNUM, J.* from
									(select * from BOARD
									WHERE BOARD_NOTICE = 'N'
									ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
						WHERE BOARD_NUM = 6)		
) WHERE RNUM = (SELECT MIN(RNUM) FROM(
					select ROWNUM RNUM, J.* from
							(select * from BOARD
							WHERE BOARD_NOTICE = 'N'
							ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J
				) WHERE RNUM > (select RNUM from
												(select ROWNUM RNUM, J.* from
													(select * from BOARD
													WHERE BOARD_NOTICE = 'N'
													ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) J)
										WHERE BOARD_NUM = 6))




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


--ajax 검색 기본
select*from(select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT 
												GROUP BY B_COMMENT_NUM)	
					ON BOARD_NUM = B_COMMENT_NUM  
					where BOARD_NAME = '홍길동'
					AND BOARD_NOTICE = 'Y'
					AND BOARD_DEPT like '홍보팀'
					ORDER BY BOARD_RE_REF DESC, 
					BOARD_RE_SEQ ASC) j 
			where rownum<= 3) 
where rnum >= 1 and rnum <= 3
UNION ALL
select*from(select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT 
												GROUP BY B_COMMENT_NUM)	
					ON BOARD_NUM = B_COMMENT_NUM  
					where BOARD_NAME = '홍길동'
					AND BOARD_NOTICE = 'N'
					AND BOARD_DEPT like '홍보팀'
					ORDER BY BOARD_RE_REF DESC, 
					BOARD_RE_SEQ ASC) j 
			where rownum<= 3) 
where rnum >= 1 and rnum <= 3

--ajax 검색 최신순 BOARD_DATE
select*from(select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT 
												GROUP BY B_COMMENT_NUM)	
					ON BOARD_NUM = B_COMMENT_NUM  
					where BOARD_NAME = '홍길동'
					AND BOARD_DEPT like '홍보팀'
					ORDER BY BOARD_DATE DESC,
					BOARD_RE_REF DESC, 
					BOARD_RE_SEQ ASC) j --추가된 부분
			where rownum<= 3) 
where rnum >= 1 and rnum <= 3

--ajax 검색 조회순 BOARD_READCOUNT
select*from(select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT 
												GROUP BY B_COMMENT_NUM)	
					ON BOARD_NUM = B_COMMENT_NUM  
					where BOARD_NAME = '홍길동'
					AND BOARD_DEPT like '홍보팀'
					ORDER BY BOARD_READCOUNT DESC,	--추가된 부분
					BOARD_RE_REF DESC,
					BOARD_RE_SEQ ASC) j 
			where rownum<= 3) 
where rnum >= 1 and rnum <= 3

--ajax 검색 댓글순 CNT
select*from(select rownum rnum, j.* 
			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT 
					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT 
												GROUP BY B_COMMENT_NUM)	
					ON BOARD_NUM = B_COMMENT_NUM  
					where BOARD_NAME = '홍길동'
					AND BOARD_DEPT like '홍보팀'
					ORDER BY CNT DESC,	--추가된 부분
					BOARD_RE_REF DESC,
					BOARD_RE_SEQ ASC) j 
			where rownum<= 3) 
where rnum >= 1 and rnum <= 3

