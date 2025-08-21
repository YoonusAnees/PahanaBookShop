package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.OrderDAO;
import com.pahana.bookshop.model.Order;

import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private static OrderService instance;
    private final OrderDAO orderDAO;

    private OrderService() {
        orderDAO = new OrderDAO(); 
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
        return orderDAO.saveOrder(order);
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
