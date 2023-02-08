package ejYang.myinfo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class TodoAdd implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		TodoDAO tdao = new TodoDAO();
		TodoBean todo = new TodoBean();
		
		todo.setT_empno(request.getParameter("t_empno"));
		todo.setT_content(request.getParameter("t_content"));
		System.out.println("content=" + todo.getT_content());
		
		int ok = tdao.todoInsert(todo);
		response.getWriter().print(ok);
		return null;
	}

}
