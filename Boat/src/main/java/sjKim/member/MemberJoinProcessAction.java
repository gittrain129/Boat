package sjKim.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sjKim.db.Member;
import sjKim.db.MemberDAO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemberJoinProcessAction implements Action {
	public ActionForward execute (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String realFolder = "";
		
		// webapp아래에 꼭 포더 생성하세요
		String saveFolder = "memberupload";
		
		int fileSize = 10 * 1024 * 1024; //업로드할 파일의 최대 사이즈 입니다. 5MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder=[" + realFolder);
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
		
		String empno = multi.getParameter("empno");
		String password = multi.getParameter("password");
		String name = multi.getParameter("name");
		int age = Integer.parseInt(multi.getParameter("age"));
		String jumin = multi.getParameter("jumin");	
		String address = multi.getParameter("address");
		int post = Integer.parseInt(multi.getParameter("post"));
		String gender = multi.getParameter("gender");
		String email = multi.getParameter("email");		
		String memberfile = multi.getFilesystemName("memberfile");
		String intro = multi.getParameter("intro");
		
		
		System.out.println("memberfile=" + memberfile);
		
		Member m = new Member();
		m.setEmail(email);		m.setIntro(intro);		m.setGender(gender);
		m.setEmpno(empno); 	 	m.setPassword(password); m.setName(name);
		m.setMemberfile(memberfile); m.setJumin(jumin); m.setAddress(address);
		m.setPost(post);		m.setAge(age);
		
		if(memberfile != null) { //파일을 선택한 경우
			m.setMemberfile(memberfile);
		}
		//기존 파일 그대로 사용하는 경우
	//	else if(request.getParameter("check") != "") {
	//		m.setMemberfile(request.getParameter("check"));
	//	}
		
		
		MemberDAO mdao = new MemberDAO();
		int result = mdao.insert(m);
		
		//result=0;
		if(result==0) {
			System.out.println("회원 가입 실패입니다.");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "회원 가입 실패입니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		if(result == 1) {// 삽입이 된 경우
			out.println("alert('회원 가입을 축하합니다.');");
			out.println("location.href='login.net';");
		} else if (result == -1) {
			out.println("alert('아이디가 중복되었습니다. 다시 입력하세요');");
			//새로고침되어 이전에 입력한 데이터가 나타나지 않습니다.
			//out.println("location.href='join.net';");
			out.println("history.back();"); //비밀번호를 제외한 다른 데이터는 유지 되어 있습니다.
		}
		out.println("</script>");
		out.close();	
		return null;
	}

}
