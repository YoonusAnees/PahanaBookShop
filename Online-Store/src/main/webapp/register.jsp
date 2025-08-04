<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register</title>
  <style>
    body {
      font-family: Arial, sans-serif;
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
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
      text-align: center;
    }

    h2 {
      margin-bottom: 1.5rem;
      color: #333;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"] {
      width: 90%;
      padding: 10px;
      margin: 0.5rem 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    button {
      background-color: #0072ff;
      color: white;
      padding: 10px 20px;
      border: none;
      margin-top: 1rem;
      border-radius: 5px;
      cursor: pointer;
    }

    button:hover {
      background-color: #0057cc;
    }

    .message {
      margin-top: 1rem;
      color: green;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <div class="register-container">
    <h2>Create Your Account</h2>

    <form action="RegisterServlet" method="post" onsubmit="return showRegisterMessage()">
      <input type="text" name="username" placeholder="Enter Username" required /><br/>
      <input type="email" name="email" placeholder="Enter Email" required /><br/>
      <input type="password" name="password" placeholder="Enter Password" required /><br/>
      <input type="password" name="confirmPassword" placeholder="Confirm Password" required /><br/>
      <button type="submit">Register</button>
    </form>
    
    <p style="margin-top: 1rem;">Already have an account? <a href="index.jsp">Login here</a></p>

    <div class="message" id="registerMsg" style="display: none;">
      Registering... 📝🚀
    </div>
  </div>

  <script>
    function showRegisterMessage() {
      document.getElementById("registerMsg").style.display = "block";
      return true; // Let form submit
    }
  </script>
</body>
</html>
