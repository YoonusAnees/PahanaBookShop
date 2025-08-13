<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Order Success</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f1fa;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
            color: #3e1d71;
        }

        .success-box {
            background-color: #fff8e1; /* lighter yellow background */
            border: 2px solid #f4d162; /* main yellow border */
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(244, 209, 98, 0.4);
            text-align: center;
            max-width: 400px;
            transition: box-shadow 0.3s ease;
        }

        .success-box:hover {
            box-shadow: 0 20px 45px rgba(244, 209, 98, 0.7);
        }

        .success-box h1 {
            font-size: 2.5rem;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1.2px;
            color: #f4d162;
        }

        .success-box p {
            font-size: 1.2rem;
            margin: 15px 0;
            color: #c68600; /* darker yellow/brownish for contrast */
        }

        .success-box strong {
            color: #f4d162;
        }

        a {
            display: inline-block;
            margin-top: 30px;
            background-color: #f4d162;
            color: #fff;
            padding: 12px 30px;
            text-decoration: none;
            font-weight: 600;
            border-radius: 12px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 6px 15px rgba(244, 209, 98, 0.3);
        }

        a:hover {
            background-color: #c68600;
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(198, 134, 0, 0.5);
        }

        @media (max-width: 450px) {
            .success-box {
                padding: 30px 25px;
            }

            .success-box h1 {
                font-size: 2rem;
            }

            .success-box p {
                font-size: 1rem;
            }

            a {
                padding: 10px 24px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="success-box">
        <h1>Thank you for your order!</h1>
        <p>Your order ID is: <strong>${orderId}</strong></p>
        <p>We will process your order soon.</p>
        <a href="customer/dashboard">Back to Home</a>
    </div>
</body>
</html>
