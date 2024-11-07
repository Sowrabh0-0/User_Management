package com.example.useraccessmanagement.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getRequestURI();

        boolean isPublicPath = path.endsWith("index.jsp") || path.endsWith("login.jsp") || path.endsWith("signup.jsp") ||
                               path.endsWith("LoginServlet") || path.endsWith("SignUpServlet") || path.endsWith("unauthorized.jsp") ||
                               path.startsWith(httpRequest.getContextPath() + "/css") || path.startsWith(httpRequest.getContextPath() + "/js");

        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("username") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
            return;
        }


        String role = (String) session.getAttribute("role");
        boolean isAuthorized = false;

        if ("Admin".equals(role)) {
            isAuthorized = true; 
        } else if ("Manager".equals(role)) {
            isAuthorized = path.contains("/jsp/pendingRequests.jsp") || path.contains("/ApprovalServlet");
        } else if ("Employee".equals(role)) {
            isAuthorized = path.contains("/jsp/requestAccess.jsp") || path.contains("/RequestServlet");
        }

        if (path.contains("pendingRequests.jsp") && !("Admin".equals(role) || "Manager".equals(role))) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/jsp/unauthorized.jsp");
            return;
        }


        if (!isAuthorized) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/jsp/unauthorized.jsp");
            return;
        }


        chain.doFilter(request, response);
    }
}
