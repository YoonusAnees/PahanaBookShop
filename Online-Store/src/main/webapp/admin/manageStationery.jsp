<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.model.Stationery" %>
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
    <title>Manage Stationery</title>
    <style>
        /* Reset and base */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }
        
         .logo {
            font-weight: 500;
            font-size: 28px;
            letter-spacing: 2px;
            color: #f1c40f;
            margin: 0 0 12px 20px;
            cursor: default;
            transition: color 0.3s ease;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
            text-decoration: none;
            
         
        }
        
           .logo:hover {
            color: #e67e22;
            text-decoration: none;
                        cursor: pointer;
            
      
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
            height: 80px;
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
            padding: 80px 40px 40px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
        }

        /* Container for table */
        .table-container {
            width: 100%;
            max-width: 1060px;
            padding: 30px 40px;
        }
     

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
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
        .btn {
            padding: 7px 14px;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            user-select: none;
            display: inline-block;
            transition: background-color 0.3s ease;
            border: none;
        }
        .btn-edit {
            background-color: #27ae60;
            color: white;
        }
        .btn-edit:hover {
            background-color: #1e8449;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
            margin-left: 8px;
        }
        .btn-delete:hover {
            background-color: #b83127;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .sidebar {
                width: 180px;
                padding-top: 50px;
            }
            .main-content {
                margin-left: 180px;
                padding: 60px 20px 20px;
            }
            .top-header {
                left: 180px;
                height: 50px;
                padding: 0 20px;
                font-size: 16px;
            }
            .sidebar ul li a {
                font-size: 14px;
                padding: 12px 16px;
            }
            .table-container {
                max-width: 100%;
                padding: 25px 30px;
                border-radius: 12px;
            }
        }
        @media (max-width: 600px) {
            .sidebar {
                display: none;
            }
            .main-content {
                margin-left: 0;
                padding: 80px 15px 15px;
            }
            .top-header {
                left: 0; right: 0;
            }
        }
    </style>
    <script>
        function confirmDelete(name, id) {
            if (confirm('Are you sure you want to delete "' + name + '"?')) {
                window.location.href = 'Stationery?action=delete&id=' + id;
            }
        }
    </script>
</head>
<body>

    <!-- Sidebar Navigation -->
    <nav class="sidebar">
            <a class="logo" href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="logo">PahanaBook</a>
    
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="AddBook.jsp">Add Book</a></li>
            <li><a href="Book?action=list">Manage Books</a></li>
            <li><a href="${pageContext.request.contextPath}/User?action=list">Manage Users</a></li>
            <li><a href="AddStationery.jsp" >Add Stationery</a></li>
            <li><a href="Stationery?action=list" class="active">Manage Stationery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order-history">Orders History</a></li>
            
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
            <h2>Manage Stationery</h2>
            <a href="AddStationery.jsp" class="btn btn-edit" style="margin-bottom: 15px; display: inline-block;">+ Add New Stationery</a>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price (USD)</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${stationeryList}">
                        <tr>
                            <td data-label="ID">${s.id}</td>
                            <td data-label="Name">${s.name}</td>
                            <td data-label="Description">${s.description}</td>
                            <td data-label="Price (USD)">${s.price}</td>
                            <td data-label="Quantity">${s.quantity}</td>
                            <td data-label="Actions">
                                <a href="EditStationery.jsp?id=${s.id}" class="btn btn-edit">Edit</a>
                                <a href="javascript:void(0);" class="btn btn-delete" onclick="confirmDelete('${s.name}', ${s.id})">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty stationeryList}">
                        <tr>
                            <td colspan="6" style="text-align:center;">No stationery items found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>
