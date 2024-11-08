package com.example.useraccessmanagement.servlets;

import com.example.useraccessmanagement.utils.DatabaseUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseUtils.getConnection()) {
            String sql = "SELECT id, role FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                int userId = rs.getInt("id");

                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                String redirectUrl;
                switch (role) {
                    case "Admin":
                        redirectUrl = "jsp/createSoftware.jsp?message=success";
                        break;
                    case "Manager":
                        redirectUrl = "jsp/pendingRequests.jsp?message=success";
                        break;
                    case "Employee":
                        redirectUrl = "jsp/requestAccess.jsp?message=success";
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unknown role");
                        return;
                }
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect("jsp/login.jsp?message=error");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/login.jsp?message=error");
        }
    }
}
