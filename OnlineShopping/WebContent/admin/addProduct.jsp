<%@ page contentType="text/html;charset=UTF-8" %>

<%
    com.online.model.User admin = (com.online.model.User) session.getAttribute("user");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Add Product</title>

    <style>
        body {
            font-family: Arial;
            padding: 20px;
            background: #f5f5f5;
        }

        .card {
            background: #fff;
            padding: 25px;
            width: 450px;
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
            background: green;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn:hover {
            opacity: 0.9;
        }
    </style>

</head>

<body>

<div class="card">
<h2>➕ Add New Product</h2>

<form action="<%= request.getContextPath() %>/addProduct"
      method="post" enctype="multipart/form-data">

    <label>Product Name</label>
    <input type="text" name="name" required>

    <label>Description</label>
    <input type="text" name="description">

    <label>Price</label>
    <input type="number" name="price" required>

    <label>Category</label>
    <input type="text" name="category" required>

    <label>Quantity</label>
    <input type="number" name="quantity" required>

    <label>Product Image</label>
    <input type="file" name="image" accept="image/*" required>

    <button class="btn" type="submit">Add Product</button>
</form>
</div>

</body>
</html>
