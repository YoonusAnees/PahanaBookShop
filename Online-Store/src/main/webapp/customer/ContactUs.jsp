<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer Contact Us  - PahanaBook</title>
<link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />

<style>
body {
    font-family: Arial, sans-serif;
    background: #f5f5f5;
    margin: 0;
    padding: 0;
    color: #333;
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

/* Mobile Menu */
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
    margin-left: 300px;
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

/* Hero Banner */
.hero {
    background: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f') center/cover no-repeat;
    height: 350px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    text-shadow: 2px 2px 5px rgba(0,0,0,0.5);
    font-size: 2.5rem;
    font-weight: bold;
}

/* Contact Section */
.contact-container {
    max-width: 900px;
    margin: 40px auto 100px auto;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    display: flex;
    gap: 30px;
    flex-wrap: wrap;
}
.contact-info {
    flex: 1;
    min-width: 250px;
}
.contact-info h2 {
    color: #2c3e50;
    margin-bottom: 15px;
}
.info-item {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}
.info-item span {
    font-size: 1.5rem;
    margin-right: 10px;
    color: #f1c40f;
}

/* Contact Form */
.contact-form {
    flex: 1.5;
    min-width: 300px;
    display: flex;
    flex-direction: column;
    gap: 15px;
}
.contact-form label {
    font-weight: bold;
}
.contact-form input, .contact-form textarea {
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 1rem;
    transition: border 0.3s ease, box-shadow 0.3s ease;
}
.contact-form input:focus, .contact-form textarea:focus {
    border-color: #f1c40f;
    box-shadow: 0 0 5px rgba(241,196,15,0.5);
    outline: none;
}
.contact-form textarea {
    min-height: 120px;
    resize: vertical;
}
.contact-form button {
    background-color: #f1c40f;
    color: #2c3e50;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    padding: 12px;
    cursor: pointer;
    font-size: 1rem;
    transition: background 0.3s ease, transform 0.2s ease;
}
.contact-form button:hover {
    background-color: #e67e22;
    color: white;
    transform: translateY(-2px);
}

/* Success/Error message */
.msg {
    font-weight: bold;
    margin-top: 10px;
}
.msg.success {
    color: green;
}
.msg.error {
    color: red;
}

/* Change button to green when success */
button.success {
    background-color: #28a745 !important;
    color: white !important;
}

footer {
    background: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px 0;
    font-size: 0.9rem;
    box-shadow: 0 -2px 8px rgba(0,0,0,0.2);
}

/* Responsive */
@media (max-width: 768px) {
    .contact-container {
        flex-direction: column;
    }
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
        <a href="<%= request.getContextPath() %>/customer/dashboard" >Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp" class="active">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
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
        <a href="<%= request.getContextPath() %>/customer/dashboard" >Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp" class="active">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
</div>

<!-- Hero Section -->
<div class="hero">Contact Us</div>

<!-- Contact Section -->
<div class="contact-container">

    <div class="contact-info">
        <h2>Get in Touch</h2>
        <div class="info-item"><span>📍</span> 123 Pahana Street, Kandy, Sri Lanka</div>
        <div class="info-item"><span>📞</span> +94 76 131 0771 </div>
        <div class="info-item"><span>✉️</span> yoonusaneesniis@gmail.com</div>
    </div>

 <form class="contact-form" action="<%= request.getContextPath() %>/sendEmail/customer" method="post">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" 
           value="<%= user.getUsername() %>" readonly required />

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" 
           value="<%= user.getEmail() %>" readonly required />

    <label for="message">Message:</label>
    <textarea id="message" name="message" required></textarea>

    <!-- Button changes if success -->
    <c:choose>
        <c:when test="${msg eq 'success'}">
            <button type="submit" class="success">Message Sent ✅</button>
            <p class="msg success">Your message was sent successfully!</p>
        </c:when>
        <c:otherwise>
            <button type="submit">Send Message</button>
            <c:if test="${not empty msg}">
                <p class="msg error">${msg}</p>
            </c:if>
        </c:otherwise>
    </c:choose>
</form>

</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved. Designed by Yoonus Anees.
</footer>

<script>
function openMenu() {
    document.getElementById("mobileMenu").classList.add("show");
}
function closeMenu() {
    document.getElementById("mobileMenu").classList.remove("show");
}
</script>
</body>
</html>
