<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.model.Customer" %>
<%
    User user = (User) request.getAttribute("user");
    Customer customer = (Customer) request.getAttribute("customer"); // Might be null if role != customer
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            width: 400px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus {
            border-color: #007BFF;
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        #customerFields {
            display: <%= "customer".equals(user.getRole()) ? "block" : "none" %>;
        }
    </style>
</head>

<body>
    <div class="form-container">
        <h2>Edit User</h2>
        <form action="User" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="<%= user.getId() %>" />

            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required />

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required />

            <label for="password">Password:</label>
            <input type="text" id="password" name="password" value="<%= user.getPassword() %>" required />

            <label for="role">Role:</label>
            <select id="role" name="role" required onchange="toggleCustomerFields(this.value)">
                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                <option value="customer" <%= "customer".equals(user.getRole()) ? "selected" : "" %>>Customer</option>
            </select>

            <!-- Customer-specific fields -->
            <div id="customerFields">
                <label for="accountNumber">Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" value="<%= customer != null ? customer.getAccountNumber() : "" %>" />

                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= customer != null ? customer.getAddress() : "" %>" />

                <label for="telephone">Telephone:</label>
                <input type="text" id="telephone" name="telephone" value="<%= customer != null ? customer.getTelephone() : "" %>" />
            </div>

            <input type="submit" value="Update" />
        </form>
    </div>

    <script>
        function toggleCustomerFields(role) {
            const fields = document.getElementById("customerFields");
            fields.style.display = (role === "customer") ? "block" : "none";
        }
    </script>
</body>
</html>
