<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User - PahanaBook Admin</title>
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Your existing CSS styles here */
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
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
            padding: 30px;
            transition: var(--transition);
        }

        /* Header */
        .header {
            background: linear-gradient(90deg, var(--primary) 0%, var(--secondary) 100%);
            color: var(--light);
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h1 {
            font-size: 2rem;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .welcome-text p {
            color: #bdc3c7;
            font-size: 1.1rem;
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
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            max-width: 800px;
            margin: 0 auto;
        }

        .form-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #ecf0f1;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-title i {
            color: var(--accent);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--secondary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-group label i {
            color: var(--accent);
            font-size: 16px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.2);
        }

        .btn-submit {
            background: linear-gradient(45deg, var(--success), #229954);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
        }

        .message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .success-message {
            background: #e8f5e8;
            color: var(--success);
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background: #fde8e8;
            color: var(--danger);
            border: 1px solid #f5c6cb;
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
            }
            
            .menu-toggle {
                display: flex;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .welcome-text h1 {
                font-size: 1.5rem;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Mobile Menu Toggle */
        .menu-toggle {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1100;
            background: var(--primary);
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            cursor: pointer;
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
    </style>
</head>
<body>
    <!-- Mobile Menu Toggle -->
    <div class="menu-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </div>

    <!-- Sidebar Navigation -->
    <nav class="sidebar" id="sidebar">
        <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="logo">
            <i class="fas fa-book"></i>PahanaBook
        </a>
        
        <h2>Admin Panel</h2>
        
        <ul class="sidebar-menu">
            <li><a href="AddBook.jsp"><i class="fas fa-plus-circle"></i>Add Book</a></li>
            <li><a href="AddUser.jsp" class="active"><i class="fas fa-user-plus"></i>Add User</a></li>
            <li><a href="Book?action=list"><i class="fas fa-book"></i>Manage Books</a></li>
            <li><a href="${pageContext.request.contextPath}/User?action=list"><i class="fas fa-users"></i>Manage Users</a></li>
            <li><a href="AddStationery.jsp"><i class="fas fa-pencil-alt"></i>Add Stationery</a></li>
            <li><a href="Stationery?action=list"><i class="fas fa-pencil-ruler"></i>Manage Stationery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order-history"><i class="fas fa-history"></i>Orders History</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="header">
            <div class="welcome-text">
                <h1>Welcome Admin: <%= user.getUsername() %></h1>
                <p>Add new users to the system</p>
            </div>
            <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>Logout
            </a>
        </header>

        <!-- Form Container -->
        <div class="form-container">
            <h2 class="form-title"><i class="fas fa-user-plus"></i> Add New User</h2>

            <c:if test="${not empty successMessage}">
                <div class="message success-message">${successMessage}</div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="message error-message">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/User?action=register" method="post" onsubmit="return validateForm()">
                <!-- Hidden field to identify this is from admin -->
                <input type="hidden" name="source" value="admin">
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user"></i>Username *</label>
                        <input type="text" id="username" name="username" placeholder="Enter username" required>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i>Email Address *</label>
                        <input type="email" id="email" name="email" placeholder="Enter email address" required>
                    </div>

                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i>Password *</label>
                        <input type="password" id="password" name="password" placeholder="Enter password" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword"><i class="fas fa-lock"></i>Confirm Password *</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                    </div>

                    <div class="form-group">
                        <label for="name"><i class="fas fa-signature"></i>Full Name *</label>
                        <input type="text" id="name" name="name" placeholder="Enter full name" required>
                    </div>

                    <div class="form-group">
                        <label for="telephone"><i class="fas fa-phone"></i>Telephone *</label>
                        <input type="text" id="telephone" name="telephone" placeholder="Enter telephone number" required>
                    </div>

                    <div class="form-group">
                        <label for="address"><i class="fas fa-address-card"></i>Address *</label>
                        <input type="text" id="address" name="address" placeholder="Enter address" required>
                    </div>

                    <div class="form-group">
                        <label for="role"><i class="fas fa-user-tag"></i>User Role *</label>
                        <select id="role" name="role" required>
                            <option value="">Select Role</option>
                            <option value="customer">Customer</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-user-plus"></i> Create User
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

        // Form validation
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 6) {
                alert('Password must be at least 6 characters long!');
                return false;
            }
            
            return true;
        }

        // Add hover effects to form inputs
        document.querySelectorAll('.form-group input, .form-group select').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>