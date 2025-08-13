package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.BookDAO;
import com.pahana.bookshop.DAO.StationeryDAO;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Stationery;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Search")
public class SearchController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query").trim();

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

        request.setAttribute("bookResults", bookResults);
        request.setAttribute("stationeryResults", stationeryResults);
        request.setAttribute("searchQuery", query);
        request.getRequestDispatcher("/searchResults.jsp").forward(request, response);
    }
}
