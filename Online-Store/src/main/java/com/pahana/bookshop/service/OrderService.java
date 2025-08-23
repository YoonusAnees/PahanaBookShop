package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.OrderDAO;
import com.pahana.bookshop.model.Order;

import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private static OrderService instance;
    private final OrderDAO orderDAO;
    private final EmailService emailService;

    private OrderService() {
        orderDAO = new OrderDAO();
        emailService = EmailService.getInstance();
    }

    public static OrderService getInstance() {
        if (instance == null) {
            synchronized (OrderService.class) {
                if (instance == null) {
                    instance = new OrderService();
                }
            }
        }
        return instance;
    }

    public int placeOrder(Order order) throws Exception {
        // Save the order and get the complete order object with ID
        Order savedOrder = orderDAO.saveOrderAndReturn(order);
        
        // Get the complete order with item details for email
        Order completeOrder = orderDAO.getOrderById(savedOrder.getId());
        
        // Send confirmation email
        try {
            emailService.sendOrderConfirmation(completeOrder.getEmail(), completeOrder);
        } catch (Exception e) {
            // Log the error but don't throw it to avoid disrupting the order process
            System.err.println("Failed to send confirmation email: " + e.getMessage());
        }
        
        return savedOrder.getId();
    }

    public void updateOrder(Order order) throws Exception {
        orderDAO.updateOrder(order);
    }
    
    public int insertOrder(Order order) throws SQLException {
        return orderDAO.saveOrder(order);
    }

    public void deleteOrder(int orderId) throws Exception {
        orderDAO.deleteOrder(orderId);
    }

    public Order getOrderById(int orderId) throws Exception {
        return orderDAO.getOrderById(orderId);
    }

    public List<Order> getAllOrders() throws Exception {
        return orderDAO.getAllOrders();
    }

    public List<Order> getAllOrdersWithItems() throws Exception {
        return orderDAO.getAllOrdersWithItems();
    }
}