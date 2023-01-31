package jhLee;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/project_calendar")
public class calendar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Calendarbean vo = new Calendarbean();
		
		vo.setSchedule_code();
		vo.setEvent_name();
		vo.setStart_date();
		vo.setEnd_date();
		vo.setAllday();
		
		CalendarDAO dao = new CalendarDAO();
		System.out.println("확인");
		
		int result = dao.insert(vo);
		System.out.println(result);
		if(result ==1) {
			System.out.println("삽입성공");
			
		}else {
			System.out.println("삽입실패");
		}
		doGet(request,response);
		}
		
	}

}
