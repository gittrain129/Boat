package jhLee.fileboard;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jhLee.fileboard.db.FileBean;
import jhLee.fileboard.db.FileDAO;

public class FileBoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	FileDAO boarddao = new FileDAO();
	List<FileBean> filebolist = new Array<FileBean>();
		
	int page = 1;
	int limit = 10;
	if(request.getParameter("page")!=null){
		page = Integer.parseInt(request.getParameter("page"));
	}
	if(request.getParameter("limit")!=null) {
		limit = Integer.parseInt(request.getParameter("limit"));
	}
	int listcount = boarddao.getListcount();
		
		return null;
	}

}
