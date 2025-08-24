package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.BookDAO;
import com.pahana.bookshop.model.Book;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/Chat")
public class ChatController extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();
    private static final String ADMIN_EMAIL = "yoonusaneesniis@gmail.com"; // admin email
    private static final String GMAIL_USER = "yoonusaneesniis@gmail.com"; // your Gmail
    private static final String GMAIL_PASS = "szaopbjpvldkkqwz"; // App Password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = request.getParameter("message");
        String reply = "Sorry, I didn't understand that.";

        if (message != null) {
            message = message.toLowerCase();
            try {
                if (message.contains("reset password")) {
                    String userEmail = request.getParameter("email"); // Get user's email
                    if (userEmail == null || userEmail.isEmpty()) {
                        reply = "Please provide your registered email for password reset.";
                    } else {
                        sendPasswordResetEmail(userEmail);
                        reply = "Your password reset request has been sent. Admin will contact you shortly.";
                    }
                } else {
                    // treat as book search
                    reply = handleBookSearch(message);
                }
            } catch (Exception e) {
                e.printStackTrace();
                reply = "Error processing your request. Please try again later.";
            }
        }

        response.setContentType("text/plain");
        response.getWriter().write(reply);
    }

    private String handleBookSearch(String query) throws SQLException {
        StringBuilder result = new StringBuilder();
        for (Book book : bookDAO.selectAllBooks()) {
            if (book.getTitle().toLowerCase().contains(query)) {
                result.append(book.getTitle())
                      .append(" by ").append(book.getAuthor())
                      .append(" - Available: ").append(book.getQuantity()).append("\n");
            }
        }
        if (result.length() == 0) {
            return "No books found for your search: " + query;
        }
        return result.toString();
    }

    private void sendPasswordResetEmail(String userEmail) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(GMAIL_USER, GMAIL_PASS);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(GMAIL_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(ADMIN_EMAIL));
        message.setSubject("Password Reset Request");
        message.setText("A user has requested a password reset.\nUser email: " + userEmail);

        Transport.send(message);
    }
}
