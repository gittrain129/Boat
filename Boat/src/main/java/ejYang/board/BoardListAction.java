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

import ejYang.member.Member;


public class BoardListAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		
		BoardDAO boarddao = new BoardDAO();
		List<BoardBean> boardlist = new ArrayList<BoardBean>();
		
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
		
		
//		//검색 기능
//		int listcount = 0;
//		int index=-1;//search_field에 존재하지 않는 값으로 초기화
//		
//		String search_word="";
//		//(BoardList.bo?page=2$search_field=-1&search_word=)
//		if(request.getParameter("search_word") == null
//				|| request.getParameter("search_word").equals("")) {
//			//총 리스트 수를 받아옵니다.
//			listcount = boarddao.getListCount();
//			//리스트를 받아옵니다.
//			boardlist = boarddao.getBoardList(page, limit);
//		}else {//검색을 클릭한 경우
//			index= Integer.parseInt(request.getParameter("search_field"));
//			String[] search_field = new String[] {"BOARD_NAME","BOARD_SUBJECT"};//"board_name","board_subject"
//			search_word = request.getParameter("search_word");
//			listcount = boarddao.getListCount(search_field[index], search_word);
//			boardlist = boarddao.getBoardList(search_field[index], search_word, page, limit);
//		}
//		//검색 기능 끝
		
		
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
//			//검색에 필요
//			request.setAttribute("search_field", index);
//			request.setAttribute("search_word", search_word);
			
	        //NEW 표시
	        System.out.println("nowday=" + nowday);
	        request.setAttribute("nowday",nowday);
	           
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			//글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("ejYang/board/boardList.jsp");
			return forward;	//BoardFrontController.java로 리턴됩니다.
			
		}else {
			System.out.println("state=ajax");
			
			
			//ajax 검색
			int index=-1;//search_field에 존재하지 않는 값으로 초기화
			String search_word="";
			
			//검색 셀렉트
			index= Integer.parseInt(request.getParameter("search_field"));
			String[] search_field = new String[] {"BOARD_NAME","BOARD_SUBJECT"};//"board_name","board_subject"
			
			//검색어
			search_word = request.getParameter("search_word");
			
			//부서명
			String department =request.getParameter("department");
			if(department.equals("selected"))
				department = "";
			else
				department = "AND BOARD_DEPT = '"+department+"'";
			
			//정렬
			int listse = -1;
			listse =Integer.parseInt(request.getParameter("listse"));
			String[] search_listse = new String[] {"BOARD_DATE DESC,","BOARD_READCOUNT DESC,","CNT DESC,",""};
			
			listcount = boarddao.getListCount(search_field[index], search_word, department);
			boardlist = boarddao.getBoardList(search_field[index], search_word, department, search_listse[listse], page, limit);
			
			//ajax 검색
			
			
			JsonObject object = new JsonObject();
			object.addProperty("page", page);//{"page": 변수 page의 값} 형식으로 저장
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit", limit);
			//검색에 필요
			System.out.println("index=" + index);
			object.addProperty("search_field", index);
			object.addProperty("search_word", search_word);
			
	        //NEW 표시   
	        System.out.println("nowday=" + nowday);
	        object.addProperty("nowday",nowday);
	        
			
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
