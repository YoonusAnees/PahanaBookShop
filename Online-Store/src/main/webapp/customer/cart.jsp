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
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f7fa;
            color: #333;
        }

        .navbar {
            background-color: #5a2a83; /* deep purple */
            color: white;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(90, 42, 131, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #d8b4fe; /* lighter purple */
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(90, 42, 131, 0.1);
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
            background-color: #7e57c2; /* medium purple */
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
            background-color: #7e57c2;
            color: white;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            display: inline-block;
        }

        .btn:hover {
            background-color: #673ab7;
            box-shadow: 0 4px 12px rgba(103, 58, 183, 0.4);
        }

        .btn-danger {
            background-color: #e53935;
        }

        .btn-danger:hover {
            background-color: #b71c1c;
            box-shadow: 0 4px 12px rgba(183, 28, 28, 0.4);
        }

        @media (max-width: 700px) {
            .container {
                margin: 20px;
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

<div class="navbar">
    <div><strong>📚 Pahana Bookshop</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
<a href="${pageContext.request.contextPath}/CartController?action=view">Cart</a>
        <a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <p>Your cart is empty.</p>
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

            <br>
            <div style="text-align:center">
                <a class="btn" href="${pageContext.request.contextPath}/CartController?action=checkout&customerId=${customerId}">
                    Proceed to Checkout
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
