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
            response.sendRedirect(request.getContextPath() + "/index.jsp");
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
                response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
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
                response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    // ---------------- REGISTER ----------------
    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        User user = new User(username, email, password,
                role == null || role.isEmpty() ? "customer" : role);
        int userId = userDAO.insertUserAndReturnId(user);

        if (userId > 0) {
            if (user.getRole().equalsIgnoreCase("customer")) {
                try {
                    CustomerDAO customerDAO = new CustomerDAO();
                    Customer customer = new Customer(0, name, address, telephone, userId);

                    // generate sequential account number like 001, 002...
                    customer.setAccountNumber(customerDAO.generateAccountNumber());

                    boolean inserted = customerDAO.insertCustomer(customer);
                    if (!inserted) {
                        request.setAttribute("error", "Customer registration failed.");
                        request.getRequestDispatcher("/register.jsp").forward(request, response);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Customer registration failed.");
                    request.getRequestDispatcher("/register.jsp").forward(request, response);
                    return;
                }
            }
            HttpSession session = request.getSession();
            session.setAttribute("message", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            request.setAttribute("error", "User registration failed.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    // ---------------- LOGIN ----------------
    private void loginUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.validateLogin(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("message", "Login successful! Welcome, " + user.getUsername());
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
            }
        } else {
            request.setAttribute("error", "Invalid username or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        }
    }

    // ---------------- LIST ----------------
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> userList = userDAO.getAllUsers();
        request.setAttribute("userList", userList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manageUsers.jsp");
        dispatcher.forward(request, response);
    }

    // ---------------- DELETE ----------------
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect(request.getContextPath() + "/User?action=list");
    }

    // ---------------- EDIT FORM ----------------
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

        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/editUser.jsp");
        dispatcher.forward(request, response);
    }

    // ---------------- UPDATE ----------------
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            if (password == null || password.trim().isEmpty()) {
                password = request.getParameter("currentPassword");
            }

            User user = new User(id, username, email, password, role);
            userDAO.updateUser(user);

            if ("customer".equalsIgnoreCase(role)) {
                String accountNumber = request.getParameter("accountNumber");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");

                CustomerDAO customerDAO = new CustomerDAO();
                if (accountNumber == null || accountNumber.trim().isEmpty()) {
                    accountNumber = customerDAO.generateAccountNumber();
                }

                Customer customer = new Customer();
                customer.setUserId(id);
                customer.setAccountNumber(accountNumber);
                customer.setAddress(address);
                customer.setTelephone(telephone);

                customerDAO.updateCustomerByUserId(customer);
            }

            response.sendRedirect(request.getContextPath() + "/User?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong");
        }
    }
}
