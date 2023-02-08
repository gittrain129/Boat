package jkKim;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class buttonViewAction implements jkKim_Action {

	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		jkKim_ActionForward forward = new jkKim_ActionForward();
		
		String id = request.getParameter("id");
		
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		forward.setRedirect(false);
			
		forward.setPath("/jkKim/chat_button.jsp");
		return forward; 

}
}
