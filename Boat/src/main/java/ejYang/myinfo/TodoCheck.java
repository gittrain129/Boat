package ejYang.myinfo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class TodoCheck implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		TodoDAO tdao = new TodoDAO();
		TodoBean todo = new TodoBean();
		
		todo.setT_empno(request.getParameter("t_empno"));
		System.out.println("t_empno="+request.getParameter("t_empno"));
		
		String content = request.getParameter("checkArray");
		System.out.println("content="+content);
		
		
//		String[] content = request.getParameter("checkArray");
//		for(int i=0; i<)
//		todo.setT_content(request.getParameter("t_content"));
//		
//		int ok = tdao.todocheck(todo);
//		response.getWriter().print(ok);
		return null;
	}

}
