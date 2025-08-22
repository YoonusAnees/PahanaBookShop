<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Edit Book - PahanaBook</title>
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
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 650px;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .form-title i {
            color: var(--accent);
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
            gap: 8px;
            font-weight: 600;
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
            box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.1);
        }

        .file-input-container {
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            transition: var(--transition);
        }

        .file-input-container:hover {
            border-color: var(--accent);
            background: #e9ecef;
        }

        .file-input-label {
            display: block;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            color: #6c757d;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .file-input-label i {
            font-size: 22px;
            margin-bottom: 8px;
            display: block;
            color: var(--info);
        }

        .file-input {
            position: absolute;
            left: -9999px;
        }

        .current-image-container {
            text-align: center;
            margin: 15px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border: 1px dashed #dee2e6;
        }

        .current-image-container p {
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .current-image {
            max-width: 150px;
            max-height: 200px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border: 1px solid #dee2e6;
        }

        .file-preview {
            margin-top: 10px;
            text-align: center;
            display: none;
        }

        .file-preview img {
            max-width: 150px;
            max-height: 200px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(45deg, var(--success), #219653);
            color: white;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            background: linear-gradient(45deg, #219653, var(--success));
            box-shadow: 0 6px 18px rgba(39, 174, 96, 0.4);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--info);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }

        .back-link:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
            }

            .form-container {
                margin-top: 140px;
                padding: 20px;
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
                padding: 18px;
                margin-top: 160px;
            }
            
            .form-title {
                font-size: 1.3rem;
            }
            
            .form-control {
                padding: 10px 12px;
            }
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
            <li><a href="${pageContext.request.contextPath}/User?action=list"><i class="fas fa-users"></i>Manage Users</a></li>
            <li><a href="AddStationery.jsp"><i class="fas fa-pencil-alt"></i>Add Stationery</a></li>
            <li><a href="Stationery?action=list"><i class="fas fa-pencil-ruler"></i>Manage Stationery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order-history"><i class="fas fa-history"></i>Orders History</a></li>
        </ul>
    </nav>

    <!-- Header -->
    <header class="header">
        <div class="welcome-text">
            <h1>Welcome Admin: <%= user.getUsername() %></h1>
            <p>Edit book details</p>
        </div>
        <a href="<%= request.getContextPath() %>/LogoutController" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>Logout
        </a>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="form-container">
            <h2 class="form-title">
                <i class="fas fa-edit"></i>Edit Book
            </h2>
            
            <form action="Book?action=update" method="post" enctype="multipart/form-data" id="bookForm">
                <input type="hidden" name="id" value="${book.id}" />
                <input type="hidden" name="existingImage" value="${book.image}" />

                <div class="form-group">
                    <label for="title"><i class="fas fa-heading"></i>Title</label>
                    <input type="text" id="title" name="title" class="form-control" value="${book.title}" required />
                </div>

                <div class="form-group">
                    <label for="author"><i class="fas fa-user"></i>Author</label>
                    <input type="text" id="author" name="author" class="form-control" value="${book.author}" required />
                </div>

                <div class="form-group">
                    <label for="category"><i class="fas fa-tag"></i>Category</label>
                    <input type="text" id="category" name="category" class="form-control" value="${book.category}" required />
                </div>

                <div class="form-group">
                    <label for="price"><i class="fas fa-dollar-sign"></i>Price (Rs.)</label>
                    <input type="number" id="price" name="price" step="0.01" class="form-control" value="${book.price}" required />
                </div>

                <div class="form-group">
                    <label for="quantity"><i class="fas fa-cubes"></i>Quantity</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" value="${book.quantity}" required />
                </div>

                <div class="current-image-container">
                    <p><i class="fas fa-image"></i>Current Book Cover</p>
                    <img src="${pageContext.request.contextPath}${book.image}" alt="Current book cover" class="current-image" 
                         onerror="this.src='https://via.placeholder.com/150x200?text=No+Image'">
                </div>

                <div class="form-group">
                    <label for="image"><i class="fas fa-camera"></i>Change Cover Image (Optional)</label>
                    <div class="file-input-container">
                        <label for="image" class="file-input-label">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <span>Choose new book cover image</span>
                        </label>
                        <input type="file" id="image" name="image" class="file-input" accept="image/*" onchange="previewImage(this)" />
                    </div>
                    <div class="file-preview" id="imagePreview">
                        <img src="" alt="Image preview" id="previewImg" />
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i>Update Book
                </button>
                
            
            </form>
        </div>
    </main>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const previewImg = document.getElementById('previewImg');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    preview.style.display = 'block';
                }
                
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
            }
        }

        document.getElementById('bookForm').addEventListener('submit', function(e) {
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
        
        // Handle image loading errors
        document.querySelector('.current-image').addEventListener('error', function() {
            this.src = 'https://via.placeholder.com/150x200?text=No+Image';
        });
    </script>
</body>
</html>