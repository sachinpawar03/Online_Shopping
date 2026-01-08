package com.online.controller;

import com.online.dao.ProductDAO;
import com.online.model.CartItem;
import com.online.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/buyNow")
public class BuyNowServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int productId = Integer.parseInt(req.getParameter("productId"));

        ProductDAO dao = new ProductDAO();
        Product p = dao.getById(productId);

        if (p == null) {
            System.out.println("ERROR: Product not found for id = " + productId);
            resp.sendRedirect("products");
            return;
        }

        HttpSession session = req.getSession();

        Map<Integer, CartItem> cart = new HashMap<>();
        cart.put(productId, new CartItem(p, 1));

        session.setAttribute("cart", cart);

        resp.sendRedirect("cart");
    }
}
