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
import com.pahana.bookshop.service.BookService;

@WebServlet("/")
public class HomeController extends HttpServlet {
    private BookService bookService;

    @Override
    public void init() throws ServletException {
        bookService = new BookService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	  List<Book> bookList = bookService.getAllBookss();
          request.setAttribute("bookList", bookList);

          RequestDispatcher dispatcher = request.getRequestDispatcher("/Books.jsp");
          dispatcher.forward(request, response);
    }
}
