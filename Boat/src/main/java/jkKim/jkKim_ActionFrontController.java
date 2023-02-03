package jkKim;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.jk")
public class jkKim_ActionFrontController extends javax.servlet.http.HttpServlet {
	private static final long serialVersionUID = 871322249870799836L;
	

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI);
		
		String contextPath = request.getContextPath(); // "/JspProject"
		System.out.println("contextPath = " + contextPath);

		String command = RequestURI.substring(contextPath.length()); // "/login.net"
		System.out.println("command = " + command);
		
		jkKim_ActionForward forward = null;
		jkKim_Action action = null;

		switch (command) {
		case "/address.jk":
			action = new AddressViewAction();
			break;
			
		}// switch end
		
		
		
		
		forward = action.execute(request, response);

		if (forward != null) {
			if (forward.isRedirect()) {// 리다이렉트 됩니다.
				response.sendRedirect(forward.getPath());
			} else { // 포워딩됩니다
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}

	}// doProcess end

	// doProcess메서드를 구현하여 get방식이든 post방식으로 전송되어 오든 같은 메서드에서 요청을 처리할수있도록함
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		doProcess(request, response);
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
