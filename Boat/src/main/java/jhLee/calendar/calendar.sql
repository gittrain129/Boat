drop table boat_Calendar cascade constraints purge;


create table boat_Calendar (
schedule_code number (2) primary key,
event_name varchar2 (50),
start_date date ,
end_date date	,
allday varchar2(10) check (allday  in('true','false'))
);

select * from boat_Calendar;

create sequence cal_seq nocache;

insert into boat_Calendar 
	values(cal_seq.nextval,?,?,?,?);
