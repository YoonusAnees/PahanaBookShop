<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Stationery" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
  

    List<Stationery> stationeryList = (List<Stationery>) request.getAttribute("stationeryList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>PahanaBook - Stationery </title>
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

        /* Mobile Menu (Centered Modal Style) */
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
            margin-left: 450px;
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
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }
        .stationery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }
        .stationery-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
        }
        .stationery-card h3 {
            color: #34495e;
            margin: 0 0 10px 0;
        }
        .stationery-card p {
            margin: 6px 0;
            color: #555;
            font-size: 0.95rem;
        }
        .stationery-card button,
        .stationery-card form button {
            margin-top: auto;
            padding: 10px 0;
            background: #f4d162;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .stationery-card button:hover,
        .stationery-card form button:hover {
            background: #f1c41f;
        }
        .message {
            text-align: center;
            color: #666;
            font-size: 1.2rem;
            padding: 40px 0;
        }
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
        
             /* Responsive */
        @media (max-width: 768px) {
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
    <form class="search-form" method="get" action="<%= request.getContextPath() %>/Search">
        <input type="text" name="query" placeholder="Search books or stationery..." required />
        <button type="submit">Search</button>
    </form>
    <div class="nav-links" id="navLinks">
        <a href="<%= request.getContextPath() %>/index.jsp" >Home</a>
        <a href="<%= request.getContextPath() %>/Books" >Books</a>
        <a href="<%= request.getContextPath() %>/stationery" class="active">Stationery</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
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
    <a href="<%= request.getContextPath() %>/index.jsp" >Home</a>
    <a href="<%= request.getContextPath() %>/Books" >Books</a>
    <a href="<%= request.getContextPath() %>/stationery" class="active">Stationery</a>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
</div>

<!-- Main Content -->
<div class="container">
    <div class="stationery-grid">
        <% if (stationeryList == null) { %>
            <p class="message">Stationery list is not available.</p>
        <% } else if (stationeryList.isEmpty()) { %>
            <p class="message">No stationery items available.</p>
        <% } else {
            for (Stationery s : stationeryList) { %>
                <div class="stationery-card" title="<%= s.getName() %>">
                    <h3><%= s.getName() %></h3>
                    <p>Description: <%= s.getDescription() %></p>
                    <p>Price: Rs. <%= s.getPrice() %></p>
                    <p>Quantity <%= s.getQuantity() %></p>
                    
           <button onclick="window.location.href='<%= request.getContextPath() %>/login.jsp'">Add to Cart</button>
                    

                    
                </div>
        <%  }
        } %>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved. Designed and Developed by Yoonus Anees.
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