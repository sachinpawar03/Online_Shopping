package com.online.controller;

import com.online.dao.UserDAO;
import com.online.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println(">>> LoginServlet called");

        String emailOrMobile = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User u = dao.login(emailOrMobile, password);

        if (u != null) {

            // ⭐ NEW BLOCK CHECK ⭐
            if ("blocked".equalsIgnoreCase(u.getStatus())) {
                resp.sendRedirect(req.getContextPath() + "/admin/login.jsp?blocked=1");
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", u);
            session.setAttribute("userId", u.getUserId());

            if ("admin".equalsIgnoreCase(u.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            }

        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp?error=1");
        }
    }
}
