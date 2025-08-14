package com.pahana.bookshop.controller;


import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.service.OrderService;

@WebServlet("/admin/order-history")
public class OrderHistoryController extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = OrderService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Order> orders = orderService.getAllOrdersWithItems();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin/order-history.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving orders", e);
        }
    }
}
