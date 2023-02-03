//http://localhost:8088/Boat/FileBoardList.filebo
package jhLee.fileboard.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jhLee.fileboard.db.FileDAO;
import jhLee.fileboard.db.FileboBean;

public class FileBoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	FileDAO boarddao = new FileDAO();
	List<FileboBean> filebolist = new ArrayList<FileboBean>();
		
	int page = 1;
	int limit = 10;
	if(request.getParameter("page")!=null){
		page = Integer.parseInt(request.getParameter("page"));
	}
	if(request.getParameter("limit")!=null) {
		limit = Integer.parseInt(request.getParameter("limit"));
	}
	int listcount = boarddao.getListcount();
	System.out.println("글의 갯수는 = "+ listcount);
	filebolist = boarddao.getfileBoardList(page,limit);
	int maxpage = (listcount+limit -1)/limit;
	System.out.println("총페이지수 = "+ maxpage);
		
	int startpage = ((page-1)/10)*10+1;
	
	int endpage = startpage+10-1;
	
	if(endpage>maxpage)
		endpage = maxpage;
	String state = request.getParameter("state");
	
	if(state ==null) {
		System.out.println("state ==null");
		request.setAttribute("page", page);//현재 페이지 수 
		request.setAttribute("maxpage", maxpage);
		
		//현재 페이지에 표시할 첫 페이지 수 
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		
		//현제 페이지에 표시할 끝 페이지 수 
		request.setAttribute("listcount", listcount);
		
		//해당 페이지의 글 목록을 갖고 있는 리스트
		request.setAttribute("boardlist", filebolist);
		
		request.setAttribute("limit", limit);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		
		//글 목록 페이지로 이동하기 위해 경로 를 설정합니다.
		forward.setPath("/jhLee/file_board/File_bo_List.jsp");
		System.out.println(filebolist);
		return forward;//BoardFrontController.java 로 리턴됩니다.
	//댓글 ajax
	}else {
		System.out.println("state = ajax");
		
		//위에서 request로 담았던 것을 JsogObject에 담습니다.
		JsonObject object = new JsonObject();
		object.addProperty("page", page);//{"page":변수page의 값}형식으로 저장
		object.addProperty("maxpage",maxpage);
		object.addProperty("startpage",startpage);
		object.addProperty("endpage", endpage);
		object.addProperty("listcount",listcount);
		object.addProperty("limit", limit);
		
		
		//ㅣList => JsonElement
		JsonElement je = new Gson().toJsonTree(filebolist);
		System.out.println("boardlist = "+je.toString());
		object.add("boardlist", je);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(object);
		System.out.println(object.toString());
	
		return null;
	}//else end
}//execute end

}//class end