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
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />


<style>
    /* Reset and base */
    * {
        box-sizing: border-box;
    }
    body {
        font-family: Arial, sans-serif;
        background: #f9f8ff;
        margin: 0;
        color: #333;
        min-height: 100vh;
        position: relative;
        padding-bottom: 70px;
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


        /* Search Form */
        .search-form {
            display: flex;
            align-items: center;
            margin-left: 320px;
        }
        .search-form input[type="text"] {
            padding: 8px 10px;
            border-radius: 4px;
            border: none;
            font-size: 1rem;
        }
        .search-form button {
            padding: 9px 12px;
            margin-left: 5px;
            border: none;
            border-radius: 4px;
            background-color: #f1c40f;
            color: #2c3e50;
            font-weight: bold;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #e67e22;
            color: white;
        }

    /* Container */
    .container {
        max-width: 1100px;
        margin: 40px auto 0;
        background: white;
        padding: 25px 35px;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(123, 63, 228, 0.15);
    }

    /* Headings */
    h2, h3 {
        color: #5a2a83;
        margin-bottom: 20px;
    }
    h3 {
        margin-top: 40px;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 16px;
    }
    th, td {
        padding: 15px 12px;
        border: 1px solid #e2dff5;
        text-align: center;
        vertical-align: middle;
    }
    th {
        background-color: #2c3e50;
        color: white;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    td {
        color: #555;
    }
    tr:hover {
        background-color: #f0eaff;
    }

    /* Buttons */
    .btn {
        display: inline-block;
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
    .btn:hover {
        background-color: #f1c41f;
    }
    .btn-danger {
        background-color: #e53935;
    }
    .btn-danger:hover {
        background-color: #b71c1c;
    }

    /* Empty cart */
    .empty-message {
        text-align: center;
        font-size: 1.25rem;
        color: #888;
        margin: 60px 0;
    }
    
    /* Quantity Controls - UPDATED */
    .quantity-controls {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 5px 0;
    }

    .quantity-btnplus {
        width: 35px;
        height: 35px;
        border: none;
        border-radius: 6px;
        background-color: #f1c41f;
        color: white;
        font-weight: bold;
        cursor: pointer;
        font-size: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s ease, transform 0.1s ease;
    }
    
      .quantity-btnminus {
        width: 35px;
        height: 35px;
        border: none;
        border-radius: 6px;
        background-color: #e53935;
        color: white;
        font-weight: bold;
        cursor: pointer;
        font-size: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s ease, transform 0.1s ease;
    }

    .quantity-btnplus:hover {
        background-color: #f1c41f;
        transform: scale(1.05);
    }
    
       .quantity-btnminus:hover {
        background-color: #b71c1c;
        transform: scale(1.05);
    }

    .quantity-btn:disabled {
        background-color: #cccccc;
        cursor: not-allowed;
    }

    .quantity-display {
        width: 45px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f8f9fa;
        border: 2px solid #f1c40f;
        border-radius: 6px;
        font-weight: bold;
        font-size: 16px;
        color: #2c3e50;
    }

    /* Proceed button container */
    .proceed-container {
        text-align: center;
        margin-top: 40px;
    }

    /* Footer */
    footer {
        flex-shrink: 0;
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
    @media (max-width: 720px) {
        nav {
            flex-direction: column;
            gap: 10px;
        }
        .container {
            margin: 20px 15px 0;
            padding: 20px;
        }
        table, th, td {
            font-size: 14px;
        }
        .btn {
            font-size: 0.9rem;
            padding: 8px 18px;
        }
        .quantity-controls {
            flex-direction: column;
            gap: 5px;
        }
        .quantity-btn, .quantity-display {
            width: 30px;
            height: 30px;
            font-size: 14px;
        }
    }
    
    @media (max-width: 768px) {
        .search-form {
            display: none;
        }
        .nav-links {
            display: none;
        }
        .burger {
            display: flex;
        }
    }
    
    /* Responsive */
    @media (max-width: 1024px) {
        .search-form { margin-left: 100px; }
    }
    @media (max-width: 768px) {
        .search-form { display: none; }
        .nav-links { display: none; }
        .burger { display: flex; }
        table, th, td { font-size: 14px; }
        .container { margin: 20px 10px; padding: 15px; }
    }
    @media (max-width: 480px) {
        .logo { font-size: 1.4rem; }
        .btn { font-size: 0.8rem; padding: 7px 14px; }
        .quantity-controls { flex-direction: column; gap: 5px; }
        .quantity-display, .quantity-btnplus, .quantity-btnminus {
            width: 30px; height: 30px; font-size: 14px;
        }
    }
</style>

</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <form class="search-form" method="get" action="<%= request.getContextPath() %>/customer/Search">
        <input type="text" name="query" placeholder="Search books or stationery..." required />
        <button type="submit">Search</button>
    </form>
    <div class="nav-links" id="navLinks">
       <span>Welcome, <%= user.getUsername() %>!</span>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard?show=books">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>" class="active">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
    <div class="burger" onclick="openMenu()">
        <div></div>
        <div></div>
        <div></div>
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

<div class="container">
    <h2 style="color: #f1c40f">Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <p class="empty-message">Your cart is empty.</p>
            <div style="text-align: center; margin-top: 30px;">
                <a class="btn" href="<%= request.getContextPath() %>/customer/dashboard?show=books">
                    Start Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Determine if cart has books or stationery -->
            <c:set var="hasBooks" value="false" />
            <c:set var="hasStationery" value="false" />
            <c:forEach var="item" items="${cartItems}">
                <c:if test="${item.book != null}">
                    <c:set var="hasBooks" value="true" />
                </c:if>
                <c:if test="${item.stationery != null}">
                    <c:set var="hasStationery" value="true" />
                </c:if>
            </c:forEach>

            <!-- Books Table -->
            <c:if test="${hasBooks}">
                <h3 style="color: #f1c40f">Books</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Quantity</th>
                            <th>Price per Item</th>
                            <th>Subtotal</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <c:if test="${item.book != null}">
                                <tr>
                                    <td>${item.book.title}</td>
                                    <td>${item.book.author}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/CartController" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartId" value="${item.id}">
                                            <input type="hidden" name="customerId" value="${user.id}">
                                            <input type="hidden" name="quantity" id="hidden-quantity-${item.id}" value="${item.quantity}">
                                            <div class="quantity-controls">
                                                <button type="button" class="quantity-btnminus" onclick="decreaseQuantity(${item.id})">-</button>
                                                <div class="quantity-display" id="quantity-display-${item.id}">${item.quantity}</div>
                                                <button type="button" class="quantity-btnplus" onclick="increaseQuantity(${item.id})">+</button>
                                            </div>
                                        </form>
                                    </td>
                                    <td>Rs. ${item.book.price}</td>
                                    <td>Rs. ${item.book.price * item.quantity}</td>
                                    <td>
                                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/CartController?action=remove&cartId=${item.id}&customerId=${user.id}">
                                            Remove
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <!-- Stationery Table -->
            <c:if test="${hasStationery}">
                <h3 style="color: #f1c40f">Stationery</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Price per Item</th>
                            <th>Subtotal</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <c:if test="${item.stationery != null}">
                                <tr>
                                    <td>${item.stationery.name}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/CartController" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartId" value="${item.id}">
                                            <input type="hidden" name="customerId" value="${user.id}">
                                            <input type="hidden" name="quantity" id="hidden-quantity-${item.id}" value="${item.quantity}">
                                            <div class="quantity-controls">
                                                <button type="button" class="quantity-btn" onclick="decreaseQuantity(${item.id})">-</button>
                                                <div class="quantity-display" id="quantity-display-${item.id}">${item.quantity}</div>
                                                <button type="button" class="quantity-btn" onclick="increaseQuantity(${item.id})">+</button>
                                            </div>
                                        </form>
                                    </td>
                                    <td>Rs. ${item.stationery.price}</td>
                                    <td>Rs. ${item.stationery.price * item.quantity}</td>
                                    <td>
                                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/CartController?action=remove&cartId=${item.id}&customerId=${user.id}">
                                            Remove
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

           

            <div class="proceed-container">
                <a class="btn" href="${pageContext.request.contextPath}/CartController?action=checkout&customerId=${user.id}">
                    Proceed to Checkout
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer class="footer">
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed By Yoonus Anees.
</footer>

<script>
function openMenu() {
    document.getElementById("mobileMenu").classList.add("show");
}

function closeMenu() {
    document.getElementById("mobileMenu").classList.remove("show");
}

// Quantity control functions
function increaseQuantity(cartId) {
    const display = document.getElementById('quantity-display-' + cartId);
    const hiddenInput = document.getElementById('hidden-quantity-' + cartId);
    const currentQty = parseInt(display.textContent);
    
    display.textContent = currentQty + 1;
    hiddenInput.value = currentQty + 1;
    
    // Submit the form
    const form = display.closest('form');
    form.submit();
}

function decreaseQuantity(cartId) {
    const display = document.getElementById('quantity-display-' + cartId);
    const hiddenInput = document.getElementById('hidden-quantity-' + cartId);
    const currentQty = parseInt(display.textContent);
    
    if (currentQty > 1) {
        display.textContent = currentQty - 1;
        hiddenInput.value = currentQty - 1;
        
        // Submit the form
        const form = display.closest('form');
        form.submit();
    }
}
</script>
</body>
</html>