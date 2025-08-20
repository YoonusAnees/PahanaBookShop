<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <meta charset="ISO-8859-1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - PahanaBook</title>
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
            padding: 30px;
            transition: var(--transition);
            min-height: 100vh;
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

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-title i {
            color: var(--accent);
            font-size: 2.2rem;
        }

        /* Search Bar */
        .search-container {
            position: relative;
            margin-bottom: 30px;
        }

        .search-input {
            width: 100%;
            padding: 15px 50px 15px 20px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.1);
        }

        .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.2rem;
        }

        /* Customer Section */
        .customer-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: var(--transition);
            border-left: 4px solid var(--info);
        }

        .customer-section:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .customer-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f8f9fa;
        }

        .customer-info h3 {
            color: var(--info);
            font-size: 1.4rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .customer-details {
            color: #6c757d;
            font-size: 0.95rem;
        }

        .customer-details p {
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .order-date {
            background: linear-gradient(45deg, var(--accent), #e67e22);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        /* Order Table */
        .order-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
            margin-top: 20px;
        }

        .order-table th {
            background:  #2980b9;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            border: none;
        }

        .order-table th:first-child {
            border-top-left-radius: 10px;
        }

        .order-table th:last-child {
            border-top-right-radius: 10px;
        }

        .order-table td {
            padding: 15px;
            border-bottom: 1px solid #ecf0f1;
            vertical-align: middle;
        }

        .order-table tr:last-child td {
            border-bottom: none;
        }

        .order-table tr:hover {
            background-color: #f8f9fa;
        }

        /* Item Type Badges */
        .item-type {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .type-book {
            background: linear-gradient(45deg, var(--success), #219653);
            color: white;
        }

        .type-stationery {
            background: linear-gradient(45deg, #8e44ad, #6c3483);
            color: white;
        }

        /* Price styling */
        .price {
            font-weight: 700;
            color: var(--success);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .empty-state i {
            font-size: 4rem;
            color: #bdc3c7;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 30px;
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
        @media (max-width: 1200px) {
            .order-table {
                font-size: 0.9rem;
            }
        }

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
            
            .menu-toggle {
                display: flex;
            }
            
            .customer-section {
                padding: 20px;
            }
            
            .customer-header {
                flex-direction: column;
                gap: 15px;
            }
        }

        @media (max-width: 768px) {
            .order-table {
                display: block;
                overflow-x: auto;
            }
            
            .order-table th,
            .order-table td {
                padding: 12px 8px;
                font-size: 0.85rem;
            }
            
            .customer-info h3 {
                font-size: 1.2rem;
            }
            
            .item-type {
                font-size: 0.75rem;
                padding: 4px 8px;
            }
        }

        @media (max-width: 576px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .welcome-text h1 {
                font-size: 1.5rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .search-input {
                padding: 12px 45px 12px 15px;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .customer-section {
            animation: fadeIn 0.6s ease-out;
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

        .order-table::-webkit-scrollbar {
            height: 8px;
        }

        .order-table::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .order-table::-webkit-scrollbar-thumb {
            background: var(--info);
            border-radius: 10px;
        }
    </style>
    <script>
        function searchCustomer() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var customers = document.getElementsByClassName("customer-section");

            for (var i = 0; i < customers.length; i++) {
                var name = customers[i].getAttribute("data-customer-name").toLowerCase();
                if (name.indexOf(filter) > -1) {
                    customers[i].style.display = "";
                    customers[i].style.animation = "fadeIn 0.6s ease-out";
                } else {
                    customers[i].style.display = "none";
                }
            }
        }

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

        // Add hover effects to customer sections
        document.addEventListener('DOMContentLoaded', function() {
            const customerSections = document.querySelectorAll('.customer-section');
            customerSections.forEach(section => {
                section.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 10px 30px rgba(0,0,0,0.15)';
                });
                
                section.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(-2px)';
                    this.style.boxShadow = '0 8px 25px rgba(0,0,0,0.12)';
                });
            });
        });
    </script>
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
            <li><a href="${pageContext.request.contextPath}/User?action=list"><i class="fas fa-users"></i>Manage Users</a></li>
            <li><a href="AddStationery.jsp"><i class="fas fa-pencil-alt"></i>Add Stationery</a></li>
            <li><a href="Stationery?action=list"><i class="fas fa-pencil-ruler"></i>Manage Stationery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order-history" class="active"><i class="fas fa-history"></i>Orders History</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="header">
            <div class="welcome-text">
                <h1>Welcome Admin: <%= user.getUsername() %></h1>
                <p>View and manage customer order history</p>
            </div>
            <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>Logout
            </a>
        </header>

        <!-- Page Header -->
        <div class="page-header">
            <h2 class="page-title">
                <i class="fas fa-shopping-bag"></i>Order History
            </h2>
        </div>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" onkeyup="searchCustomer()" 
                   placeholder="Search by customer name...">
            <i class="fas fa-search search-icon"></i>
        </div>

        <c:choose>
            <c:when test="${not empty orders}">
                <c:set var="lastCustomer" value="" />
                <c:forEach var="order" items="${orders}">
                    <c:if test="${lastCustomer ne order.fullName}">
                        <!-- Close previous section if not first customer -->
                        <c:if test="${lastCustomer ne ''}">
                            </tbody>
                            </table>
                            </div>
                        </c:if>

                        <!-- Customer section -->
                        <div class="customer-section" data-customer-name="${order.fullName}">
                            <div class="customer-header">
                                <div class="customer-info">
                                    <h3><i class="fas fa-user"></i>${order.fullName}</h3>
                                    <div class="customer-details">
                                        <p><i class="fas fa-envelope"></i>${order.email}</p>
                                        <p><i class="fas fa-map-marker-alt"></i>${order.address}</p>
                                    </div>
                                </div>
                                <span class="order-date">
                                    <i class="fas fa-calendar-alt"></i>
                                    ${order.orderDate}
                                </span>
                            </div>

                            <!-- Order table for this customer -->
                            <table class="order-table">
                                <thead>
                                    <tr>
                                        <th>Item Type</th>
                                        <th>Title / Name</th>
                                        <th>Quantity</th>
                                        <th>Price (Rs.)</th>
                                    </tr>
                                </thead>
                                <tbody>
                        <c:set var="lastCustomer" value="${order.fullName}" />
                    </c:if>

                    <!-- Order Items -->
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td>
                                <span class="item-type ${item.book != null ? 'type-book' : 'type-stationery'}">
                                    <c:choose>
                                        <c:when test="${item.book != null}">Book</c:when>
                                        <c:otherwise>Stationery</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <strong>
                                    <c:choose>
                                        <c:when test="${item.book != null}">${item.book.title}</c:when>
                                        <c:otherwise>${item.stationery.name}</c:otherwise>
                                    </c:choose>
                                </strong>
                            </td>
                            <td>${item.quantity}</td>
                            <td class="price">Rs. ${item.price}</td>
                        </tr>
                    </c:forEach>
                </c:forEach>

                <!-- Close last customer section -->
                </tbody>
                </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-shopping-bag"></i>
                    <h3>No Orders Found</h3>
                    <p>There are no orders in the system yet</p>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>