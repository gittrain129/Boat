package jhLee.fileboard.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileBoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//File_bo_Write.jsp
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("jhLee/file_board/File_bo_Write.jsp");
		return forward;
	}

}
