<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.pahana.bookshop.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Shopping Cart - PahanaBook</title>

<style>
    /* Reset and base */
    * {
        box-sizing: border-box;
    }
    body {
              font-family: Arial, sans-serif;
    
        background: #f9f8ff;
        margin: 0;
        color: #333;
        min-height: 100vh;
        position: relative;
        padding-bottom: 70px; /* space for fixed footer */
    }

    /* Navbar */
      nav {
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;}
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
    nav .logo:hover {
        color: #e67e22;
    }
    nav .nav-links {
        display: flex;
        align-items: center;
        gap: 20px;
        font-weight: 600;
    }
    nav .nav-links a {
        color: white;
        text-decoration: none;
        font-size: 1rem;
        transition: color 0.3s ease;
    }
    nav .nav-links a:hover {
        color: #f1c40f;
    }
    nav .nav-links span {
        font-weight: 700;
        margin-right: 10px;
    }

    /* Container */
    .container {
        max-width: 1100px;
        margin: 40px auto 0;
        background: white;
        padding: 25px 35px;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(123, 63, 228, 0.15);
        /* No need extra bottom padding here since body has it */
    }

    /* Headings */
    h2, h3 {
        color: #5a2a83;
        margin-bottom: 20px;
    }
    h3 {
        margin-top: 40px;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 16px;
    }
    th, td {
        padding: 15px 12px;
        border: 1px solid #e2dff5;
        text-align: center;
        vertical-align: middle;
    }
    th {
        background-color: #7b3fe4;
        color: white;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    td {
        color: #555;
    }
    tr:hover {
        background-color: #f0eaff;
    }

    /* Buttons */
    .btn {
        display: inline-block;
        padding: 10px 22px;
        border-radius: 10px;
        background-color: #7b3fe4;
        color: white;
        font-weight: 700;
        font-size: 1rem;
        text-decoration: none;
        cursor: pointer;
        border: none;
        transition: background-color 0.3s ease;
    }
    .btn:hover {
        background-color: #5e2db3;
    }
    .btn-danger {
        background-color: #e53935;
    }
    .btn-danger:hover {
        background-color: #b71c1c;
    }

    /* Empty cart */
    .empty-message {
        text-align: center;
        font-size: 1.25rem;
        color: #888;
        margin: 60px 0;
    }

    /* Proceed button container */
    .proceed-container {
        text-align: center;
        margin-top: 40px;
    }

    /* Footer - FIXED at bottom */
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

    /* Responsive */
    @media (max-width: 720px) {
        nav {
            flex-direction: column;
            gap: 10px;
        }
        .container {
            margin: 20px 15px 0;
            padding: 20px;
        }
        table, th, td {
            font-size: 14px;
        }
        .btn {
            font-size: 0.9rem;
            padding: 8px 18px;
        }
    }
</style>

</head>
<body>

<nav>
    <a href="<%= request.getContextPath() %>/customer/dashboard" class="logo">PahanaBook</a>
    <div class="nav-links">
        <span>Welcome, <%= user.getUsername() %>!</span>
                <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
        
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</nav>

<div class="container">
    <h2>Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <p class="empty-message">Your cart is empty.</p>
        </c:when>
        <c:otherwise>
            <!-- Determine if cart has books or stationery -->
            <c:set var="hasBooks" value="false" />
            <c:set var="hasStationery" value="false" />
            <c:forEach var="item" items="${cartItems}">
                <c:if test="${item.book != null}">
                    <c:set var="hasBooks" value="true" />
                </c:if>
                <c:if test="${item.stationery != null}">
                    <c:set var="hasStationery" value="true" />
                </c:if>
            </c:forEach>

            <!-- Books Table -->
            <c:if test="${hasBooks}">
                <h3>Books</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Quantity</th>
                            <th>Price per Item</th>
                            <th>Subtotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <c:if test="${item.book != null}">
                                <tr>
                                    <td>${item.book.title}</td>
                                    <td>${item.book.author}</td>
                                    <td>${item.quantity}</td>
                                    <td>$${item.book.price}</td>
                                    <td>$${item.book.price * item.quantity}</td>
                                    <td>
                                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/CartController?action=remove&cartId=${item.id}&customerId=${user.id}">
                                            Remove
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <!-- Stationery Table -->
            <c:if test="${hasStationery}">
                <h3>Stationery</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Price per Item</th>
                            <th>Subtotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <c:if test="${item.stationery != null}">
                                <tr>
                                    <td>${item.stationery.name}</td>
                                    <td>${item.quantity}</td>
                                    <td>$${item.stationery.price}</td>
                                    <td>$${item.stationery.price * item.quantity}</td>
                                    <td>
                                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/CartController?action=remove&cartId=${item.id}&customerId=${user.id}">
                                            Remove
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <div class="proceed-container">
                <a class="btn" href="${pageContext.request.contextPath}/CartController?action=checkout&customerId=${user.id}">
                    Proceed to Checkout
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer class="footer">
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed By Yoonus Anees.
</footer>

</body>
</html>
