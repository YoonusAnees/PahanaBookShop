<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Orders List</title>
</head>
<body>
<h2>All Orders</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Customer ID</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Order Date</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="order" items="${orders}">
        <tr>
            <td>${order.id}</td>
            <td>${order.customerId}</td>
            <td>${order.fullName}</td>
            <td>${order.email}</td>
            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.id}">View</a> |
                <a href="${pageContext.request.contextPath}/admin/orders?action=edit&id=${order.id}">Edit</a> |
                <a href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${order.id}" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
