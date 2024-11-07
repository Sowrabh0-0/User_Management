<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.example.useraccessmanagement.utils.DatabaseUtils" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Employee".equals(role))) {
        response.sendRedirect(request.getContextPath() + "/jsp/unauthorized.jsp");
        return;
    }
    String status = request.getParameter("status");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Request Access</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <script src="../js/script.js"></script>
</head>
<body>

    <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-link">Logout</a>

    <jsp:include page="snackbar.jsp" />

    <h2>Request Access to Software</h2>
    <form action="/UserAccessManagement/RequestServlet" method="post" onsubmit="return validateRequestForm()">
        <label for="software">Software:</label>
        <select id="software" name="softwareId" required>
            <%
                try (Connection conn = DatabaseUtils.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT id, name FROM software")) {

                    if (!rs.isBeforeFirst()) { 
            %>
                        <option value="">No software available</option>
            <%
                    } else {
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
            %>
                            <option value="<%= id %>"><%= name %></option>
            <%
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
            %>
                    <option value="">Error loading software</option>
            <%
                }
            %>
        </select><br><br>

        <label for="accessType">Access Type:</label>
        <select id="accessType" name="accessType" required>
            <option value="Read">Read</option>
            <option value="Write">Write</option>
            <option value="Admin">Admin</option>
        </select><br><br>

        <label for="reason">Reason for Request:</label><br>
        <textarea id="reason" name="reason" rows="4" cols="50" required></textarea><br><br>

        <input type="submit" value="Submit Request">
    </form>

    <%-- Display snackbar message based on status --%>
    <%
        if ("success".equals(status)) {
    %>
        <script>showSnackbar("Request submitted successfully!", "success");</script>
    <%
        } else if ("error".equals(status)) {
    %>
        <script>showSnackbar("Failed to submit request. Please try again.", "error");</script>
    <%
        }
    %>
</body>
</html>
