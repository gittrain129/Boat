--투두리스트
drop table MYINFO cascade constraints purge;

create table MYINFO (
	T_EMPNO VARCHAR2(12),
	T_CONTENT VARCHAR2(1000),
	T_DATE DATE DEFAULT SYSDATE, 
	T_GRAPH VARCHAR2(2),
	CONSTRAINT MYINFO_GP_CK check(T_GRAPH in ('Y','N'))
);

--글내용, 완료(Y,N), 날짜(SYSDATE)

select*from MYINFO