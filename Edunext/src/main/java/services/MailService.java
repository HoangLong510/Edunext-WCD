package services;

import configs.MailConfig;
import jakarta.servlet.ServletContext;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author Admin
 */
public class MailService {
    public static void SendMail(String toMail, String subject, String content) throws AddressException, MessagingException {
        Session session = MailConfig.getSession();
        Message message = new MimeMessage(session);

        message.setFrom(new InternetAddress(MailConfig.getMailSender()));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toMail));
        message.setSubject(subject);
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(content, "text/html; charset=utf-8");
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        message.setContent(multipart);
        Transport.send(message);
    }
}
