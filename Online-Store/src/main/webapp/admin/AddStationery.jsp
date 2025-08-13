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
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Add Stationery</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Sidebar and layout styles from admin theme */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7f9fc;
            color: #333;
        }
        
            .logo {
            font-weight: 500;
            font-size: 28px;
            letter-spacing: 2px;
            color: #f1c40f;
            margin: 0 0 12px 20px;
            cursor: default;
            transition: color 0.3s ease;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
            text-decoration: none;
            
         
        }
        
           .logo:hover {
            color: #e67e22;
            text-decoration: none;
                        cursor: pointer;
            
      
    }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 220px;
            height: 100%;
            background: linear-gradient(180deg, #34495e, #2c3e50);
            padding-top: 60px;
            box-shadow: 3px 0 12px rgba(0,0,0,0.15);
            overflow-y: auto;
        }
        .sidebar h2 {
            color: #ecf0f1;
            text-align: center;
            font-weight: 600;
            font-size: 24px;
            margin: 0 0 10px;
            letter-spacing: 1.2px;
            border-bottom: 1px solid rgba(236, 240, 241, 0.15);
            padding-bottom: 12px;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar ul li a {
            display: block;
            padding: 16px 24px;
            color: #bdc3c7;
            font-weight: 500;
            text-decoration: none;
            border-left: 5px solid transparent;
            transition: all 0.3s ease;
            font-size: 17px;
        }
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            color: #ecf0f1;
            background: rgba(255,255,255,0.1);
            border-left: 5px solid #f39c12;
            font-weight: 700;
        }
        .main-content {
            margin-left: 220px;
            padding: 120px 40px 40px;
            min-height: 100vh;
            background: linear-gradient(135deg, #f7f9fc, #e3eaf2);
            display: flex;
            justify-content: center;
            align-items: start;
        }
        .top-header {
            position: fixed;
            left: 220px;
            top: 0;
            right: 0;
            height: 60px;
            background-color: #34495e;
            color: #ecf0f1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.15);
            font-size: 18px;
            font-weight: 600;
            z-index: 1000;
        }
        .logout-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.6);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .logout-btn:hover {
            background-color: #c0392b;
            box-shadow: 0 6px 15px rgba(192, 57, 43, 0.7);
        }
        .form-container {
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 480px;
            transition: box-shadow 0.3s ease;
        }
        .form-container:hover {
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        h2 {
            font-weight: 700;
            margin-bottom: 30px;
            color: #2c3e50;
        }
        .btn-primary {
         margin-top: 30px;
            width: 100%;
            background-color: #2980b9;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 700;
            font-size: 1.1rem;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #1c5980;
            border-color: #1c5980;
        }
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
                padding-top: 50px;
            }
            .main-content {
                margin-left: 180px;
                padding: 80px 20px 20px;
                justify-content: center;
            }
            .top-header {
                left: 180px;
                height: 50px;
                padding: 0 20px;
                font-size: 16px;
            }
            .sidebar ul li a {
                font-size: 14px;
                padding: 12px 16px;
            }
        }
        @media (max-width: 600px) {
            .sidebar {
                display: none;
            }
            .main-content {
                margin-left: 0;
                padding: 80px 15px 15px;
            }
            .top-header {
                left: 0;
                right: 0;
            }
        }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <nav class="sidebar">
            <a class="logo" href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="logo">PahanaBook</a>
    
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="AddBook.jsp">Add Book</a></li>
            <li><a href="Book?action=list">Manage Books</a></li>
            <li><a href="${pageContext.request.contextPath}/User?action=list">Manage Users</a></li>
            <li><a href="AddStationery.jsp" class="active">Add Stationery</a></li>
            <li><a href="Stationery?action=list">Manage Stationery</a></li>
        </ul>
    </nav>

    <!-- Top Header -->
    <header class="top-header">
        <div class="welcome">Welcome Admin: <%= user.getUsername() %></div>
        <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </header>

    <!-- Main content area -->
    <main class="main-content">
        <div class="form-container">
            <h2>Add Stationery</h2>
            <form action="Stationery" method="post">
                <input type="hidden" name="action" value="add" />

                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" placeholder="Stationery name" required class="form-control" />
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description" placeholder="Description" required class="form-control" />
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" placeholder="Price" required class="form-control" />
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" min="0" placeholder="Quantity" required class="form-control" />
                </div>

                <input type="submit" value="Add Stationery" class="btn btn-primary btn-block" />
            </form>
        </div>
    </main>

</body>
</html>
