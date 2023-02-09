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
		
		//보여지는 전체 리스트
		JsonObject object = new JsonObject();
		JsonArray jarray = tdao.getTodoList(t_empno);
		
		JsonElement je = new Gson().toJsonTree(jarray);
		object.add("todolist", je);
		
		//전체 리스트
		JsonArray jarrayn = tdao.getNTodoList(t_empno);
		
		JsonElement jen = new Gson().toJsonTree(jarrayn);
		object.add("ntodolist", jen);
		
		//Y 리스트
		JsonArray jarrayy = tdao.getYTodoList(t_empno);
		
		JsonElement jey = new Gson().toJsonTree(jarrayy);
		object.add("ytodolist", jey);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
		
	}

}
