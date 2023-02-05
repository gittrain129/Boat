package jhLee.calendar;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class CalShowAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		

		CalendarDAO caldao = new CalendarDAO();
		
		JsonObject object = new JsonObject();
		
		List<Calendarbean> callist = new ArrayList<Calendarbean>();
		callist = caldao.getCalList();

		
		//callist = caldao.getCalList(empno);
		
		JsonElement je = new Gson().toJsonTree(callist);
		System.out.println("callist = "+je.toString());
		object.add("callist", je);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(object);
		System.out.println(object.toString());
		
		// result = caldao.caldelelte(title,empno);
		//delte from boat_calendar where title = 'title' and empno = '';
		
		return null;
	}

}
