<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/jsp/unauthorized.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Software</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <script src="../js/script.js"></script>
</head>
<body>
    <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-link">Logout</a>

    <jsp:include page="snackbar.jsp" />

    <h2>Create New Software</h2>

    <form action="/UserAccessManagement/SoftwareServlet" method="post" onsubmit="return validateSoftwareForm()">
        <label for="name">Software Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br><br>

        <label>Access Levels:</label><br>
        <input type="checkbox" name="access_levels" value="Read"> Read<br>
        <input type="checkbox" name="access_levels" value="Write"> Write<br>
        <input type="checkbox" name="access_levels" value="Admin"> Admin<br><br>

        <input type="submit" value="Add Software">
    </form>

    <%-- Display snackbar message based on status --%>
    <%
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
        <script>showSnackbar("Software created successfully!", "success");</script>
    <%
        } else if ("error".equals(status)) {
    %>
        <script>showSnackbar("Failed to create software. Please try again.", "error");</script>
    <%
        }
    %>
</body>
</html>
