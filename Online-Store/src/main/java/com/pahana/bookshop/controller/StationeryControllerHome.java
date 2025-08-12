package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Stationery;
import com.pahana.bookshop.service.StationeryService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/stationery")
public class StationeryControllerHome extends HttpServlet {

    private StationeryService stationeryService;

    @Override
    public void init() throws ServletException {
        stationeryService = new StationeryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Stationery> stationeryList = stationeryService.getAllStationerySafe(); // get stationery list safely
        request.setAttribute("stationeryList", stationeryList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/stationery.jsp");
        dispatcher.forward(request, response);
    }
}
