package ejYang.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentUpdate implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		CommentDAO dao = new CommentDAO();
		Comment co = new Comment();
		co.setContent(request.getParameter("content"));
		System.out.println("content=" + co.getContent());
		
		co.setNum(Integer.parseInt(request.getParameter("num")));
		
		int ok = dao.commentUpdate(co);
		response.getWriter().print(ok);
		
		return null;
	}
}
