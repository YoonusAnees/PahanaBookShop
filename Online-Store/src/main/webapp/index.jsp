<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>PahanaBook - Home</title>
    <link rel="icon" type="image/png" href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; margin:0; padding:0; color:#333; }

        /* Navbar */
        nav { background-color: #2c3e50; color: white; padding: 15px 20px; display:flex; justify-content:space-between; align-items:center; position:sticky; top:0; z-index:10; }
        .logo { font-size: 1.8rem; font-weight:bold; letter-spacing:1px; color:#f1c40f; text-decoration:none; }
        .nav-links { display:flex; align-items:center; }
        .nav-links a { color:white; text-decoration:none; margin-left:20px; font-weight:bold; transition: color 0.3s ease; }
        .nav-links a:hover { color:#f1c40f; }
        .nav-links a.active { color:#f1c40f; font-weight:bold; }

        /* Burger Menu */
        .burger { display:none; flex-direction:column; cursor:pointer; }
        .burger div { width:25px; height:3px; background:white; margin:4px; transition: all 0.3s ease; }

        /* Mobile Menu */
        .nav-links.mobile { display:none; flex-direction:column; align-items:center; justify-content:center; background-color: rgba(44,62,80,0.95); position:fixed; top:0; left:0; width:100%; height:100%; z-index:999; }
        .nav-links.mobile a { margin:15px 0; text-align:center; color:white; font-size:1.3rem; }
        .close-btn { position:absolute; top:20px; right:25px; color:white; font-size:2rem; cursor:pointer; }

        /* Search Form */
        .search-form { display:flex; align-items:center; margin-left:400px; }
        .search-form input[type="text"] { padding:8px 10px; border-radius:4px; border:none; font-size:1rem; }
        .search-form button { padding:9px 12px; margin-left:5px; border:none; border-radius:4px; background-color:#f1c40f; color:#2c3e50; font-weight:bold; cursor:pointer; }
        .search-form button:hover { background-color:#e67e22; color:white; }

        /* Hero Section */
        .hero { position:relative; height:350px; background-size:cover; background-position:center; color:white; display:flex; align-items:center; justify-content:center; text-align:center; }
        .hero-overlay { position:absolute; top:0; left:0; right:0; bottom:0; background-color: rgba(0,0,0,0.5); z-index:1; }
        .hero-content { position:relative; z-index:2; max-width:700px; padding:20px; }
        .hero h1 { font-size:3rem; margin-bottom:15px; }
        .hero p { font-size:1.2rem; margin-bottom:25px; }
        .hero a { padding:12px 25px; background:#f1c40f; color:#2c3e50; text-decoration:none; border-radius:5px; font-weight:bold; transition: background 0.3s ease; margin:0 10px; display:inline-block; }
        .hero a:hover { background:#e67e22; color:white; }

        /* Featured Categories */
        .featured-categories { max-width:1200px; margin:40px auto; display:flex; gap:30px; justify-content:center; text-align:center; padding:0 20px; flex-wrap:wrap; }
        .category-card { flex:1; min-width:250px; background:white; padding:20px; border-radius:12px; box-shadow:0 4px 10px rgba(0,0,0,0.1); transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .category-card:hover { transform:translateY(-5px); box-shadow:0 6px 20px rgba(0,0,0,0.15); }
        .category-card img { width:100%; height:180px; object-fit:cover; border-radius:8px; margin-bottom:15px; }
        .category-card h3 { margin:15px 0 10px 0; color:#34495e; }
        .category-card p { color:#555; margin-bottom:15px; font-size:0.95rem; line-height:1.4; }
        .category-card a { color:#f1c40f; font-weight:bold; text-decoration:none; font-size:1rem; }
        .category-card a:hover { text-decoration:underline; }

        /* Map Section */
        .map-section { max-width:1000px; margin:40px auto; padding:20px; background:white; border-radius:12px; box-shadow:0 4px 10px rgba(0,0,0,0.1); text-align:center; }
        .map-section h2 { margin-bottom:20px; color:#34495e; }
        .map-container { width:100%; height:400px; border-radius:10px; overflow:hidden; }
        .map-container iframe { width:100%; height:100%; border:0; }

        /* Footer */
        footer { background:#2c3e50; color:white; text-align:center; padding:15px 0; font-size:0.9rem; margin-top:40px; }

        /* Chatbot */
        #chatbot {
            position: fixed;
            bottom: 25px;
            right: 25px;
            width: 320px;
            font-family: Arial, sans-serif;
            z-index: 1000;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        #chatbot-header {
            background: linear-gradient(135deg,#f1c40f,#e67e22);
            color: white;
            padding: 12px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1rem;
            text-align: center;
            border-radius: 20px 20px 0 0;
            user-select: none;
        }

        #chatbot-body {
            display: none;
            background: #ffffff;
            border: 2px solid #f1c40f;
            max-height: 400px;
            flex-direction: column;
            border-radius: 0 0 20px 20px;
            animation: fadeIn 0.3s ease forwards;
        }

        #chatbot-messages {
            padding: 10px;
            flex-grow: 1;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: #f1c40f #eee;
        }

        #chatbot-messages::-webkit-scrollbar { width: 6px; }
        #chatbot-messages::-webkit-scrollbar-track { background: #eee; border-radius: 3px; }
        #chatbot-messages::-webkit-scrollbar-thumb { background: #f1c40f; border-radius: 3px; }

        .chatbot-message {
            margin: 8px 0;
            padding: 8px 12px;
            border-radius: 20px;
            max-width: 85%;
            word-wrap: break-word;
            line-height: 1.3;
            animation: fadeIn 0.3s ease forwards;
        }
        .bot-msg { background: #f1c40f; color: #2c3e50; align-self: flex-start; }
        .user-msg { background: #2c3e50; color: #f1c40f; align-self: flex-end; }

        #chatbot-input-wrapper { display: flex; border-top: 1px solid #eee; }
        #chatbot-input { flex-grow: 1; padding: 10px; border: none; border-radius: 0 0 0 20px; outline: none; font-size: 0.95rem; }
        #chatbot-send { background: #f1c40f; border: none; padding: 10px 15px; cursor: pointer; border-radius: 0 0 20px 0; font-weight: bold; transition: background 0.3s ease; }
        #chatbot-send:hover { background: #e67e22; color: white; }

        @keyframes fadeIn { from {opacity:0; transform: translateY(10px);} to {opacity:1; transform: translateY(0);} }

        /* Responsive */
        @media (max-width:768px) {
            .search-form { display:none; }
            .nav-links { display:none; }
            .burger { display:flex; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">PahanaBook</a>
    <form class="search-form" method="get" action="<%= request.getContextPath() %>/Search">
        <input type="text" name="query" placeholder="Search books or stationery..." required />
        <button type="submit">Search</button>
    </form>
    <div class="nav-links" id="navLinks">
        <a href="<%= request.getContextPath() %>/index.jsp" class="active">Home</a>
        <a href="<%= request.getContextPath() %>/Books">Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
        <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
        <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
        <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
    </div>
    <div class="burger" onclick="openMenu()">
        <div></div><div></div><div></div>
    </div>
</nav>

<!-- Mobile Nav -->
<div class="nav-links mobile" id="mobileMenu">
    <div class="close-btn" onclick="closeMenu()">✖</div>
    <a href="<%= request.getContextPath() %>/index.jsp" class="active">Home</a>
    <a href="<%= request.getContextPath() %>/Books">Books</a>
    <a href="<%= request.getContextPath() %>/stationery">Stationery</a>
    <a href="<%= request.getContextPath() %>/AboutUs.jsp">About Us</a>
    <a href="<%= request.getContextPath() %>/ContactUs.jsp">Contact Us</a>
    <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
    <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
</div>

<!-- Hero Section -->
<div class="hero" style="background-image: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1200&q=80');">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>Welcome to PahanaBook</h1>
        <p>Your one-stop destination for books, stationery, and more.</p>
        <a href="<%= request.getContextPath() %>/Books">Browse Books</a>
        <a href="<%= request.getContextPath() %>/stationery">Browse Stationery</a>
    </div>
</div>

<!-- Featured Categories -->
<section class="featured-categories">
    <div class="category-card">
        <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80" alt="Books">
        <h3>Books</h3>
        <p>Explore our wide range of books from various genres and authors.</p>
        <a href="<c:url value='/Books'/>">Browse Books &rarr;</a>
    </div>
    <div class="category-card">
        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBYOE_MQG9sb1VTrIV86tZKkniMZaE4mu3qg&s" alt="Stationery">
        <h3>Stationery</h3>
        <p>High quality stationery products to support your daily needs.</p>
        <a href="<c:url value='/stationery'/>">Browse Stationery &rarr;</a>
    </div>
    <div class="category-card">
        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLSTpGgbL_ieg8ZP07f35U2QOarInQKZDOg&s" alt="About Us">
        <h3>About Us</h3>
        <p>Learn more about PahanaBook and our mission to bring knowledge closer to you.</p>
        <a href="<c:url value='/AboutUs.jsp'/>">Read More &rarr;</a>
    </div>
</section>

<!-- Map Section -->
<section class="map-section">
    <h2>Find Us in Akurana, Kandy</h2>
    <div class="map-container">
        <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3962.506720772391!2d80.61068297499386!3d7.356767314362662!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae3679ac26dff13%3A0x54c2f7a4dfdc0fb6!2sAkurana%2C%20Sri%20Lanka!5e0!3m2!1sen!2slk!4v1693900999999"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
</section>

<!-- Chatbot -->
<div id="chatbot">
    <div id="chatbot-header" onclick="toggleChat()">💬 PahanaBot</div>
    <div id="chatbot-body">
        <div id="chatbot-messages"></div>
        <div id="chatbot-input-wrapper">
            <input type="text" id="chatbot-input" placeholder="Ask about a book or reset password..." onkeydown="handleChat(event)" />
            <button id="chatbot-send" onclick="sendChat()">➤</button>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; <%= java.time.Year.now() %> PahanaBook. All rights reserved | Designed and Developed by Yoonus Anees.
</footer>

<script>
    // Navbar mobile menu
    function openMenu(){document.getElementById("mobileMenu").classList.add("show");}
    function closeMenu(){document.getElementById("mobileMenu").classList.remove("show");}

    // Chatbot toggle
    function toggleChat(){
        const body=document.getElementById('chatbot-body');
        body.style.display = (body.style.display==='flex') ? 'none' : 'flex';
    }

    function appendMessage(msg, cls){
        const messages=document.getElementById('chatbot-messages');
        const div=document.createElement('div');
        div.className='chatbot-message '+cls;
        div.textContent=msg;
        messages.appendChild(div);
        messages.scrollTop=messages.scrollHeight;
    }

    function sendChat() {
        const input = document.getElementById('chatbot-input');
        const value = input.value.trim();
        if(!value) return;
        appendMessage(value,'user-msg');
        input.value='';

        let emailPrompt = '';
        if(value.toLowerCase().includes("reset password")){
            emailPrompt = prompt("Please enter your registered email for password reset:");
            if(!emailPrompt) {
                appendMessage("Password reset cancelled. Please provide your email.", 'bot-msg');
                return;
            }
        }

        let postData = 'message=' + encodeURIComponent(value);
        if(emailPrompt) postData += '&email=' + encodeURIComponent(emailPrompt);

        fetch('<%= request.getContextPath() %>/Chat',{
            method:'POST',
            headers:{'Content-Type':'application/x-www-form-urlencoded'},
            body: postData
        })
        .then(res=>res.text())
        .then(data=>appendMessage(data,'bot-msg'))
        .catch(err=>appendMessage('Error: '+err,'bot-msg'));
    }

    function handleChat(e){
        if(e.key==='Enter'){ sendChat(); }
    }
</script>

</body>
</html>
