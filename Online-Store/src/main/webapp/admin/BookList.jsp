<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Book List</title>
    <style>
        /* Reset */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f2f2f2;
        }

        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 220px;
            height: 100%;
            background-color: #2f4f6f;
            padding-top: 60px; /* space for header */
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

        /* Main content */
        .main-content {
            margin-left: 220px;
            padding: 80px 40px;
            min-height: 100vh;
            background: linear-gradient(to right, #f2f2f2, #d9e4f5);
        }

        /* Top header */
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

        /* Book list container */
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        img.book-image {
            max-width: 60px;
            max-height: 60px;
            border-radius: 4px;
        }

        a.button {
            padding: 6px 12px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            margin: 0 3px;
        }

        a.edit-btn {
            background-color: #28a745;
        }

        a.delete-btn {
            background-color: #dc3545;
        }

        a.add-btn {
            display: inline-block;
            margin-bottom: 15px;
            background-color: #007bff;
            padding: 10px 15px;
        }

        a.add-btn:hover {
            background-color: #0056b3;
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
            .container {
                max-width: 100%;
                padding: 20px;
            }
        }
    </style>
    <script>
        function confirmDelete(title, id) {
            if (confirm('Are you sure you want to delete "' + title + '"?')) {
                window.location.href = 'Book?action=delete&id=' + id;
            }
        }
    </script>
</head>
<body>
    <!-- Sidebar Navigation -->
    <nav class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="AddBook.jsp">Add Book</a></li>
            <li><a href="Book?action=list" class="active">Manage Books</a></li>
            <li><a href="${pageContext.request.contextPath}/User?action=list">Manage Users</a>
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
        <div class="container">
            <h2>Book List</h2>
            <a href="AddBook.jsp" class="add-btn">+ Add New Book</a>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Category</th>
                    <th>Price ($)</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="book" items="${bookList}">
                    <tr>
                        <td>${book.id}</td>
                        <td>
                  <img src="${pageContext.request.contextPath}/${book.image}" alt="${book.title}" class="book-image" />
                        </td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.category}</td>
                        <td>${book.price}</td>
                        <td>${book.quantity}</td>
                        <td>
                            <a class="button edit-btn" href="Book?action=edit&id=${book.id}">Edit</a>
                            <a href="javascript:void(0);" class="button delete-btn" onclick="confirmDelete('${book.title}', ${book.id})">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty bookList}">
                    <tr><td colspan="8">No books found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
