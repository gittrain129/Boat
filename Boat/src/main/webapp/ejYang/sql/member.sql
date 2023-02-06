drop table member cascade constraints purge;

create table MEMBER(
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
 
 --홍보팀 소속 ADMIN계정 
 INSERT INTO member 
 (EMPNO, DEPT, DEPTNO, PASSWORD,PWCHECK,NAME,JUMIN,ADDRESS,POST,GENDER,EMAIL,PHONE,MEMBERFILE,IMGSRC)
 VALUES('ADMIN','인사팀','','123456','123456','홍길동','8811221012345','서울특별시 종로구 율곡로10길 105 디아망', 
 '12345','남','admin@boat.com','01012345678','안녕하세
요 반갑습니다','/uploadImage/adminImage');
 
 select * from member;