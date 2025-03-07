/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package configs;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;



/**
 *
 * @author Admin
 */
public class MailConfig {
    private static final String EMAIL = "mingken036@gmail.com";
    private static final String PASSWORD = "wpup qxcp wyec glha";
    //phuong thuc tao va tra ve doi tuong session de gui mail
    public static Session getSession() {
            Properties props = new Properties();
            //dinh nghia may chu SMTP qua gmail
            props.put("mail.smtp.host", "smtp.gmail.com");
            //cong su dung gui mail (587 TLS, 465 SSL)
            props.put("mail.smtp.port", "587");
            //bat xac thuc nguoi dung
            props.put("mail.smtp.auth", "true");
            //Bat StartTLS de ma hoa du leiu
            props.put("mail.smtp.starttls.enable", "true");
            //tra ve mot session de lam viec voi cac thuoc tnih da thiet lap
            return Session.getInstance(props, new Authenticator(){
        @Override
                protected PasswordAuthentication getPasswordAuthentication(){
                    return new PasswordAuthentication(EMAIL, PASSWORD);
                }
    });
            
}
    public static String getMailSender(){
        return EMAIL;
    }
        
    }

