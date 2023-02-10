package jkKim;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jkKim.member.db.jkKim_Member;
import jkKim.member.db.jkKim_MemberDAO;

public class chatAction implements jkKim_Action {

	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		jkKim_MemberDAO mdao = new jkKim_MemberDAO();
		jkKim_ActionForward forward = new jkKim_ActionForward();
		
		
		
		String state = request.getParameter("state");
		if(state == null) {
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			if(id != null) {
			System.out.println("sessionid = " + id);
			jkKim_Member chatid = mdao.chatIdFind(id);
			
		
			System.out.println("chatid.getName() = " + chatid.getEmpno());
			
			
			
			request.setAttribute("idid", chatid);
			forward.setRedirect(false);
			forward.setPath("/jkKim/chatView.jsp");
			return forward; 
			}else {
				
				
				forward.setRedirect(false);
				forward.setPath("/jkKim/chatView.jsp");
				return forward; 
			}
		}else {
		
		
			JsonObject obj = new JsonObject();
			obj.addProperty("test", "test"); 
						
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(obj);
			System.out.println(obj.toString());
			return null;
	}

		
		
		
		
		
		
}
}
