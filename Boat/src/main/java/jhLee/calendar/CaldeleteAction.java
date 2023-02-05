package jhLee.calendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CaldeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		CalendarDAO caldao = new CalendarDAO();
		String title = request.getParameter("title");
		//이름이나 empno로 바꿔야함
		boolean result =false;
		result = caldao.caldelelte(title);
		
		
		
		// result = caldao.caldelelte(title,empno);
		//delte from boat_calendar where title = 'title' and empno = '';
		
		return null;
	}

}
