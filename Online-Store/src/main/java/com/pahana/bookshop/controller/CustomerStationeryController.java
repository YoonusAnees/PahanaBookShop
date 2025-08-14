package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Stationery;
import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.StationeryService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer/stationery")
public class CustomerStationeryController extends HttpServlet {

    private StationeryService stationeryService;

    @Override
    public void init() throws ServletException {
        stationeryService = StationeryService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Redirect to login if user not logged in
        if (user == null || !"customer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch stationery list
        List<Stationery> stationeryList = stationeryService.getAllStationerySafe();

        // Pass data to JSP
        request.setAttribute("stationeryList", stationeryList);
        request.setAttribute("username", user.getUsername());

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/customerStationery.jsp");
        dispatcher.forward(request, response);
    }
}
