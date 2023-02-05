package jhLee.calendar;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CalAllsaveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",Locale.KOREA);
		
		Calendarbean cal = new Calendarbean();
		CalendarDAO caldao = new CalendarDAO();
		
		String title = request.getParameter("title");
		String allday = request.getParameter("allday");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		
		//int empno = request.getParameter("empno");
		//LocalDateTime startDate = LocalDateTime.parse(start,dateTimeFormatter);
	     //LocalDateTime endDate = LocalDateTime.parse(end, dateTimeFormatter);
	            
		System.out.println(title);
		System.out.println(allday);
		System.out.println(start);
		System.out.println(end);
		System.out.println("확인");
		
		cal.setAllday(allday);
		cal.setEvent_name(title);
		cal.setStart_date(start);
		cal.setEnd_date(end);
		//cal.setEmpno(empno);
		
		int saveall = caldao.saveall(cal);
		if(saveall ==1) {
			System.out.println("캘린더데이터 삽입 성공");
		}
		
		//월간달력 전체 이벤트 추가합니다.
		
		return null;
	}

}
