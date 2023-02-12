package ejYang.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardDetailAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		BoardDAO boarddao = new BoardDAO();
		BoardBean boarddata = new BoardBean();
		BoardBean prevdata = new BoardBean();
		BoardBean nextdata = new BoardBean();
		
		int num=Integer.parseInt(request.getParameter("num"));
		boarddao.setReadCountUpdate(num);//조회수
		boarddata=boarddao.getDetail(num);//상세내용
		
		prevdata=boarddao.getPrevDetail(num);//이전글 getPrevDetail
		nextdata=boarddao.getNextDetail(num);//다음글 getNextDetail
		
		if(boarddata==null) {
			System.out.println("상세보기 실패");
			ActionForward forward=new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("sjKim/error/error.jsp");
			return forward;
		}
		System.out.println("상세보기 성공");
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		request.setAttribute("boarddata", boarddata);
		request.setAttribute("prevdata", prevdata);
		request.setAttribute("nextdata", nextdata);
		forward.setPath("ejYang/board/boardView.jsp");//글 내용 보기 페이지로 이동하기 위해 경로를 설정합니다.
		return forward;
	}
}
