package sjKim.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sjKim.db.Member;
import sjKim.db.MemberDAO;



public class MemberUpdateAction implements Action {
	@Override
	public ActionForward execute (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				
		HttpSession session = request.getSession();
		String empno = (String) session.getAttribute("empno");
		
		MemberDAO mdao = new MemberDAO();
		Member m = mdao.member_info(empno);
		
		ActionForward forward = new ActionForward();
		forward.setPath("member/updateForm.jsp");
		forward.setRedirect(false);
		request.setAttribute("memberinfo", m);
		
		return forward;
	}
}
