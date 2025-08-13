<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Customer Dashboard - PahanaBook</title>
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
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
         /* Search Form */
        .search-form {
            display: flex;
            align-items: center;
            margin-left: 550px;
        }
        .search-form input[type="text"] {
            padding: 6px 10px;
            border-radius: 4px;
            border: none;
            font-size: 1rem;
        }
        .search-form button {
            padding: 6px 12px;
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
        
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #f1c40f;
            text-decoration: none;
        }
        .logo:hover { color: #e67e22; }
        .nav-links a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }
        .nav-links a:hover { color: #f1c40f; }
        .nav-links .logout:hover { color: red; }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
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

        /* Form container to push button to bottom */
        .card-content {
            flex: 1 0 auto;
        }
        .card-actions {
            margin-top: 10px;
        }

        /* Add to Cart Button */
        .book-card button {
            padding: 10px;
            width: 100%;
            background-color: #f4d162;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        .book-card button:hover {
            background-color: #f1c41f;
            transform: translateY(-2px);
        }
        .book-card button:active {
            background-color: #e0b90f;
            transform: translateY(0);
        }

        /* Message */
        .message {
            text-align: center;
            color: #666;
            font-size: 1.2rem;
            padding: 40px 0;
        }

        /* Footer */
        footer {
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
    <a class="logo" href="<%= request.getContextPath() %>/customer/dashboard">PahanaBook</a>
    <!-- Search Form -->
        <form class="search-form" method="get" action="<%= request.getContextPath() %>/Search">
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

<!-- Main Content -->
<div class="container">
    <div class="book-grid">
        <% if (bookList == null) { %>
            <p class="message">Book list is not available.</p>
        <% } else if (bookList.isEmpty()) { %>
            <p class="message">No books available.</p>
        <% } else {
            for (Book book : bookList) { %>
                <div class="book-card">
                    <div class="card-content">
                        <img src="<%= request.getContextPath() + book.getImage() %>" alt="<%= book.getTitle() %>" />
                        <h3><%= book.getTitle() %></h3>
                        <p><strong>Author:</strong> <%= book.getAuthor() %></p>
                        <p><strong>Price:</strong> Rs. <%= book.getPrice() %></p>
                        <p><strong>Category:</strong> <%= book.getCategory() %></p>
                        <p><strong>Quantity:</strong> <%= book.getQuantity() %></p>
                    </div>
                    <div class="card-actions">
                        <form method="post" action="<%= request.getContextPath() %>/CartController">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="bookId" value="<%= book.getId() %>" />
                            <button type="submit">Add to Cart</button>
                        </form>
                    </div>
                </div>
        <%  }
        } %>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

</body>
</html>
