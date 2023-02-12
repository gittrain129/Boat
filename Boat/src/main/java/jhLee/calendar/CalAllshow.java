package jhLee.calendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;


public class CalAllshow implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		CalendarDAO caldao = new CalendarDAO();
		ActionForward forward = new ActionForward();

		
		JsonArray callist = null;
		String info = request.getParameter("dept");
		
		System.out.println("info= "+info);
		
		callist = caldao.getCalList();
		
		
		request.setAttribute("callist",callist);

		
	//	request.setAttribute("id", id);
		forward.setRedirect(false);  //주소 변경없이 jsp페이지의 내용을 보여줍니다.
		forward.setPath("/jhLee/calendar.jsp");
		return forward;
		
	}

}
