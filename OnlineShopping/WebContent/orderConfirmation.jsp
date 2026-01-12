<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html><head><title>Order Confirmation</title><link rel="stylesheet" href="css/style.css"></head><body>
<h2>🎉 Order Placed Successfully</h2>

<p>Order ID: ${orderId}</p>
<p>Total Amount: ₹${total}</p>
<p>Payment Mode: ${paymentMode}</p>

<a href="products.jsp">Continue Shopping</a>
