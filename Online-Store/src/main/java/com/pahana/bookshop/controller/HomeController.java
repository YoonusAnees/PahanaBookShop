package com.pahana.bookshop.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Stationery;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.StationeryService;

@WebServlet("/")
public class HomeController extends HttpServlet {
    private BookService bookService;
    private StationeryService stationeryService;

    @Override
    public void init() throws ServletException {
        bookService = BookService.getInstance(); 
        stationeryService = StationeryService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> bookList = bookService.getAllBooksSafe(); // Fetch all books safely
        request.setAttribute("bookList", bookList);

        List<Stationery> stationeryList = stationeryService.getAllStationerySafe(); // Fetch all stationery safely
        request.setAttribute("stationeryList", stationeryList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Books.jsp");
        dispatcher.forward(request, response);
    }
}
