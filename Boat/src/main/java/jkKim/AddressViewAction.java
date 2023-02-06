package jkKim;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jkKim.member.db.jkKim_Member;
import jkKim.member.db.jkKim_MemberDAO;

public class AddressViewAction implements jkKim_Action {
	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		jkKim_MemberDAO mdao = new jkKim_MemberDAO();
		List<jkKim_Member> memberlist = new ArrayList<jkKim_Member>();
		
		
		String dept[] = {""," where dept = 홍보팀 "," where dept = 개발팀 "," where dept = 인사팀 "," where dept = 기획팀 "," where dept = 영업팀 "};
		String dept_sql="";
		int page = 1; 	
		int limit = 8; //한화면에 주소록 사진 4개씩 2줄만 노출 
		if(request.getParameter("page") != null) {
			page= Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		//추가
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		if(request.getParameter("dept") != null) {
			int num = Integer.parseInt(request.getParameter("dept")); 
			dept_sql = dept[num-1];
		}
		System.out.println("넘어온 limit = " + limit);
		
		//총 리스트를 수 받아옵니다
		int listcount =mdao.getListCount();
		
		//리스트를 받아옵니다
		memberlist = mdao.getMemberList(page, limit, dept_sql);
		
		String dept_value = request.getParameter("dept_value");
		System.out.println("dept_value = " +  dept_value);
		
		
		/* 총페이지수 = (db에 저장된 총 리스트의 수 + 한 페이지에서 보여주는 리스트의 수 -1) / 한페이지에서 보여주는 리스트의 수
		 * 
		 */
		int maxpage = (listcount + limit -1) / limit;
		System.out.println("총페이지수 = " +maxpage);
		
		int startpage = ((page -1) / 10) *10 +1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 = " + startpage);
		
		int endpage = startpage +10 -1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 = " + endpage);
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		String state = request.getParameter("state");
		
		
		
		//state 상태에 따른if구문 들어갈자리
		if(state == null) {
			System.out.println("state == null");
			request.setAttribute("page", page);
			request.setAttribute("maxpage", maxpage);
			
			request.setAttribute("startpage", startpage);
			
			request.setAttribute("endpage", endpage);
			
			request.setAttribute("listcount", listcount);
			
			request.setAttribute("memberlist", memberlist);
			
			request.setAttribute("limit", limit);
			
			jkKim_ActionForward forward = new jkKim_ActionForward();
			forward.setRedirect(false);
			
			//글 목록 페이지로 이동하기 위한 경로 설정
			forward.setPath("/jkKim/addressView.jsp");
			return forward; //BoardFrontController.java로 리턴
			
		}else {
			System.out.println(dept);
			
			
			JsonObject obj = new JsonObject();
			obj.addProperty("page", page); //{"page":변수 page의 값
			obj.addProperty("maxpage", maxpage);
			obj.addProperty("startpage", startpage);
			obj.addProperty("endpage", endpage);
			obj.addProperty("listcount", listcount);
			 obj.addProperty("limit", limit);
			
			//JsonObject에는 list형식을 담을수없는 addproperty()가 존재하지않습니다
			//void com.google.gson.JsonObject.add(String property,JsonElement value) 메서드를 통해서 저장
			//List 형식을 JsonElement로 바꾸어주어야 object에 저장할수있습니다
			
			//List -> JsonElement
			JsonElement je = new Gson().toJsonTree(memberlist);
			System.out.println("memberlist= " + je.toString());
			obj.add("memberlist",je);
			
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(obj);
			System.out.println(obj.toString());
			return null;
			}//else end
		
		
		//페이징 처리 후 보여줄 기본화면 = 모든부서 보기
				
				
	}//execute end
		
		
		
		
		
	
	
}

