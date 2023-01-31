	--calendar sql
	--테이블 정의서 Number, E_NAME, START_DATE, END_DATE, ALLDAY
	
	create table calendar
	(schedule_code number(4) primary key,
	event_name varchar2(50),
	start_date	varchar2(10),
	end_date varchar2(10),
	allday varchar2(4) check (allday in ('y','n')));
	
	
	
create sequence cal_seq nocache;
