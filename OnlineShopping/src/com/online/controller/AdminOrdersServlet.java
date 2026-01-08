package com.online.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/adminOrders")
public class AdminOrdersServlet extends HttpServlet {

    private static final String URL  = "jdbc:mysql://localhost:3306/your_db_name?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "your_password";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Map<String, Object>> orders = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, USER, PASS);

            String sql =
                "SELECT o.id AS order_id, o.user_id, o.total, o.created_at, " +
                "oi.product_id, oi.qty, oi.price, " +
                "p.name AS product_name " +
                "FROM orders o " +
                "JOIN order_items oi ON o.id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.id " +   // 👈 FIXED
                "ORDER BY o.id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("order_id", rs.getInt("order_id"));
                row.put("user_id", rs.getInt("user_id"));
                row.put("total", rs.getDouble("total"));
                row.put("created_at", rs.getString("created_at"));
                row.put("product_id", rs.getInt("product_id"));
                row.put("product_name", rs.getString("product_name"));
                row.put("qty", rs.getInt("qty"));
                row.put("price", rs.getDouble("price"));

                orders.add(row);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("orders", orders);

        RequestDispatcher rd = req.getRequestDispatcher("/admin/admin_orders.jsp");
        rd.forward(req, resp);
    }
}
