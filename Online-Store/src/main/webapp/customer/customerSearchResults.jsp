<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.model.Book" %>



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
    <meta charset="UTF-8">
    <title>Search Results - PahanaBook</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }

        nav {
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
        }
        
          /* Search Form */
        .search-form {
            display: flex;
            align-items: center;
            margin-left: 590px;
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

        .logo
         { font-size: 1.5rem; 
         font-weight: bold;
          color: #f1c40f; 
          text-decoration: none; }
          
        .nav-links a { 
        color: white;
         margin-left: 20px;
          font-weight: bold;
          text-decoration: none; }
          
        .nav-links a:hover, .nav-links a.active
         { color: #f1c40f; }

        .container { max-width: 1200px;
         margin: 30px auto;
          padding: 20px; }
        h2 
        { color: #2c3e50; }
        
        h3 { margin-top: 40px; margin-bottom: 15px; color: #34495e; border-bottom: 2px solid #f1c40f; padding-bottom: 5px; }

        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 25px; }
        .card { background: white; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); padding: 15px; text-align: center; display: flex; flex-direction: column; }
        .card img { width: 100%; height: 200px; object-fit: cover; border-radius: 10px; margin-bottom: 15px; }
        .card h4 { margin: 5px 0; color: #34495e; }
        .card p { margin: 4px 0; color: #555; font-size: 0.95rem; }
        .card button { margin-top: auto; padding: 10px 0; background: #f4d162; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; width: 100%; transition: background 0.3s; }
        .card button:hover { background: #f1c41f; }

        .message { text-align: center; color: #666; font-size: 1.2rem; padding: 20px 0; }
        footer {
    background: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px 0;
    font-size: 0.9rem;
    position: fixed;
    bottom: 0;
    width: 100%;
}

    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a href="<%= request.getContextPath() %>/customer/dashboard" class="logo">PahanaBook</a>
      <!-- Search Form -->
        <form class="search-form" method="get" action="<%= request.getContextPath() %>/customer/Search">
            <input type="text" name="query" placeholder="Search books or stationery..." required />
            <button type="submit">Search</button>
        </form>
    <div class="nav-links">
        <span>Welcome, <%= user.getUsername() %>!</span>
                <a href="<%= request.getContextPath() %>/customer/dashboard">Home</a>
        
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</nav>

<div class="container">
    <h2>Search results for: "<c:out value='${searchQuery}'/>"</h2>

    <!-- Books -->
    <h3>Books</h3>
    <c:choose>
        <c:when test="${empty bookResults}">
            <p class="message">No books found for "<c:out value='${searchQuery}'/>".</p>
        </c:when>
        <c:otherwise>
            <div class="grid">
                <c:forEach var="book" items="${bookResults}">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}${book.image}" alt="${book.title}" />
                        <h4><c:out value="${book.title}"/></h4>
                        <p>Author: <c:out value="${book.author}"/></p>
                        <p>Price: Rs. <c:out value="${book.price}"/></p>
                        <p>Quantity: <c:out value="${book.quantity}"/></p>
                        <p>Category: <c:out value="${book.category}"/></p>
  <div class="card-actions">
                       <form method="post" action="${pageContext.request.contextPath}/CartController">
    <input type="hidden" name="action" value="add" />
    <input type="hidden" name="bookId" value="${book.id}" />
    <button type="submit">Add to Cart</button>
</form>

                    </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Stationery -->
    <h3>Stationery</h3>
    <c:choose>
        <c:when test="${empty stationeryResults}">
            <p class="message">No stationery items found for "<c:out value='${searchQuery}'/>".</p>
        </c:when>
        <c:otherwise>
            <div class="grid">
                <c:forEach var="s" items="${stationeryResults}">
                    <div class="card">
                        <h4><c:out value="${s.name}"/></h4>
                        <p><c:out value="${s.description}"/></p>
                        <p>Price: Rs. <c:out value="${s.price}"/></p>
                        <p>Quantity: <c:out value="${s.quantity}"/></p>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/login.jsp'">Add to Cart</button>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

</body>
</html>
