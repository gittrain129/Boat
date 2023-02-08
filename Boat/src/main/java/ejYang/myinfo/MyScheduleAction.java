package ejYang.myinfo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class MyScheduleAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<TodoBean> todolist = new ArrayList<TodoBean>();
		TodoDAO tdao = new TodoDAO();
		
		//+ 누르면 추가
		boolean result = false;
		String addValue = request.getParameter("addValue");
		System.out.println("addValue="+addValue);
		if(addValue!="" && addValue != null) {
			result = tdao.todoInsert(addValue);
			request.setAttribute("result", result);
			System.out.println("투두리스트 저장 성공");
			
		}
		
		int listcount = 0;
		//총 리스트 수를 받아옵니다.
		listcount = tdao.getTodoListCount();
		//리스트를 받아옵니다.
		todolist = tdao.getTodoList();
		
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		
		request.setAttribute("listcount", listcount);//총 개수
		request.setAttribute("todolist", todolist);//리스트
		
		forward.setPath("ejYang/myinfo/MySchedule.jsp");
		return forward;
	}

}
