package com.pahana.bookshop.controller;

import com.pahana.bookshop.DAO.CustomerDAO;
import com.pahana.bookshop.DAO.UserDAO;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/User")
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (action) {
            case "register":
                insertUser(request, response);
                break;
            case "login":
                loginUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

   
    
    
    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Customer-specific fields
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        User user = new User(username, email, password, role == null || role.isEmpty() ? "customer" : role);

        int userId = userDAO.insertUserAndReturnId(user);

        if (userId > 0) {
            // If role is customer, insert into customer table
            if (user.getRole().equalsIgnoreCase("customer")) {
                Customer customer = new Customer(0, accountNumber, name, address, telephone, userId);
                CustomerDAO customerDAO = new CustomerDAO();
                boolean inserted = customerDAO.insertCustomer(customer);

                if (!inserted) {
                    request.setAttribute("error", "Customer registration failed.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            }

            request.setAttribute("message", "Registration successful. Please login.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "User registration failed.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    
    
    
    
    

    private void loginUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.getUserByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
            }
        } else {
            request.setAttribute("error", "Invalid username or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	List<User> userList = userDAO.getAllUsers();  // or your DAO method to fetch users
    	request.setAttribute("userList", userList);
    	RequestDispatcher dispatcher = request.getRequestDispatcher("admin/manageUsers.jsp"); // or whatever your JSP is
    	dispatcher.forward(request, response);
    }



    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect("User?action=list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User existingUser = userDAO.getUserById(id);
        request.setAttribute("user", existingUser);

        if ("customer".equalsIgnoreCase(existingUser.getRole())) {
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByUserId(existingUser.getId());
            request.setAttribute("customer", customer);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/editUser.jsp");
        dispatcher.forward(request, response);
    }


    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            // Create User object and update it
            User user = new User(id, username, email, password, role);
            userDAO.updateUser(user); // Update user in the users table

            // If the user is a customer, also update the customer-specific data
            if ("customer".equalsIgnoreCase(role)) {
                String accountNumber = request.getParameter("accountNumber");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");

                Customer customer = new Customer();
                customer.setUserId(id);
                customer.setAccountNumber(accountNumber);
                customer.setAddress(address);
                customer.setTelephone(telephone);

                CustomerDAO customerDAO = new CustomerDAO();
                boolean updated = customerDAO.updateCustomerByUserId(customer);

                if (!updated) {
                    // Optionally, you can set an error message in request scope and redirect
                    System.err.println("Failed to update customer details.");
                    // You can also forward to an error page if needed
                }
            }

            // Redirect back to user list page
            response.sendRedirect("User?action=list");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong");
        }
    }


}
