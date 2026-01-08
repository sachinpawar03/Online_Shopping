package com.online.controller;

import com.online.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        ProductDAO dao = new ProductDAO();
        dao.deleteProduct(id);

        resp.sendRedirect(req.getContextPath() + "/admin/manageProducts.jsp");
    }
}
