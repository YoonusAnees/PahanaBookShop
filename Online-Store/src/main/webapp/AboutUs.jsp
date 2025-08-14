<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>About Us - PahanaBook</title>
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
            margin-left: 400px;
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
    /* Hero Banner */
    .hero {
        background: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f') center/cover no-repeat;
        height: 350px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-shadow: 2px 2px 5px rgba(0,0,0,0.5);
        font-size: 2.5rem;
        font-weight: bold;
        animation: fadeIn 1.5s ease-in-out;
    }

    /* About Section */
    .about-section {
        max-width: 1100px;
        margin: 40px auto;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        display: flex;
        gap: 20px;
        align-items: center;
    }
    .about-section img {
        width: 400px;
        border-radius: 8px;
        transition: transform 0.3s ease;
    }
    .about-section img:hover {
        transform: scale(1.05);
    }
    .about-text h1 {
        color: #2c3e50;
    }
    .about-text p {
        line-height: 1.6;
        margin-bottom: 15px;
    }

    /* Footer */
      footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px 0;
            font-size: 0.9rem;
            margin-top: 40px;
        }
    

    /* Animation */
    @keyframes fadeIn {
        from {opacity: 0;}
        to {opacity: 1;}
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
        
        @media (max-width: 768px) {
    .about-section {
        flex-direction: column;
        align-items: center;
        padding: 15px;
    }
    .about-section img {
        width: 90%;
        max-width: 300px;
        margin-bottom: 20px;
    }
    .about-text h1 {
        font-size: 1.8rem;
        text-align: center;
    }
    .about-text p {
        font-size: 0.95rem;
        text-align: center;
    }
    
}
</style>
</head>
<body>

<!-- Navbar -->
<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <form class="search-form" method="get" action="<%= request.getContextPath() %>/Search">
        <input type="text" name="query" placeholder="Search books or stationery..." required />
        <button type="submit">Search</button>
    </form>
    <div class="nav-links" id="navLinks">
        <a href="<%= request.getContextPath() %>/index.jsp" >Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp" class="active">About Us</a>
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
    <a href="<%= request.getContextPath() %>/Books">Books</a>
    <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp"class="active">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
</div>

<!-- Hero Banner -->
<div class="hero">About Us</div>

<!-- About Section -->
<div class="about-section">
    <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794" alt="Books and Stationery">
    <div class="about-text">
        <h1>Welcome to PahanaBook</h1>
        <p>At PahanaBook, we believe books are the gateway to knowledge and imagination. Since our inception, we have proudly served book lovers, students, and professionals with a wide variety of books from classics to the latest bestsellers.</p>
        <p>Our passion extends beyond books; we also provide top-quality stationery products to meet all your academic and office needs.</p>
        <p>We strive to offer excellent customer service and a friendly shopping experience, whether you visit us online or in-store.</p>
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
