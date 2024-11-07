<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to User Access Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f2f5;
        }

        .container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
        }

        h2 {
            color: #333;
        }

        p {
            color: #555;
        }

        .links {
            margin-top: 20px;
        }

        .links a {
            text-decoration: none;
            color: #4CAF50;
            padding: 10px 15px;
            border: 1px solid #4CAF50;
            border-radius: 5px;
            margin: 0 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .links a:hover {
            background-color: #4CAF50;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome to User Access Management</h2>
        <p>This is the home page of your application.</p>
        
        <div class="links">
            <a href="jsp/signup.jsp">Sign Up</a>
            <a href="jsp/login.jsp">Login</a>
        </div>
    </div>
</body>
</html>
