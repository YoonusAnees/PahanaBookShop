<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Customer Dashboard</title>
    <style>
        /* Reset & Base */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f7fa;
            color: #333;
        }

        /* Navbar */
        .navbar {
            background-color: #4b2c91; /* Deep purple */
            color: #fff;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 8px rgba(75, 44, 145, 0.5);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar div:first-child {
            font-weight: 700;
            font-size: 1.2rem;
        }
        .navbar a {
            color: #ddd;
            margin-left: 20px;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .navbar a:hover {
            color: #fff;
            text-shadow: 0 0 8px #d1b3ff;
        }

        /* Container */
        .dashboard-container {
            padding: 30px 40px;
            max-width: 1200px;
            margin: auto;
        }

        /* Book Grid */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }

        /* Book Card */
        .book-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(75, 44, 145, 0.15);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: default;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }
        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(75, 44, 145, 0.3);
            cursor: pointer;
        }
        .book-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
            box-shadow: 0 4px 8px rgba(75, 44, 145, 0.1);
        }
        .book-card h3 {
            font-size: 1.15rem;
            margin: 0 0 10px 0;
            color: #4b2c91;
            min-height: 48px; /* keep cards uniform */
        }
        .book-card p {
            margin: 6px 0;
            font-size: 0.95rem;
            color: #555;
        }

        /* Button */
        .book-card form button {
            margin-top: auto;
            padding: 12px 0;
            background-color: #7b3fe4;
            color: white;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 12px rgba(123, 63, 228, 0.5);
        }
        .book-card form button:hover {
            background-color: #5e2db3;
            box-shadow: 0 6px 18px rgba(94, 45, 179, 0.7);
        }

        /* Responsive */
        @media (max-width: 600px) {
            .dashboard-container {
                padding: 20px 15px;
            }
            .navbar {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .navbar div:first-child {
                margin-bottom: 5px;
            }
            .navbar a {
                margin-left: 0;
                margin-right: 15px;
            }
            .book-card img {
                height: 160px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>Welcome, <%= user.getUsername() %> (Customer)</div>
    <div>
        <a href="<%= request.getContextPath() %>/customer/dashboard">Books</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
</div>

<div class="dashboard-container">
    <div class="book-grid">
        <% if (bookList != null && !bookList.isEmpty()) {
            for (Book book : bookList) { %>
                <div class="book-card" title="<%= book.getTitle() %> by <%= book.getAuthor() %>">
                    <img src="<%= request.getContextPath() + "/" + book.getImage() %>" alt="Book Image" />
                    <h3><%= book.getTitle() %></h3>
                    <p>Author: <%= book.getAuthor() %></p>
                    <p>Price: Rs. <%= book.getPrice() %></p>
                    <form method="post" action="<%= request.getContextPath() %>/CartController">
                        <input type="hidden" name="action" value="add" />
                        <input type="hidden" name="bookId" value="<%= book.getId() %>" />
                        <button type="submit">Add to Cart</button>
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
