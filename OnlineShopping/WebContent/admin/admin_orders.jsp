<%@ page import="java.util.*, com.online.dao.OrderDAO, com.online.model.Order, com.online.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }

    OrderDAO dao = new OrderDAO();
    List<Order> orders = dao.getAllOrders();

    java.text.SimpleDateFormat sdf =
            new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - All Orders</title>

    <style>
        table {
            width:100%;
            border-collapse: collapse;
            background:white;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align:center;
        }
        .btn {
            background:#007bff;
            color:white;
            padding:6px 12px;
            border-radius:6px;
            text-decoration:none;
        }
        .delivered {
            color:green;
            font-weight:bold;
        }
        .pending {
            color:orange;
            font-weight:bold;
        }
    </style>
</head>

<body>

<h2 style="text-align:center;">All Orders</h2>

<table>
<tr>
    <th>Order ID</th>
    <th>User ID</th>
    <th>Total</th>
    <th>Date</th>
    <th>Status</th>
    <th>Change Status</th>
    <th>Action</th>
</tr>

<%
    if (orders != null && !orders.isEmpty()) {
        for (Order o : orders) {

            String status = o.getStatus();
            if (status == null) status = "Pending";
%>

<tr>
    <td><%= o.getId() %></td>
    <td><%= o.getUserId() %></td>
    <td>₹ <%= o.getTotal() %></td>
    <td><%= sdf.format(o.getCreatedAt()) %></td>

    <td class="<%= "Delivered".equalsIgnoreCase(status) ? "delivered" : "pending" %>">
        <%= status %>
    </td>

    <!-- STATUS DROPDOWN -->
    <td>
        <form action="admin/updateOrderStatus.jsp" method="post" style="margin:0;">
            <input type="hidden" name="oid" value="<%= o.getId() %>">

            <select name="status" onchange="this.form.submit()">
                <option value="Pending" <%= "Pending".equalsIgnoreCase(status) ? "selected" : "" %>>
                    Pending
                </option>
                <option value="Packed" <%= "Packed".equalsIgnoreCase(status) ? "selected" : "" %>>
                    Packed
                </option>
                <option value="Shipped" <%= "Shipped".equalsIgnoreCase(status) ? "selected" : "" %>>
                    Shipped
                </option>
                <option value="Out for Delivery" <%= "Out for Delivery".equalsIgnoreCase(status) ? "selected" : "" %>>
                    Out for Delivery
                </option>
                <option value="Delivered" <%= "Delivered".equalsIgnoreCase(status) ? "selected" : "" %>>
                    Delivered
                </option>
            </select>
        </form>
    </td>

    <!-- MARK DELIVERED -->
    <td>
        <% if (!"Delivered".equalsIgnoreCase(status)) { %>
            <a class="btn"
               href="admin/updateOrderStatus.jsp?oid=<%= o.getId() %>&status=Delivered">
                Mark Delivered
            </a>
        <% } else { %>
            ✔ Completed
        <% } %>
    </td>
</tr>

<%
        }
    } else {
%>

<tr>
    <td colspan="7" style="color:red;">No Orders Found</td>
</tr>

<% } %>

</table>

</body>
</html>
