<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>About Us - PahanaBook</title>
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

        /* Main Content */
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #2c3e50;
        }
        p {
            line-height: 1.6;
            margin-bottom: 15px;
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
        <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/Stationary.jsp">Stationary</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp" class="active">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <h1>About Us</h1>
    <h2>Welcome to PahanaBook</h2>
    <p>
        At PahanaBook, we believe books are the gateway to knowledge and imagination. Since our inception, we have proudly served book lovers, students, and professionals with a wide variety of books from classics to the latest bestsellers.
    </p>
    <p>
        Our passion extends beyond books; we also provide top-quality stationery products to meet all your academic and office needs.
    </p>
    <p>
        We strive to offer excellent customer service and a friendly shopping experience, whether you visit us online or in-store.
    </p>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed by Yoonus Anees.
</footer>

</body>
</html>
