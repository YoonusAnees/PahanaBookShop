<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Users</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Sidebar and layout styles from admin theme */
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
        /* Adjust container to not full width */
        .container {
            max-width: 960px;
        }
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
                padding-top: 50px;
            }
            .main-content {
                margin-left: 180px;
                padding: 20px;
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
            <li><a href="User?action=list" class="active">Manage Users</a></li>
            <li><a href="AddStationery.jsp">Add Stationery</a></li>
        </ul>
    </nav>

    <!-- Top Header -->
    <header class="top-header">
        <div class="welcome">Welcome Admin: <%= user.getUsername() %></div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </header>

    <!-- Main content area -->
    <main class="main-content">
        <div class="container mt-4">
            <table class="table table-striped mt-3">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.password}</td>
                            <td>${user.role}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/User?action=edit&id=${user.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="${pageContext.request.contextPath}/User?action=delete&id=${user.id}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>
