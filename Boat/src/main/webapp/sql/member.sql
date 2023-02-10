drop table member cascade constraints purge;
--1. index.jsp에서 시작 합니다.
--2. 관리자 계정 admin, 비번 1234를 만듭니다.
--3. 사용자 계정을 3개 만듭니다.

create table MEMBER(
	 EMPNO VARCHAR2(12) PRIMARY KEY,
	 DEPT VARCHAR2(10)
	 CONSTRAINT BOAT_DEPT_CK CHECK (DEPT IN('홍보팀','개발팀','인사팀','기획팀','영업팀')),
	 DEPTNO NUMBER(2),
	 CONSTRAINT BOAT_DEPTNO_CK CHECK (DEPTNO IN('10','20','30','40','50')),
	 PASSWORD VARCHAR2(10),
	 PWCHECK VARCHAR2(10),
	 NAME VARCHAR2(15),
	 JUMIN varchar2(15),
	 ADDRESS VARCHAR2(150),
	 POST NUMBER(5),
	 gender		char(1) check(gender in ('m', 'f')),
	 EMAIL VARCHAR2(30),
	 PHONE NUMBER(11),
	 MEMBERFILE VARCHAR2(50),
	 IMGSRC VARCHAR2(150),
	 register_date date default sysdate,
	 intro		varchar2(100)
);

--memberfile은 회원 정보 수정시 적용합니다.
select * from member;

