package jkKim;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jkKim.member.db.jkKim_Member;
import jkKim.member.db.jkKim_MemberDAO;

public class AddressViewAction implements jkKim_Action {
	@Override
	public jkKim_ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		jkKim_MemberDAO mdao = new jkKim_MemberDAO();
		List<jkKim_Member> memberlist = new ArrayList<jkKim_Member>();

		
		int page = 1; 	
		int limit = 8; //한화면에 주소록 사진 4개씩 2줄만 노출 
		if(request.getParameter("page") != null) {
			page= Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		//추가
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		//총 리스트를 수 받아옵니다
		int listcount =mdao.getListCount();
		
		//리스트를 받아옵니다
		memberlist = mdao.getMemberList(page, limit);
		/* 총페이지수 = (db에 저장된 총 리스트의 수 + 한 페이지에서 보여주는 리스트의 수 -1) / 한페이지에서 보여주는 리스트의 수
		 * 
		 */
		int maxpage = (listcount + limit -1) / limit;
		System.out.println("총페이지수 = " +maxpage);
		
		int startpage = ((page -1) / 10) *10 +1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 = " + startpage);
		
		int endpage = startpage +10 -1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 = " + endpage);
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		String state = request.getParameter("state");
		
		//state 상태에 따른if구문 들어갈자리
		
		
		
		//페이징 처리 후 보여줄 기본화면 = 모든부서 보기
		request.setAttribute("dept_select", "모두보기");
		jkKim_ActionForward forward = new jkKim_ActionForward();
		forward.setRedirect(false);
		forward.setPath("/jkKim/addressView.jsp");
		return forward;
		
		
	}
	
}
