package ejYang.board;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;


public class BoardListAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		
		BoardDAO boarddao = new BoardDAO();
		List<BoardBean> boardlist = new ArrayList<BoardBean>();
		
//		//공지글 총 리스트 수를 받아옵니다.
//		int ycount = boarddao.getYListCount();
//		System.out.println("ycount"+ycount);
		int page = 1;	//보여줄 page
		int limit = 10;	//한 페이지에 보여줄 게시판 목록의 수
		
//		int limit = 13;	//한 페이지에 보여줄 게시판 목록의 수
//		if(ycount == 0) {//공지 0개
//			limit = 10;	//한 페이지에 보여줄 게시판 목록의 수
//		}else if(ycount == 1) {//공지 1개
//			limit = 11;	//한 페이지에 보여줄 게시판 목록의 수
//		}else if(ycount == 2) {//공지 2개
//			limit = 12;	//한 페이지에 보여줄 게시판 목록의 수
//		}
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 =" + page);
		
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit =" + limit);
		
		//총 리스트 수를 받아옵니다.
		int listcount = boarddao.getListCount();//글의 갯수 구하기
		
		//리스트를 받아옵니다.
		boardlist = boarddao.getBoardList(page, limit);
		
		int maxpage = (listcount + limit -1)/limit;
		System.out.println("총 페이지수 = " +maxpage);
		
		int startpage = ((page -1) / 10)*10 + 1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 : "+startpage);
		
		int endpage = startpage +10 -1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 : "+endpage);
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		String state = request.getParameter("state");
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
			
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar cal = Calendar.getInstance();
	        cal.add(Calendar.DAY_OF_MONTH, -3); //1일간 보이도록 하기위해서.
	        String nowday = format.format(cal.getTime());
	           
	        System.out.println("nowday=" + nowday);
	        request.setAttribute("nowday",nowday);
	        
	           
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			//글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("ejYang/board/boardList.jsp");
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
			
			JsonElement je = new Gson().toJsonTree(boardlist);
			System.out.println("boardlist = " + je.toString());
			object.add("boardlist", je);
			
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		}//else end
	}//execute end
}
