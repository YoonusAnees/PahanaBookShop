<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="java.util.List" %>

<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>PahanaBook - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0; 
            padding: 0;
            color: #333;
        }

        /* Navbar Styles */
        nav {
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            letter-spacing: 1px;
            color: #f1c40f;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .logo:hover {
            color: #e67e22;
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

        /* Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            border-radius: 8px;
        }

        /* Book Grid */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }
        .book-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
        }
        .book-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .book-card h3 {
            color: #34495e;
            margin: 0 0 10px 0;
        }
        .book-card p {
            margin: 6px 0;
            color: #555;
            font-size: 0.95rem;
        }
        .book-card button {
            margin-top: auto;
            padding: 10px 0;
            background: #7b3fe4;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .book-card button:hover {
            background: #5e2db3;
        }
        .message {
            text-align: center;
            color: #666;
            font-size: 1.2rem;
            padding: 40px 0;
        }
        
        
        /* Footer */
        footer {
            flex-shrink: 0; /* don’t shrink */
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
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/home.jsp">PahanaBook</a>
    <div class="nav-links">
    
    
         <a href="<%= request.getContextPath() %>/">Home</a>
         <a href="<%= request.getContextPath() %>/Home" class="active">Book</a>
<a href="<%= request.getContextPath() %>/stationery">Stationery</a>
         <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
          <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
         
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
        
    </div>
</nav>

<!-- Main Content -->
<div class="container">

    <div class="book-grid">
        <% if (bookList == null) { %>
            <p class="message">Book list is not available.</p>
        <% } else if (bookList.isEmpty()) { %>
            <p class="message">No books available.</p>
        <% } else {
            for (Book book : bookList) { %>
                <div class="book-card" title="<%= book.getTitle() %> by <%= book.getAuthor() %>">
                    <img src="<%= request.getContextPath() + book.getImage() %>" alt="Book Image" />
                    <h3><%= book.getTitle() %></h3>
                    <p>Author: <%= book.getAuthor() %></p>
                    <p>Price: Rs. <%= book.getPrice() %></p>
                    <p>Quantity <%= book.getQuantity() %></p>
                    
                    <p>Category: <%= book.getCategory() %></p>
                    <button onclick="window.location.href='<%= request.getContextPath() %>/login.jsp'">Add to Cart</button>
                </div>
        <%  }
        } %>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed by Yoonus Anees.
</footer>

</body>
</html>
