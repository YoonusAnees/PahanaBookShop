<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.model.Customer" %>
<%
    User user = (User) session.getAttribute("user");
    Customer customer = (Customer) request.getAttribute("customer"); // Might be null if role != customer

    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit User</title>
    <style>
        /* Sidebar and layout styles */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f2f2f2;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 220px;
            height: 100%;
            background-color: #2f4f6f;
            padding-top: 60px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            overflow-y: auto;
        }
        .sidebar h2 {
            color: white;
            text-align: center;
            padding: 10px 0;
            margin: 0;
            font-weight: normal;
            font-size: 22px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar ul li {
            margin: 0;
        }
        .sidebar ul li a {
            display: block;
            padding: 14px 20px;
            color: white;
            text-decoration: none;
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
            font-size: 16px;
        }
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #4a90e2;
            border-left: 4px solid #f39c12;
        }
        .main-content {
            margin-left: 220px;
            padding: 80px 40px;
            min-height: 100vh;
            background: linear-gradient(to right, #f2f2f2, #d9e4f5);
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        .top-header {
            position: fixed;
            left: 220px;
            top: 0;
            right: 0;
            height: 60px;
            background-color: #2f4f6f;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        .top-header .welcome {
            font-size: 18px;
        }
        .logout-btn {
            background-color: #e74c3c;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .logout-btn:hover {
            background-color: #c0392b;
        }
        /* Form container styling */
        .form-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }
        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus {
            border-color: #007BFF;
            outline: none;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        #customerFields {
            display: <%= "customer".equals(user.getRole()) ? "block" : "none" %>;
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
                padding-top: 50px;
            }
            .main-content {
                margin-left: 180px;
                padding: 30px 20px;
            }
            .top-header {
                left: 180px;
                height: 50px;
                padding: 0 20px;
            }
            .top-header .welcome {
                font-size: 16px;
            }
            .sidebar ul li a {
                font-size: 14px;
                padding: 12px 16px;
            }
            .form-container {
                width: 100%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <nav class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="admin/AddBook.jsp">Add Book</a></li>
            <li><a href="admin/Book?action=list">Manage Books</a></li>
            <li><a href="User?action=list">Manage Users</a></li>
            <li><a href="AddStationery.jsp">Add Stationery</a></li>
        </ul>
    </nav>

    <!-- Top Header -->
    <header class="top-header">
        <div class="welcome">Welcome Admin: <%= user.getUsername() %></div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </header>

    <!-- Main content -->
    <main class="main-content">
        <div class="form-container">
            <h2>Edit User</h2>
            <form action="User" method="post">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="id" value="<%= user.getId() %>" />

                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required />

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required />

                <label for="password">Password:</label>
                <input type="text" id="password" name="password" value="<%= user.getPassword() %>" required />

                <label for="role">Role:</label>
                <select id="role" name="role" required onchange="toggleCustomerFields(this.value)">
                    <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                    <option value="customer" <%= "customer".equals(user.getRole()) ? "selected" : "" %>>Customer</option>
                </select>

                <!-- Customer-specific fields -->
                <div id="customerFields">
                    <label for="accountNumber">Account Number:</label>
                    <input type="text" id="accountNumber" name="accountNumber" value="<%= customer != null ? customer.getAccountNumber() : "" %>" />

                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= customer != null ? customer.getAddress() : "" %>" />

                    <label for="telephone">Telephone:</label>
                    <input type="text" id="telephone" name="telephone" value="<%= customer != null ? customer.getTelephone() : "" %>" />
                </div>

                <input type="submit" value="Update" />
            </form>
        </div>
    </main>

    <script>
        function toggleCustomerFields(role) {
            const fields = document.getElementById("customerFields");
            fields.style.display = (role === "customer") ? "block" : "none";
        }
    </script>
</body>
</html>
