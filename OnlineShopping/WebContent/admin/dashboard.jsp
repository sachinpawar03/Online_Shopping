<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // --- Admin access check ---
    com.online.model.User admin = (com.online.model.User) session.getAttribute("user");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        body { font-family: Arial; padding: 20px; }
        .card {
            background: #f8f9fa;
            padding: 20px;
            margin: 10px;
            border-radius: 8px;
            width: 250px;
            box-shadow: 0 0 10px #ccc;
            display: inline-block;
        }
        .card a { text-decoration: none; font-weight: bold; color: #333; }
    </style>
</head>

<body>
<h1>Welcome Admin, <%= admin.getName() %> 👋</h1>

<!-- MANAGE PRODUCTS -->
<div class="card">
    <a href="manageProducts.jsp">📦 Manage Products</a>
</div>

<!-- MANAGE USERS (✔ CORRECTED) -->
<div class="card">
    <a href="<%=request.getContextPath()%>/admin/users">👥 Manage Users</a>
</div>

<!-- VIEW ORDERS -->
<div class="card">
    <a href="<%=request.getContextPath()%>/adminOrders">🧾 View Orders</a>
</div>

<!-- LOGOUT -->
<div class="card">
    <a href="<%=request.getContextPath()%>/logout" style="color:red;">🚪 Logout</a>
</div>

</body>
</html>
