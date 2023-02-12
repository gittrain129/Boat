package ejYang.myinfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import ejYang.board.Action;
import ejYang.board.ActionForward;
import ejYang.member.Member;
import ejYang.member.MemberDAO;

public class MyBoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//로그인 세션
		HttpSession session = request.getSession();
		String empno = (String) session.getAttribute("empno");
		
		//로그인 안하면
		if(empno == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하시길 바랍니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		MemberDAO mdao = new MemberDAO();
		Member m = new Member();
		m = mdao.member_info(empno);
		//로그인 세션 추가
		
//		String empno = "ADMIN";
//		MemberDAO mdao = new MemberDAO();
//		Member m = new Member();
//		m = mdao.member_info(empno);
		//세션 추가되면 삭제
		
		
		String name = m.getName();
		System.out.println("name"+m.getName());//이름 가져오기
		
		MyBoardDAO boarddao = new MyBoardDAO();
		List<MyBoardBean> boardlist = new ArrayList<MyBoardBean>();
		
		int page = 1;	//보여줄 page
		int limit = 10;	//한 페이지에 보여줄 게시판 목록의 수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 =" + page);
		
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit =" + limit);
		
		//총 리스트 수를 받아옵니다.
		int listcount = boarddao.getMyListCount(name);//글의 갯수 구하기
		
		//리스트를 받아옵니다.
		boardlist = boarddao.getMyBoardList(page, limit, name);
		
		int maxpage = (listcount + limit -1)/limit;
		System.out.println("총 페이지수 = " +maxpage);
		
		int startpage = ((page -1) / 10)*10 + 1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 : "+startpage);
		
		int endpage = startpage +10 -1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 : "+endpage);
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		String state = request.getParameter("state");
		
		//NEW 표시
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -3); //3일간 보이도록 하기위해서.
        String nowday = format.format(cal.getTime());
		if(state == null) {
			System.out.println("state==null");
			request.setAttribute("page", page);//현재 페이지 수
			request.setAttribute("maxpage", maxpage);//최대 페이지 수
			
			//현재 페이지에 표시할 첫 페이지 수
			request.setAttribute("startpage", startpage);
			
			//현재 페이지에 표시할 끝 페이지 수
			request.setAttribute("endpage", endpage);
			
			request.setAttribute("listcount", listcount);//총 글의 수
			
			//해당 페이지의 글 목록을 갖고 있는 리스트
			request.setAttribute("boardlist", boardlist);
			
			request.setAttribute("limit", limit);
			//검색에 필요
			
			//NEW 표시
	        System.out.println("nowday=" + nowday);
	        request.setAttribute("nowday",nowday);
	        
	           
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			//글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("ejYang/myinfo/MyboardList.jsp");
			return forward;	//BoardFrontController.java로 리턴됩니다.
			
		}else {
			System.out.println("state=ajax");
			
			JsonObject object = new JsonObject();
			object.addProperty("page", page);//{"page": 변수 page의 값} 형식으로 저장
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit", limit);
			
			//NEW 표시   
	        System.out.println("nowday=" + nowday);
	        request.setAttribute("nowday",nowday);
	        
			
			JsonElement je = new Gson().toJsonTree(boardlist);
			System.out.println("boardlist = " + je.toString());
			object.add("boardlist", je);
			
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		}//else end
	}

}
