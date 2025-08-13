package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.OrderDAO;
import com.pahana.bookshop.model.Order;

import java.sql.Connection;
import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO;

    public OrderService(Connection conn) {
        this.orderDAO = new OrderDAO();
    }

    public int placeOrder(Order order) throws Exception {
        return orderDAO.saveOrder(order);
    }
    
 // In OrderService.java

    public void updateOrder(Order order) throws Exception {
        orderDAO.updateOrder(order);
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

}
