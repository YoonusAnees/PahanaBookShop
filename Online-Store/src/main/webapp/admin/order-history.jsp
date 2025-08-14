<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Admin - Order History</title>
    <style>
        /* Base Styles */
        * { box-sizing: border-box; }
        body, html { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #333; }

        /* Sidebar */
        .sidebar {
            position: fixed; top: 0; left: 0; width: 220px; height: 100%;
            background: linear-gradient(180deg, #34495e, #2c3e50);
            padding-top: 60px; box-shadow: 3px 0 12px rgba(0,0,0,0.15);
        }
        .sidebar h2 { color: #ecf0f1; text-align: center; font-weight: 600; font-size: 24px; margin-bottom: 10px; border-bottom: 1px solid rgba(236,240,241,0.15); padding-bottom: 12px; }
        .sidebar ul { list-style: none; padding: 0; margin: 0; }
        .sidebar ul li a { display: block; padding: 16px 24px; color: #bdc3c7; font-weight: 500; text-decoration: none; border-left: 5px solid transparent; transition: all 0.3s ease; font-size: 17px; }
        .sidebar ul li a:hover, .sidebar ul li a.active { color: #ecf0f1; background: rgba(255,255,255,0.1); border-left: 5px solid #f39c12; font-weight: 700; }

        .logo { font-weight: 500; font-size: 28px; color: #f1c40f; margin-left: 20px; text-decoration: none; text-shadow: 1px 1px 2px rgba(0,0,0,0.2); display: block; padding-bottom: 15px; }
        .logo:hover { color: #e67e22; }

        /* Top Header */
        .top-header {
            position: fixed; left: 220px; top: 0; right: 0; height: 80px; background-color: #34495e; color: #ecf0f1;
            display: flex; align-items: center; justify-content: space-between; padding: 0 30px; box-shadow: 0 3px 8px rgba(0,0,0,0.15); font-size: 18px; font-weight: 600; z-index: 1000;
        }
        .logout-btn { background-color: #e74c3c; color: white; padding: 10px 18px; border-radius: 8px; font-weight: 700; text-decoration: none; box-shadow: 0 4px 9px rgba(231, 76, 60, 0.6); transition: 0.3s ease; }
        .logout-btn:hover { background-color: #c0392b; }

        /* Main Content */
        .main-content { margin-left: 220px; padding: 50px 40px 40px; min-height: 100vh; }

        /* Container */
        .table-container {
            max-width: 1100px; margin: auto;  padding: 30px 40px; border-radius: 12px; 
        }

        h1 { text-align: center; margin-bottom: 20px; color: #34495e; }

        /* Search bar */
        #searchBar {
            width: 100%; padding: 12px 20px; margin-bottom: 25px; font-size: 16px; border: 1px solid #ccc; border-radius: 8px;
        }

        /* Customer Header */
        h2.customer-heading {
            background: #2980b9; color: #fff; padding: 12px 20px; border-radius: 8px; margin-top: 30px; margin-bottom: 10px;
        }
        p.customer-info { margin: 0 0 15px 5px; font-size: 14px; color: #555; }

        /* Table Styling */
        table {
            width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 8px 16px rgba(0,0,0,0.05); margin-bottom: 25px;
        }
        thead { background-color: #2980b9; color: #fff; }
        thead th { padding: 14px 18px; text-align: left; font-weight: 700; }
        tbody tr { border-bottom: 1px solid #ddd; transition: 0.3s ease; }
        tbody tr:hover { background-color: #f0f8ff; }
        tbody td { padding: 14px 18px; vertical-align: middle; }

        /* Responsive Table */
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr { display: block; }
            thead tr { position: absolute; top: -9999px; left: -9999px; }
            tbody td { padding-left: 50%; position: relative; border-bottom: 1px solid #eee; }
            tbody td::before { position: absolute; top: 14px; left: 18px; font-weight: bold; color: #2980b9; content: attr(data-label); width: 45%; }
        }
    </style>
    <script>
        function searchCustomer() {
            var input = document.getElementById("searchBar");
            var filter = input.value.toLowerCase();
            var customers = document.getElementsByClassName("customer-section");

            for (var i = 0; i < customers.length; i++) {
                var name = customers[i].getAttribute("data-customer-name").toLowerCase();
                if (name.indexOf(filter) > -1) {
                    customers[i].style.display = "";
                } else {
                    customers[i].style.display = "none";
                }
            }
        }
    </script>
</head>
<body>

<!-- Sidebar -->
<nav class="sidebar">
    <a class="logo" href="<%= request.getContextPath() %>/admin/dashboard.jsp">PahanaBook</a>
    <h2>Admin Panel</h2>
    <ul>
      <li><a href="AddBook.jsp">Add Book</a></li>
            <li><a href="Book?action=list">Manage Books</a></li>
            <li><a href="${pageContext.request.contextPath}/User?action=list">Manage Users</a></li>
            <li><a href="AddStationery.jsp">Add Stationery</a></li>
            <li><a href="Stationery?action=list">Manage Stationery</a></li>
</li>
<li><a href="${pageContext.request.contextPath}/admin/order-history" class="active">Orders History</a></li>
    </ul>
</nav>

<!-- Top Header -->
<header class="top-header">
    <div>Welcome Admin: <%= user.getUsername() %></div>
    <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
</header>

<!-- Main Content -->
<main class="main-content">
    <div class="table-container">
        <h1>Order History</h1>

        <!-- Search Bar -->
        <input type="text" id="searchBar" onkeyup="searchCustomer()" placeholder="Search by customer name...">

        <c:set var="lastCustomer" value="" />
        <c:forEach var="order" items="${orders}">
            <c:if test="${lastCustomer ne order.fullName}">
                <!-- Close previous table if not first customer -->
                <c:if test="${lastCustomer ne ''}">
                    </tbody>
                    </table>
                </c:if>

                <!-- Customer section -->
                <div class="customer-section" data-customer-name="${order.fullName}">
                    <h2 class="customer-heading">Customer: ${order.fullName}</h2>
                    <p class="customer-info">Email: ${order.email} | Address: ${order.address}</p>

                    <!-- Start table for this customer -->
                    <table>
                        <thead>
                            <tr>
                                <th>Item Type</th>
                                <th>Title / Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Order Date</th>
                            </tr>
                        </thead>
                        <tbody>
                <c:set var="lastCustomer" value="${order.fullName}" />
            </c:if>

            <!-- Items -->
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td data-label="Item Type">
                        <c:choose>
                            <c:when test="${item.book != null}">Book</c:when>
                            <c:otherwise>Stationery</c:otherwise>
                        </c:choose>
                    </td>
                    <td data-label="Title / Name">
                        <c:choose>
                            <c:when test="${item.book != null}">${item.book.title}</c:when>
                            <c:otherwise>${item.stationery.name}</c:otherwise>
                        </c:choose>
                    </td>
                    <td data-label="Quantity">${item.quantity}</td>
                    <td data-label="Price">${item.price}</td>
                    <td data-label="Order Date">${order.orderDate}</td>
                </tr>
            </c:forEach>
        </c:forEach>

        <!-- Close last table -->
        </tbody>
        </table>
    </div>
</main>

</body>
</html>
