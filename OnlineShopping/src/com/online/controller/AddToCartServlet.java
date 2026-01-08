package com.online.controller;

import com.online.dao.ProductDAO;
import com.online.model.CartItem;
import com.online.model.Product;

import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

    // 🔥 Your POST request will come here
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // productId is coming from hidden input field:
        int productId = Integer.parseInt(req.getParameter("productId"));

        ProductDAO dao = new ProductDAO();
        Product p = dao.getById(productId);

        if (p == null) {
            System.out.println("ERROR: Product not found for id = " + productId);
            resp.sendRedirect("products");
            return;
        }

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart =
                (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        if (cart.containsKey(productId)) {
            CartItem item = cart.get(productId);
            item.setQuantity(item.getQuantity() + 1);
        } else {
            CartItem item = new CartItem(p, 1);
            cart.put(productId, item);
        }

        System.out.println("AddToCart: productId=" + productId
                + " cartSize=" + cart.size()
                + " sessionId=" + session.getId());

        session.setAttribute("cart", cart);
        resp.sendRedirect("index.jsp");

    }

    // Optional: Keep doGet if needed for testing
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);  // Allow GET to behave like POST
    }
}
