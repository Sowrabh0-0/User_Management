<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Sign Up</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <script src="../js/script.js"></script>
</head>
<body>

    <jsp:include page="snackbar.jsp" />

    <h2>Sign Up</h2>
    <form action="../SignUpServlet" method="post" onsubmit="return validateSignUpForm()">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="hidden" name="role" value="Employee">
        
        <input type="submit" value="Sign Up">
    </form>


    <%
        String message = request.getParameter("message");
        if ("success".equals(message)) {
    %>
        <script>showSnackbar("Sign up successful!", "success");</script>
    <%
        } else if ("error".equals(message)) {
    %>
        <script>showSnackbar("Sign up failed. Try again.", "error");</script>
    <%
        }
    %>
</body>
</html>
