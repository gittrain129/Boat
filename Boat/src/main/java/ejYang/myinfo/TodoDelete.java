package ejYang.myinfo;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class TodoDelete implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TodoDAO tdao = new TodoDAO();
		
		String empno = request.getParameter("t_empno");
		System.out.println("t_empno="+request.getParameter("t_empno"));
		
		int ok = 0;
		String[] content = request.getParameterValues("checkArray");
		System.out.println(Arrays.toString(content));
		for(int i=0;i<content.length;i++) {
		    System.out.println(content[i]);    
		    
		    ok = tdao.tododelete(empno, content[i]);
		}
		
		response.getWriter().print(ok);
		return null;
	}

}
