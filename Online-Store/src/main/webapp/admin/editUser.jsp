<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.model.Customer" %>
<%
    // Get the admin user from session for authorization
    User adminUser = (User) session.getAttribute("user");
    
    // Get the user being edited from request attributes
    User userToEdit = (User) request.getAttribute("user");
    Customer customer = (Customer) request.getAttribute("customer"); // Might be null if role != customer

    if (adminUser == null || !"admin".equals(adminUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    
    // Check if we have a user to edit
    if (userToEdit == null) {
        response.sendRedirect(request.getContextPath() + "/User?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - PahanaBook</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />
    
     <style>
        :root {
            --primary: #2c3e50;
            --secondary: #34495e;
            --accent: #f39c12;
            --danger: #e74c3c;
            --success: #27ae60;
            --warning: #f1c40f;
            --info: #3498db;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --sidebar-width: 250px;
            --header-height: 80px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f7f9fc 0%, #e3eaf2 100%);
            color: var(--dark);
            min-height: 100vh;
            line-height: 1.6;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(180deg, var(--primary) 0%, var(--secondary) 100%);
            padding: 20px 0;
            box-shadow: 3px 0 15px rgba(0,0,0,0.2);
            overflow-y: auto;
            z-index: 1000;
            transition: var(--transition);
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: var(--accent);
            font-size: 28px;
            font-weight: 700;
            text-decoration: none;
            transition: var(--transition);
        }

        .logo:hover {
            color: #e67e22;
            transform: scale(1.05);
        }

        .logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        .sidebar h2 {
            color: var(--light);
            text-align: center;
            font-size: 1.3rem;
            margin: 10px 0 20px;
            padding: 0 20px;
            border-bottom: 2px solid rgba(255,255,255,0.1);
            padding-bottom: 15px;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0 15px;
        }

        .sidebar-menu li {
            margin-bottom: 5px;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #bdc3c7;
            text-decoration: none;
            border-radius: 10px;
            transition: var(--transition);
            font-weight: 500;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: linear-gradient(90deg, rgba(243, 156, 18, 0.2) 0%, transparent 100%);
            color: var(--light);
            transform: translateX(5px);
        }

        .sidebar-menu a i {
            margin-right: 12px;
            font-size: 18px;
            width: 25px;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
            transition: var(--transition);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        /* Header */
        .header {
            background: linear-gradient(90deg, var(--primary) 0%, var(--secondary) 100%);
            color: var(--light);
            padding: 10px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 30px;
            left: calc(var(--sidebar-width) + 30px);
            right: 30px;
            z-index: 900;
        }

        .welcome-text h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .welcome-text p {
            color: #bdc3c7;
            font-size: 1rem;
        }

        .logout-btn {
            background: linear-gradient(45deg, var(--danger), #c0392b);
            color: white;
            padding: 12px 25px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
        }

        /* Form Container */
        .form-container {
            background: white;
            padding: 28px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            margin-top: 120px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--accent), var(--info));
        }

        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }

        .form-title {
            text-align: center;
            margin-bottom: 5px;
            color: var(--dark);
            font-size: 2rem;
            font-weight: 700;
            position: relative;
        }

        .form-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: var(--accent);
            border-radius: 2px;
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group label i {
            color: var(--accent);
            font-size: 18px;
        }

        .form-control {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: #f8f9fa;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            background: white;
            box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.1);
            transform: translateY(-2px);
        }

        .form-select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: #f8f9fa;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23f39c12' viewBox='0 0 16 16'%3E%3Cpath d='M8 12L2 6h12L8 12z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 16px;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--accent);
            background: white;
            box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.1);
            transform: translateY(-2px);
        }

        .customer-fields {
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            padding: 25px;
            border-radius: 15px;
            border-left: 4px solid var(--info);
            margin-top: 20px;
            transition: var(--transition);
        }

        .customer-fields h3 {
            color: var(--info);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.2rem;
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(45deg, var(--info), #2980b9);
            color: white;
            padding: 18px;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 5px 20px rgba(52, 152, 219, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
            background: linear-gradient(45deg, #2980b9, var(--info));
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        /* Password info box */
        .password-info {
            background: #e8f4fc;
            border-left: 4px solid var(--info);
            padding: 12px 15px;
            border-radius: 8px;
            margin-top: 10px;
            font-size: 0.9rem;
            color: #2c3e50;
        }

        .password-info i {
            color: var(--info);
            margin-right: 8px;
        }

        /* Mobile Menu Button */
        .menu-toggle {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--accent);
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            cursor: pointer;
            z-index: 1100;
            box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            
            .header {
                left: 20px;
                right: 20px;
                top: 20px;
            }
            
            .menu-toggle {
                display: flex;
            }
            
            .form-container {
                margin-top: 100px;
                padding: 30px;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
                padding: 15px;
            }
            
            .welcome-text h1 {
                font-size: 1.5rem;
            }
            
            .form-container {
                padding: 25px;
                margin-top: 140px;
            }
            
            .form-title {
                font-size: 1.7rem;
            }
            
            .customer-fields {
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .main-content {
                padding: 15px;
            }
            
            .form-container {
                padding: 20px;
                margin-top: 160px;
            }
            
            .form-control,
            .form-select {
                padding: 12px 15px;
            }
            
            .submit-btn {
                padding: 15px;
                font-size: 1rem;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-container {
            animation: fadeIn 0.6s ease-out;
        }

        .customer-fields {
            animation: fadeIn 0.8s ease-out;
        }

        /* Custom scrollbar */
        .sidebar::-webkit-scrollbar {
            width: 5px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: rgba(255,255,255,0.1);
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: var(--accent);
            border-radius: 10px;
        }

        /* Form validation styles */
        .form-control:invalid,
        .form-select:invalid {
            border-color: var(--danger);
        }

        .form-control:valid,
        .form-select:valid {
            border-color: var(--success);
        }
    </style>
</head>
<body>
    <!-- Sidebar Navigation -->
    <nav class="sidebar" id="sidebar">
        <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="logo">
            <i class="fas fa-book"></i>PahanaBook
        </a>
        
        <h2>Admin Panel</h2>
        
        <ul class="sidebar-menu">
            <li><a href="AddBook.jsp"><i class="fas fa-plus-circle"></i>Add Book</a></li>
            <li><a href="Book?action=list"><i class="fas fa-book"></i>Manage Books</a></li>
            <li><a href="User?action=list" class="active"><i class="fas fa-users"></i>Manage Users</a></li>
            <li><a href="AddStationery.jsp"><i class="fas fa-pencil-alt"></i>Add Stationery</a></li>
            <li><a href="Stationery?action=list"><i class="fas fa-pencil-ruler"></i>Manage Stationery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order-history"><i class="fas fa-history"></i>Orders History</a></li>
        </ul>
    </nav>

    <!-- Header -->
    <header class="header">
        <div class="welcome-text">
            <h1>Welcome Admin: <%= adminUser.getUsername() %></h1>
            <p>Edit user information and permissions</p>
        </div>
        <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>Logout
        </a>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="form-container">
            <h2 class="form-title">
                <i class="fas fa-user-edit"></i>Edit User: <%= userToEdit.getUsername() %>
            </h2>
            
            <form action="User" method="post" id="userForm">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="id" value="<%= userToEdit.getId() %>" />
                <!-- Hidden field to preserve current password if not changed -->
                <input type="hidden" name="currentPassword" value="<%= userToEdit.getPassword() %>" />

                <div class="form-group">
                    <label for="username"><i class="fas fa-user"></i>Username</label>
                    <input type="text" id="username" name="username" class="form-control" 
                           value="<%= userToEdit.getUsername() %>" required />
                </div>

                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i>Email</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="<%= userToEdit.getEmail() %>" required />
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i>New Password</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Enter new password (leave blank to keep current)" 
                           minlength="6" 
                           title="Password must be at least 6 characters" />
                    <div class="password-info">
                        <i class="fas fa-info-circle"></i>
                        Leave blank to keep the current password. Password will be automatically encrypted.
                    </div>
                </div>

                <div class="form-group">
                    <label for="role"><i class="fas fa-user-tag"></i>Role</label>
                    <select id="role" name="role" class="form-select" required onchange="toggleCustomerFields(this.value)">
                        <option value="admin" <%= "admin".equals(userToEdit.getRole()) ? "selected" : "" %>>Admin</option>
                        <option value="customer" <%= "customer".equals(userToEdit.getRole()) ? "selected" : "" %>>Customer</option>
                    </select>
                </div>

                <!-- Customer-specific fields -->
                <div id="customerFields" class="customer-fields" style="display: <%= "customer".equals(userToEdit.getRole()) ? "block" : "none" %>">
                    <h3><i class="fas fa-address-card"></i>Customer Details</h3>
                    
                    <div class="form-group">
                        <label for="accountNumber"><i class="fas fa-credit-card"></i>Account Number</label>
                        <input type="text" id="accountNumber" name="accountNumber" class="form-control" 
                               value="<%= customer != null ? customer.getAccountNumber() : "" %>" />
                    </div>

                    <div class="form-group">
                        <label for="address"><i class="fas fa-map-marker-alt"></i>Address</label>
                        <input type="text" id="address" name="address" class="form-control" 
                               value="<%= customer != null ? customer.getAddress() : "" %>" />
                    </div>

                    <div class="form-group">
                        <label for="telephone"><i class="fas fa-phone"></i>Telephone</label>
                        <input type="text" id="telephone" name="telephone" class="form-control" 
                               value="<%= customer != null ? customer.getTelephone() : "" %>" 
                               pattern="[0-9+\-\s]{10,15}" 
                               title="Please enter a valid telephone number" />
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i>Update User
                </button>
            </form>
        </div>
    </main>

    <script>
        // Toggle sidebar on mobile
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
        }

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const menuToggle = document.querySelector('.menu-toggle');
            
            if (window.innerWidth <= 992 && 
                !sidebar.contains(event.target) && 
                !menuToggle.contains(event.target) &&
                sidebar.classList.contains('active')) {
                sidebar.classList.remove('active');
            }
        });

        // Toggle customer fields based on role selection
        function toggleCustomerFields(role) {
            const customerFields = document.getElementById('customerFields');
            if (role === 'customer') {
                customerFields.style.display = 'block';
                customerFields.style.animation = 'fadeIn 0.8s ease-out';
                
                // Make customer fields required
                document.getElementById('accountNumber').required = true;
                document.getElementById('address').required = true;
                document.getElementById('telephone').required = true;
            } else {
                customerFields.style.display = 'none';
                
                // Remove required attribute from customer fields
                document.getElementById('accountNumber').required = false;
                document.getElementById('address').required = false;
                document.getElementById('telephone').required = false;
            }
        }

        // Form validation
        document.getElementById('userForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            
            // Password validation - only if password is being changed
            if (password.length > 0 && password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            // If password field is empty, set it to the current password value
            if (password.length === 0) {
                document.getElementById('password').value = document.querySelector('input[name="currentPassword"]').value;
            }
        });

        // Add hover effects to form elements
        document.querySelectorAll('.form-control, .form-select').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });
        });

        // Real-time validation
        document.querySelectorAll('input[pattern]').forEach(input => {
            input.addEventListener('input', function() {
                if (this.validity.patternMismatch) {
                    this.style.borderColor = 'var(--danger)';
                } else {
                    this.style.borderColor = 'var(--success)';
                }
            });
        });

        // Clear password field on page load to avoid displaying hash
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('password').value = '';
        });
    </script>
</body>
</html>