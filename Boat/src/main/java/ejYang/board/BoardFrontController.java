package ejYang.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.bo")
public class BoardFrontController extends javax.servlet.http.HttpServlet{
private static final long serialVersionUID=1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI= " + RequestURI);
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath= " + contextPath);
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println("command= " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		//http://localhost:8089/Boat/
		switch(command) {
			case "/BoardList.bo":
				action = new BoardListAction();//글 목록
				break;
			case "/BoardWrite.bo":
				action = new BoardWriteAction();//글쓰기 페이지
				break;
			case "/BoardAddAction.bo":
				action = new BoardAddAction();//글쓰기 처리
				break;
			case "/BoardDetailAction.bo":
				action = new BoardDetailAction();//글 상세페이지
				break;
			case "/BoardModifyView.bo":
				action = new BoardModifyView();//글 수정 페이지
				break;
			case "/BoardModifyAction.bo":
				action = new BoardModifyAction();//글 수정 처리
				break;
			case "/BoardReplyView.bo":
				action = new BoardReplyView();//답글 페이지
				break;
			case "/BoardReplyAction.bo":
				action = new BoardReplyAction();//답글 처리
				break;
			case "/BoardDeleteAction.bo":
				action = new BoardDeleteAction();//글 삭제
				break;
			case "/CommentList.bo":
				action = new CommentList();
				break;
			case "/CommentAdd.bo":
				action = new CommentAdd();
				break;
			case "/CommentUpdate.bo":
				action = new CommentUpdate();
				break;
			case "/CommentDelete.bo":
				action = new CommentDelete();
				break;
			case "/CommentReply.bo":
				action = new CommentReply();
				break;
				
		}//switch end
		forward = action.execute(request, response);
		
		if(forward != null) {
			if(forward.isRedirect()) {//리다이렉트 됩니다.
				response.sendRedirect(forward.getPath());
			}else {//포워딩됩니다.
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}//doProcess end
	
	protected void doGet(HttpServletRequest request,
			  HttpServletResponse response) throws ServletException, IOException{
		doProcess(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		doProcess(request, response);
	}
}
