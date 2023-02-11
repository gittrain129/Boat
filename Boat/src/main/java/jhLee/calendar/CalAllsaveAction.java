package jhLee.calendar;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jhLee.fileboard.member.Member;


public class CalAllsaveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",Locale.KOREA);
		
		Calendarbean cal = new Calendarbean();
		CalendarDAO caldao = new CalendarDAO();
		
		//Member mem = new Member();
		
		String empno = request.getParameter("empno");
		String title = request.getParameter("title");
		String allday = request.getParameter("allDay");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String color = request.getParameter("color");
		
		//int empno = request.getParameter("empno");
		//LocalDateTime startDate = LocalDateTime.parse(start,dateTimeFormatter);
	     //LocalDateTime endDate = LocalDateTime.parse(end, dateTimeFormatter);
	    System.out.println(empno);     
		System.out.println(title);
		System.out.println(allday);
		System.out.println(start);
		System.out.println(end);
		System.out.println(color);
		System.out.println("확인");
		
		/*
		 * SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss.SSS"); Date date; try {
		 * date = sdf.parse(start); System.out.println(date.getTime()); } catch
		 * (ParseException e) { // TODO Auto-generated catch block e.printStackTrace();
		 * } Calendar c = Calendar.getInstance(); c.add(Calendar.MILLISECOND, 1);
		 */
	
		
		cal.setAllday(allday);
		cal.setEvent_name(title);
		cal.setStart_date(start);
		cal.setEnd_date(end);
		cal.setEmpno(empno);
		cal.setColor(color);
		
		int saveall = caldao.saveall(cal);
		if(saveall ==1) {
			System.out.println("캘린더데이터 삽입 성공");
		}
		
		//월간달력 전체 이벤트 추가합니다.
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);  //주소 변경없이 jsp페이지의 내용을 보여줍니다.
		//request.setAttribute(color, forward)
		forward.setPath("/project_calendarshow.cal");
		return forward;
	}

}
