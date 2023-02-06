package ex8_template;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//http://localhost:8088/JSP_template_jstl/templatetest
@WebServlet("/login.net")
public class Template extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException,IOException {
		String go = request.getParameter("page");
		if(go==null) {
			go="newitem";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sjKim/board/mainPage.html"); //view
		request.setAttribute("pagefile", go);
		dispatcher.forward(request, response);
	}

	
}
