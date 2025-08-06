<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #f2f2f2, #d9e4f5);
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #2f4f6f;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
        }

        .dashboard-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        .menu {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }

        .menu li {
            margin: 15px 0;
        }

        .menu a {
            display: block;
            background-color: #4a90e2;
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            border-radius: 8px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .menu a:hover {
            background-color: #357ab7;
        }

        .logout-btn {
            display: inline-block;
            margin-top: 30px;
            background-color: #e74c3c;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Welcome Admin: <%= user.getUsername() %></h1>
    </div>

    <div class="dashboard-container">
        <ul class="menu">
            <li><a href="AddBook.jsp"> Add Book</a></li>
            <li><a href="Book?action=list"> Manage Books (Update/Delete)</a></li>
            <li><a href="${pageContext.request.contextPath}/User?action=list" class="btn btn-primary">Manage Users</a>
            </li>
        </ul>

        <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</body>
</html>
