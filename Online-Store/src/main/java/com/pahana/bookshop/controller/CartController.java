package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.CustomerDAO;
import com.pahana.bookshop.model.CartItem;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.CartService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
    private final CartService cartService = new CartService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("/login.jsp");
            return;
        }

        switch (action) {
            case "view":
                viewCart(request, response);
                break;
            case "remove":
                removeItem(request, response);
                break;
            case "checkout":
                checkout(request, response);
                break;
            default:
                response.sendRedirect("/");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addToCart(request, response);
        }
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getId());
        if (customer == null) {
            response.sendRedirect("/login.jsp");
            return;
        }
        int customerId = customer.getId();

        List<CartItem> items = cartService.getCartItems(customerId);
        request.setAttribute("cartItems", items);
        request.setAttribute("customerId", customerId);
        request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
    }


    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        com.pahana.bookshop.model.User user = (com.pahana.bookshop.model.User) session.getAttribute("user");
        com.pahana.bookshop.DAO.CustomerDAO customerDAO = new com.pahana.bookshop.DAO.CustomerDAO();
        int customerId = customerDAO.getCustomerIdByUserId(user.getId());

        if (customerId == -1) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = 1;
        cartService.addToCart(customerId, bookId, quantity);
        response.sendRedirect("CartController?action=view&customerId=" + customerId);
    }

    private void removeItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        cartService.removeItem(cartId);
        response.sendRedirect("CartController?action=view&customerId=" + customerId);
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getId());
        if (customer == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        int customerId = customer.getId();

        List<CartItem> cartItems = cartService.getCartItems(customerId);

        int totalItems = 0;
        double totalPrice = 0.0;
        for (CartItem item : cartItems) {
            totalItems += item.getQuantity();
            totalPrice += item.getQuantity() * item.getBook().getPrice();
        }

        request.setAttribute("totalItems", totalItems);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("customerId", customerId);
        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
    }

}
