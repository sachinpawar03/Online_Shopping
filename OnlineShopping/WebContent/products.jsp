<%@page import="java.util.*,com.online.model.Product"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<script>
function confirmLogout() {
    if (confirm("Are you sure you want to logout?")) {
        window.location.href = "logout";
    }
}
</script>

<body>

<h2>Products</h2>

<p>
    <a href="${pageContext.request.contextPath}/cart">View Cart</a> |
    <a href="index.jsp">Home</a>
</p>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products == null) {
        out.print("<p>No products available.</p>");
    } else {
%>

<table border="1" cellpadding="6">
    <tr>
        <th>Name</th>
        <th>Price</th>
        <th>Category</th>
        <th>Image</th>
        <th>Action</th>
    </tr>

    <% for(Product p : products) { %>
    <tr>
        <td><%= p.getName() %></td>
        <td><%= p.getPrice() %></td>
        <td><%= p.getCategory() %></td>

        <td>
            <img src="<%= request.getContextPath() %>/images/<%= p.getImage() %>" 
                 width="120" height="120">
            <br>IMG:<%= p.getImage() %>
        </td>

        <td>
            <form action="${pageContext.request.contextPath}/addToCart" 
                  method="get" style="display:inline">
                <input type="hidden" name="id" value="<%= p.getProductId() %>">
                <button type="submit">Add to Cart</button>
            </form>
        </td>
    </tr>
    <% } %>

</table>

<!-- ✨ MOVED FORM OUTSIDE LOOP — NOW SHOWS ONLY ONCE ✨ -->
<br><br>


<% if (session.getAttribute("admin") != null) { %>

<br><br>

<h2>Add Product</h2>
<form action="addProduct" method="post">
    ID: <input type="text" name="id"><br>
    Name: <input type="text" name="name"><br>
    Description: <input type="text" name="description"><br>
    Price: <input type="text" name="price"><br>
    Category: <input type="text" name="category"><br>
    Quantity: <input type="text" name="quantity"><br>

    Image Name (Wireless Headphone.png): 
    <input type="text" name="image"><br><br>

    <button type="submit">Add Product</button>
</form>

<% } %>

<% } %>

</body>
</html>
