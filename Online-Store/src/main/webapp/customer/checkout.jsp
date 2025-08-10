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
    <title>Checkout</title>
    <style>
        /* Reset & base */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f1fa;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .checkout-container {
            max-width: 480px;
            margin: 50px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 12px 25px rgba(90, 42, 131, 0.15);
            transition: box-shadow 0.3s ease;
        }
        .checkout-container:hover {
            box-shadow: 0 16px 40px rgba(90, 42, 131, 0.25);
        }

        h2 {
            color: #5a2a83;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 700;
            letter-spacing: 1.1px;
        }

        .summary-box {
            background: #ede7f6;
            border: 2px solid #7e57c2;
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
            color: #5a2a83;
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
            border-color: #7e57c2;
            box-shadow: 0 0 8px rgba(126, 87, 194, 0.6);
        }

        input[type="text"]:invalid,
        input[type="email"]:invalid {
            border-color: #e53935;
        }

        .btn {
            background-color: #7e57c2;
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
            background-color: #5a2a83;
            box-shadow: 0 8px 16px rgba(90, 42, 131, 0.4);
        }

        @media (max-width: 520px) {
            .checkout-container {
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
<div class="checkout-container">
    <h2>Checkout</h2>
    <div class="summary-box">
        <p><strong>Total Items:</strong> ${totalItems}</p>
        <p><strong>Total Price:</strong> Rs. ${totalPrice}</p>
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
</body>
</html>
