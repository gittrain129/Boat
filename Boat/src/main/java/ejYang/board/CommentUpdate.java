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
		co.setB_content(request.getParameter("b_content"));
		System.out.println("content=" + co.getB_content());
		
		co.setB_c_num(Integer.parseInt(request.getParameter("b_c_num")));
		
		int ok = dao.commentUpdate(co);
		response.getWriter().print(ok);
		
		return null;
	}
}
