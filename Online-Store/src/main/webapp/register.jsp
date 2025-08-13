<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Register - PahanaBook</title>
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
    font-size: 1.5rem;
    font-weight: 700;
    letter-spacing: 1.5px;
    color: #f1c40f;
    text-decoration: none;
    transition: color 0.3s ease;
  }
  .logo:hover { color: #e67e22; }
  .nav-links { display: flex; gap: 20px; }
  .nav-links a { color: white; text-decoration: none; font-weight: bold; }
  .nav-links a.active { color: #f1c40f; }

  /* Register card */
  .main {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px 20px;
  }
  .container {
    background: white;
    padding: 30px 25px;
    border-radius: 10px;
    width: 360px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    text-align: center;
    transition: transform 0.3s ease;
  }
  .container:hover { transform: translateY(-5px); }

  h2 { color: #2c3e50; margin-bottom: 20px; }

  input[type="text"],
  input[type="email"],
  input[type="password"] {
    width: 100%;
    padding: 12px;
    margin: 8px 0;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 1rem;
    box-sizing: border-box;
  }
  input:focus { border-color: #f1c40f; box-shadow: 0 0 8px rgba(241,196,15,0.5); outline: none; }

  input[type="submit"] {
    background-color: #f1c40f;
    color: #2c3e50;
    padding: 12px;
    margin-top: 15px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    width: 100%;
    font-weight: 700;
    font-size: 1rem;
    transition: background 0.3s ease, transform 0.2s ease;
  }
  input[type="submit"]:hover { background: #e67e22; color: white; transform: translateY(-2px); }

  .message { color: green; margin-top: 10px; font-weight: bold; }
  .error-message { color: red; margin-top: 10px; font-weight: bold; }

  a { display: block; margin-top: 15px; color: #f1c40f; text-decoration: none; }
  a:hover { text-decoration: underline; color: #e67e22; }

  footer {
    background: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px;
    font-size: 0.9rem;
  }
</style>
</head>
<body>

<nav>
  <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
  <div class="nav-links">
    <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/Books">Books</a>
    <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp" class="active">Register</a>
  </div>
</nav>

<div class="main">
  <div class="container">
    <h2>Create Your Account</h2>

    <form action="User?action=register" method="post" onsubmit="return validatePasswords();">
      <input type="text" name="username" placeholder="Username" required />
      <input type="email" name="email" placeholder="Email" required />
      <input type="password" name="password" id="password" placeholder="Password" required />
      <input type="password" id="confirmPassword" placeholder="Confirm Password" required />

      <!-- Customer-specific fields -->
      <input type="text" name="accountNumber" placeholder="Account Number" required />
      <input type="text" name="name" placeholder="Full Name" required />
      <input type="text" name="address" placeholder="Address" required />
      <input type="text" name="telephone" placeholder="Telephone" required />

      <input type="submit" value="Register" />
    </form>

    <c:if test="${not empty errorMessage}">
      <div class="error-message">${errorMessage}</div>
    </c:if>

    <a href="login.jsp">Already have an account? Login here</a>

    <div class="message" id="registerMsg" style="display: none;">Registering... 📝🚀</div>
  </div>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved Designed and Developed By Yoonus Anees.
</footer>

<script>
  function validatePasswords() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    if(password !== confirmPassword) {
      alert("Passwords do not match!");
      return false;
    }
    document.getElementById("registerMsg").style.display = "block";
    return true;
  }
</script>

</body>
</html>
