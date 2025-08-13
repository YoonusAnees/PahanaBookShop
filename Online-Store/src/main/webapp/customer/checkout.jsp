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
    <style>
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
        
           .nav-links .logout:hover {
               color: red;
            text-decoration: none;}

        .container {
            max-width: 480px;
            margin: 50px auto;
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #f4d162;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1.1px;
        }

        .summary-box {
            background: white;
            border: 2px solid #f4d162;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
            color: #4a148c;
            font-weight: 600;
            font-size: 1.1rem;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #f4d162;
            letter-spacing: 0.03em;
        }

        input[type="text"],
        input[type="email"] {
            padding: 12px 15px;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            outline-offset: 2px;
        }
        input[type="text"]:focus,
        input[type="email"]:focus {
            border-color: #f4d162;
        }

        input[type="text"]:invalid,
        input[type="email"]:invalid {
            border-color: #e53935;
        }

        .btn {
        background-color: #f4d162;
            color: white;
            font-weight: 700;
            padding: 14px 0;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1.1rem;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
        background-color: #f1c41f;
            box-shadow: 0 8px 16px rgba(94, 45, 179, 0.4);
        }

        @media (max-width: 520px) {
            .container {
                margin: 20px;
                padding: 25px 20px;
            }
            input[type="text"],
            input[type="email"] {
                font-size: 0.95rem;
                padding: 10px 12px;
            }
            .btn {
                font-size: 1rem;
                padding: 12px 0;
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
        <a href="<%= request.getContextPath() %>/CartController?action=view">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</nav>

<div class="container">
    <h2 style="color: #f4d162">Checkout</h2>
    <div class="summary-box">
        <p style="color: black;"><strong>Total Items:</strong> ${totalItems}</p>
        <p style="color: black;"><strong>Total Price:</strong> Rs. ${totalPrice}</p>
    </div>

    <form action="${pageContext.request.contextPath}/OrderController" method="post" novalidate>
        <input type="hidden" name="action" value="placeOrder" />
        <input type="hidden" name="customerId" value="${user.id}" />

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input id="fullName" type="text" name="fullName" value="${user.username}" required
                   placeholder="Enter your full name" />
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input id="email" type="email" name="email" value="${user.email}" required
                   placeholder="example@domain.com" />
        </div>

        <div class="form-group">
            <label for="address">Shipping Address</label>
            <input id="address" type="text" name="address" required placeholder="Enter your shipping address" />
        </div>

        <button class="btn" type="submit">Confirm Order</button>
    </form>
</div>


<!-- Footer -->
<footer style="  flex-shrink: 0; /* don’t shrink */
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -2px 8px rgba(0,0,0,0.2);
            font-size: 0.9rem;
            z-index: 100;">
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed by Yoonus Anees.
</footer>
</body>
</html>
