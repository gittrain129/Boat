package jhLee.calendar;

public class Calendarbean {

	int schedule_code;
	String event_name;
	String start_date;
	String end_date;
	String allday;
	/*
	 * 1 id 추가
	 * 2 color 추가
	 * 3 dept  추가
	 * 4. 쉽게하려면 admin 추가
	 */
	
	
	public int getSchedule_code() {
		return schedule_code;
	}
	public void setSchedule_code(int schedule_code) {
		this.schedule_code = schedule_code;
	}
	public String getEvent_name() {
		return event_name;
	}
	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getAllday() {
		return allday;
	}
	public void setAllday(String allday) {
		this.allday = allday;
	}
	
}
