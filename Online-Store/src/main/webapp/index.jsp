<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="java.util.List" %>

<%
    List<Book> featuredBooks = (List<Book>) request.getAttribute("featuredBooks");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>PahanaBook - Online Bookstore</title>
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
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            letter-spacing: 1px;
            color: #f1c40f;
            text-decoration: none;
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


        /* Hero Section */
        .hero {
            background: linear-gradient(to right, #34495e, #2c3e50);
            color: white;
            padding: 60px 20px;
            text-align: center;
        }
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 25px;
        }
        .hero a {
            padding: 12px 25px;
            background: #f1c40f;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        .hero a:hover {
            background: #e67e22;
        }

        /* Section Styles */
        section {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 20px;
        }
        section h2 {
            margin-bottom: 20px;
            color: #2c3e50;
        }

        /* Book Grid */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        .book-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 15px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .book-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        .book-card h3 {
            margin: 10px 0;
            color: #34495e;
        }

        /* About & Contact Preview */
        .info-section {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            margin-top: 30px;
        }
        .info-section p {
            margin-bottom: 15px;
        }
        .info-section a {
            color: #7b3fe4;
            text-decoration: none;
            font-weight: bold;
        }
        .info-section a:hover {
            text-decoration: underline;
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
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/index.jsp" class="active">Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/Stationary.jsp">Stationary</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero">
    <h1>Welcome to PahanaBook</h1>
    <p>Your one-stop destination for books, stationery, and more.</p>
    <a href="<%= request.getContextPath() %>/Books">Browse Books</a>
</div>

<!-- Featured Books -->


<!-- About Us Preview -->
<section class="info-section">
    <h2>About Us</h2>
    <p>At PahanaBook, we believe books are the gateway to knowledge. We provide a vast collection of books from various genres along with high-quality stationery products.</p>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">Read More</a>
</section>

<!-- Contact Us Preview -->
<section class="info-section">
    <h2>Contact Us</h2>
    <p>Have questions or need assistance? Our friendly support team is here to help you.</p>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Get in Touch</a>
</section>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed by Yoonus Anees.
</footer>

</body>
</html>
