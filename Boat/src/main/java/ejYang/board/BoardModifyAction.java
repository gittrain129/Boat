package ejYang.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardModifyAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		BoardDAO boarddao = new BoardDAO();
		BoardBean boarddata = new BoardBean();
		ActionForward forward=new ActionForward();
			
		int num=Integer.parseInt(request.getParameter("board_num"));
		String pass=request.getParameter("board_pass");
			
		//글쓴이 인지 확인하기 위해 저장된 비밀번호와 입력한 비밀번호를 비교
		boolean usercheck = boarddao.isBoardWriter(num, pass);
			
		//비밀번호가 다른 경우
		if(usercheck == false) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호가 다릅니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		//비밀번호가 일치하는 경우 수정 내용을 설정합니다.
		boarddata.setBoard_num(num);
		boarddata.setBoard_name(request.getParameter("board_name"));
		boarddata.setBoard_subject(request.getParameter("board_subject"));
		boarddata.setBoard_content(request.getParameter("editordata"));
		boarddata.setBoard_dept(request.getParameter("department"));
			
		//DAO에서 수정 메서드 호출하여 수정합니다.
		boolean result = boarddao.boardModify(boarddata);
			
		//수정에 실패한 경우
		if(result == false) {
			System.out.println("게시판 수정 실패");
			forward.setRedirect(false);
			request.setAttribute("message", "게시판 수정이 되지 않았습니다.");
			forward.setPath("jsKim/error/error.jsp");
			return forward;
		}
			
		//수정 성공의 경우
		System.out.println("게시판 수정 완료");
		
		forward.setRedirect(true);
		//수정한 글 내용을 보여주기 위해 글 내용 보기 페이지로 이동하기 위해 경로를 설정합니다.
		forward.setPath("BoardDetailAction.bo?num=" + boarddata.getBoard_num());
		return forward;
	}
}
