<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.DAO.BookDAO" %>
<%@ page import="com.pahana.bookshop.DAO.UserDAO" %>
<%@ page import="com.pahana.bookshop.DAO.StationeryDAO" %>
<%@ page import="com.pahana.bookshop.DAO.OrderDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    BookDAO bookDAO = new BookDAO();
    UserDAO userDAO = new UserDAO();
    StationeryDAO stationeryDAO = new StationeryDAO();
    OrderDAO orderDAO = new OrderDAO();

    
    int bookCount = bookDAO.selectAllBooks().size();
    int userCount = userDAO.getAllUsers().size();
    int stationeryCount = stationeryDAO.getAllStationery().size();
    int orderCount = orderDAO.getAllOrders().size(); 

    
   
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard</title>
    <style>
        /* Reset and base styles as before */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f7f9fc, #e3eaf2);
            color: #2c3e50;
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
        
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
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
        .main-content {
            margin-left: 220px;
            padding: 120px 40px 40px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        h1 {
            font-weight: 700;
            font-size: 2.4rem;
            color: #2c3e50;
            margin: 0;
        }
        p {
            font-size: 1.1rem;
            color: #34495e;
            max-width: 600px;
            line-height: 1.5;
        }
        /* Top header */
        .top-header {
            position: fixed;
            left: 220px;
            top: 0;
            right: 0;
            height: 80px;
            background: linear-gradient(90deg, #34495e, #2c3e50);
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
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.6);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .logout-btn:hover {
            background-color: #c0392b;
            box-shadow: 0 6px 15px rgba(192, 57, 43, 0.7);
        }
        /* Dashboard widgets container */
        .widgets {
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
        }
        /* Individual widget card */
        .widget {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            flex: 1 1 220px;
            max-width: 600px;
            display: flex;
            flex-direction: column;
            justify-content: center;
           text-decoration: none;
            
            align-items: center;
            color: #34495e;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
            cursor: pointer;
        }
        .widget:hover {
            box-shadow: 0 15px 40px rgba(0,0,0,0.12);
            transform: translateY(-5px);
        }
        .widget .number {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-decoration: none;
        }
        .widget-books .number {
            color: #2980b9;
            
        }
        .widget-users .number {
            color: #27ae60;
            
        }
        .widget-stationery .number {
            color: #8e44ad;
            
        }
        .widget-orders .number {
            color: #e67e22;
            
        }
        .widget .label {
            font-size: 1.2rem;
            font-weight: 600;
            text-align: center;
            
        }
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
                padding-top: 50px;
            }
            .main-content {
                margin-left: 180px;
                padding: 80px 20px 20px;
            }
            .top-header {
                left: 180px;
                height: 50px;
                padding: 0 20px;
            }
            .logout-btn {
                padding: 8px 14px;
                font-size: 14px;
            }
            .widgets {
                flex-direction: column;
                max-width: 320px;
                margin: 0 auto;
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
                left: 0;
                right: 0;
            }
        }
    </style>
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
            <li><a href="AddStationery.jsp">Add Stationery</a></li>
            <li><a href="Stationery?action=list">Manage Stationery</a></li>
</li>
<li><a href="${pageContext.request.contextPath}/admin/order-history">Orders History</a></li>
            </li>
        </ul>
    </nav>

    <!-- Top Header -->
    <header class="top-header">
        <div class="welcome">Welcome Admin: <%= user.getUsername() %></div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </header>

    <!-- Main content area -->
    <main class="main-content">
        <h1>Dashboard</h1>
        <p>Welcome to Admin Panel. Here's an overview of your store.</p>

        <!-- Widgets -->
        <div class="widgets">
            <a href="Book?action=list" class="widget widget-books">
                <div class="number"><%= bookCount %></div>
                <div class="label">Total Books</div>
            </a>
            <a href="${pageContext.request.contextPath}/User?action=list" class="widget widget-users">
                <div class="number"><%= userCount %></div>
                <div class="label">Active Users</div>
            </a>
            <a href="Stationery?action=list" class="widget widget-stationery">
                <div class="number"><%= stationeryCount %></div>
                <div class="label">Stationery Items</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/order-history" class="widget widget-orders">
             <div class="number"><%= orderCount %></div>
           <div class="label">Total Orders</div>
</a>
            
           
        </div>
    </main>
</body>
</html>