package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.BookDAO;
import com.pahana.bookshop.DAO.StationeryDAO;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Stationery;
import com.pahana.bookshop.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/customer/Search")
public class customerSearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Redirect to login if not logged in or not a customer
        if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String query = request.getParameter("query");
        if (query != null) {
            query = query.trim();
        } else {
            query = "";
        }

        List<Book> bookResults = new ArrayList<>();
        List<Stationery> stationeryResults = new ArrayList<>();

        BookDAO bookDAO = new BookDAO();
        StationeryDAO stationeryDAO = new StationeryDAO();

        try {
            for (Book b : bookDAO.selectAllBooks()) {
                if (b.getTitle().toLowerCase().contains(query.toLowerCase())) {
                    bookResults.add(b);
                }
            }
            for (Stationery s : stationeryDAO.getAllStationery()) {
                if (s.getName().toLowerCase().contains(query.toLowerCase())) {
                    stationeryResults.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Pass results and username to JSP
        request.setAttribute("bookResults", bookResults);
        request.setAttribute("stationeryResults", stationeryResults);
        request.setAttribute("searchQuery", query);
        request.setAttribute("username", user.getUsername());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/customerSearchResults.jsp");
        dispatcher.forward(request, response);
    }
}
