<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"Manager".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pending Requests</title>
</head>
<body>
    <h2>Pending Access Requests</h2>

    <table border="1">
        <tr>
            <th>User ID</th>
            <th>Software ID</th>
            <th>Access Type</th>
            <th>Reason</th>
            <th>Action</th>
        </tr>
        <%
            java.sql.Connection conn = null;
            java.sql.Statement stmt = null;
            java.sql.ResultSet rs = null;
            try {
                conn = com.example.useraccessmanagement.utils.DatabaseUtils.getConnection();
                String sql = "SELECT id, user_id, software_id, access_type, reason FROM requests WHERE status = 'Pending'";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    int requestId = rs.getInt("id");
                    int userId = rs.getInt("user_id");
                    int softwareId = rs.getInt("software_id");
                    String accessType = rs.getString("access_type");
                    String reason = rs.getString("reason");
        %>
                    <tr>
                        <td><%= userId %></td>
                        <td><%= softwareId %></td>
                        <td><%= accessType %></td>
                        <td><%= reason %></td>
                        <td>
                            <form action="/UserAccessManagement/ApprovalServlet" method="post" style="display:inline;">
                                <input type="hidden" name="requestId" value="<%= requestId %>">
                                <input type="hidden" name="action" value="approve">
                                <input type="submit" value="Approve">
                            </form>
                            <form action="/UserAccessManagement/ApprovalServlet" method="post" style="display:inline;">
                                <input type="hidden" name="requestId" value="<%= requestId %>">
                                <input type="hidden" name="action" value="reject">
                                <input type="submit" value="Reject">
                            </form>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
                if (conn != null) try { conn.close(); } catch (Exception ignore) {}
            }
        %>
    </table>
</body>
</html>
