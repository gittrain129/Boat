package ejYang.myinfo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ejYang.board.Action;
import ejYang.board.ActionForward;
import ejYang.member.Member;
import ejYang.member.MemberDAO;

public class MyInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//로그인 세션
		HttpSession session = request.getSession();
		String empno = (String) session.getAttribute("empno");
		
		//로그인 안하면
		if(empno == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하시길 바랍니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		MemberDAO mdao = new MemberDAO();
		Member m = new Member();
		m = mdao.member_info(empno);
		//로그인 세션 추가
		
//		String empno = "ADMIN";
//		MemberDAO mdao = new MemberDAO();
//		Member m = new Member();
//		m = mdao.member_info(empno);
//		//세션 추가되면 삭제
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		request.setAttribute("myinfo", m);
		forward.setPath("ejYang/myinfo/MyInfo.jsp");
		return forward;
	}

}
