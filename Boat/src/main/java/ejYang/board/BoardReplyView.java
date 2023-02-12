package ejYang.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ejYang.member.Member;
import ejYang.member.MemberDAO;

public class BoardReplyView implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		ActionForward forward=new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		BoardBean boarddata = new BoardBean();
		
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
		
		//파라미터로 전달받은 수정할 글 번호를 num변수에 저장합니다.
		int num=Integer.parseInt(request.getParameter("num"));
		
		//글의 내용을 불러와서 boarddata 객체에 저장합니다.
		boarddata=boarddao.getDetail(num);
				
		//글 내용 불러오기 실패한 경우입니다.
		if(boarddata==null) {
			System.out.println("글이 존재하지 않습니다.");
			forward.setRedirect(false);
			request.setAttribute("message", "글이 존재하지 않습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("답변 페이지 이동 완료");
		//답변 폼 페이지로 이동할 때 원본 글 내용을 보여주기 위해
		//boarddata 객체를 request 객체에 저장합니다.
		request.setAttribute("member", m);
		request.setAttribute("boarddata", boarddata);
		
		forward.setRedirect(false);
		forward.setPath("ejYang/board/boardReply.jsp");
		return forward;
	}
}
