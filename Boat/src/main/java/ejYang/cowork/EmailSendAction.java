package ejYang.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ejYang.board.Action;
import ejYang.board.ActionForward;

public class EmailSendAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String sender=request.getParameter("sender");
		String receiver=request.getParameter("receiver");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");

		Properties prop = System.getProperties();
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.naver.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        Authenticator auth = new MailInfo();
        Session session = Session.getDefaultInstance(prop, auth);
        MimeMessage msg = new MimeMessage(session);
    
        try {
            msg.setSentDate(new Date());
            
            msg.setFrom(new InternetAddress(sender, "ADMIN"));//admin 메일로 변경
            InternetAddress to = new InternetAddress(receiver);         
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject(subject, "UTF-8");            
            msg.setText(content, "UTF-8");            
            
            Transport.send(msg);
            
            //${pageContext.request.contextPath}
            out.println("<script>");
    		out.println("alert('메일이 정상적으로 전송되었습니다.');");
    		out.println("location.href='jkKim/adminView.jk';");
    		out.println("</script>");
            return null;
        } catch(Exception ae) {            
            System.out.println("EmailSend 오류 : " + ae.getMessage());   
            out.println("<script>");
    		out.println("alert('메일 전송을 실패했습니다.');");
    		out.println("location.href='jkKim/adminView.jk';");
    		out.println("</script>");
            return null;
        }
        
	}

}
