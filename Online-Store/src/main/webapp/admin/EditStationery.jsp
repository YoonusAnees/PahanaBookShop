<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.pahana.bookshop.model.User" %>
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
    <title>Edit Stationery</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: #f2f2f2;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            max-width: 500px;
            margin-top: 60px;
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Stationery</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/Stationery" method="post">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="${stationery.id}" />

        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="${stationery.name}" required class="form-control" />
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="${stationery.description}" required class="form-control" />
        </div>

        <div class="form-group">
            <label for="price">Price (USD):</label>
            <input type="number" id="price" name="price" step="0.01" value="${stationery.price}" required class="form-control" />
        </div>

        <div class="form-group">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="0" 
                value="${stationery.quantity != null ? stationery.quantity : 0}" required class="form-control" />
        </div>

        <button type="submit" class="btn btn-primary btn-block">Update Stationery</button>
        <a href="${pageContext.request.contextPath}/admin/Stationery?action=list" class="btn btn-secondary btn-block mt-2">Cancel</a>
    </form>
</div>

</body>
</html>
