<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #2c3e50;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
        }
        .navbar a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
        }
        .dashboard-container {
            padding: 20px;
        }
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        .book-card {
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
            background: #f8f8f8;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .book-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 4px;
        }
        .book-card h3 {
            margin: 10px 0 5px 0;
        }
        .book-card p {
            margin: 5px 0;
        }
        .book-card form button {
            margin-top: 10px;
            padding: 8px 12px;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .book-card form button:hover {
            background-color: #1e8449;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>Welcome, <%= user.getUsername() %> (Customer)</div>
    <div>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</div>

<div class="dashboard-container">
   
    <div class="book-grid">
        <% if (bookList != null && !bookList.isEmpty()) {
            for (Book book : bookList) { %>
                <div class="book-card">
<img src="<%= request.getContextPath() + "/" + book.getImage() %>" />
                    <h3><%= book.getTitle() %></h3>
                    <p>Author: <%= book.getAuthor() %></p>
                    <p>Price: Rs. <%= book.getPrice() %></p>
                    <form method="post" action="<%= request.getContextPath() %>/order">
                        <input type="hidden" name="bookId" value="<%= book.getId() %>" />
                        <button type="submit">Order</button>
                    </form>
                </div>
        <%  }
        } else { %>
            <p>No books available.</p>
        <% } %>
    </div>
</div>

</body>
</html>
