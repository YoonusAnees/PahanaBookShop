<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Navbar Styles */
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
            text-decoration: underline;
        }

        /* Main content area - flexible and pushes footer down */
        .container {
            flex: 1 0 auto; /* grow and shrink but take minimum space */
            width: 900px;
            margin: 40px auto 60px; /* bottom margin for footer space */
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            text-align: center;
            color: #5a2a83;
            margin-bottom: 30px;
            font-weight: 700;
            letter-spacing: 1.2px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        table, th, td {
            border: 1px solid #e2dff5;
        }

        th {
            background-color: #7b3fe4; /* Pahana purple */
            color: white;
            padding: 15px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        td {
            padding: 14px 12px;
            text-align: center;
            color: #444;
            transition: background-color 0.3s ease;
        }

        tbody tr:hover {
            background-color: #f3eafd;
            cursor: pointer;
        }

        .btn {
            padding: 8px 18px;
            border-radius: 8px;
            background-color: #7b3fe4;
            color: white;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            display: inline-block;
        }

        .btn:hover {
            background-color: #5e2db3;
            box-shadow: 0 4px 12px rgba(94, 45, 179, 0.4);
        }

        .btn-danger {
            background-color: #e53935;
        }

        .btn-danger:hover {
            background-color: #b71c1c;
            box-shadow: 0 4px 12px rgba(183, 28, 28, 0.4);
        }
        
        /* Footer fixed at bottom */
        footer {
            flex-shrink: 0; /* don’t shrink */
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
        @media (max-width: 700px) {
            .container {
                margin: 40px 20px 80px; /* extra bottom space for footer */
                padding: 20px;
            }
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                display: none;
            }
            tbody tr {
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                background-color: #fff;
            }
            tbody td {
                text-align: right;
                padding-left: 50%;
                position: relative;
                border: none;
                border-bottom: 1px solid #eee;
            }
            tbody td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: 45%;
                padding-left: 15px;
                font-weight: 600;
                text-align: left;
                color: #5a2a83;
            }
            tbody td:last-child {
                border-bottom: 0;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a href="<%= request.getContextPath() %>/customer/dashboard" class="logo">PahanaBook</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="${pageContext.request.contextPath}/CartController?action=view">Cart</a>
        <a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <h2>Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <p style="text-align: center;">Your cart is empty.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td data-label="Title">${item.book.title}</td>
                        <td data-label="Author">${item.book.author}</td>
                        <td data-label="Quantity">${item.quantity}</td>
                        <td data-label="Action">
                            <a class="btn btn-danger"
                               href="${pageContext.request.contextPath}/CartController?action=remove&cartId=${item.id}&customerId=${customerId}">
                                Remove
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <br />
            <div style="text-align:center">
                <a class="btn" href="${pageContext.request.contextPath}/CartController?action=checkout&customerId=${customerId}">
                    Proceed to Checkout
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

</body>
</html>
