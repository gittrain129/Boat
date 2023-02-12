//글 등록에 대한 Action 클래스
package ejYang.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardAddAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession session = request.getSession();
		String empno = (String) session.getAttribute("empno");
//		String empno = request.getParameter("loginboardid");
		System.out.println("empno="+empno);

//		String notice = "N";
//		if(empno == "ADMIN") {
//			notice = "Y";
//		}
		
		BoardDAO boarddao = new BoardDAO();
		BoardBean boarddata = new BoardBean();
		ActionForward forward=new ActionForward();
		boolean result=false;
		
		boarddata.setBoard_name(request.getParameter("board_name"));
		boarddata.setBoard_pass(request.getParameter("board_pass"));
		boarddata.setBoard_subject(request.getParameter("board_subject"));
		boarddata.setBoard_content(request.getParameter("editordata"));
		boarddata.setBoard_dept(request.getParameter("department"));
		boarddata.setBoard_notice(request.getParameter("notice"));
		
		System.out.println("notice="+boarddata.getBoard_notice());
//		System.out.println("notice="+notice);
//		boarddata.setBoard_notice(notice);
		
		result=boarddao.boardInsert(boarddata);
			
		if(result==false) {
			System.out.println("게시판 등록 실패");
			forward.setPath("sjKim/error/error.jsp");
			request.setAttribute("message", "게시판 등록 실패입니다.");
			forward.setRedirect(false);
			return forward;
		}
		System.out.println("게시판 등록 완료");
			
		forward.setRedirect(true);
		forward.setPath("BoardList.bo");
		return forward;
	}
}
