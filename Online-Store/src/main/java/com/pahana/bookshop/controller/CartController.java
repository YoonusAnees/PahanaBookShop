package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.BookDAO;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.CartItem;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CartController")
public class CartController extends HttpServlet {

    private BookDAO bookDAO = new BookDAO();

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdStr = request.getParameter("bookId");
        int bookId = Integer.parseInt(bookIdStr);

        try {
            Book book = bookDAO.selectBookById(bookId);
            if (book == null) {
                response.sendRedirect("CustomerDashboard");  // Book not found
                return;
            }

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;
            for (CartItem item : cart) {
                if (item.getBook().getId() == bookId) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }
            if (!found) {
                cart.add(new CartItem(book, 1));
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("CartView.jsp"); // Redirect to cart view page

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For removing items or clearing cart based on parameters
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            response.sendRedirect("CartView.jsp");
            return;
        }

        if ("remove".equals(action)) {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            cart.removeIf(item -> item.getBook().getId() == id);
        } else if ("clear".equals(action)) {
            cart.clear();
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("CartView.jsp");
    }
}
