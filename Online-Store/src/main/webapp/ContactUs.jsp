<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Contact Us - PahanaBook</title>
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
    .nav-links a:hover, .nav-links a.active {
        color: #f1c40f;
    }
    .search-form {
        display: flex;
        align-items: center;
        margin-left: 550px;
    }
    .search-form input {
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
        height: 190px;
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
        box-shadow: 0 -2px 8px rgba(0,0,0,0.2);
    }
</style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <form class="search-form" method="get" action="<%= request.getContextPath() %>/Search">
        <input type="text" name="query" placeholder="Search books or stationery..." required />
        <button type="submit">Search</button>
    </form>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp" class="active">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero">Contact Us</div>

<!-- Contact Section -->
<div class="contact-container">
    <div class="contact-info">
        <h2>Get in Touch</h2>
        <div class="info-item"><span>📍</span> 123 Pahana Street, Colombo, Sri Lanka</div>
        <div class="info-item"><span>📞</span> +94 76 131 0771 </div>
        <div class="info-item"><span>✉️</span> support@pahanabook.com</div>
    </div>

    <form class="contact-form" action="SendContactMessage" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required />

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required />

        <label for="message">Message:</label>
        <textarea id="message" name="message" required></textarea>

        <button type="submit">Send Message</button>
    </form>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved. Designed and Developed by Yoonus Anees.
</footer>

</body>
</html>
