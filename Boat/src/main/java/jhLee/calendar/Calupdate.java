package jhLee.calendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Calupdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Calendarbean cal = new Calendarbean();
		CalendarDAO caldao = new CalendarDAO();
		
		String empno = request.getParameter("empno");
		String title = request.getParameter("title");
		String allday = request.getParameter("allDay");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String color = request.getParameter("color");
		
		cal.setAllday(allday);
		cal.setEvent_name(title);
		cal.setStart_date(start);
		cal.setEnd_date(end);
		cal.setEmpno(empno);
		cal.setColor(color);
		
		int update = caldao.update(cal);
		if(update ==1) {
			System.out.println("캘린더데이터 날짜수정 성공");
		}
		return null;
	}

}
