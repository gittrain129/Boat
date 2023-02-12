package jhLee.calendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;

public class CalShowAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//dept 선택시 보여줌
		
		CalendarDAO caldao = new CalendarDAO();
		JsonArray callist = null;
		String dept = request.getParameter("info");
		System.out.println(dept);
		
		callist = caldao.getCalList(dept);
		
		
		
		response.getWriter().print(callist);
		System.out.println(callist.toString());
		return null;
	}

}
