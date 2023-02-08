package jkKim;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import jkKim.member.db.jkKim_Member;
import jkKim.member.db.jkKim_MemberDAO;

public class chatAction implements jkKim_Action {

	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		jkKim_MemberDAO mdao = new jkKim_MemberDAO();
		
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		System.out.println("sessionid = " + id);
		jkKim_Member chatid = mdao.chatIdFind(id);
		
	
	System.out.println("chatid.getName() = " + chatid.getEmpno());
		
		
		jkKim_ActionForward forward = new jkKim_ActionForward();	
		request.setAttribute("idid", chatid);
		forward.setRedirect(false);
		forward.setPath("/jkKim/chatView.jsp");
		return forward; 
	}

}
