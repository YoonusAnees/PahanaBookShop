<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="com.pahana.bookshop.model.Customer" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    Customer customer = (Customer) request.getAttribute("customer");
    List<String> recommendations = (List<String>) request.getAttribute("recommendations");
    
    // Default recommendations if none are provided
    if (recommendations == null) {
        recommendations = new ArrayList<>();
        recommendations.add("Bestselling Fiction");
        recommendations.add("Popular Science Books");
        recommendations.add("Award-winning Novels");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Customer Dashboard - PahanaBook</title>
    <link rel="icon" type="image/png"  href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />
    
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            margin: 0; 
            padding: 0;
            color: #333;
        }

        /* Navbar */
        nav {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            letter-spacing: 1px;
            color: #f1c40f;
            text-decoration: none;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #f1c40f;
        }
        
        .nav-links span {
            font-weight: bold;
        
        }
        
        .nav-links .logout:hover { color: red; }
        
        .nav-links a.active {
            color: #f1c40f;
            font-weight: bold;
        }

        /* Burger Menu */
        .burger {
            display: none;
            flex-direction: column;
            cursor: pointer;
        }
        .burger div {
            width: 25px;
            height: 3px;
            background: white;
            margin: 4px;
            transition: all 0.3s ease;
        }

        /* Mobile Menu (Centered Modal Style) */
        .nav-links.mobile {
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: rgba(44,62,80,0.95);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 999;
        }
        .nav-links.mobile a {
            margin: 15px 0;
            text-align: center;
            color: white;
            font-size: 1.3rem;
        }
        
       
        .nav-links.mobile.show {
            display: flex;
        }
        .close-btn {
            position: absolute;
            top: 20px;
            right: 25px;
            color: white;
            font-size: 2rem;
            cursor: pointer;
        }


        /* Search Form */
        .search-form {
            display: flex;
            align-items: center;
            margin-left: 320px;
        }
        .search-form input[type="text"] {
            padding: 8px 10px;
            border-radius: 4px;
            border: none;
            font-size: 1rem;
        }
        .search-form button {
            padding: 9px 12px;
            margin-left: 5px;
            border: none;
            border-radius: 4px;
            background-color: #f1c40f;
            color: #2c3e50;
            font-weight: bold;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #e67e22;
            color: white;
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(135deg, #3498db, #2c3e50);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .welcome-section h1 {
            margin-top: 0;
            font-size: 2.5rem;
        }
        
        .welcome-section p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto;
        }
        
        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .dashboard-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .dashboard-card h3 {
            color: #2c3e50;
            margin-top: 0;
            border-bottom: 2px solid #f1c40f;
            padding-bottom: 10px;
        }
        
        .dashboard-card p {
            color: #555;
            line-height: 1.6;
        }
        
        .dashboard-card ul {
            padding-left: 20px;
            color: #555;
        }
        
        .dashboard-card li {
            margin-bottom: 8px;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .action-btn {
            padding: 12px 25px;
            background-color: #f1c40f;
            color: #2c3e50;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1rem;
            text-decoration: none;
            display: inline-block;
        }
        
        .action-btn:hover {
            background-color: #e67e22;
            color: white;
            transform: translateY(-2px);
        }
        
        /* Book Grid (Hidden by default) */
        .book-grid {
            display: none;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .book-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }
        
        .book-card:hover {
            transform: translateY(-5px);
        }
        
        .book-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        
        .book-card h3 {
            color: #34495e;
            margin: 0 0 10px 0;
        }
        
        .book-card p {
            margin: 6px 0;
            color: #555;
            font-size: 0.95rem;
        }

        /* Form container to push button to bottom */
        .card-content {
            flex: 1 0 auto;
        }
        
        .card-actions {
            margin-top: 10px;
        }

        /* Add to Cart Button */
        .book-card button {
            padding: 10px;
            width: 100%;
            background-color: #f1c40f;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .book-card button:hover {
            background-color: #e67e22;
        }

        /* Message */
        .message {
            text-align: center;
            color: #666;
            font-size: 1.2rem;
            padding: 40px 0;
        }

        /* Footer */
        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px 0;
            width: 100%;
            font-size: 0.9rem;
            margin-top: 40px;
        }
        
        @media (max-width: 768px) {
            .search-form {
                display: none;
            }
            .nav-links {
                display: none;
            }
            .burger {
                display: flex;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .welcome-section h1 {
                font-size: 2rem;
            }
            
            .welcome-section p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <form class="search-form" method="get" action="<%= request.getContextPath() %>/customer/Search">
        <input type="text" name="query" placeholder="Search books or stationery..." required />
        <button type="submit">Search</button>
    </form>
    <div class="nav-links" id="navLinks">
       <span>Welcome, <%= user.getUsername() %>!</span>
        <a href="<%= request.getContextPath() %>/customer/dashboard" class="active">Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard?show=books">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
    </div>
    <div class="burger" onclick="openMenu()">
        <div></div>
        <div></div>
        <div></div>
    </div>
</nav>

<!-- Mobile Nav -->
<div class="nav-links mobile" id="mobileMenu">
    <div class="close-btn" onclick="closeMenu()">✖</div>
        <a>Welcome, <%= user.getUsername() %>!</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard" class="active">Home</a>
        <a href="<%= request.getContextPath() %>/customer/dashboard?show=books">Books</a>
        <a href="<%= request.getContextPath() %>/customer/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/customer/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>">Cart</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutController">Logout</a>
</div>

<!-- Main Content -->
<div class="container">
    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1>Welcome back, <%= user.getUsername() %>!</h1>
        <p>We're glad to see you again. Discover new books, explore our stationery collection, and enjoy exclusive member benefits.</p>
    </div>
    
    <!-- Dashboard Cards -->
    <div class="dashboard-cards">
        <div class="dashboard-card">
            <h3>Your Profile</h3>
            <p><strong>Username:</strong> <%= user.getUsername() %></p>
            <p><strong>Role:</strong> <%= user.getRole() %></p>
            <% if (customer != null) { %>
                <p><strong>Account Number:</strong> <%= customer.getAccountNumber() %></p>
                <p><strong>Name:</strong> <%= customer.getName() %></p>
                <p><strong>Address:</strong> <%= customer.getAddress() %></p>
                <p><strong>Telephone:</strong> <%= customer.getTelephone() %></p>
            <% } else { %>
                <p><strong>Customer details not available</strong></p>
            <% } %>
        </div>
        
        <div class="dashboard-card">
            <h3>Quick Actions</h3>
            <ul>
                <li>Browse our latest book arrivals</li>
                <li>Check out special offers</li>
                <li>View your reading history</li>
                <li>Update your preferences</li>
            </ul>
        </div>
        
<div class="dashboard-card">
    <h3>Your Reading Preferences</h3>
    <% 
        List<String> orderCategories = (List<String>) request.getAttribute("orderCategories");
        System.out.println("JSP - orderCategories: " + orderCategories);
        
        if (orderCategories != null && !orderCategories.isEmpty()) { 
    %>
        <p>Based on your purchase history, you enjoy:</p>
        <ul>
            <% for (String category : orderCategories) { 
                System.out.println("JSP - Displaying category: " + category);
            %>
                <li><strong><%= category %></strong></li>
            <% } %>
        </ul>
    <% } else if (orderCategories == null) { %>
        <p>You haven't purchased any books yet.</p>
        <p>Explore our collection to discover your favorite categories!</p>
        <div style="margin-top: 15px; padding: 10px; background: #f8f9fa; border-radius: 8px;">
            <p><strong>Popular starting points:</strong></p>
            <ul>
                <li>Fantasy & Adventure</li>
                <li>Classic Literature</li>
                <li>Mystery & Thriller</li>
                <li>Science Fiction</li>
            </ul>
        </div>
    <% } else { %>
        <p>No specific categories found in your order history.</p>
    <% } %>
</div>
    </div>
    
    <div class="action-buttons">
        <button class="action-btn" onclick="showBooks()">Browse Books</button>
        <a href="<%= request.getContextPath() %>/customer/stationery" class="action-btn">Explore Stationery</a>
        <a href="<%= request.getContextPath() %>/CartController?action=view&customerId=<%= user.getId() %>" class="action-btn">View Cart</a>
    </div>
    
<div class="book-grid" id="bookGrid" 
     style="<%= request.getAttribute("showBooks") != null && (Boolean) request.getAttribute("showBooks") ? "display: grid;" : "display: none;" %>">
    <% if (bookList == null) { %>
        <p class="message">Book list is not available.</p>
    <% } else if (bookList.isEmpty()) { %>
        <p class="message">No books available.</p>
    <% } else {
        for (Book book : bookList) { %>
            <div class="book-card">
                <div class="card-content">
                    <img src="<%= request.getContextPath() + book.getImage() %>" alt="<%= book.getTitle() %>" />
                    <h3><%= book.getTitle() %></h3>
                    <p><strong>Author:</strong> <%= book.getAuthor() %></p>
                    <p><strong>Price:</strong> Rs. <%= book.getPrice() %></p>
                    <p><strong>Category:</strong> <%= book.getCategory() %></p>
                    <p><strong>Quantity:</strong> <%= book.getQuantity() %></p>
                </div>
                <div class="card-actions">
                    <form method="post" action="<%= request.getContextPath() %>/CartController">
                        <input type="hidden" name="action" value="add" />
                        <input type="hidden" name="bookId" value="<%= book.getId() %>" />
                        <button type="submit">Add to Cart</button>
                    </form>
                </div>
            </div>
    <%  }
    } %>
</div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved.
</footer>

<script>
    function openMenu() {
        document.getElementById("mobileMenu").classList.add("show");
    }
    
    function closeMenu() {
        document.getElementById("mobileMenu").classList.remove("show");
    }
    
    function showBooks() {
        document.getElementById("bookGrid").style.display = "grid";
        window.scrollTo({
            top: document.getElementById("bookGrid").offsetTop - 20,
            behavior: 'smooth'
        });
    }

    // Show welcome message with user's name and check if we should show books immediately
    document.addEventListener('DOMContentLoaded', function() {
        console.log("Welcome, <%= user.getUsername() %>! Enjoy your shopping experience.");
        
        // Check if we should show books immediately (from URL parameter)
        <% if (request.getAttribute("showBooks") != null && (Boolean) request.getAttribute("showBooks")) { %>
            showBooks();
        <% } %>
    });
    
    document.addEventListener('DOMContentLoaded', function() {
        console.log("Welcome, <%= user.getUsername() %>! Enjoy your shopping experience.");
    });
</script>

</body>
</html>