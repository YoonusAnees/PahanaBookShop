<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
    <style>
        body {
            font-family: Arial, sans-serif; background: #f4f7f8; margin: 0; padding: 0;
        }
        .container {
            max-width: 480px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        label { display: block; margin-top: 15px; font-weight: bold; }
        input[type="text"], input[type="number"], input[type="file"] {
            width: 100%; padding: 10px; margin-top: 6px; border: 1px solid #ccc; border-radius: 4px;
        }
        input[type="submit"] {
            margin-top: 25px; width: 100%; background: #28a745; color: white; padding: 12px; border:none;
            border-radius: 5px; cursor: pointer; font-weight: bold; font-size: 16px;
        }
        input[type="submit"]:hover { background: #218838; }
        .back-link {
            display: block; margin-top: 15px; text-align: center; color: #007bff; text-decoration: none;
        }
        .back-link:hover { text-decoration: underline; }
        img.book-image {
            display: block; margin-top: 15px; max-width: 100%; height: auto; border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Book</h2>
    <form action="Book?action=update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${book.id}" />
        <input type="hidden" name="existingImage" value="${book.image}" />

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="${book.title}" required>

        <label for="author">Author:</label>
        <input type="text" id="author" name="author" value="${book.author}" required>

        <label for="category">Category:</label>
        <input type="text" id="category" name="category" value="${book.category}" required>

        <label for="price">Price:</label>
        <input type="number" step="0.01" id="price" name="price" value="${book.price}" required>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" value="${book.quantity}" required>

        <label>Current Image:</label>
        <img class="book-image" src="${pageContext.request.contextPath}/${book.image}" alt="Book Image" />

        <label for="image">Change Image (optional):</label>
        <input type="file" id="image" name="image" accept="image/*">

        <input type="submit" value="Update Book">
    </form>

    <a class="back-link" href="Book?action=list">← Back to Book List</a>
</div>
</body>
</html>
