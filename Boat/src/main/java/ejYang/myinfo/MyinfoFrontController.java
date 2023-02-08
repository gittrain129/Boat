package ejYang.myinfo;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

@WebServlet("*.my")
public class MyinfoFrontController extends javax.servlet.http.HttpServlet{
private static final long serialVersionUID=1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI= " + RequestURI);
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath= " + contextPath);
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println("command= " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		//http://localhost:8089/Boat/
		switch(command) {
			case "/MySchedule.my":
				action = new TodoAction();//페이지 이동
				break;
			case "/Todolist.my":
				action = new Todolist();//글 목록
				break;
			case "/TodoAdd.my":
				action = new TodoAdd();//투두 추가
				break;
			case "/TodoCheck.my":
				action = new TodoCheck();//글 목록
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
