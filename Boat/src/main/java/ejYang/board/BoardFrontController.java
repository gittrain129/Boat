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
		/*
		 * 요청된 전체 URL중에서 포트 번호 다음 부터 마지막 문자열까지 반환합니다.
		 * 예) contextPath가 "/JspProJect"인 경우
		 * 		http://localhost:8088/JspProJect/login.net로 요청하면
		 * 		getRequestURI()는 "/JspProJect/BoardList.bo" 반환됩니다.
		 */
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI= " + RequestURI);
		
		//getContextPath() : 컨텍스트 경로가 반환됩니다.
		//contextPath는 "/JspProJect"가 반환됩니다.
		String contextPath = request.getContextPath();
		System.out.println("contextPath= " + contextPath);
		
		//RequestURI에서 컨텍스트 경로 길이 값의 인덱스 위치의 문자부터 마지막 위치 문자까지 추출합니다.
		//command는 "/BoardList.bo" 반환됩니다.
		String command = RequestURI.substring(contextPath.length());
		System.out.println("command= " + command);
		
		//초기화
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
				action = new BoardModifyView();
				break;
			case "/BoardModifyAction.bo":
				action = new BoardModifyAction();
				break;
			case "/BoardReplyView.bo":
				action = new BoardReplyView();
				break;
			case "/BoardReplyAction.bo":
				action = new BoardReplyAction();
				break;
			case "/BoardDeleteAction.bo":
				action = new BoardDeleteAction();
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
	
	//doProcess(request, response)메서드를 구현하여 요청이 GET방식이든
	//POST 방식으로 전송되어 오든 같은 메서드에서 요청을 처리할 수 있도록 하였스빈다.
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
