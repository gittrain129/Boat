package ejYang.myinfo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class Todolist implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TodoDAO tdao = new TodoDAO();
		
		String t_empno = request.getParameter("t_empno");
		System.out.println("t_empno="+t_empno);
		
		JsonObject object = new JsonObject();
		JsonArray jarray = tdao.getTodoList(t_empno);
		
		JsonElement je = new Gson().toJsonTree(jarray);
		object.add("todolist", je);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
		
	}

}
