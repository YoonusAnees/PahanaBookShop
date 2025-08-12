<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Stationery" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }

    List<Stationery> stationeryList = (List<Stationery>) request.getAttribute("stationeryList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Customer Stationery - PahanaBook</title>
     <style>
        /* (You can reuse styles from dashboard.jsp for navbar and container) */
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0; 
            padding: 0;
            color: #333;
        }
        nav {
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            letter-spacing: 1px;
            color: #f1c40f;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .logo:hover {
            color: #e67e22;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #f1c40f;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }
        .stationery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }
        .stationery-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
        }
        .stationery-card h3 {
            color: #34495e;
            margin: 0 0 10px 0;
        }
        .stationery-card p {
            margin: 6px 0;
            color: #555;
            font-size: 0.95rem;
        }
        .stationery-card button,
        .stationery-card form button {
            margin-top: auto;
            padding: 10px 0;
            background: #7b3fe4;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .stationery-card button:hover,
        .stationery-card form button:hover {
            background: #5e2db3;
        }
        .message {
            text-align: center;
            color: #666;
            font-size: 1.2rem;
            padding: 40px 0;
        }
        footer {
            flex-shrink: 0;
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -2px 8px rgba(0,0,0,0.2);
            font-size: 0.9rem;
            z-index: 100;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/customer/dashboard">PahanaBook</a>
    <div class="nav-links">
        <span>Welcome, <%= user.getUsername() %>!</span>
    
        <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="stationery-grid">
        <% if (stationeryList == null) { %>
            <p class="message">Stationery list is not available.</p>
        <% } else if (stationeryList.isEmpty()) { %>
            <p class="message">No stationery items available.</p>
        <% } else {
            for (Stationery s : stationeryList) { %>
                <div class="stationery-card" title="<%= s.getName() %>">
                    <h3><%= s.getName() %></h3>
                    <p>Description: <%= s.getDescription() %></p>
                    <p>Price: Rs. <%= s.getPrice() %></p>

                   <form method="post" action="<%= request.getContextPath() %>/CartController">
    <input type="hidden" name="action" value="add" />
    <input type="hidden" name="stationeryId" value="<%= s.getId() %>" />
    <button type="submit">Add to Cart</button>
</form>

                </div>
        <%  }
        } %>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>
</body>
</html>