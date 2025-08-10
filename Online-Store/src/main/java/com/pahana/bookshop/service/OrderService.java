package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.OrderDAO;
import com.pahana.bookshop.model.Order;

import java.sql.Connection;

public class OrderService {
    private final OrderDAO orderDAO;

    public OrderService(Connection conn) {
        this.orderDAO = new OrderDAO();
    }

    public int placeOrder(Order order) throws Exception {
        return orderDAO.saveOrder(order);
    }
}
