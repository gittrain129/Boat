package sjKim.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberLoginAction implements Action {
	@Override
	public ActionForward execute (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String id = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("id")) {
					id=cookies[i].getValue();
				}
			}
		}
		
		
		request.setAttribute("id", id);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);  //주소 변경없이 jsp페이지의 내용을 보여줍니다.
		forward.setPath("sjKim/boat/loginForm.jsp");
		return forward;
	}
}
