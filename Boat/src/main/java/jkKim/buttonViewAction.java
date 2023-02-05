package jkKim;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class buttonViewAction implements jkKim_Action {

	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		jkKim_ActionForward forward = new jkKim_ActionForward();
		forward.setPath("/jkKim/chat_button.jsp");
		return forward; //BoardFrontController.java로 리턴

}
}
