<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.example.useraccessmanagement.utils.DatabaseUtils" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || (!"Admin".equals(role) && !"Manager".equals(role))) {
        response.sendRedirect(request.getContextPath() + "/jsp/unauthorized.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pending Access Requests</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <script src="../js/script.js"></script>
</head>
<body>
    <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-link">Logout</a>

    <jsp:include page="snackbar.jsp" />

    <h2>Pending Access Requests</h2>
    <table class="styled-table">
        <thead>
            <tr>
                <th>Employee Name</th>
                <th>Software Name</th>
                <th>Access Type</th>
                <th>Reason for Request</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DatabaseUtils.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(
                         "SELECT r.id AS requestId, u.username AS employeeName, s.name AS softwareName, " +
                         "r.access_type AS accessType, r.reason AS reason " +
                         "FROM requests r " +
                         "JOIN users u ON r.user_id = u.id " +
                         "JOIN software s ON r.software_id = s.id " +
                         "WHERE r.status = 'Pending'")) {

                    while (rs.next()) {
                        int requestId = rs.getInt("requestId");
                        String employeeName = rs.getString("employeeName");
                        String softwareName = rs.getString("softwareName");
                        String accessType = rs.getString("accessType");
                        String reason = rs.getString("reason");
            %>
                        <tr id="row-<%= requestId %>">
                            <td><%= employeeName %></td>
                            <td><%= softwareName %></td>
                            <td><%= accessType %></td>
                            <td><%= reason %></td>
                            <td>
                                <button onclick="submitApproval('<%= requestId %>', 'approve')">Approve</button>
                                <button onclick="submitApproval('<%= requestId %>', 'reject')">Reject</button>
                            </td>
                        </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <%-- Display snackbar message based on status --%>
    <%
        String status = request.getParameter("status");
        if ("approved".equals(status)) {
    %>
        <script>showSnackbar("Request approved successfully!", "success");</script>
    <%
        } else if ("rejected".equals(status)) {
    %>
        <script>showSnackbar("Request rejected successfully!", "success");</script>
    <%
        } else if ("error".equals(status)) {
    %>
        <script>showSnackbar("Failed to process the request. Please try again.", "error");</script>
    <%
        }
    %>
</body>
</html>
