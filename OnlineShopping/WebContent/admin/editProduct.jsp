<%@ page import="com.online.dao.ProductDAO" %>
<%@ page import="com.online.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    com.online.model.User admin = (com.online.model.User) session.getAttribute("user");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    ProductDAO dao = new ProductDAO();
    Product p = dao.getById(id);
%>

<html>
<head>
    <title>Edit Product</title>

    <style>
        body {
            font-family: Arial;
            padding: 20px;
            background: #f5f5f5;
        }

        .card {
            background: #fff;
            padding: 25px;
            width: 480px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        label {
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-top: 5px;
            margin-bottom: 15px;
            font-size: 15px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .image-box {
            text-align: center;
            margin-bottom: 15px;
        }

    </style>

</head>

<body>

<div class="card">

<h2>✏ Edit Product</h2>

<form action="<%=request.getContextPath()%>/updateProduct"
      method="post" enctype="multipart/form-data">

    <input type="hidden" name="id" value="<%= p.getProductId() %>">

    <label>Name</label>
    <input type="text" name="name" value="<%= p.getName() %>" required>

    <label>Description</label>
    <input type="text" name="description" value="<%= p.getDescription() %>">

    <label>Price</label>
    <input type="number" name="price" value="<%= p.getPrice() %>" required>

    <label>Category</label>
    <input type="text" name="category" value="<%= p.getCategory() %>" required>

    <label>Quantity</label>
    <input type="number" name="quantity" value="<%= p.getQuantity() %>" required>

    <div class="image-box">
        <label>Current Image</label><br>
        <img src="<%=request.getContextPath()%>/images/<%= p.getImage() %>"
             width="150" style="border-radius:10px; margin-top:10px;">
    </div>

    <label>New Image (Optional)</label>
    <input type="file" name="image">

    <button class="btn" type="submit">Update Product</button>

</form>

</div>

</body>
</html>
