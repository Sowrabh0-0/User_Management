package com.example.useraccessmanagement.servlets;

import com.example.useraccessmanagement.utils.DatabaseUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ApprovalServlet", urlPatterns = "/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int requestId;

        try {
            requestId = Integer.parseInt(request.getParameter("requestId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("jsp/pendingRequests.jsp?status=error");
            return;
        }

        if (action == null || (!action.equals("approve") && !action.equals("reject"))) {
            response.sendRedirect("jsp/pendingRequests.jsp?status=error");
            return;
        }

        try (Connection conn = DatabaseUtils.getConnection()) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, action.equals("approve") ? "Approved" : "Rejected");
                stmt.setInt(2, requestId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    String statusMessage = action.equals("approve") ? "approved" : "rejected";
                    response.sendRedirect("jsp/pendingRequests.jsp?status=" + statusMessage);
                } else {
                    response.sendRedirect("jsp/pendingRequests.jsp?status=error");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/pendingRequests.jsp?status=error");
        }
    }
}
