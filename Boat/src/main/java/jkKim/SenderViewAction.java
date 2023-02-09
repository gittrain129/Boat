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
		
		String dept_sql = "";
		
		memberlist = mdao.getMemberList();
		int listcount =mdao.getListCount(dept_sql);
		
		String state = request.getParameter("state");
		
		if(request.getParameter("rownum")!=null) {
		int rownum = Integer.parseInt(request.getParameter("rownum"));
		String name_id = mdao.getName_id(rownum);
		}
		
		
		
		
		
		
		request.setAttribute("listcount", listcount);
		request.setAttribute("memberlist", memberlist);
		
		jkKim_ActionForward forward = new jkKim_ActionForward();
		forward.setRedirect(false);
		
		
		forward.setPath("/jkKim/chat_sender_select.jsp");
		return forward; 
/*
		if(state == "ajax") {
			
			request.setAttribute("name_id", name_id); 
			
			
			
			forward.setPath("/jkKim/chatView_Sender.jsp");
			return forward; 
		}
	*/
}
}