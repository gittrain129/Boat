package ejYang.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentAdd implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		CommentDAO dao = new CommentDAO();
		
		Comment co = new Comment();
		co.setB_c_id(request.getParameter("b_c_id"));
		co.setB_content(request.getParameter("b_content"));
		System.out.println("content=" + co.getB_content());
		
		co.setB_comment_num(Integer.parseInt(request.getParameter("b_comment_num")));
		co.setB_comment_re_lev(Integer.parseInt(request.getParameter("b_comment_re_lev")));
		co.setB_comment_re_seq(Integer.parseInt(request.getParameter("b_comment_re_seq")));
		
		int ok = dao.commentsInsert(co);
		response.getWriter().print(ok);
		return null;
	}
}
