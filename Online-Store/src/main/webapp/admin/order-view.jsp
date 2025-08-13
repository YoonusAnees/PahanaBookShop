<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.pahana.bookshop.model.OrderItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    com.pahana.bookshop.model.Order order = (com.pahana.bookshop.model.Order) request.getAttribute("order");
%>

<html>
<head>
    <title>View Order #<%= order.getId() %></title>
</head>
<body>
    <h2>Order #<%= order.getId() %></h2>
    <p><b>Customer ID:</b> <%= order.getCustomerId() %></p>
    <p><b>Full Name:</b> <%= order.getFullName() %></p>
    <p><b>Email:</b> <%= order.getEmail() %></p>
    <p><b>Address:</b> <%= order.getAddress() %></p>
    <p><b>Order Date:</b> <%= order.getOrderDate() %></p>

    <h3>Order Items</h3>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Type</th>
            <th>Item ID</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <%
            for (OrderItem item : order.getItems()) {
                String type = (item.getBookId() != null) ? "Book" : "Stationery";
                int itemId = (item.getBookId() != null) ? item.getBookId() : item.getStationeryId();
        %>
        <tr>
            <td><%= type %></td>
            <td><%= itemId %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getPrice() %></td>
        </tr>
        <%
            }
        %>
    </table>

    <p><a href="<%= request.getContextPath() %>/admin/orders">Back to Orders</a></p>
</body>
</html>
