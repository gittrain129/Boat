package jkKim;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddressViewAction implements jkKim_Action {
	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		request.setAttribute("deptno", deptno);
		jkKim_ActionForward forward = new jkKim_ActionForward();
		forward.setRedirect(false);
		forward.setPath("/jkKim/addressView.jsp");
		return forward;
		
		
	}
	
}
