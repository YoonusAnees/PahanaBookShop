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
<link rel="icon" type="image/png" href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />

<style>
    /* ---- Reset & Base ---- */
    * { box-sizing: border-box; }
    body {
        font-family: Arial, sans-serif;
        background: #f9f8ff;
        margin: 0;
        color: #333;
        min-height: 100vh;
        position: relative;
        padding-bottom: 70px;
    }

    /* ---- Navbar ---- */
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
    .logo { font-size: 1.8rem; font-weight: bold; color: #f1c40f; text-decoration: none; }
    .nav-links { display: flex; align-items: center; }
    .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-weight: bold; }
    .nav-links a:hover { color: #f1c40f; }
    .nav-links span { font-weight: bold; }
    .nav-links .logout:hover { color: red; }
    .nav-links a.active { color: #f1c40f; }

    /* ---- Container ---- */
    .container {
        max-width: 1100px;
        margin: 40px auto 0;
        background: white;
        padding: 25px 35px;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(123, 63, 228, 0.15);
    }

    h2, h3 { color: #5a2a83; margin-bottom: 20px; }
    h2 { text-align: center; color: #f1c40f; }

    /* ---- Table ---- */
    table { width: 100%; border-collapse: collapse; font-size: 16px; margin-top: 20px; }
    th, td { padding: 15px 12px; border: 1px solid #e2dff5; text-align: center; }
    th { background-color: #2c3e50; color: white; }
    tr:hover { background-color: #f0eaff; }
    .total-row { font-weight: bold; background: #f9f9f9; }

    /* ---- Buttons ---- */
    .btn {
        padding: 10px 22px;
        border-radius: 10px;
        background-color: #f4d162;
        color: white;
        font-weight: 700;
        font-size: 1rem;
        text-decoration: none;
        cursor: pointer;
        border: none;
        transition: background-color 0.3s ease;
    }
    .btn:hover { background-color: #f1c41f; }
    .btn-danger { background-color: #e53935; }
    .btn-danger:hover { background-color: #b71c1c; }

    /* ---- Quantity ---- */
    .quantity-controls { display: flex; align-items: center; justify-content: center; gap: 8px; }
    .quantity-btnplus, .quantity-btnminus {
        width: 35px; height: 35px; border: none; border-radius: 6px; font-size: 18px;
        color: white; cursor: pointer; font-weight: bold;
    }
    .quantity-btnplus { background-color: #f1c41f; }
    .quantity-btnminus { background-color: #e53935; }
    .quantity-btnplus:hover { background-color: #f39c12; }
    .quantity-btnminus:hover { background-color: #b71c1c; }
    .quantity-display {
        width: 45px; height: 35px; display: flex; align-items: center; justify-content: center;
        background-color: #f8f9fa; border: 2px solid #f1c40f; border-radius: 6px;
        font-weight: bold; font-size: 16px; color: #2c3e50;
    }

    .empty-message { text-align: center; font-size: 1.25rem; color: #888; margin: 60px 0; }
    .proceed-container { text-align: center; margin-top: 40px; }

    /* ---- Footer ---- */
    footer {
        flex-shrink: 0;
        background: #2c3e50;
        color: white;
        text-align: center;
        padding: 15px 0;
        position: fixed;
        bottom: 0;
        width: 100%;
        font-size: 0.9rem;
    }
</style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <div class="nav-links">
       <span>Welcome, <%= user.getUsername() %>!</span>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard?show=books">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>" class="active">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</nav>

<div class="container">
    <h2>Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <p class="empty-message">Your cart is empty.</p>
            <div style="text-align: center;">
                <a class="btn" href="<%= request.getContextPath() %>/customer/dashboard?show=books">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Item</th>
                    <th>Author / Type</th>
                    <th>Price (Rs.)</th>
                    <th>Quantity</th>
                    <th>Subtotal (Rs.)</th>
                    <th>Action</th>
                </tr>

                <c:set var="total" value="0" />
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td><c:choose>
                                <c:when test="${item.book != null}">${item.book.title}</c:when>
                                <c:otherwise>${item.stationery.name}</c:otherwise>
                            </c:choose></td>
                        <td><c:choose>
                                <c:when test="${item.book != null}">${item.book.author}</c:when>
                                <c:otherwise>Stationery</c:otherwise>
                            </c:choose></td>
                        <td><c:choose>
                                <c:when test="${item.book != null}">Rs. ${item.book.price}</c:when>
                                <c:otherwise>Rs. ${item.stationery.price}</c:otherwise>
                            </c:choose></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/CartController" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="cartId" value="${item.id}">
                                <input type="hidden" name="customerId" value="${user.id}">
                                <input type="hidden" name="quantity" id="hidden-quantity-${item.id}" value="${item.quantity}">
                                
                                <c:set var="stock" value="${item.book != null ? item.book.quantity : item.stationery.quantity}" />
                                <c:choose>
                                    <c:when test="${stock == 0}">
                                        <span style="color:red;font-weight:bold;">Out of Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="quantity-controls">
                                            <button type="button" class="quantity-btnminus"
                                                    onclick="decreaseQuantity(${item.id}, ${stock})"
                                                    <c:if test="${item.quantity == 1}">disabled</c:if>>-</button>
                                            <div class="quantity-display" id="quantity-display-${item.id}">${item.quantity}</div>
                                            <button type="button" class="quantity-btnplus"
                                                    onclick="increaseQuantity(${item.id}, ${stock})"
                                                    <c:if test="${item.quantity >= stock}">disabled</c:if>>+</button>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </td>
                        <td><c:choose>
                                <c:when test="${item.book != null}">Rs. ${item.book.price * item.quantity}</c:when>
                                <c:otherwise>Rs. ${item.stationery.price * item.quantity}</c:otherwise>
                            </c:choose></td>
                        <td>
                            <a class="btn btn-danger" href="${pageContext.request.contextPath}/CartController?action=remove&cartId=${item.id}&customerId=${user.id}">
                                Remove
                            </a>
                        </td>
                    </tr>
                    <c:if test="${item.book != null}">
                        <c:set var="total" value="${total + (item.book.price * item.quantity)}" />
                    </c:if>
                    <c:if test="${item.stationery != null}">
                        <c:set var="total" value="${total + (item.stationery.price * item.quantity)}" />
                    </c:if>
                </c:forEach>

          
            </table>

            <div class="proceed-container">
                <a class="btn" href="${pageContext.request.contextPath}/CartController?action=checkout&customerId=${user.id}">
                    Proceed to Checkout
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

<script>
function increaseQuantity(cartId, stock) {
    const display = document.getElementById('quantity-display-' + cartId);
    const hiddenInput = document.getElementById('hidden-quantity-' + cartId);
    let currentQty = parseInt(display.textContent);
    if (currentQty < stock) {
        display.textContent = currentQty + 1;
        hiddenInput.value = currentQty + 1;
        hiddenInput.closest('form').submit();
    }
}
function decreaseQuantity(cartId, stock) {
    const display = document.getElementById('quantity-display-' + cartId);
    const hiddenInput = document.getElementById('hidden-quantity-' + cartId);
    let currentQty = parseInt(display.textContent);
    if (currentQty > 1) {
        display.textContent = currentQty - 1;
        hiddenInput.value = currentQty - 1;
        hiddenInput.closest('form').submit();
    }
}
</script>

</body>
</html>
