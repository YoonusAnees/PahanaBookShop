package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.CustomerDAO;
import com.pahana.bookshop.DAO.DBConnectionFactory;
import com.pahana.bookshop.model.*;
import com.pahana.bookshop.service.CartService;
import com.pahana.bookshop.service.OrderService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/OrderController")
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Show checkout form
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Place order
        String action = request.getParameter("action");
        if ("placeOrder".equals(action)) {
            placeOrder(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getId());
        if (customer == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        CartService cartService = new CartService();
        List<CartItem> cart = cartService.getCartItems(customer.getId());

        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Your cart is empty!");
            request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cart) {
            OrderItem orderItem = new OrderItem(
                cartItem.getBook().getId(),
                cartItem.getQuantity(),
                cartItem.getBook().getPrice()
            );
            orderItems.add(orderItem);
        }


        Order order = new Order(customer.getId(), fullName, email, address, orderItems);

        try (Connection conn = DBConnectionFactory.getConnection()) {
            OrderService orderService = new OrderService(conn);
            int orderId = orderService.placeOrder(order);
            cartService.checkout(customer.getId());
            session.removeAttribute("cart");
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("customer/order-success.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Order failed. Please try again.");
            request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
        }
    }
}
