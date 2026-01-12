package com.online.controller;

import com.online.dao.OrderDAO;
import com.online.model.CartItem;
import com.online.model.OrderItem;
import com.online.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        Map<Integer, CartItem> cart =
                (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        // ================= PAYMENT VALIDATION =================
        String paymentMode = req.getParameter("paymentMode");
        boolean paymentValid = false;

        if ("CARD".equals(paymentMode)) {

            String cardHolder = req.getParameter("cardHolder");
            String cardNo = req.getParameter("cardNumber");
            String expiry = req.getParameter("expiry");
            String cvv = req.getParameter("cvv");

            if (cardHolder != null && !cardHolder.trim().isEmpty()
                    && cardNo != null && cardNo.matches("\\d{16}")
                    && expiry != null && !expiry.isEmpty()
                    && cvv != null && cvv.matches("\\d{3}")) {

                paymentValid = true;
            }

        } else if ("UPI".equals(paymentMode)) {

            String upiId = req.getParameter("upiId");

            if (upiId != null &&
                upiId.matches("^[a-zA-Z0-9._-]+@[a-zA-Z]+$")) {

                paymentValid = true;
            }
        }

        if (!paymentValid) {
            req.setAttribute("error", "Invalid payment details");
            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
            return;
        }

        // ================= CREATE ORDER =================
        double total = 0;
        List<OrderItem> items = new ArrayList<>();

        for (CartItem ci : cart.values()) {
            double price = ci.getProduct().getPrice();
            total += price * ci.getQuantity();

            OrderItem oi = new OrderItem();
            oi.setProductId(ci.getProduct().getProductId());
            oi.setQuantity(ci.getQuantity());
            oi.setPrice(price);

            items.add(oi);
        }

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.createOrder(user.getUserId(), total, items);

        if (orderId > 0) {

            session.removeAttribute("cart");

            session.setAttribute("orderId", orderId);
            session.setAttribute("total", total);
            session.setAttribute("paymentMode", paymentMode);

            // ✅ SUCCESS PAGE FIRST
            resp.sendRedirect(req.getContextPath() + "/orderSuccess.jsp");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/cart.jsp?err=orderfail");
    }
}
