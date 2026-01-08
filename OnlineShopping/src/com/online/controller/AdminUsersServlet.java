package com.online.controller;

import com.online.dao.UserDAO;
import com.online.model.User;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();
        List<User> users = dao.getAllUsers();

        req.setAttribute("usersList", users);

        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }
}
