<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Unauthorized Access</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }
        .container {
            text-align: center;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #d9534f;
        }
        p {
            font-size: 16px;
            margin: 20px 0;
        }
        a {
            color: #428bca;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 20px;
            border: 1px solid #428bca;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #428bca;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Unauthorized Access</h2>
        <p>You do not have permission to access this page.</p>
        <a href="../index.jsp">Return to Home Page</a>
    </div>
</body>
</html>
