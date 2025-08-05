<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.pahana.bookshop.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<!-- Session check and redirect -->
<c:if test="${empty sessionScope.user}">
    <c:redirect url="/index.jsp"/>
</c:if>

<div class="container mt-4">
    <h2>Welcome Admin: <%= ((User) session.getAttribute("user")).getUsername() %></h2>

    <h3 class="mt-4">User Management</h3>
    
    <table class="table table-striped mt-3">
        <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                      <th>Password</th>
                <th>Role</th>
          
                
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                     <td>${user.password}</td>
                    
                    
                    
                    <td>${user.role}</td>
                  <td>
    <a href="${pageContext.request.contextPath}/User?action=edit&id=${user.id}" class="btn btn-sm btn-warning">Edit</a>
    <a href="${pageContext.request.contextPath}/User?action=delete&id=${user.id}" class="btn btn-sm btn-danger"
       onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
</td>

                </tr>
            </c:forEach>
        </tbody>
    </table>

    <a href="admin/dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

</body>
</html>
