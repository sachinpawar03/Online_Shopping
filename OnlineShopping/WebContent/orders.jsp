<%@ page
    import="java.util.*, com.online.dao.OrderDAO, com.online.model.Order, com.online.model.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Check login
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("admin/login.jsp");
        return;
    }

    // Load user orders
    OrderDAO dao = new OrderDAO();
    List<Order> orders = dao.getOrdersByUserId(u.getUserId());

    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
<title>Your Orders</title>

<style>
body {
    background: #f0f2f5;
    font-family: Arial, sans-serif;
}

.container {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto;
}

.title {
    text-align: center;
    margin-bottom: 30px;
    font-size: 28px;
    font-weight: bold;
}

/* GRID LAYOUT */
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 20px;
}

/* CARD STYLE */
.order-card {
    background: #fff;
    padding: 20px;
    border-radius: 14px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    transition: transform .2s ease, box-shadow .2s ease;
}

.order-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 14px rgba(0,0,0,0.2);
}

.order-id {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 12px;
}

.row {
    font-size: 15px;
    margin: 6px 0;
}

.price {
    color: green;
    font-weight: bold;
}

.empty {
    background: white;
    padding: 30px;
    text-align: center;
    border-radius: 12px;
    color: gray;
    font-size: 18px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

/* BUTTONS */
.btn-box {
    margin-top: 15px;
    display: flex;
    gap: 10px;
}

.btn {
    padding: 10px 15px;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    display: inline-block;
}

.view-btn {
    background: #007bff;
}

.track-btn {
    background: #28a745;
}

.btn:hover {
    opacity: 0.85;
}

/* STATUS COLORS */
.status-box {
    font-weight: bold;
    padding: 6px 12px;
    border-radius: 8px;
    display: inline-block;
    color: white;
}

.pending { background: orange; }
.packed { background: #795548; }
.shipped { background: #17a2b8; }
.out-for-delivery { background: #6f42c1; }
.delivered { background: green; }

</style>
</head>

<body>

    <div class="container">

        <h2 class="title">Your Orders</h2>

        <% if (orders == null || orders.isEmpty()) { %>

        <div class="empty">You have no orders yet.</div>

        <% } else { %>

        <div class="grid">

            <% for (Order o : orders) { %>

            <div class="order-card">

                <div class="order-id">
                    Order ID: #<%= o.getId() %>
                </div>

                <div class="row">
                    Status:

                    <%
                        String st = o.getStatus() == null ? "Pending" : o.getStatus();
                        String css = "pending";

                        if(st.equalsIgnoreCase("Packed")) css = "packed";
                        if(st.equalsIgnoreCase("Shipped")) css = "shipped";
                        if(st.equalsIgnoreCase("Out for Delivery")) css = "out-for-delivery";
                        if(st.equalsIgnoreCase("Delivered")) css = "delivered";
                    %>

                    <span class="status-box <%= css %>"><%= st %></span>
                </div>

                <div class="row">
                    Total Amount: <span class="price">₹<%= o.getTotal() %></span>
                </div>

                <div class="row">
                    Ordered On: <%= sdf.format(o.getCreatedAt()) %>
                </div>

                <div class="btn-box">
                    <a class="btn view-btn" href="viewOrder.jsp?oid=<%= o.getId() %>">View Order</a>
                    <a class="btn track-btn" href="trackOrder.jsp?oid=<%= o.getId() %>">Track Order</a>
                </div>

            </div>

            <% } %>

        </div>

        <% } %>

    </div>

</body>
</html>
