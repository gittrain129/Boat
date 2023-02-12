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

		String state = "default";
		if( request.getParameter("state") != null) {
		state = request.getParameter("state");
		System.out.println("state = " +state);
		}
				
		
		String id = null;
		
		HttpSession session = request.getSession();
		if(session.getAttribute("empno") != null) {
		id = (String) session.getAttribute("empno");
		} else {
			forward.setRedirect(false);
			forward.setPath("/jkKim/error.jsp");
			return forward; 
			
		}
		
		
		
		jkKim_Member chatid = null;
		if (id != null) {
			System.out.println("sessionid = " + id);
			chatid = mdao.chatIdFind(id);
			System.out.println("chatid.getName() = " + chatid.getEmpno());
		}
		System.out.println("여기까지 진행됨1");
		
		if (state.equals("default")) {
			
			System.out.println("여기까지 진행됨2");
				request.setAttribute("idid", chatid);
				
				forward.setRedirect(false);
				forward.setPath("/jkKim/chatView.jsp");
				return forward;
				/*
				 * }else {
				 * 
				 * 
				 * forward.setRedirect(false); forward.setPath("/jkKim/chatView.jsp"); return
				 * forward; }
				 */
			} else {
				System.out.println("여기까지 진행됨3");
				JsonObject obj = new JsonObject();
				obj.addProperty("test", "test");

				response.setContentType("application/json;charset=utf-8");
				response.getWriter().print(obj);
				System.out.println(obj.toString());
				return null;
			}

		}
	
}
