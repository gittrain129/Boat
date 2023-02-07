//http://localhost:8088/Boat/FileBoardList.filebo
package jhLee.fileboard.action;

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

import jhLee.fileboard.db.FileDAO;
import jhLee.fileboard.db.FileboBean;

public class FileBoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	FileDAO boarddao = new FileDAO();
	List<FileboBean> filebolist = new ArrayList<FileboBean>();
		int filelicount = 0;
	

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
	//==========================================================
	//검색 및 페이징
	
	int depthidden =  Integer.parseInt(request.getParameter("dept"));
	String dept = "";
    String order =   request.getParameter("order");//최신순조회순댓글순 asc desc 쿼리
    String search =  request.getParameter("searchsel");
    //작성자나 제목
    String searchinput =  request.getParameter("searchinput");
    //검색결과
    
    
    System.out.println("dept "+dept);
    switch(depthidden) {
    case 10:dept = "홍보팀";
  	  break;
    case 20:dept = "개발팀";
  	  break;
    case 30:dept = "인사팀";
  	  break;
    case 40:dept = "기획팀";
  	  break;
    case 50:dept = "영업팀";
  	  break;
  	  
    }
    
    filelicount =boarddao.getListcount();
   filebolist = boarddao.getList(dept,search,searchinput,order,page,limit); 
    
    System.out.println("order "+order);
    System.out.println("search "+search);

	
	
	
	
	
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
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -3); //1일간 보이도록 하기위해서.
        String nowday = format.format(cal.getTime());
           
        
     
        
        
        
        
        
        
        System.out.println("nowday=" + nowday);
        request.setAttribute("nowday",nowday);
        
		
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