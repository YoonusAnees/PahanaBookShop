<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Login - PahanaBook</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f5f5f5;
      margin: 0;
      padding: 0;
      color: #333;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* Navbar */
    nav {
      background-color: #2c3e50;
      color: white;
      padding: 10px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      z-index: 1000;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    .logo {
      font-size: 1.8rem;
      font-weight: 700;
      letter-spacing: 1.5px;
      color: #f1c40f;
      text-decoration: none;
      user-select: none;
      transition: color 0.3s ease;
    }
    .logo:hover {
      color: #e67e22;
            text-decoration: none;
      
    }
    .nav-links {
      display: flex;
      align-items: center;
      gap: 22px;
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
      text-decoration: none;
    }
    .nav-links a.active {
      color: #f1c40f;
      font-weight: bold;
    }

    /* Responsive navbar */
    @media (max-width: 600px) {
      nav {
        flex-wrap: wrap;
        padding: 15px 20px;
      }
      .nav-links {
        width: 100%;
        justify-content: center;
        margin-top: 10px;
        gap: 15px;
      }
    }

    /* Main container */
    .container {
      max-width: 400px;
      margin: 70px auto 80px;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      flex-grow: 1;
      text-align: center;
    }

    h2 {
      color: #2c3e50;
      margin-bottom: 1.5rem;
      font-weight: 700;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 0.6rem 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
      box-sizing: border-box;
      transition: all 0.3s ease;
    }

    input:focus {
      border-color: #f1c40f;
      box-shadow: 0 0 8px rgba(241, 196, 15, 0.5);
      outline: none;
    }

    input[type="submit"] {
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
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #e67e22;
      color: white;
    }

    .message {
      margin-top: 1rem;
      color: green;
      font-weight: bold;
    }

    .error-message {
      color: red;
      margin-top: 1rem;
      font-weight: bold;
    }

    a {
      display: block;
      margin-top: 1rem;
      color: #f1c40f;
      text-decoration: none;
      font-weight: 600;
      user-select: none;
    }

    a:hover {
      text-decoration: underline;
    }

    /* Footer */
    footer {
      background: #2c3e50;
      color: white;
      text-align: center;
      padding: 15px;
      margin-top: auto;
      user-select: none;
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
    <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp" class="active">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
  </div>
</nav>

<!-- Login form container -->
<div class="container">
  <h2>Welcome Back! Please Login</h2>

  <form action="User?action=login" method="post" onsubmit="return showSuccess();">
    <input type="text" name="username" placeholder="Username" required />
    <input type="password" name="password" placeholder="Password" required />
    <input type="submit" value="Login" />
  </form>

  <c:if test="${not empty error}">
    <div class="error-message">${error}</div>
  </c:if>

  <a href="register.jsp">Don't have an account? Register here</a>

  <div class="message" id="successMsg" style="display: none;">
    Logging in... ⚽️🔥
  </div>
</div>

<!-- Footer -->
<footer>
  &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

<script>
  function showSuccess() {
    document.getElementById("successMsg").style.display = "block";
    return true;
  }
</script>

</body>
</html>
