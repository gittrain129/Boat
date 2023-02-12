package ejYang.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ejYang.member.Member;
import ejYang.member.MemberDAO;

public class BoardWriteAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		String empno = (String) session.getAttribute("empno");
		
		MemberDAO mdao = new MemberDAO();
		Member m = new Member();
		m = mdao.member_info(empno);
		//로그인 세션 추가
		
//		String empno = "ADMIN";
//		MemberDAO mdao = new MemberDAO();
//		Member m = new Member();
//		m = mdao.member_info(empno);
		//세션 추가되면 삭제
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		request.setAttribute("member", m);
		forward.setPath("ejYang/board/boardWrite.jsp");
		return forward;
	}
}
