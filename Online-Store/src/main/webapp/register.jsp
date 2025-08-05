<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #00c6ff, #0072ff);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .register-container {
      background-color: white;
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
      width: 350px;
      text-align: center;
    }

    h2 {
      margin-bottom: 1.2rem;
      color: #333;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"],
    select {
      width: 100%;
      padding: 12px;
      margin-top: 0.5rem;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
      transition: all 0.3s ease;
    }

    input:focus,
    select:focus {
      border-color: #0072ff;
      box-shadow: 0 0 5px rgba(0, 114, 255, 0.5);
      outline: none;
    }

    button,
    input[type="submit"] {
      background-color: #0072ff;
      color: white;
      padding: 12px;
      margin-top: 1.5rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      font-size: 1rem;
      transition: background-color 0.3s ease;
    }

    button:hover,
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
      color: #0072ff;
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="register-container">
    <h2>Create Your Account</h2>

    <form action="User?action=register" method="post" onsubmit="return validatePasswords();">
      <input type="text" name="username" placeholder="Username" required /><br />
      <input type="email" name="email" placeholder="Email" required /><br />
      <input type="password" name="password" id="password" placeholder="Password" required /><br />
      <input type="password" id="confirmPassword" placeholder="Confirm Password" required /><br />
      <select name="role" required>
        <option value="">-- Select Role --</option>
        <option value="customer">Customer</option>
        <option value="admin">Admin</option>
      </select><br />
      <input type="submit" value="Register" />
    </form>

    <c:if test="${not empty errorMessage}">
      <div class="error-message">${errorMessage}</div>
    </c:if>

    <p style="margin-top: 1rem;">Already have an account? <a href="index.jsp">Login here</a></p>

    <div class="message" id="registerMsg" style="display: none;">
      Registering... 📝🚀
    </div>
  </div>

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
  </script>
</body>
</html>
