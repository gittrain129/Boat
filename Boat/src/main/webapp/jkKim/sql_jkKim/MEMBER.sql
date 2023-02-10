drop table member cascade constraints purge;

create table member(
EMPNO VARCHAR2(12) PRIMARY KEY,
DEPT VARCHAR2(10)
CONSTRAINT BOAT_DEPT_CK CHECK (DEPT IN('홍보팀','개발팀','인사팀','기획팀','영업팀')),
DEPTNO NUMBER(2),
CONSTRAINT BOAT_DEPTNO_CK CHECK (DEPTNO IN('10','20','30','40','50')),
PASSWORD VARCHAR2(10),
PWCHECK VARCHAR2(10),
NAME VARCHAR2(15),
JUMIN VARCHAR2(15),
ADDRESS VARCHAR2(150),
POST NUMBER(5),
GENDER VARCHAR2(3),
EMAIL VARCHAR2(30),
PHONE NUMBER(11),
MEMBERFILE VARCHAR2(50),
IMGSRC VARCHAR2(150)
);

 INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('ADMIN','','','aAbB123456','aAbB123456','홍길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','admin@boat.com','01012345678','안녕하세요 반갑습니다','/uploadImage/adminImage');
 
 
 
  INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('231001','홍보팀','10','aAbB123456','aAbB123456','홍길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','hgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
   INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('232001','개발팀','20','aAbB123456','aAbB123456','박길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
  INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('233001','인사팀','30','aAbB123456','aAbB123456','김길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
  INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('234001','기획팀','40','aAbB123456','aAbB123456','이길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
  INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('235001','영업팀','50','aAbB123456','aAbB123456','최길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
 
 
   INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('231002','홍보팀','10','aAbB123456','aAbB123456','홍동길','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','hgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
    INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('232002','개발팀','20','aAbB123456','aAbB123456','박동길','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
  INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('233002','인사팀','30','aAbB123456','aAbB123456','김동길','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
   INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('234002','기획팀','40','aAbB123456','aAbB123456','이동길','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
  INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('235002','영업팀','50','aAbB123456','aAbB123456','최동길','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
 
   INSERT INTO member (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('235003','영업팀','50','aAbB123456','aAbB123456','gildong','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', '12345','남','bgd123@boat.com','01012345678','안녕하세요 반갑습니다','/image/image_sample.png');
 
 
 
 select * from member
 
 select name, pwcheck from member;
 
 update member set imgsrc = '/image/image_sample.png'
 
 update member set empno =232001 where name='박길동' and deptno = 20
 
 update member set name ='박길동' where name='홍길동' and deptno = 20
 
 
 select imgsrc from member;
 
 
	 select * from (select rownum rnum, j.* from ( select deptno, name, dept, email, imgsrc   from member order by deptno desc ) j
	 	where rownum <=? )
 	where rnum >=? and rnum <=?;
 	
 	
select rownum rnum, empno, name, dept, email, imgsrc   from member order by deptno asc

select j.*
from (select rownum rnum,
		k.*
	from (select empno, name, dept, email, imgsrc from member order by deptno asc) k
) j
where where rnum >=1 and rnum <=8











select rownum, empno, name, dept, email, imgsrc from member  where rownum = 2 order by deptno asc

select j.*
from (select rownum rnum, empno, name, dept, email, imgsrc from member  order by deptno asc) j
where j.rnum = 2







