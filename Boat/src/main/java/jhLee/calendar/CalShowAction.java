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
		

		CalendarDAO caldao = new CalendarDAO();
		
		
		JsonArray callist = null;
		
		
		callist = caldao.getCalList();
		
		
		
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(callist);
		
		System.out.println(callist.toString());
		
		
		return null;
	}

}
