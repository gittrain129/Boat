package ejYang.cowork;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;
import ejYang.member.Member;
import ejYang.member.MemberDAO;

public class EmailAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
//		HttpSession session = request.getSession();
//		String adminempno = (String) session.getAttribute("empno");//admin
		
		String adminempno = "ADMIN";//관리자 페이지
		String memberempno = request.getParameter("empno");//주소록에서 넘겨받을 회원
		
		System.out.println("전송받은 memberempno = " + memberempno);
		ActionForward forward=new ActionForward();
		MemberDAO mdao = new MemberDAO();
		Member admininfo = mdao.member_info(adminempno);
		Member memberinfo = mdao.member_info(memberempno);
		
		if(admininfo!=null && memberinfo!=null)
			System.out.println("DB연결");
		
		forward.setRedirect(false);
		request.setAttribute("admininfo", admininfo);
		request.setAttribute("memberinfo", memberinfo);
		forward.setPath("ejYang/cowork/email.jsp");
		return forward;
	}
}
