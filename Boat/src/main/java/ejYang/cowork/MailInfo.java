package ejYang.cowork;
 
import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

public class MailInfo extends Authenticator{
    
    PasswordAuthentication pa;
    
    public MailInfo() {
        String mail_id = "";//네이버 아이디
        String mail_pw = "";//네이버 비번
        
        pa = new PasswordAuthentication(mail_id, mail_pw);
    }
    
    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }
}
