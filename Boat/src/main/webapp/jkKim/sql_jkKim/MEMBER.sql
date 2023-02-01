drop table BOAT cascade constraints purge;

create table BOAT(
EMPNO VARCHAR2(12) PRIMARY KEY,
DEPT VARCHAR2(10)
CONSTRAINT BOAT_DEPT_CK CHECK (DEPT IN('홍보팀','개발팀','인사팀','기획팀','영업팀')),
DEPTNO NUMBER(2),
CONSTRAINT BOAT_DEPTNO_CK CHECK (DEPTNO IN('10','20','30','40','50')),
PASSWORD VARCHAR2(10),
PWCHECK VARCHAR2(10),
NAME VARCHAR2(15),
JUMIN NUMBER(14),
ADDRESS VARCHAR2(150),
POST NUMBER(5),
GENDER VARCHAR2(3),
EMAIL VARCHAR2(30),
PHONE NUMBER(11),
MEMBERFILE VARCHAR2(50),
IMGSRC VARCHAR2(150)
);