<%@ page import="java.util.*, com.online.dao.OrderDAO, com.online.model.Order, com.online.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Check login
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("admin/login.jsp");
        return;
    }

    // Read order ID from URL
    int oid = Integer.parseInt(request.getParameter("oid"));

    // Load orders
    OrderDAO dao = new OrderDAO();
    List<Order> list = dao.getOrdersByUserId(u.getUserId());

    Order order = null;
    for (Order o : list) {
        if (o.getId() == oid) {
            order = o;
            break;
        }
    }

    if (order == null) {
        out.println("<h2>Order Not Found!</h2>");
        return;
    }

    String status = order.getStatus();
    if (status == null) status = "Pending";

    status = status.trim().toLowerCase(); // normalize
%>

<!DOCTYPE html>
<html>
<head>
    <title>Track Order</title>

    <style>
        body {
            background: #f1f3f6;
            font-family: Arial;
            padding: 30px;
        }

        .container {
            width: 90%;
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
        }

        .timeline {
            position: relative;
            margin: 30px 0;
            padding-left: 30px;
        }

        .step {
            position: relative;
            margin-bottom: 40px;
            padding-left: 40px;
        }

        .circle {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: #c7c7c7;
            position: absolute;
            left: 0;
            top: 0;
        }

        .circle.active {
            background: #2874f0;
        }

        .line {
            width: 3px;
            height: 40px;
            background: #c7c7c7;
            position: absolute;
            left: 10px;
            top: 25px;
        }

        .line.active {
            background: #2874f0;
        }

        .label {
            font-size: 17px;
            font-weight: bold;
        }

        .date {
            font-size: 14px;
            color: #555;
            margin-top: 4px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 18px;
            background: #2874f0;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }

        .back-btn:hover {
            opacity: 0.85;
        }
    </style>

</head>
<body>

<div class="container">

    <h2>Track Order #<%= oid %></h2>

    <%-- FLIPKART STEPS --%>
    <div class="timeline">

        <!-- STEP 1: ORDER PLACED -->
        <div class="step">
            <div class="circle active"></div>
            <div class="line <%= (!status.equals("pending")) ? "active" : "" %>"></div>
            <div class="label">Order Placed</div>
        </div>

        <!-- STEP 2: PACKED -->
        <div class="step">
            <div class="circle <%= (status.equals("packed") || status.equals("shipped") || status.equals("out for delivery") || status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="line <%= (status.equals("shipped") || status.equals("out for delivery") || status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="label">Packed</div>
        </div>

        <!-- STEP 3: SHIPPED -->
        <div class="step">
            <div class="circle <%= (status.equals("shipped") || status.equals("out for delivery") || status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="line <%= (status.equals("out for delivery") || status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="label">Shipped</div>
        </div>

        <!-- STEP 4: OUT FOR DELIVERY -->
        <div class="step">
            <div class="circle <%= (status.equals("out for delivery") || status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="line <%= (status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="label">Out for Delivery</div>
        </div>

        <!-- STEP 5: DELIVERED -->
        <div class="step">
            <div class="circle <%= (status.equals("delivered")) ? "active" : "" %>"></div>
            <div class="label">Delivered</div>
        </div>

    </div>

    <a href="orders.jsp" class="back-btn">← Back to Orders</a>

</div>

</body>
</html>
