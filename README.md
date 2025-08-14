PahanaBook – Online Bookshop (JSP/Servlets)

A simple, production-ready Java web app for managing an online bookshop. Customers can browse books & stationery, search, add to cart, and place orders. Admins can manage inventory and content.

✨ Features

Customer login & session-based auth (role: customer)

Admin dashboard & role guard (role: admin)

Browse Books and Stationery

Full-text search across books & stationery

Cart & checkout flow (JSP)

Image upload/display for items

JSTL-powered JSP views with clean UI

DAO layer for data access; MVC controllers

Error handling & friendly redirects

🧱 Tech Stack

Java (Servlets, JSP, JSTL)

Tomcat 9+

DAO pattern (e.g., BookDAO, StationeryDAO)

JDBC / Service layer (as applicable)

JSP Views under /customer, /admin

Session Auth via HttpSession

Build: Maven 


Project Structure
src/
  main/
    java/
      com/pahana/bookshop/
        controller/           # Servlets (e.g., CustomerSearchController, CustomerStationeryController)
        DAO/                  # BookDAO, StationeryDAO, UserDAO, DB Factory 
        model/                # POJOs: Book, Stationery, User, ...
        service/              # Services (e.g., StationeryService)
    webapp/
      META-INF/
      WEB-INF/
        web.xml          
      login.jsp
      register.jsp
    
pom.xml
README.md
