<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f4f4f4;
        }

        .receipt {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            width: 60%;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #444;
        }

        .line {
            border-top: 1px solid #ddd;
            margin: 20px 0;
        }

        .item {
            display: flex;
            justify-content: space-between;
        }

        .total {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="receipt">
    <h2>Order Receipt</h2>
    <p><strong>Name:</strong> ${customer.fullName}</p>
    <p><strong>Email:</strong> ${customer.email}</p>
    <p><strong>Shipping Address:</strong> ${customer.address}</p>

    <div class="line"></div>

    <c:forEach var="item" items="${orderedItems}">
        <div class="item">
            <span>${item.book.title} (x${item.quantity})</span>
            <span>Rs. ${item.total}</span>
        </div>
    </c:forEach>

    <div class="line"></div>

    <div class="item total">
        <span>Total:</span>
        <span>Rs. ${totalAmount}</span>
    </div>
</div>

</body>
</html>
