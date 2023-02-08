package ejYang.myinfo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class MyScheduleInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TodoDAO tdao = new TodoDAO();
		ActionForward forward=new ActionForward();
		boolean result = false;
		
		//+ 누르면 추가
		String addValue = request.getParameter("addValue");
		if(addValue != "" || addValue != null) {
			result = tdao.todoInsert(addValue);
		}
		
		if(result == false) {
			System.out.println("투두리스트 저장 실패");
			forward=new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "게시판 수정 상세 보기 실패입니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("두리스트 저장 성공");
		
		forward.setRedirect(false);
		forward.setPath("MySchedule.my");
		return null;
	}

}
