package com.online.controller;

import com.online.dao.OrderDAO;
import com.online.model.CartItem;
import com.online.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔥 FIX: redirect user (not admin)
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "admin/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        double total = Double.parseDouble(request.getParameter("total"));

        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        List<OrderItem> items = new ArrayList<>();
        for (CartItem c : cart.values()) {

            OrderItem oi = new OrderItem();

            oi.setProductId(c.getProduct().getProductId());   // product id
            oi.setQuantity(c.getQuantity());                  // quantity
            oi.setPrice(c.getProduct().getPrice());           // price
            oi.setProductImage(c.getProduct().getImage());    // product image from DB
            oi.setProductName(c.getProduct().getName());      // product name

            items.add(oi);
        }


        OrderDAO dao = new OrderDAO();
        int orderId = dao.createOrder(userId, total, items);

        if (orderId > 0) {
            session.removeAttribute("cart");
            session.setAttribute("lastOrderId", orderId);
            response.sendRedirect(request.getContextPath() + "/orderSuccess.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/orderFailed.jsp");
        }
    }
}
