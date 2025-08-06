<%@ page import="com.pahana.bookshop.model.CartItem" %>
<%@ page import="java.util.List" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        .remove-btn, .clear-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }
        .clear-btn {
            background-color: #6c757d;
        }
        .remove-btn:hover, .clear-btn:hover {
            opacity: 0.8;
        }
        .checkout-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border:none;
            border-radius: 5px;
            cursor:pointer;
            margin-top: 20px;
        }
        .checkout-btn:hover {
            background-color: #218838;
        }
        .empty-msg {
            text-align: center;
            margin-top: 40px;
            font-size: 1.2em;
            color: #555;
        }
        a {
            text-decoration: none;
            color: #007BFF;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Your Shopping Cart</h2>

<%
    if (cart.isEmpty()) {
%>
    <p class="empty-msg">Your cart is empty. <a href="CustomerDashboard">Go back to books</a></p>
<%
    } else {
%>
    <table>
        <tr>
            <th>Book</th>
            <th>Author</th>
            <th>Price (USD)</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Action</th>
        </tr>
        <%
            double grandTotal = 0;
            for (CartItem item : cart) {
                double total = item.getBook().getPrice() * item.getQuantity();
                grandTotal += total;
        %>
            <tr>
                <td><%= item.getBook().getTitle() %></td>
                <td><%= item.getBook().getAuthor() %></td>
                <td>$<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", total) %></td>
                <td>
                    <form action="CartController" method="get" style="display:inline;">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="id" value="<%= item.getBook().getId() %>">
                        <input type="submit" value="Remove" class="remove-btn">
                    </form>
                </td>
            </tr>
        <%
            }
        %>
        <tr>
            <td colspan="4" style="text-align:right; font-weight:bold;">Grand Total:</td>
            <td colspan="2" style="font-weight:bold;">$<%= String.format("%.2f", grandTotal) %></td>
        </tr>
    </table>

    <form action="CartController" method="get" style="text-align:center;">
        <input type="hidden" name="action" value="clear">
        <input type="submit" value="Clear Cart" class="clear-btn">
    </form>

    <form action="CheckoutController" method="post" style="text-align:center; margin-top: 20px;">
        <input type="submit" value="Proceed to Checkout" class="checkout-btn">
    </form>
<%
    }
%>

</body>
</html>
