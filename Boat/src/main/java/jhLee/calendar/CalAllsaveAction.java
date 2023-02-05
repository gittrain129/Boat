package jhLee.calendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CalAllsaveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Calendarbean cal = new Calendarbean();
		CalendarDAO caldao = new CalendarDAO();
		ActionForward forward = new ActionForward();
		
		String title = request.getParameter("title");
		String allday = request.getParameter("allday");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		
		System.out.println(title);
		System.out.println(allday);
		System.out.println(start);
		System.out.println(end);
		System.out.println("확인");
		
		cal.setAllday(allday);
		cal.setEvent_name(title);
		cal.setStart_date(start);
		cal.setEnd_date(end);
		
		int saveall = caldao.saveall(cal);
		
		//월간달력 전체 이벤트 추가합니다.
		
		return null;
	}

}
