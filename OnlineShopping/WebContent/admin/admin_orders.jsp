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

    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<html>
<head>
    <title>Admin - All Orders</title>

    <style>
        table { width:100%; border-collapse: collapse; background:white; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align:center; }
        .btn { background:#007bff; color:white; padding:6px 12px; border-radius:6px; text-decoration:none; }
        .delivered { color:green; font-weight:bold; }
        .pending { color:orange; font-weight:bold; }
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
   if (orders != null && orders.size() > 0) {
       for (Order o : orders) { 
%>

<tr>

    <td><%= o.getId() %></td>
    <td><%= o.getUserId() %></td>
    <td>₹ <%= o.getTotal() %></td>
    <td><%= sdf.format(o.getCreatedAt()) %></td>

    <td><%= o.getStatus() %></td>

    <!-- STATUS DROPDOWN -->
    <td>
        <form action="updateOrderStatus.jsp" method="post" style="margin:0;">
            <input type="hidden" name="oid" value="<%= o.getId() %>">

            <select name="status" onchange="this.form.submit()">
                <option <%= o.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                <option <%= o.getStatus().equals("Packed") ? "selected" : "" %>>Packed</option>
                <option <%= o.getStatus().equals("Shipped") ? "selected" : "" %>>Shipped</option>
                <option <%= o.getStatus().equals("Out for Delivery") ? "selected" : "" %>>Out for Delivery</option>
                <option <%= o.getStatus().equals("Delivered") ? "selected" : "" %>>Delivered</option>
            </select>
        </form>
    </td>

    <!-- MARK DELIVERED BUTTON -->
   <td>
    <% if (!"Delivered".equalsIgnoreCase(o.getStatus())) { %>

        <a class="btn" href="updateOrderStatus.jsp?oid=<%= o.getId() %>&status=Delivered">
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
