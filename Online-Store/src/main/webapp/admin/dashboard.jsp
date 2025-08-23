<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.DAO.BookDAO" %>
<%@ page import="com.pahana.bookshop.DAO.UserDAO" %>
<%@ page import="com.pahana.bookshop.DAO.StationeryDAO" %>
<%@ page import="com.pahana.bookshop.DAO.OrderDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.Order" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="com.pahana.bookshop.model.Stationery" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    BookDAO bookDAO = new BookDAO();
    UserDAO userDAO = new UserDAO();
    StationeryDAO stationeryDAO = new StationeryDAO();
    OrderDAO orderDAO = new OrderDAO();

    int bookCount = bookDAO.selectAllBooks().size();
    int userCount = userDAO.getAllUsers().size();
    int stationeryCount = stationeryDAO.getAllStationery().size();
    int orderCount = orderDAO.getAllOrders().size(); 
    
    // Get low stock items
    List<Book> lowStockBooks = bookDAO.getLowStockBooks(5);
    List<Stationery> lowStockStationery = stationeryDAO.getLowStockStationery(5);
    
    // Get recent orders for the chart
    List<Order> recentOrders = orderDAO.getAllOrders();
    if (recentOrders.size() > 5) {
        recentOrders = recentOrders.subList(0, 5);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PahanaBook</title>
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        /* Widgets */
        .widget {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: var(--transition);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            text-decoration: none;
        }

        .widget::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: var(--accent);
        }

        .widget:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .widget-books::before { background: var(--info); }
        .widget-users::before { background: var(--success); }
        .widget-stationery::before { background: #8e44ad; }
        .widget-orders::before { background: var(--warning); }

        .widget-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .widget-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
        }

        .widget-books .widget-icon { background: var(--info); }
        .widget-users .widget-icon { background: var(--success); }
        .widget-stationery .widget-icon { background: #8e44ad; }
        .widget-orders .widget-icon { background: var(--warning); }

        .widget-info {
            text-align: right;
        }

        .widget-number {
            font-size: 2.5rem;
            font-weight: 800;
            line-height: 1;
            margin-bottom: 5px;
        }

        .widget-books .widget-number { color: var(--info); }
        .widget-users .widget-number { color: var(--success); }
        .widget-stationery .widget-number { color: #8e44ad; }
        .widget-orders .widget-number { color: var(--warning); }

        .widget-label {
            color: #7f8c8d;
            font-weight: 600;
            font-size: 0.9rem;
        }

        /* Low Stock Alert */
        .low-stock-alert {
            position: absolute;
            top: 10px;
            right: 4px;
            background: var(--danger);
            color: white;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        /* Low Stock Section */
        .low-stock-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .low-stock-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .low-stock-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ecf0f1;
        }

        .low-stock-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .low-stock-title i {
            color: var(--danger);
        }

        .low-stock-list {
            list-style: none;
        }

        .low-stock-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .low-stock-item:last-child {
            border-bottom: none;
        }

        .low-stock-info h4 {
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--dark);
        }

        .low-stock-info p {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .low-stock-quantity {
            background: #ffe8e8;
            color: var(--danger);
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .no-low-stock {
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-style: italic;
        }

   

        /* Recent Orders */
        .recent-orders {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .orders-list {
            list-style: none;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #ecf0f1;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-info h4 {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .order-info p {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .order-status {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-completed {
            background: #e8f5e8;
            color: var(--success);
        }

        .status-pending {
            background: #fef5e7;
            color: var(--warning);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .charts-section, .low-stock-section {
                grid-template-columns: 1fr;
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
            
            .dashboard-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
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
            
            .dashboard-grid, .low-stock-section {
                grid-template-columns: 1fr;
            }
            
            .widget-content {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .widget-info {
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .main-content {
                padding: 15px;
            }
            
            .widget, .low-stock-container {
                padding: 20px;
            }
            
            .widget-number {
                font-size: 2rem;
            }
            
            .chart-container,
            .recent-orders {
                padding: 20px;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .widget {
            animation: fadeIn 0.6s ease-out;
        }

        .low-stock-container {
            animation: fadeIn 0.7s ease-out;
        }

        .chart-container {
            animation: fadeIn 0.8s ease-out;
        }

        .recent-orders {
            animation: fadeIn 1s ease-out;
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
    <div class="menu-toggle" style="display: none; position: fixed; top: 20px; left: 20px; z-index: 1100; background: var(--primary); color: white; width: 40px; height: 40px; border-radius: 50%; align-items: center; justify-content: center; box-shadow: 0 2px 10px rgba(0,0,0,0.2); cursor: pointer;" onclick="toggleSidebar()">
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
                <p>Manage your bookstore efficiently with our admin dashboard</p>
            </div>
            <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>Logout
            </a>
        </header>

        <!-- Dashboard Widgets -->
        <div class="dashboard-grid">
            <a href="Book?action=list" class="widget widget-books">
                <% if (lowStockBooks.size() > 0) { %>
                    <div class="low-stock-alert"><%= lowStockBooks.size() %></div>
                <% } %>
                <div class="widget-content">
                    <div class="widget-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="widget-info">
                        <div class="widget-number"><%= bookCount %></div>
                        <div class="widget-label">Total Books</div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/User?action=list" class="widget widget-users">
                <div class="widget-content">
                    <div class="widget-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="widget-info">
                        <div class="widget-number"><%= userCount %></div>
                        <div class="widget-label">Active Users</div>
                    </div>
                </div>
            </a>

            <a href="Stationery?action=list" class="widget widget-stationery">
                <% if (lowStockStationery.size() > 0) { %>
                    <div class="low-stock-alert"><%= lowStockStationery.size() %></div>
                <% } %>
                <div class="widget-content">
                    <div class="widget-icon">
                        <i class="fas fa-pencil-alt"></i>
                    </div>
                    <div class="widget-info">
                        <div class="widget-number"><%= stationeryCount %></div>
                        <div class="widget-label">Stationery Items</div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/order-history" class="widget widget-orders">
                <div class="widget-content">
                    <div class="widget-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="widget-info">
                        <div class="widget-number"><%= orderCount %></div>
                        <div class="widget-label">Total Orders</div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Low Stock Alerts Section -->
        <div class="low-stock-section">
            <!-- Low Stock Books -->
            <div class="low-stock-container">
                <div class="low-stock-header">
                    <h3 class="low-stock-title">
                        <i class="fas fa-exclamation-triangle"></i>
                        Low Stock Books
                    </h3>
                    <span class="low-stock-count"><%= lowStockBooks.size() %> items</span>
                </div>
                
                <% if (lowStockBooks.size() > 0) { %>
                    <ul class="low-stock-list">
                        <% for (Book book : lowStockBooks) { %>
                        <li class="low-stock-item">
                            <div class="low-stock-info">
                                <h4><%= book.getTitle() %></h4>
                                <p>ID: <%= book.getId() %></p>
                            </div>
                            <span class="low-stock-quantity"><%= book.getQuantity() %> left</span>
                        </li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <div class="no-low-stock">
                        <i class="fas fa-check-circle" style="font-size: 2rem; color: var(--success); margin-bottom: 10px;"></i>
                        <p>All books are sufficiently stocked</p>
                    </div>
                <% } %>
            </div>

            <!-- Low Stock Stationery -->
            <div class="low-stock-container">
                <div class="low-stock-header">
                    <h3 class="low-stock-title">
                        <i class="fas fa-exclamation-triangle"></i>
                        Low Stock Stationery
                    </h3>
                    <span class="low-stock-count"><%= lowStockStationery.size() %> items</span>
                </div>
                
                <% if (lowStockStationery.size() > 0) { %>
                    <ul class="low-stock-list">
                        <% for (Stationery stationery : lowStockStationery) { %>
                        <li class="low-stock-item">
                            <div class="low-stock-info">
                                <h4><%= stationery.getName() %></h4>
                                <p>ID: <%= stationery.getId() %></p>
                            </div>
                            <span class="low-stock-quantity"><%= stationery.getQuantity() %> left</span>
                        </li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <div class="no-low-stock">
                        <i class="fas fa-check-circle" style="font-size: 2rem; color: var(--success); margin-bottom: 10px;"></i>
                        <p>All stationery items are sufficiently stocked</p>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Charts Section -->
    

        <!-- Recent Orders -->
        <div class="recent-orders">
            <div class="chart-header">
                <h3 class="chart-title">Recent Orders</h3>
                <a href="${pageContext.request.contextPath}/admin/order-history" style="color: var(--info); text-decoration: none;">
                    View All <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <ul class="orders-list">
                <% for (Order order : recentOrders) { %>
                <li class="order-item">
                    <div class="order-info">
                        <h4>Order #<%= order.getId() %></h4>
                        <p>Customer: <%= order.getFullName() %></p>
                        <p><%= order.getOrderDate() %></p>
                    </div>
                    <span class="order-status status-completed">Completed</span>
                </li>
                <% } %>
            </ul>
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

        // Initialize Charts
        document.addEventListener('DOMContentLoaded', function() {
            // Sales Chart
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            const salesChart = new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                        label: 'Sales (Rs)',
                        data: [12000, 19000, 15000, 25000, 22000, 30000, 28000],
                        borderColor: '#3498db',
                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Inventory Chart
            const inventoryCtx = document.getElementById('inventoryChart').getContext('2d');
            const inventoryChart = new Chart(inventoryCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Books', 'Stationery', 'E-books'],
                    datasets: [{
                        data: [<%= bookCount %>, <%= stationeryCount %>, 45],
                        backgroundColor: [
                            '#3498db',
                            '#8e44ad',
                            '#2ecc71'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    cutout: '70%',
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // Store charts for updates
            window.salesChart = salesChart;
            window.inventoryChart = inventoryChart;
        });

        // Update chart based on selection
        function updateChart() {
            const range = document.getElementById('chartRange').value;
            let labels, data;

            switch(range) {
                case 'week':
                    labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    data = [12000, 19000, 15000, 25000, 22000, 30000, 28000];
                    break;
                case 'month':
                    labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                    data = [85000, 92000, 78000, 105000];
                    break;
                case 'year':
                    labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    data = [320000, 280000, 350000, 420000, 380000, 450000, 520000, 480000, 550000, 600000, 580000, 650000];
                    break;
            }

            window.salesChart.data.labels = labels;
            window.salesChart.data.datasets[0].data = data;
            window.salesChart.update();
        }

        // Add hover effects to widgets
        document.querySelectorAll('.widget').forEach(widget => {
            widget.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px)';
                this.style.boxShadow = '0 15px 35px rgba(0,0,0,0.2)';
            });
            
            widget.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 10px 30px rgba(0,0,0,0.15)';
            });
        });
    </script>
</body>
</html>