package com.online.controller;

import com.online.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

//@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart =
                (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        System.out.println("CartServlet GET, items: " + cart.size()
                + ", sessionId=" + session.getId());

        // Just show cart.jsp
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart =
                (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        String action = req.getParameter("action");
        System.out.println("CartServlet POST action=" + action);

        if ("update".equals(action)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int qty = Integer.parseInt(req.getParameter("qty"));

                CartItem item = cart.get(productId);
                if (item != null) {
                    if (qty <= 0) {
                        cart.remove(productId);
                    } else {
                        item.setQuantity(qty);
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else if ("remove".equals(action)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cart.remove(productId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect("cart");   // reload cart page
    }
}
