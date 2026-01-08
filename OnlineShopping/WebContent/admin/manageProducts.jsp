<%@ page import="java.util.List" %>
<%@ page import="com.online.dao.ProductDAO" %>
<%@ page import="com.online.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // --- Admin access check ---
    com.online.model.User admin = (com.online.model.User) session.getAttribute("user");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }

    ProductDAO dao = new ProductDAO();
    List<Product> products = dao.getAll();
%>

<html>
<head>
    <title>Manage Products</title>

    <style>
        body { font-family: Arial; padding: 20px; }

        h1 { margin-bottom: 20px; }

        .btn {
            padding: 7px 14px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
            margin-right: 5px;
        }

        .add-btn { background: green; }
        .edit-btn { background: #007bff; }
        .delete-btn { background: #d9534f; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
        }

        th { background: #f2f2f2; }
    </style>
</head>

<body>

<h1>Manage Products</h1>

<!-- Add New Product Button -->
<a href="addProduct.jsp" class="btn add-btn">➕ Add New Product</a>

<!-- Product Table -->
<!-- Product Table -->
<table>
    <tr>
        <th>S.No</th>
        <th>Name</th>
        <th>Description</th>
        <th>Category</th>
        <th>Price</th>
        <th>Qty</th>
        <th>Image</th>
        <th>Actions</th>
    </tr>

    <%
        int sno = 1;  // serial number starts from 1
        for(Product p : products) {
    %>

    <tr>
        <td><%= sno++ %></td>
        <td><%= p.getName() %></td>
        <td><%= p.getDescription() %></td>
        <td><%= p.getCategory() %></td>
        <td>₹<%= p.getPrice() %></td>
        <td><%= p.getQuantity() %></td>

        <td>
            <img src="<%= request.getContextPath() %>/images/<%= p.getImage() %>"
                 width="60" height="60" style="border-radius:5px;">
        </td>

        <td>
            <a href="editProduct.jsp?id=<%= p.getProductId() %>" class="btn edit-btn">✏ Edit</a>

            <a href="<%=request.getContextPath()%>/deleteProduct?id=<%= p.getProductId() %>"
               onclick="return confirm('Delete this product?')"
               class="btn delete-btn">🗑 Delete</a>
        </td>
    </tr>

    <% } %>

</table>
