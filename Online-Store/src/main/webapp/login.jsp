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
      padding: 15px 30px;
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
    /* Responsive: stack links on small screens */
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
    .login-container {
      background-color: white;
      padding: 2.5rem 2rem;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
      width: 350px;
      margin: 80px auto 40px;
      text-align: center;
      flex-grow: 1;
    }

    h2 {
      margin-bottom: 1.5rem;
      color: #2c3e50;
      font-weight: 700;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 0.6rem 0;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
      transition: all 0.3s ease;
      font-size: 1rem;
    }

    input:focus {
      border-color: #0072ff;
      box-shadow: 0 0 8px rgba(0, 114, 255, 0.5);
      outline: none;
    }

    input[type="submit"] {
      background-color: #0072ff;
      color: white;
      padding: 12px;
      margin-top: 1rem;
      border: none;
      border-radius: 8px;
      width: 100%;
      font-size: 1rem;
      cursor: pointer;
      font-weight: 700;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #0057cc;
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
      color: #0072ff;
      text-decoration: none;
      font-weight: 600;
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
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp" class="active">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
  </div>
</nav>

<!-- Login form -->
<div class="login-container">
  <h2>Welcome Back! Please Login</h2>

  <form action="User?action=login" method="post" onsubmit="return showSuccess();">
    <input type="text" name="username" placeholder="Username" required /><br />
    <input type="password" name="password" placeholder="Password" required /><br />
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
