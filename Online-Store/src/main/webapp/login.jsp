<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Login - PahanaBook</title>
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />

<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    color: #333;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: #f5f5f5;
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
        
        .nav-links.mobile a {
            margin: 15px 0;
            text-align: center;
            color: white;
            font-size: 1.3rem;
        }

  /* Centering wrapper */
  .main {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px 20px;
  }

  /* Login card */
  .container {
    max-width: 400px;
    width: 100%;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    animation: fadeInUp 0.6s ease forwards;
  }
  @keyframes fadeInUp {
    from { transform: translateY(30px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
  }

  h2 {
    color: #2c3e50;
    margin-bottom: 1.5rem;
    font-weight: 700;
    text-align: center;
  }

  /* Floating labels */
  .form-group {
    position: relative;
    margin: 1.5rem 0;
     display: flex;
    justify-content: center; /* horizontally center input */
  }
  .form-group input {
  
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    background: transparent;
    transition: all 0.3s ease;
  }
  .form-group label {
    position: absolute;
    top: 12px;
    left: 12px;
    background: white;
    padding: 0 5px;
    color: #888;
    font-size: 0.9rem;
    pointer-events: none;
    transition: all 0.3s ease;
  }
  .form-group input:focus {
    border-color: #f1c40f;
    box-shadow: 0 0 8px rgba(241,196,15,0.5);
    outline: none;
  }
  .form-group input:focus + label,
  .form-group input:not(:placeholder-shown) + label {
    top: -8px;
    left: 8px;
    font-size: 0.75rem;
    color: #f39c12;
  }

  /* Button */
  .btn {
    background-color: #f1c40f;
    color: #2c3e50;
    border: none;
    padding: 12px;
    margin-top: 1rem;
    border-radius: 6px;
    width: 100%;
    font-size: 1rem;
    font-weight: 700;
    cursor: pointer;
    transition: transform 0.2s ease, background-color 0.3s ease;
  }
  .btn:hover {
    background-color: #e67e22;
    color: white;
    transform: translateY(-2px);
  }
  .btn:active {
    transform: scale(0.98);
  }

  /* Messages */
  .message {
    margin-top: 1rem;
    color: green;
    font-weight: bold;
    text-align: center;
  }
  .error-message {
    color: red;
    margin-top: 1rem;
    font-weight: bold;
    text-align: center;
  }

  /* Links */
  a {
    display: block;
    margin-top: 1rem;
    color: #f1c40f;
    text-decoration: none;
    font-weight: 600;
    text-align: center;
  }
 
  /* Footer */
  footer {
    background: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px;
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
  
    <div class="nav-links" id="navLinks">
        <a href="<%= request.getContextPath() %>/index.jsp" >Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp" class="active">Login</a>
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
    <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/Books">Books</a>
    <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp" class="active">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
</div>

<!-- Main login form -->
<div class="main">
  <div class="container">
    <h2>Welcome ! Please Login</h2>

    <form action="User?action=login" method="post" onsubmit="return showSuccess();">
      <div class="form-group">
        <input type="email" name="email" placeholder=" " required />
        <label>Email</label>
      </div>
      <div class="form-group">
        <input type="password" name="password" placeholder=" " required />
        <label>Password</label>
      </div>
      <button type="submit" class="btn">Login</button>
    </form>

    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>

    <a href="register.jsp">Don't have an account? Register here</a>

    <div class="message" id="successMsg" style="display: none;">
      Logging in... ⚽️🔥
    </div>
  </div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed By Yoonus Anees.
</footer>

<script>
  function showSuccess() {
    document.getElementById("successMsg").style.display = "block";
    return true;
    

  }
  
  function openMenu() {
      document.getElementById("mobileMenu").classList.add("show");
  }
  function closeMenu() {
      document.getElementById("mobileMenu").classList.remove("show");
  }
</script>

</body>
</html>
