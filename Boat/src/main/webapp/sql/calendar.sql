	--calendar sql
	--테이블 정의서 Number, E_NAME, START_DATE, END_DATE, ALLDAY
	

	
	
--dept empno추가 필요
create table boat_Calendar (
schedule_code number (2) primary key,
event_name varchar2 (55),
start_date varchar2  (55),
end_date varchar2	 (55),
allday varchar2(10) check (allday  in('true','false'))
);



delete from boat_Calendar;

select * from boat_Calendar;


drop sequence cal_seq;
	
create sequence cal_seq nocache;

insert into boat_Calendar 
	values(cal_seq.nextval,?,?,?,?);

	
	
create sequence cal_seq nocache;

--  member table

