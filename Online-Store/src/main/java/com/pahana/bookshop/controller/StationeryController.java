package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.StationeryDAO;
import com.pahana.bookshop.model.Stationery;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/Stationery")
public class StationeryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final StationeryDAO stationeryDAO = new StationeryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStationery(request, response);
                    break;
                default:
                    listStationery(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    insertStationery(request, response);
                    break;
                case "update":
                    updateStationery(request, response);
                    break;
                default:
                    response.sendRedirect("Stationery?action=list");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listStationery(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Stationery> list = stationeryDAO.getAllStationery();
        request.setAttribute("stationeryList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manageStationery.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Stationery stationery = stationeryDAO.getStationeryById(id);
        request.setAttribute("stationery", stationery);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/EditStationery.jsp");
        dispatcher.forward(request, response);
    }

    private void insertStationery(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = 0;
        Integer quantity = null;

        try {
            price = Double.parseDouble(request.getParameter("price"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or quantity format.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/AddStationery.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Stationery stationery = new Stationery(name, description, price, quantity);
        boolean success = stationeryDAO.insertStationery(stationery);

        if (success) {
            response.sendRedirect("Stationery?action=list");
        } else {
            request.setAttribute("error", "Failed to add stationery.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/AddStationery.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void updateStationery(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = 0;
        Integer quantity = null;

        try {
            price = Double.parseDouble(request.getParameter("price"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or quantity format.");
            request.setAttribute("stationery", new Stationery(id, name, description, 0, 0));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/EditStationery.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Stationery stationery = new Stationery(id, name, description, price, quantity);
        boolean success = stationeryDAO.updateStationery(stationery);

        if (success) {
            response.sendRedirect("Stationery?action=list");
        } else {
            request.setAttribute("error", "Failed to update stationery.");
            request.setAttribute("stationery", stationery);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/EditStationery.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void deleteStationery(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        stationeryDAO.deleteStationery(id);
        response.sendRedirect("Stationery?action=list");
    }
}
