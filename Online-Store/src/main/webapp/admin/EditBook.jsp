<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Edit Book</title>
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
        /* Edit form container */
        .container {
            max-width: 480px;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"], input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            margin-top: 25px;
            width: 100%;
            background: #28a745;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background: #218838;
        }
        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        img.book-image {
            display: block;
            margin-top: 15px;
            max-width: 100%;
            height: auto;
            border-radius: 5px;
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
            .container {
                max-width: 100%;
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
            <li><a href="AddBook.jsp">Add Book</a></li>
            <li><a href="Book?action=list">Manage Books</a></li>
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
        <div class="container">
            <h2>Edit Book</h2>
            <form action="Book?action=update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${book.id}" />
                <input type="hidden" name="existingImage" value="${book.image}" />

                <label for="title">Title:</label>
                <input type="text" id="title" name="title" value="${book.title}" required>

                <label for="author">Author:</label>
                <input type="text" id="author" name="author" value="${book.author}" required>

                <label for="category">Category:</label>
                <input type="text" id="category" name="category" value="${book.category}" required>

                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" value="${book.price}" required>

                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" value="${book.quantity}" required>

                <label>Current Image:</label>
                <img class="book-image" src="${pageContext.request.contextPath}/${book.image}" alt="Book Image" />

                <label for="image">Change Image (optional):</label>
                <input type="file" id="image" name="image" accept="image/*">

                <input type="submit" value="Update Book">
            </form>

        </div>
    </main>

</body>
</html>
