<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <script src="../js/script.js"></script>
</head>
<body>
    <jsp:include page="snackbar.jsp" />

    <h2>Login</h2>
    <form action="/UserAccessManagement/LoginServlet" method="post" onsubmit="return validateLoginForm()">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Login">
    </form>

    <%
        String message = request.getParameter("message");
        if ("success".equals(message)) {
    %>
        <script>showSnackbar("Login successful!", "success");</script>
    <%
        } else if ("error".equals(message)) {
    %>
        <script>showSnackbar("Login failed. Check your username and password.", "error");</script>
    <%
        }
    %>
</body>
</html>
