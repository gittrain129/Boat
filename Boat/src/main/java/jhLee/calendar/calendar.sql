drop table boat_Calendar cascade constraints purge;

--dept empno추가 필요
create table boat_Calendar (
schedule_code number (2) primary key,
event_name varchar2 (55),
start_date varchar2  (55),
end_date varchar2	 (55),
allday varchar2(10) check (allday  in('true','false'))
);

select * from boat_Calendar;

create sequence cal_seq nocache;

insert into boat_Calendar 
	values(cal_seq.nextval,?,?,?,?);
