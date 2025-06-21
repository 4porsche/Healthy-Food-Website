package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String USERNAME = "daioceanratdamsau@gmail.com"; // Thay bằng email của bạn
    private static final String PASSWORD = "vahr eoem nwbe iopl"; // Sử dụng App Password

    public static void sendOTP(String toEmail, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(USERNAME));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("[Healthy Food] Mã OTP Khôi Phục Mật Khẩu");
        message.setText("Mã OTP của bạn là: " + otp + "\nMã có hiệu lực trong 5 phút.");

        Transport.send(message);
    }
}