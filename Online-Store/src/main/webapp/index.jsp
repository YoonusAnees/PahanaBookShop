<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login</title>
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

    .login-container {
      background-color: white;
      padding: 2.5rem 2rem;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
      width: 350px;
      text-align: center;
    }

    h2 {
      margin-bottom: 1.5rem;
      color: #333;
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
    }

    input:focus {
      border-color: #0072ff;
      box-shadow: 0 0 5px rgba(0, 114, 255, 0.5);
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
    }

    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
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

  <script>
    function showSuccess() {
      document.getElementById("successMsg").style.display = "block";
      return true;
    }
  </script>
</body>
</html>
