<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Checkout - PahanaBook</title>
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }

         /* Navbar */
        nav {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            letter-spacing: 1px;
            color: #f1c40f;
            text-decoration: none;
        }
        .nav-links {
            display: flex;
            align-items: center;
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
        
        .nav-links span {
            font-weight: bold;
        
        }
        
        .nav-links .logout:hover { color: red; }
        
        .nav-links a.active {
            color: #f1c40f;
            font-weight: bold;
        }

        /* Burger Menu */
        .burger {
            display: none;
            flex-direction: column;
            cursor: pointer;
        }
        .burger div {
            width: 25px;
            height: 3px;
            background: white;
            margin: 4px;
            transition: all 0.3s ease;
        }

        /* Mobile Menu (Centered Modal Style) */
        .nav-links.mobile {
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: rgba(44,62,80,0.95);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 999;
        }
        .nav-links.mobile a {
            margin: 15px 0;
            text-align: center;
            color: white;
            font-size: 1.3rem;
        }
        
       
        .nav-links.mobile.show {
            display: flex;
        }
        .close-btn {
            position: absolute;
            top: 20px;
            right: 25px;
            color: white;
            font-size: 2rem;
            cursor: pointer;
        }

        /* Checkout Container */
        .container {
            max-width: 500px;
            margin: 20px auto 80px auto;
            background: white;
            padding: 35px 40px;
            border-radius: 14px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #f1c40f;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1.1px;
        }

        .summary-box {
            background: #fff8e1;
            border: 2px solid #f1c40f;
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 20px;
            color: black;
            font-weight: 600;
            font-size: 1.1rem;
            text-align: center;
            box-shadow: inset 0 0 8px rgba(0,0,0,0.05);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .form-group { display: flex; flex-direction: column; }
        label {
            font-weight: 600;
            margin-bottom: 6px;
            color: #2c3e50;
            letter-spacing: 0.02em;
        }

        input[type="text"],
        input[type="email"] {
            padding: 12px 14px;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input:focus {
            border-color: #f1c40f;
            box-shadow: 0 0 6px rgba(241,196,15,0.4);
            outline: none;
        }
        input:invalid { border-color: #e74c3c; }

        .btn {
            background: #f1c40f;
            color: white;
            font-weight: 700;
            padding: 14px 0;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1.1rem;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        .btn:hover {
            background: #d4ac0d;
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(241,196,15,0.3);
        }

        /* Footer */
        footer {
            flex-shrink: 0;
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px 0;
            position: fixed;
            bottom: 0; width: 100%;
            box-shadow: 0 -3px 10px rgba(0,0,0,0.2);
            font-size: 0.9rem;
            z-index: 100;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-links { display: none; }
            .burger { display: flex; }
            .container { margin: 25px 15px 90px 15px; padding: 25px 20px; }
        }
        
        /* Loading overlay */
        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #f1c40f;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner"></div>
</div>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <div class="nav-links" id="navLinks">
        <span>Welcome, <%= user.getUsername() %>!</span>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard?show=books">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
    <div class="burger" onclick="openMenu()">
        <div></div><div></div><div></div>
    </div>
</nav>

<!-- Mobile Nav -->
<div class="nav-links mobile" id="mobileMenu">
    <div class="close-btn" onclick="closeMenu()">✖</div>
    <a>Welcome, <%= user.getUsername() %>!</a>
    <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
    <a href="<%= request.getContextPath() %>/customer/dashboard?show=books">Books</a>
    <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
    <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
    <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
</div>

<!-- Checkout Box -->
<div class="container">
    <h2>Checkout</h2>
    <div class="summary-box">
        <p><strong>Total Items:</strong> ${totalItems}</p>
        <p><strong>Total Price:</strong> Rs. ${totalPrice}</p>
    </div>

    <form action="${pageContext.request.contextPath}/OrderController" method="post" novalidate id="checkoutForm">
        <input type="hidden" name="action" value="placeOrder" />
        <input type="hidden" name="customerId" value="${user.id}" />

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input id="fullName" type="text" name="fullName" value="${user.username}" required placeholder="Enter your full name" />
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input id="email" type="email" name="email" value="${user.email}" required placeholder="example@domain.com" />
        </div>

        <div class="form-group">
            <label for="address">Shipping Address</label>
            <input id="address" type="text" name="address" required placeholder="Enter your shipping address" />
        </div>

        <button class="btn" type="submit" id="submitBtn">Confirm Order</button>
    </form>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved | Designed & Developed by Yoonus Anees.
</footer>

<script>
function openMenu() { document.getElementById("mobileMenu").classList.add("show"); }
function closeMenu() { document.getElementById("mobileMenu").classList.remove("show"); }

// Show loading overlay when form is submitted
document.getElementById('checkoutForm').addEventListener('submit', function() {
    document.getElementById('loadingOverlay').style.display = 'flex';
    document.getElementById('submitBtn').disabled = true;
});
</script>
</body>
</html>