<%@ page import="java.util.*, com.online.dao.OrderDAO, com.online.model.OrderItem, com.online.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // FIX: define oid first
    int oid = Integer.parseInt(request.getParameter("oid"));

    OrderDAO dao = new OrderDAO();
    List<OrderItem> items = dao.getOrderItems(oid);
%>


<!DOCTYPE html>
<html>
<head>
    <title>View Order</title>

    <style>
        body {
            background: #f4f6f9;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        .title {
            text-align: center;
            font-size: 26px;
            margin-bottom: 25px;
            font-weight: bold;
        }

        .item-box {
            display: flex;
            align-items: center;
            background: #fafafa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            border: 1px solid #eee;
        }

        .item-box img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
            border: 1px solid #ddd;
        }

        .details {
            flex: 1;
        }

        .name {
            font-size: 18px;
            font-weight: bold;
        }

        .qty {
            font-size: 15px;
            margin-top: 4px;
        }

        .price {
            margin-top: 6px;
            font-size: 16px;
            color: green;
            font-weight: bold;
        }

        .total-box {
            margin-top: 25px;
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .back-btn {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 18px;
            background: #007bff;
            color: #fff;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
        }

        .back-btn:hover {
            opacity: .85;
        }
    </style>
</head>
<body>

<div class="container">

    <h2 class="title">Order Details - #<%= oid %></h2>

    <% double grandTotal = 0; %>

    <% for (OrderItem it : items) { %>

        <div class="item-box">

            <!-- Product Image -->
           <img src="images/<%= it.getProductImage() %>"
     style="width:90px;height:90px;object-fit:cover;border-radius:8px;border:1px solid #ddd;">>

            <div class="details">
                <div class="name"><%= it.getProductName() %></div>

                <div class="qty">
                    Quantity: <%= it.getQuantity() %>
                </div>

                <div class="price">
                    ₹ <%= it.getPrice() %>
                </div>
            </div>

        </div>

        <% grandTotal += (it.getPrice() * it.getQuantity()); %>

    <% } %>

    <div class="total-box">
        Total Amount: ₹ <%= grandTotal %>
    </div>

    <a href="orders.jsp" class="back-btn">← Back to Orders</a>

</div>

</body>
</html>
