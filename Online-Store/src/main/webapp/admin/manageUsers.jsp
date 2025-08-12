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
    <meta charset="ISO-8859-1" />
    <title>Manage Users</title>
    <style>
        /* Reset and base */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7f9fc;
            color: #333;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0; left: 0;
            width: 220px;
            height: 100%;
            background: linear-gradient(180deg, #34495e, #2c3e50);
            padding-top: 60px;
            box-shadow: 3px 0 12px rgba(0,0,0,0.15);
            overflow-y: auto;
        }
        .sidebar h2 {
            color: #ecf0f1;
            text-align: center;
            font-weight: 600;
            font-size: 24px;
            margin: 0 0 10px;
            letter-spacing: 1.2px;
            border-bottom: 1px solid rgba(236, 240, 241, 0.15);
            padding-bottom: 12px;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar ul li a {
            display: block;
            padding: 16px 24px;
            color: #bdc3c7;
            font-weight: 500;
            text-decoration: none;
            border-left: 5px solid transparent;
            transition: all 0.3s ease;
            font-size: 17px;
        }
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            color: #ecf0f1;
            background: rgba(255,255,255,0.1);
            border-left: 5px solid #f39c12;
            font-weight: 700;
        }

        /* Top Header */
        .top-header {
            position: fixed;
            left: 220px; top: 0; right: 0;
            height: 60px;
            background-color: #34495e;
            color: #ecf0f1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.15);
            font-size: 18px;
            font-weight: 600;
            z-index: 1000;
        }
        .logout-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 4px 9px rgba(231, 76, 60, 0.6);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .logout-btn:hover {
            background-color: #c0392b;
            box-shadow: 0 6px 15px rgba(192, 57, 43, 0.7);
        }

        /* Main content */
        .main-content {
            margin-left: 220px;
            padding: 100px 40px 40px;
            min-height: 100vh;
            background: linear-gradient(135deg, #f7f9fc, #e3eaf2);
            display: flex;
            justify-content: center;
        }

        /* Container for table */
        .table-container {
            width: 100%;
            max-width: 960px;
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: box-shadow 0.3s ease;
        }
        .table-container:hover {
            box-shadow: 0 15px 40px rgba(0,0,0,0.12);
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
            background: white;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            border-radius: 12px;
            overflow: hidden;
        }

        thead {
            background-color: #2980b9;
            color: #fff;
            user-select: none;
        }

        thead th {
            padding: 14px 18px;
            text-align: left;
            font-weight: 700;
            letter-spacing: 0.07em;
        }

        tbody tr {
            border-bottom: 1px solid #ddd;
            transition: background-color 0.3s ease;
        }

        tbody tr:hover {
            background-color: #f0f8ff;
        }

        tbody td {
            padding: 14px 18px;
            vertical-align: middle;
            color: #333;
        }

        /* Buttons */
        .btn-warning {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            user-select: none;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-warning:hover {
            background-color: #1e8449;
            color: white;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            user-select: none;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-left: 8px;
        }
        .btn-danger:hover {
            background-color: #b83127;
            color: white;
        }

        /* Responsive - make table scroll horizontally on small screens */
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tbody tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #2980b9;
                padding-bottom: 15px;
            }
            tbody td {
                padding-left: 50%;
                position: relative;
                text-align: left;
                border: none;
                border-bottom: 1px solid #eee;
            }
            tbody td::before {
                position: absolute;
                top: 14px;
                left: 18px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                font-weight: 700;
                color: #2980b9;
                content: attr(data-label);
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
            <li><a href="admin/AddStationery.jsp">Add Stationery</a></li>
            <li><a href="Stationery?action=list">Manage Stationery</a></li>
        </ul>
    </nav>

    <!-- Top Header -->
    <header class="top-header">
        <div class="welcome">Welcome Admin: <%= user.getUsername() %></div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </header>

    <!-- Main content area -->
    <main class="main-content">
        <div class="table-container">
            <h2 style="margin-bottom: 20px;">Manage Users</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td data-label="ID">${user.id}</td>
                            <td data-label="Username">${user.username}</td>
                            <td data-label="Email">${user.email}</td>
                            <td data-label="Password">${user.password}</td>
                            <td data-label="Role">${user.role}</td>
                            <td data-label="Actions">
                                <a href="${pageContext.request.contextPath}/User?action=edit&id=${user.id}" class="btn-warning">Edit</a>
                                <a href="${pageContext.request.contextPath}/User?action=delete&id=${user.id}" class="btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="6" class="text-center">No users found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>
