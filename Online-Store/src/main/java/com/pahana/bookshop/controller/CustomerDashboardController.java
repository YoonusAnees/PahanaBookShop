package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer/dashboard")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
	    maxFileSize = 1024 * 1024 * 10,       // 10 MB
	    maxRequestSize = 1024 * 1024 * 15     // 15 MB
	)
public class CustomerDashboardController extends HttpServlet {

    private BookService bookService;

    @Override
    public void init() throws ServletException {
        bookService = new BookService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"customer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        List<Book> bookList = bookService.getAllBookss();
        request.setAttribute("bookList", bookList);
        request.setAttribute("username", user.getUsername());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
