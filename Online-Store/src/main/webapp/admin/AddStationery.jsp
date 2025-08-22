<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Stationery - PahanaBook</title>
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            line-height: 1.5;
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
            padding: 15px;
            color: var(--accent);
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
            transition: var(--transition);
        }

        .logo i {
            margin-right: 8px;
            font-size: 28px;
        }

        .sidebar h2 {
            color: var(--light);
            text-align: center;
            font-size: 1.1rem;
            margin: 10px 0 15px;
            border-bottom: 2px solid rgba(255,255,255,0.1);
            padding-bottom: 10px;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0 10px;
        }

        .sidebar-menu li {
            margin-bottom: 5px;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #bdc3c7;
            text-decoration: none;
            border-radius: 8px;
            transition: var(--transition);
            font-weight: 500;
            font-size: 0.9rem;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: linear-gradient(90deg, rgba(243, 156, 18, 0.2) 0%, transparent 100%);
            color: var(--light);
            transform: translateX(5px);
        }

        .sidebar-menu a i {
            margin-right: 10px;
            font-size: 16px;
            width: 22px;
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
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 20px;
            left: calc(var(--sidebar-width) + 20px);
            right: 20px;
            z-index: 900;
        }

        .welcome-text h1 {
            font-size: 1.4rem;
            margin-bottom: 3px;
            font-weight: 700;
        }

        .welcome-text p {
            color: #bdc3c7;
            font-size: 0.9rem;
        }

        .logout-btn {
            background: linear-gradient(45deg, var(--danger), #c0392b);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition);
            box-shadow: 0 3px 12px rgba(231, 76, 60, 0.3);
            font-size: 0.9rem;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 16px rgba(231, 76, 60, 0.4);
        }

        /* Form Container */
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            margin-top: 100px;
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
            height: 4px;
            background: linear-gradient(90deg, var(--accent), var(--info));
        }

        .form-container:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .form-title {
            text-align: center;
            margin-bottom: 25px;
            color: var(--dark);
            font-size: 1.5rem;
            font-weight: 700;
            position: relative;
        }

        .form-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: var(--accent);
            border-radius: 2px;
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 6px;
            font-weight: 500;
        }

        .form-group label i {
            color: var(--accent);
            font-size: 16px;
            width: 20px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border-radius: 8px;
            font-size: 0.95rem;
            border: 2px solid #e9ecef;
            background: #f8f9fa;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            background: white;
            box-shadow: 0 0 0 2px rgba(243, 156, 18, 0.1);
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(45deg, var(--info), #2980b9);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            background: linear-gradient(45deg, #2980b9, var(--info));
            box-shadow: 0 6px 18px rgba(52, 152, 219, 0.4);
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
                padding: 15px;
            }
            
            .header {
                left: 20px;
                right: 20px;
            }
            
            .menu-toggle {
                display: block;
                position: fixed;
                top: 25px;
                left: 25px;
                z-index: 1100;
                background: var(--primary);
                color: white;
                width: 40px;
                height: 40px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }
        }

        @media (max-width: 768px) {
            .form-container {
                margin-top: 140px;
                padding: 25px;
            }
            
            .header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
                padding: 15px;
            }
            
            .welcome-text h1 {
                font-size: 1.2rem;
            }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 20px;
                margin-top: 160px;
            }
        }
    </style>
</head>
<body>
    <!-- Mobile Menu Toggle -->
    <div class="menu-toggle" style="display: none;" onclick="toggleSidebar()">
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
            <li><a href="Book?action=list"><i class="fas fa-book"></i>Manage Books</a></li>
            <li><a href="User?action=list"><i class="fas fa-users"></i>Manage Users</a></li>
            <li><a href="AddStationery.jsp" class="active"><i class="fas fa-pencil-alt"></i>Add Stationery</a></li>
            <li><a href="Stationery?action=list"><i class="fas fa-pencil-ruler"></i>Manage Stationery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order-history"><i class="fas fa-history"></i>Orders History</a></li>
        </ul>
    </nav>

    <!-- Header -->
    <header class="header">
        <div class="welcome-text">
            <h1>Welcome Admin: <%= user.getUsername() %></h1>
            <p>Add new stationery items to your collection</p>
        </div>
        <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>Logout
        </a>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="form-container">
            <h2 class="form-title">Add New Stationery</h2>
            <form action="Stationery" method="post" id="stationeryForm">
                <input type="hidden" name="action" value="add" />

                <div class="form-group">
                    <label for="name"><i class="fas fa-tag"></i>Name</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Enter stationery name" required />
                </div>

                <div class="form-group">
                    <label for="description"><i class="fas fa-align-left"></i>Description</label>
                    <input type="text" id="description" name="description" class="form-control" placeholder="Enter description" required />
                </div>

                <div class="form-group">
                    <label for="price"><i class="fas fa-tag"></i>Price (Rs.)</label>
                    <input type="number" id="price" name="price" step="0.01" class="form-control" placeholder="Enter price" required />
                </div>

                <div class="form-group">
                    <label for="quantity"><i class="fas fa-cubes"></i>Quantity</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" placeholder="Enter quantity" required />
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-plus-circle"></i>Add Stationery
                </button>
            </form>
        </div>
    </main>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
        }

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

        document.getElementById('stationeryForm').addEventListener('submit', function(e) {
            const price = document.getElementById('price').value;
            const quantity = document.getElementById('quantity').value;
            
            if (price <= 0) {
                e.preventDefault();
                alert('Price must be greater than 0');
                return false;
            }
            
            if (quantity <= 0) {
                e.preventDefault();
                alert('Quantity must be greater than 0');
                return false;
            }
        });

        // Show menu toggle on mobile
        function checkWidth() {
            if (window.innerWidth <= 992) {
                document.querySelector('.menu-toggle').style.display = 'flex';
            } else {
                document.querySelector('.menu-toggle').style.display = 'none';
                document.getElementById('sidebar').classList.remove('active');
            }
        }

        window.addEventListener('resize', checkWidth);
        window.addEventListener('load', checkWidth);
    </script>
</body>
</html>