package jkKim;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import jkKim.member.db.jkKim_Member;
import jkKim.member.db.jkKim_MemberDAO;

public class SenderViewAction implements jkKim_Action {

	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		jkKim_MemberDAO mdao = new jkKim_MemberDAO();
		List<jkKim_Member> memberlist = new ArrayList<jkKim_Member>();
		jkKim_ActionForward forward = new jkKim_ActionForward();
		
		String dept_sql = "";
		String empno_id ="";
		
		
		
		memberlist = mdao.getMemberList();
		int listcount =mdao.getListCount(dept_sql);
		
		String state = request.getParameter("state");
		
		if(request.getParameter("rownum")!=null) {
		int rownum = Integer.parseInt(request.getParameter("rownum"));
			empno_id = mdao.getName_id(rownum);
			System.out.println("넘어온 rownum = " + request.getParameter("rownum"));
		}
		
		
		
		
		if(state == null) {
		
		request.setAttribute("listcount", listcount);
		request.setAttribute("memberlist", memberlist);
				
		forward.setRedirect(false);
		forward.setPath("/jkKim/chat_sender_select.jsp");
		return forward; 
		
		} else {
			System.out.println("보내려고하는 name_id = " + empno_id);
			 
						
			JsonObject obj = new JsonObject();
			obj.addProperty("empno_id", empno_id);
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(obj);
			System.out.println(obj.toString());
			return null;
			
			
		}
	
		
		
		
		
		
		
		
		
}
}