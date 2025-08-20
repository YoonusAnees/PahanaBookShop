package com.pahana.bookshop.controller;

import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/sendEmail")
public class EmailController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String senderEmail = request.getParameter("email");
        String messageBody = request.getParameter("message");

        // Gmail credentials
        final String user = "yoonusaneesniis@gmail.com"; // your Gmail
        final String pass = "szaopbjpvldkkqwz"; // Gmail App Password

        // Recipient
        String recipient = "yoonusaneesniis@gmail.com";

        String subject = "Contact Form Message from " + name;
        String fullMessage = "Message from: " + name + "\nEmail: " + senderEmail + "\n\n" + messageBody;

        // SMTP configuration
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(fullMessage);

            Transport.send(message);

            request.getSession().setAttribute("msg", "Email sent successfully!");
            request.getSession().setAttribute("msgType", "success");

        } catch (MessagingException e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Error sending email: " + e.getMessage());
            request.getSession().setAttribute("msgType", "error");
        }

        // Redirect to avoid form resubmission
        response.sendRedirect("ContactUs.jsp");
    }
}
