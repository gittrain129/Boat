package ejYang.cowork;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

@WebServlet("*.ne")
public class CoworkFrontController extends javax.servlet.http.HttpServlet{
	private static final long serialVersionUID=1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI= " + RequestURI);
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath= " + contextPath);
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println("command= " + command);
		
		//초기화
		ActionForward forward = null;
		Action action = null;
		
		//http://localhost:8089/Boat
		switch(command) {
			case "/email.ne":
				action = new EmailAction();
				break;
			case "/emailsend.ne":
				action = new EmailSendAction();
				break;
				
		}//switch end
		forward = action.execute(request, response);
		
		if(forward != null) {
			if(forward.isRedirect()) {//리다이렉트 됩니다.
				response.sendRedirect(forward.getPath());
			}else {//포워딩됩니다.
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}//doProcess end
	
	//doProcess(request, response)메서드를 구현하여 요청이 GET방식이든
	//POST 방식으로 전송되어 오든 같은 메서드에서 요청을 처리할 수 있도록 하였스빈다.
	protected void doGet(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		doProcess(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		doProcess(request, response);
	}
}
