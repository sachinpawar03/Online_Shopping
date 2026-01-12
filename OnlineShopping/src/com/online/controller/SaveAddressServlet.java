package com.online.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/saveAddress")
public class SaveAddressServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();

        session.setAttribute("fullName", req.getParameter("fullName"));
        session.setAttribute("address", req.getParameter("address"));
        session.setAttribute("city", req.getParameter("city"));
        session.setAttribute("pincode", req.getParameter("pincode"));
        session.setAttribute("phone", req.getParameter("phone"));

        resp.sendRedirect("checkout.jsp");
    }
}

