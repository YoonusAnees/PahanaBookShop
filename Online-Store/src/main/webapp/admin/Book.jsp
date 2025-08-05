// BookList.jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.bookshop.model.Book" %>
<%
    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<html>
<head>
    <title>Book List</title>
</head>
<body>
<h2>Book List</h2>
<a href="/admin/AddBook.jsp">Add New Book</a>
<table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="book" items="${books}">
        <tr>
            <td>${book.id}</td>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.category}</td>
            <td>${book.price}</td>
            <td>${book.quantity}</td>
            <td><img src="/uploads/${book.image}" width="80"></td>
            <td>
                <a href="/Book?action=editForm&id=${book.id}">Edit</a> |
                <a href="/Book?action=delete&id=${book.id}" onclick="return confirm('Delete this book?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>