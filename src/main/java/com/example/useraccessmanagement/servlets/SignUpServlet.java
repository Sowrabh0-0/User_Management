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

@WebServlet(name = "SignUpServlet", urlPatterns = "/SignUpServlet")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection conn = DatabaseUtils.getConnection()) {
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, role);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("jsp/login.jsp?message=success");
            } else {
                response.sendRedirect("jsp/signup.jsp?message=error");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/signup.jsp?message=error");
        }
    }
}
