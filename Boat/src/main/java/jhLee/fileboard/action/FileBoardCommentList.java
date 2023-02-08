package jhLee.fileboard.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jhLee.fileboard.db.FileboComDAO;

public class FileBoardCommentList implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	FileboComDAO dao = new FileboComDAO();
	
	int comment_board_num = Integer.parseInt(request.getParameter("comment_board_num"));
	int state = Integer.parseInt(request.getParameter("state"));
	
	
	int listcount = dao.getfilecomListcount(comment_board_num);
	
	JsonObject object = new JsonObject();
	JsonArray jarray = dao.getfileCommentList(comment_board_num,state);
	
	System.out.println("1"+jarray);
			object.addProperty("listcount",listcount);
	
	JsonElement je = new Gson().toJsonTree(jarray);
	object.add("boardlist", je);
	
	response.setContentType("application/json;charset=utf-8");
	PrintWriter out = response.getWriter();
	out.print(object.toString());
		return null;
	}
	
			


}
