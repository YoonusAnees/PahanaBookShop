package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.CustomerDAO;
import com.pahana.bookshop.DAO.OrderDAO;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.Stationery;
import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.StationeryService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/customer/dashboard")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 15
)
public class CustomerDashboardController extends HttpServlet {

    private BookService bookService;
    private StationeryService stationeryService;
    private CustomerDAO customerDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        bookService = BookService.getInstance(); 
        stationeryService = StationeryService.getInstance();
        customerDAO = new CustomerDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch customer details
        Customer customer = customerDAO.getCustomerByUserId(user.getId());
        
        // Get the customer ID (not user ID)
        int customerId = customerDAO.getCustomerIdByUserId(user.getId());
        
        List<Book> bookList = bookService.getAllBooksSafe();
        List<Stationery> stationeryList = stationeryService.getAllStationerySafe();

        // Get categories from order history using customer ID
        List<String> orderCategories = getOrderHistoryCategories(customerId);
        
        // Check if we should show books immediately
        String showParam = request.getParameter("show");
        boolean showBooksImmediately = "books".equals(showParam);
        
        request.setAttribute("bookList", bookList);
        request.setAttribute("stationeryList", stationeryList);
        request.setAttribute("username", user.getUsername());
        request.setAttribute("customer", customer);
        request.setAttribute("orderCategories", orderCategories);
        request.setAttribute("showBooks", showBooksImmediately);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/dashboard.jsp");
        dispatcher.forward(request, response);
    }

    private List<String> getOrderHistoryCategories(int customerId) {
        Set<String> categories = new HashSet<>();
        try {
            System.out.println("Fetching order history for customer ID: " + customerId);
            
            // Get all orders with items
            List<Order> allOrders = orderDAO.getAllOrdersWithItems();
            System.out.println("Total orders found: " + allOrders.size());
            
            boolean hasOrders = false;
            
            // Filter orders for this specific customer and extract categories
            for (Order order : allOrders) {
                System.out.println("Checking order ID: " + order.getId() + ", Customer ID in order: " + order.getCustomerId());
                
                if (order.getCustomerId() == customerId) {
                    hasOrders = true;
                    System.out.println("Order belongs to current customer");
                    
                    for (OrderItem item : order.getItems()) {
                        System.out.println("Item: " + item.getId() + ", Book ID: " + item.getBookId());
                        
                        if (item.getBook() != null) {
                            System.out.println("Book found: " + item.getBook().getTitle() + ", Category: " + item.getBook().getCategory());
                            
                            if (item.getBook().getCategory() != null) {
                                String category = item.getBook().getCategory();
                                System.out.println("Processing category: " + category);
                                
                                // Handle categories with commas (like "Fantasy, Adventure")
                                if (category.contains(",")) {
                                    String[] categoryArray = category.split(",");
                                    for (String cat : categoryArray) {
                                        String trimmedCat = cat.trim();
                                        categories.add(trimmedCat);
                                        System.out.println("Added category: " + trimmedCat);
                                    }
                                } else {
                                    String trimmedCat = category.trim();
                                    categories.add(trimmedCat);
                                    System.out.println("Added category: " + trimmedCat);
                                }
                            }
                        }
                    }
                }
            }
            
            System.out.println("Final categories: " + categories);
            
            // If customer has no orders, return null to show appropriate message
            if (!hasOrders) {
                return null;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Return null if there's an error
            return null;
        }
        
        // Convert to list and return
        return new ArrayList<>(categories);
    }
}