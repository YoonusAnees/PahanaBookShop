<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
    <style>
        body {
            font-family: Arial, sans-serif; background: #f4f7f8; margin: 0; padding: 0;
        }
        .container {
            max-width: 900px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center; color: #333; margin-bottom: 20px;
        }
        table {
            width: 100%; border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd; padding: 10px; text-align: center;
        }
        th {
            background-color: #007bff; color: white;
        }
        tr:nth-child(even) { background-color: #f9f9f9; }
        tr:hover { background-color: #f1f1f1; }
        img.book-image {
            max-width: 60px; max-height: 60px; border-radius: 4px;
        }
        a.button {
            padding: 6px 12px; color: white; text-decoration: none; border-radius: 4px;
            font-weight: bold;
            margin: 0 3px;
        }
        a.edit-btn { background-color: #28a745; }
        a.delete-btn { background-color: #dc3545; }
        a.add-btn {
            display: inline-block; margin-bottom: 15px; background-color: #007bff; padding: 10px 15px;
        }
        a.add-btn:hover { background-color: #0056b3; }
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
<div class="container">
    <h2>Book List</h2>
    <a href="AddBook.jsp" class="add-btn">+ Add New Book</a>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Price ($)</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="book" items="${bookList}">
            <tr>
                <td>${book.id}</td>
                <td><img src="${pageContext.request.contextPath}/${book.image}" alt="${book.title}" class="book-image" /></td>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.category}</td>
                <td>${book.price}</td>
                <td>${book.quantity}</td>
                <td>
                    <a class="button edit-btn" href="Book?action=edit&id=${book.id}">Edit</a>
                    <a href="javascript:void(0);" class="button delete-btn" onclick="confirmDelete('${book.title}', ${book.id})">Delete</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty bookList}">
            <tr><td colspan="8">No books found.</td></tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
