package ejYang.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentDelete implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		int b_c_num = Integer.parseInt(request.getParameter("b_c_num"));
		
		CommentDAO dao = new CommentDAO();
		
		int result = dao.commentsDelete(b_c_num);
		PrintWriter out = response.getWriter();
		out.print(result);
		
		return null;
	}
}
