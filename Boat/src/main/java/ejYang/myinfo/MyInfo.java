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
import ejYang.member.Member;
import ejYang.member.MemberDAO;

public class MyInfo implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//로그인 세션
//		HttpSession session = request.getSession();
//		String empno = (String) session.getAttribute("empno");
//		
//		MemberDAO mdao = new MemberDAO();
//		Member m = new Member();
//		m = mdao.member_info(empno);
		//로그인 세션 추가
		
		String empno = "ADMIN";
		MemberDAO mdao = new MemberDAO();
//		Member m = new Member();
		//세션 추가되면 삭제
		
		JsonObject object = new JsonObject();
		JsonArray jarray = mdao.my_info(empno);
		
		JsonElement je = new Gson().toJsonTree(jarray);
		object.add("memberinfo", je);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
	}

}
