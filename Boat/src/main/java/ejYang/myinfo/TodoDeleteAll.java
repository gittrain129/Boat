package ejYang.myinfo;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class TodoDeleteAll implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TodoDAO tdao = new TodoDAO();
		
		String empno = request.getParameter("t_empno");
		System.out.println("t_empno="+request.getParameter("t_empno"));
		
		int ok = tdao.tododeleteall(empno);
		
		response.getWriter().print(ok);
		return null;
	}

}
