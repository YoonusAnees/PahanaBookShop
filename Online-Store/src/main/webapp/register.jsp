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
      padding: 10px 30px; /* increased padding for taller navbar */
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
        padding: 25px 20px; /* keep it taller on mobile too */
      }
      .nav-links {
        width: 100%;
        justify-content: center;
        margin-top: 10px;
        gap: 15px;
      }
    }

    /* Register container */
    .register-container {
      background-color: white;
      padding: 2.5rem 2rem;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      width: 360px;
      margin: 80px auto 80px;
      text-align: center;
      flex-grow: 1;
      transition: transform 0.3s ease;
    }
    .register-container:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    h2 {
      margin-bottom: 1.5rem;
      color: #2c3e50;
      font-weight: 700;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"],
    select {
      width: 100%;
      padding: 12px;
      margin: 0.6rem 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
      transition: all 0.3s ease;
      font-size: 1rem;
    }

    input:focus,
    select:focus {
      border-color: #f1c40f;
      box-shadow: 0 0 8px rgba(241, 196, 15, 0.5);
      outline: none;
    }

    input[type="submit"] {
      background-color: #f1c40f;
      color: #2c3e50;
      padding: 12px;
      margin-top: 1.5rem;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      width: 100%;
      font-size: 1rem;
      font-weight: 700;
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #e67e22;
      color: white;
      box-shadow: 0 4px 15px rgba(230, 126, 34, 0.7);
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
      display: inline-block;
      margin-top: 1rem;
      color: #f1c40f;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
      user-select: none;
    }

    a:hover {
      text-decoration: underline;
      color: #e67e22;
    }

    /* Customer fields section */
    .customer-fields {
      margin-top: 1rem;
      display: none;
      text-align: left;
    }
    .customer-fields input {
      margin-top: 10px;
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
    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp" class="active">Register</a>
  </div>
</nav>

<!-- Register form -->
<div class="register-container">
  <h2>Create Your Account</h2>

  <form action="User?action=register" method="post" onsubmit="return validatePasswords();">
    <input type="text" name="username" placeholder="Username" required /><br />
    <input type="email" name="email" placeholder="Email" required /><br />
    <input type="password" name="password" id="password" placeholder="Password" required /><br />
    <input type="password" id="confirmPassword" placeholder="Confirm Password" required /><br />

    <select name="role" id="roleSelect" required>
      <option value="">-- Select Role --</option>
      <option value="customer">Customer</option>
      <option value="admin">Admin</option>
    </select><br />

    <!-- Customer-specific fields -->
    <div class="customer-fields" id="customerFields">
      <input type="text" name="accountNumber" placeholder="Account Number" /><br />
      <input type="text" name="name" placeholder="Full Name" /><br />
      <input type="text" name="address" placeholder="Address" /><br />
      <input type="text" name="telephone" placeholder="Telephone" /><br />
    </div>

    <input type="submit" value="Register" />
  </form>

  <c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
  </c:if>

  <p>Already have an account? <a href="index.jsp">Login here</a></p>

  <div class="message" id="registerMsg" style="display: none;">
    Registering... 📝🚀
  </div>
</div>

<!-- Footer -->
<footer>
  &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

<script>
  function validatePasswords() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (password !== confirmPassword) {
      alert("Passwords do not match!");
      return false;
    }

    document.getElementById("registerMsg").style.display = "block";
    return true;
  }

  // Show customer fields only if "customer" is selected
  const roleSelect = document.getElementById("roleSelect");
  const customerFields = document.getElementById("customerFields");

  roleSelect.addEventListener("change", function () {
    if (this.value === "customer") {
      customerFields.style.display = "block";
    } else {
      customerFields.style.display = "none";
    }
  });
</script>

</body>
</html>
