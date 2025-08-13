<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            position: relative;
            height: 400px;
            background-image: url('<%= request.getContextPath() %>/images/banner.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .hero-overlay {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: rgba(0,0,0,0.5);
            z-index: 1;
        }
        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 700px;
            padding: 20px;
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
            margin: 0 10px;
            display: inline-block;
        }
        .hero a:hover {
            background: #e67e22;
            color: white;
        }

        /* Featured Categories */
        .featured-categories {
            max-width: 1200px;
            margin: 50px auto;
            display: flex;
            gap: 30px;
            justify-content: center;
            text-align: center;
            padding: 0 20px;
        }
        .category-card {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .category-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .category-card h3 {
            margin: 15px 0 10px 0;
            color: #34495e;
        }
        .category-card p {
            color: #555;
            margin-bottom: 15px;
            font-size: 0.95rem;
            line-height: 1.4;
        }
        .category-card a {
            color: #f1c40f;
            font-weight: bold;
            text-decoration: none;
            font-size: 1rem;
        }
        .category-card a:hover {
            text-decoration: underline;
        }

        /* About & Contact Preview */
        .info-section {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            max-width: 1200px;
            margin: 40px auto;
            padding: 40px 30px;
        }
        .info-section h2 {
            margin-bottom: 20px;
            color: #2c3e50;
        }
        .info-section p {
            margin-bottom: 15px;
            font-size: 1rem;
            line-height: 1.5;
            color: #555;
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
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/index.jsp" class="active">Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>Welcome to PahanaBook</h1>
        <p>Your one-stop destination for books, stationery, and more.</p>
        <a href="<%= request.getContextPath() %>/Books">Browse Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Browse Stationery</a>
  <%--       <p style="color:red;">Context Path: <%= request.getContextPath() %></p> --%>
        
    </div>
</div>

<!-- Featured Categories -->
<section class="featured-categories">
    <div class="category-card">
        <img src="<c:url value='/images/books_category.jpg'/>" alt="Books">
        <h3>Books</h3>
        <p>Explore our wide range of books from various genres and authors.</p>
        <a href="<c:url value='/Books'/>">Browse Books &rarr;</a>
    </div>
    <div class="category-card">
        <img src="<c:url value='/images/CT012.jpg'/>" alt="Stationery">
        <h3>Stationery</h3>
        <p>High quality stationery products to support your daily needs.</p>
        <a href="<c:url value='/stationery'/>">Browse Stationery &rarr;</a>
    </div>
    <div class="category-card">
        <img src="<c:url value='/images/aboutUS.jpg'/>" alt="About Us">
        <h3>About Us</h3>
        <p>Learn more about PahanaBook and our mission to bring knowledge closer to you.</p>
        <a href="<c:url value='/AboutUs.jsp'/>">Read More &rarr;</a>
    </div>
</section>



<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed by Yoonus Anees.
</footer>

</body>
</html>
