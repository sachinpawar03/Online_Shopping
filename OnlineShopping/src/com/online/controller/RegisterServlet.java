package com.online.controller;

import com.online.dao.UserDAO;
import com.online.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

//@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // ⭐ NEW: Read role from the register form
        String role = req.getParameter("role");

        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);

        // ⭐ NEW: Set role in user object
        u.setRole(role);

        UserDAO dao = new UserDAO();
        boolean ok = dao.register(u);

        if (ok) {
            resp.sendRedirect("register.jsp?success=1");
        } else {
            resp.sendRedirect("register.jsp?err=failed");
        }
    }
}
