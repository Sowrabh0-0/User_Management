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

@WebServlet(name = "SoftwareServlet", urlPatterns = "/SoftwareServlet")
public class SoftwareServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"Admin".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] accessLevelsArray = request.getParameterValues("access_levels");
        String accessLevels = String.join(", ", accessLevelsArray);

        try (Connection conn = DatabaseUtils.getConnection()) {
            String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setString(3, accessLevels);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("jsp/createSoftware.jsp?status=success");
            } else {
                response.sendRedirect("jsp/createSoftware.jsp?status=error");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/createSoftware.jsp?status=error");
        }
    }
}
