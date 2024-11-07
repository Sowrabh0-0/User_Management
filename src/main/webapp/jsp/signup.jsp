<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Sign Up</title>
</head>
<body>
    <h2>Sign Up</h2>
    <form action="../SignUpServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="hidden" name="role" value="Employee">
        
        <input type="submit" value="Sign Up">
    </form>
</body>
</html>
