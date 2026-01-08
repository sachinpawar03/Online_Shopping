package com.online.controller;
import com.online.dao.OrderDAO;
import com.online.model.CartItem;
import com.online.model.OrderItem;
import com.online.model.User;

import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession();
        User u = (User) s.getAttribute("user");
        if(u == null) { resp.sendRedirect("login.jsp"); return; }
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) s.getAttribute("cart");
        if(cart == null || cart.isEmpty()) { resp.sendRedirect("cart.jsp"); return; }

        // simulate payment processing (no real integration)
        double total = 0;
        List<OrderItem> items = new ArrayList<>();
        for(CartItem ci : cart.values()) {
            double price = ci.getProduct().getPrice();
            total += price * ci.getQuantity();
            OrderItem oi = new OrderItem();
            oi.setOrderId(ci.getProduct().getProductId());
            oi.setQuantity(ci.getQuantity());
            oi.setProductImage(null);
            items.add(oi);
        }

        OrderDAO odao = new OrderDAO();
        int orderId = odao.createOrder(u.getUserId(), total, items);
        if(orderId > 0) {
            s.removeAttribute("cart");
            req.setAttribute("orderId", orderId);
            req.setAttribute("total", total);
            req.getRequestDispatcher("orderConfirmation.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("cart.jsp?err=orderfail");
        }
    }
}
