<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Book Management - PahanaBook</title>
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

        .add-btn {
            background: linear-gradient(45deg, var(--success), #219653);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
        }

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        /* Table Styling */
        .book-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1rem;
            margin-top: 20px;
        }

        .book-table th {
            background: #2980b9;
            color: white;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
        }

        .book-table th:first-child {
            border-top-left-radius: 10px;
        }

        .book-table th:last-child {
            border-top-right-radius: 10px;
        }

        .book-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #ecf0f1;
            vertical-align: middle;
        }

        .book-table tr:last-child td {
            border-bottom: none;
        }

        .book-table tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
            transition: var(--transition);
        }

        /* Book Image */
        .book-image {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: var(--transition);
        }

        .book-image:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .btn-edit {
            background: linear-gradient(45deg, var(--info), #2980b9);
            color: white;
            box-shadow: 0 3px 10px rgba(52, 152, 219, 0.3);
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }

        .btn-delete {
            background: linear-gradient(45deg, var(--danger), #c0392b);
            color: white;
            box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
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

      

        /* Responsive Design */
        @media (max-width: 1200px) {
            .book-table {
                font-size: 0.9rem;
            }
            
            .btn {
                padding: 8px 15px;
                font-size: 0.8rem;
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
            
            .table-container {
                padding: 20px;
            }
            
            .page-header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
        }

        @media (max-width: 768px) {
            .book-table {
                display: block;
                overflow-x: auto;
            }
            
            .book-table th,
            .book-table td {
                padding: 12px 8px;
                font-size: 0.85rem;
            }
            
            .book-image {
                width: 50px;
                height: 70px;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }
            
            .btn {
                justify-content: center;
                padding: 8px 12px;
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
            
            .add-btn {
                padding: 12px 20px;
                font-size: 0.9rem;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .table-container {
            animation: fadeIn 0.6s ease-out;
        }

        .book-table tr {
            animation: fadeIn 0.4s ease-out;
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

        .table-container::-webkit-scrollbar {
            height: 8px;
        }

        .table-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .table-container::-webkit-scrollbar-thumb {
            background: var(--info);
            border-radius: 10px;
        }
    </style>
    <script>
        function confirmDelete(title, id) {
            if (confirm('Are you sure you want to delete "' + title + '"?')) {
                window.location.href = 'Book?action=delete&id=' + id;
            }
        }
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
            <li><a href="AddUser.jsp"><i class="fas fa-user-plus"></i>Add User</a></li>
          <li><a href="Book?action=list" class="active"><i class="fas fa-book"></i>Manage Books</a></li>
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
                <p>Manage your book inventory efficiently</p>
            </div>
            <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>Logout
            </a>
        </header>

        <!-- Page Header -->
        <div class="page-header">
            <h2 class="page-title">
                <i class="fas fa-books"></i>Book Management
            </h2>
            <a href="AddBook.jsp" class="add-btn">
                <i class="fas fa-plus-circle"></i>Add New Book
            </a>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty bookList}">
                    <table class="book-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Cover</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Category</th>
                                <th>Price (Rs.)</th>
                                <th>Quantity</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${bookList}">
                                <tr>
                                    <td>${book.id}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/${book.image}" 
                                             class="book-image" 
                                             alt="${book.title}"
                                             onerror="this.src='https://via.placeholder.com/60x80?text=No+Image'">
                                    </td>
                                    <td><strong>${book.title}</strong></td>
                                    <td>${book.author}</td>
                                    <td>${book.category}</td>
                                    <td>Rs. ${book.price}</td>
                                    <td>${book.quantity}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="Book?action=edit&id=${book.id}" class="btn btn-edit">
                                                <i class="fas fa-edit"></i>Edit
                                            </a>
                                            <button onclick="confirmDelete('${book.title}', ${book.id})" 
                                                    class="btn btn-delete">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-book-open"></i>
                        <h3>No Books Found</h3>
                        <p>Get started by adding your first book to the collection</p>
                        <a href="AddBook.jsp" class="add-btn">
                            <i class="fas fa-plus-circle"></i>Add Your First Book
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
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

        // Add hover effects to table rows
        document.querySelectorAll('.book-table tr').forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9fa';
                this.style.transform = 'scale(1.01)';
            });
            
            row.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
                this.style.transform = 'scale(1)';
            });
        });

        // Image error handling
        document.querySelectorAll('.book-image').forEach(img => {
            img.addEventListener('error', function() {
                this.src = 'https://via.placeholder.com/60x80?text=No+Image';
            });
        });
    </script>
</body>
</html>