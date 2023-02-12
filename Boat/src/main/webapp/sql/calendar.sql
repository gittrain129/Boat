	--calendar sql
	--테이블 정의서 Number, E_NAME, START_DATE, END_DATE, ALLDAY
	
	
create table boat_Calendar (
schedule_code varchar2 (500) primary key,
event_name varchar2 (55),
start_date varchar2  (55),
end_date varchar2	 (55),
allday varchar2(10) check (allday  in('true','false')),
empno varchar2(20),
color varchar2(20),
DEPT varchar2(15) CHECK (DEPT IN('홍보팀','개발팀','인사팀','기획팀','영업팀','개인일정','관리자'))
);
delete from boat_Calendar;

select * from boat_Calendar;


drop sequence cal_seq;
	
create sequence cal_seq nocache;

insert into boat_Calendar 
	values(cal_seq.nextval,?,?,?,?);

	
	
create sequence cal_seq nocache;

--  member table

