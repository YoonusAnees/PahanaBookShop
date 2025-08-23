package com.pahana.bookshop.service;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;

public class EmailService {
    private static EmailService instance;
    private final String FROM_EMAIL = "yoonusaneesniis@gmail.com";
    private final String PASSWORD = "szaopbjpvldkkqwz";
    
    private EmailService() {}
    
    public static EmailService getInstance() {
        if (instance == null) {
            synchronized (EmailService.class) {
                if (instance == null) {
                    instance = new EmailService();
                }
            }
        }
        return instance;
    }
    
    public boolean sendEmail(String toEmail, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean sendOrderConfirmation(String toEmail, Order order) {
        String subject = "Order Confirmation - PahanaBookShop";
        String body = generateOrderEmailBody(order);
        return sendEmail(toEmail, subject, body);
    }
    
    private String generateOrderEmailBody(Order order) {
        StringBuilder body = new StringBuilder();
        body.append("Thank you for your order with PahanaBookShop!\n\n");
        body.append("Order ID: ").append(order.getId()).append("\n");
        body.append("Order Date: ").append(order.getOrderDate()).append("\n");
        body.append("Customer Name: ").append(order.getFullName()).append("\n");
        body.append("Email: ").append(order.getEmail()).append("\n");
        body.append("Shipping Address: ").append(order.getAddress()).append("\n\n");
        
        
        
        
        body.append("--------------------------------------------------\n");
        body.append("Grand Total: Rs.").append(order.getTotal()).append("\n\n");
        body.append("We will process your order shortly.\n");
        body.append("Thank you for shopping with us!\n\n");
        body.append("Best regards,\n");
        body.append("PahanaBookShop Team");
        
        return body.toString();
    }
}