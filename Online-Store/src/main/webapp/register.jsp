<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Register - PahanaBook</title>
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
        
        .nav-links.mobile a {
            margin: 15px 0;
            text-align: center;
            color: white;
            font-size: 1.3rem;
        }

  /* Register card */
  .main {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px 20px;
  }
  .container {
    background: white;
    padding: 7px 25px;
    border-radius: 10px;
    width: 360px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    text-align: center;
    transition: transform 0.3s ease;
  }
  .container:hover { transform: translateY(-5px); }

  h2 { color: #2c3e50; margin-bottom: 5px; }

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
  a:hover {  color: #f1c40f; }

  footer {
    background: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px;
    font-size: 0.9rem;
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
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp" class="active">Register</a>
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
    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp" class="active">Register</a>
</div>

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
  
  
  function openMenu() {
      document.getElementById("mobileMenu").classList.add("show");
  }
  function closeMenu() {
      document.getElementById("mobileMenu").classList.remove("show");
  }

</script>

</body>
</html>
