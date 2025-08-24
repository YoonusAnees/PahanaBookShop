<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Order Success</title>
    <link rel="icon" type="image/png" href="https://img.freepik.com/free-vector/gradient-p-logo-template_23-2149372725.jpg?w=32&q=80" />

    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fb;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
            color: #2c3e50;
        }

        .success-box {
            background: #ffffff;
            border: 1px solid #e1e8ef;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            text-align: center;
            max-width: 420px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .success-box:hover {
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        .success-box h1 {
            font-size: 2rem;
            margin-bottom: 20px;
            font-weight: 700;
            color: black
            ; 
        }

        .success-box p {
            font-size: 1.1rem;
            margin: 12px 0;
            color: #555;
        }

        .success-box strong {
            color: black;
        }

        a {
            display: inline-block;
            margin-top: 28px;
            background: #f4d162;
            color: #fff;
            padding: 12px 28px;
            text-decoration: none;
            font-weight: 600;
            border-radius: 10px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.3);
        }

        a:hover {
            background: #f1c41f;
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(30, 132, 73, 0.4);
        }

        @media (max-width: 450px) {
            .success-box {
                padding: 28px 22px;
            }
            .success-box h1 {
                font-size: 1.7rem;
            }
            .success-box p {
                font-size: 1rem;
            }
            a {
                padding: 10px 22px;
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>
    <div class="success-box">
        <h1>Thank you for your order!</h1>
        <p>Your order ID is: <strong>${orderId}</strong></p>
        <p>We’ll process your order shortly and notify you once it’s shipped.</p>
        <a href="customer/dashboard">Back to Home</a>
    </div>
</body>
</html>
